#import "ScoreBoardViewController.h"

@class ScoreBoardViewController;

@interface ScoreBoardAppDelegate : NSObject <UIApplicationDelegate> {
  UIWindow *_window;
  ScoreBoardViewController *_viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ScoreBoardViewController *viewController;

@end

