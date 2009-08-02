//
//  SDScoreBoard.h
//  ScoreBoard
//
//  Created by Dave Verwer on 02/08/2009.
//  Copyright 2009 Shiny Development Ltd.. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

#define maxDigits 5

@interface SDScoreBoard : CALayer {
  char digits[maxDigits+1];
  NSMutableArray *digitLayers;
  NSArray *digitImages;
}

- (id)initWithInitialValue:(NSInteger)value;
- (void)setValue:(NSInteger)value;

@end
