#define maxDigits 5

@interface SDScoreBoard : CALayer {
  char digits[maxDigits+1];
  NSMutableArray *digitLayers;
  NSArray *digitImages;
}

- (id)initWithInitialValue:(NSInteger)value;
- (void)setValue:(NSInteger)value;

@end
