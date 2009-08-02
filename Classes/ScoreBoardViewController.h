//
//  ScoreBoardViewController.h
//  ScoreBoard
//
//  Created by Dave Verwer on 02/08/2009.
//  Copyright Shiny Development Ltd. 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDScoreBoard.h"

@interface ScoreBoardViewController : UIViewController {
  SDScoreBoard *_scoreBoard;
  NSInteger score;
}

@property (nonatomic,retain) SDScoreBoard *scoreBoard;

- (IBAction)scoreUp:(id)sender;
- (IBAction)scoreDown:(id)sender;
- (IBAction)scoreRandom:(id)sender;

@end
