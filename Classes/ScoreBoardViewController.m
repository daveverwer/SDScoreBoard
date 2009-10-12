#import "ScoreBoardViewController.h"

@interface ScoreBoardViewController ()
@property (nonatomic, retain) SDScoreBoard *scoreBoard;
@property (nonatomic, assign) NSInteger score;
@end

@implementation ScoreBoardViewController

@synthesize scoreBoard = _scoreBoard;
@synthesize score = _score;

- (void)dealloc {
  [_scoreBoard release];
  [super dealloc];
}

- (void)loadView {
  [super loadView];
  
  // Initialise the random number generator
  srandom((NSInteger)[NSDate timeIntervalSinceReferenceDate]);

  // Initialise the score
  [self setScore:0];
  
  // Create the score board and add it in to the layer hierarchy
  SDScoreBoard *layer = [[SDScoreBoard alloc] initWithInitialValue:[self score]];
  CGSize viewSize = [[self view] bounds].size;
  [layer setPosition:CGPointMake(viewSize.width / 2, viewSize.height / 3)];
  [self setScoreBoard:layer];
  [layer release]; layer = nil;
  [[[self view] layer] addSublayer:[self scoreBoard]];
}

- (void)viewDidUnload {
  [self setScoreBoard:nil];
}

- (IBAction)scoreUp:(id)sender {
  [self setScore:MIN([self score]+1, USHRT_MAX)];
  [[self scoreBoard] setValue:[self score]];
}

- (IBAction)scoreDown:(id)sender {
  [self setScore:MAX([self score]-1, 0)];
  [[self scoreBoard] setValue:[self score]];
}

- (IBAction)scoreRandom:(id)sender {
  [self setScore:random() % USHRT_MAX];
  [[self scoreBoard] setValue:[self score]];
}

@end
