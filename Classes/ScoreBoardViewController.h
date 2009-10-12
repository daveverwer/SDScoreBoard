#import <UIKit/UIKit.h>
#import "SDScoreBoard.h"

@interface ScoreBoardViewController : UIViewController {
  SDScoreBoard *_scoreBoard;
  NSInteger _score;
}

- (IBAction)scoreUp:(id)sender;
- (IBAction)scoreDown:(id)sender;
- (IBAction)scoreRandom:(id)sender;

@end
