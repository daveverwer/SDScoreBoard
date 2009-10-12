#import "ScoreBoardAppDelegate.h"

@implementation ScoreBoardAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (void)applicationDidFinishLaunching:(UIApplication*)application {
  [[self window] addSubview:[[self viewController] view]];
  [[self window] makeKeyAndVisible];
}

- (void)dealloc {
  [_viewController release];
  [_window release];
  [super dealloc];
}

@end
