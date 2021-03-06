#import "SDScoreBoard.h"

NSInteger const scoreBoardAnimationDuration = 0.8; // seconds
NSString* const scoreBoardAnimationKeyRemoveWhenDone = @"removeWhenDone";

@interface SDScoreBoard (Private)
- (CALayer*)layerForDigit:(NSInteger)value atPosition:(NSInteger)position;
- (CAAnimation*)animationInForLayer:(CALayer*)layer fromTop:(BOOL)fromTop;
- (CAAnimation*)animationOutForLayer:(CALayer*)layer fromTop:(BOOL)fromTop;
@end

@implementation SDScoreBoard

- (id)init {
  // Call the designated initialiser with some defaults
  self = [self initWithInitialValue:0];
  return self;
}

- (id)initWithInitialValue:(NSInteger)value {
  if (self = [super init]) {
    // Initialise with invalid digits & zero terminate
    memset(digits, 0xff, sizeof(digits));
    digits[sizeof(digits)] = 0;
    
    // Ensure that the digits are never drawn outside the bounds
    [self setMasksToBounds:YES];
    
    // Load the individual digit images
    NSMutableArray *loadedImages = [[NSMutableArray alloc] initWithCapacity:10];
    for (NSInteger i=0; i<10; i++)
      [loadedImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png", i]]];
    digitImages = [[NSArray alloc] initWithArray:loadedImages];
    [loadedImages release]; loadedImages = nil;
    
    // Add some placeholder layers in just to give the array some values
    digitLayers = [[NSMutableArray alloc] initWithCapacity:maxDigits];
    for (NSInteger i=0; i<maxDigits; i++) [digitLayers addObject:[CALayer layer]];
    
    // Sort out the dimesions of the scoreboard
    CGSize imageSize = [[digitImages lastObject] size];
    [self setBounds:CGRectMake(0, 0, imageSize.width * maxDigits, imageSize.height)];
    
    // Kick set the initial value
    [self setValue:value];
  }
  return self;
}
                        
- (void)dealloc {
  [digitLayers release];
  [digitImages release];
  [super dealloc];
}

#pragma mark Property accessors
- (void)setValue:(NSInteger)value {
  // Score board can not display negative numbers
  if (value < 0) {
    NSLog(@"Error: Value can not be negative.");
    return;
  }

  // Format the new value as a zero padded string of length maxDigits
  NSString *format = [NSString stringWithFormat:@"%%0%dd", maxDigits];
  NSString *valueStr = [NSString stringWithFormat:format, value];
  
  // Only set the value if it fits
  if ([valueStr length] <= maxDigits) {
    // Keep a copy of the old digits array
    char oldDigits[maxDigits+1];
    memcpy(oldDigits, digits, sizeof(digits));

    // Assign value to the digits array
    [valueStr getCString:digits maxLength:sizeof(digits) encoding:NSUTF8StringEncoding];
    
    // Check which digits have changed and animate the new digit in
    for (NSInteger i=0; i<maxDigits; i++) {
      if (digits[i] != oldDigits[i]) {
        // Should the digit come in from the top or the bottom?
        // This includes a hack so that it appears to make the
        // digits wrap correctly when switching from 0 to 9.
        BOOL fromTop = digits[i] > oldDigits[i];
        if ((digits[i] == '0' && oldDigits[i] == '9') ||
            (digits[i] == '9' && oldDigits[i] == '0')) fromTop = !fromTop;
        
        // Create a new layer for the changed digit
        CALayer *layer = [self layerForDigit:digits[i]-(NSInteger)'0' atPosition:i];
        
        // Animate out the old layer at this position
        CALayer *oldLayer = [digitLayers objectAtIndex:i];
        [oldLayer addAnimation:[self animationOutForLayer:oldLayer fromTop:fromTop] forKey:@"move-out"];
        
        // Replace the reference to the old layer with the new layer
        [digitLayers replaceObjectAtIndex:i withObject:layer];
        
        // Animate in the new layer
        [layer addAnimation:[self animationInForLayer:layer fromTop:fromTop] forKey:@"move-in"];
        
        // Add the layer into the hierarchy, removal of the old layer is done
        // in animationDidStop:finished: after it's animation is done
        [self addSublayer:layer];
      }
    }
  } else NSLog(@"Error: Value is too large to display.");
}

- (CALayer*)layerForDigit:(NSInteger)value atPosition:(NSInteger)position {
  // Get the image to use, this assumes images have been inserted in the correct
  // order which should have been done in initWithInitialValue:withMaxDigits:
  UIImage *image = [digitImages objectAtIndex:value];
  
  // Set up the layer ready to animate in
  CALayer *layer = [CALayer layer];
  [layer setAnchorPoint:CGPointZero];
  [layer setBounds:CGRectMake(0, 0, [image size].width, [image size].height)];
  [layer setPosition:CGPointMake(position * [image size].width, 0)];
  [layer setContents:(id)[image CGImage]];

  return layer;
}

- (CAAnimation*)animationInForLayer:(CALayer*)layer fromTop:(BOOL)fromTop {
  // Create the animation to slide the number in
  CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position.y"];
  [anim setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
  CGFloat animationOrigin = fromTop ? -[layer bounds].size.height : [layer bounds].size.height;
  [anim setFromValue:[NSNumber numberWithFloat:animationOrigin]];
  [anim setDuration:scoreBoardAnimationDuration];
  [anim setFillMode:kCAFillModeBackwards];
  return anim;
}

- (CAAnimation*)animationOutForLayer:(CALayer*)layer fromTop:(BOOL)fromTop {
  // Create the animation to slide the number out
  CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position.y"];
  [anim setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
  CGFloat animationDest = fromTop ? [layer bounds].size.height : -[layer bounds].size.height;
  [anim setToValue:[NSNumber numberWithFloat:animationDest]];
  [anim setDuration:scoreBoardAnimationDuration];
  [anim setValue:layer forKey:scoreBoardAnimationKeyRemoveWhenDone];
  [anim setDelegate:self];
  return anim;
}

- (void)animationDidStop:(CAAnimation*)animation finished:(BOOL)flag {
  // Remove any old layers from the hierarchy
  CALayer *layer = [animation valueForKey:scoreBoardAnimationKeyRemoveWhenDone];
  if (layer && [layer isKindOfClass:[CALayer class]]) [layer removeFromSuperlayer];
}

@end
