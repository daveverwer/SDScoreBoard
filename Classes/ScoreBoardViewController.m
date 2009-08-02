//
//  ScoreBoardViewController.m
//  ScoreBoard
//
//  Created by Dave Verwer on 02/08/2009.
//  Copyright Shiny Development Ltd. 2009. All rights reserved.
//

#import "ScoreBoardViewController.h"

@implementation ScoreBoardViewController

@synthesize scoreBoard = _scoreBoard;

- (void)loadView {
  [super loadView];

  score = 0;
  
  SDScoreBoard *layer = [[SDScoreBoard alloc] initWithInitialValue:score];
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
  [[self scoreBoard] setValue:++score];
}

- (IBAction)scoreDown:(id)sender {
  [[self scoreBoard] setValue:--score];
}

- (IBAction)scoreRandom:(id)sender {
  score = random() % USHRT_MAX;
  [[self scoreBoard] setValue:score];
}

@end
