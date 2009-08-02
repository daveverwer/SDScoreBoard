//
//  ScoreBoardAppDelegate.h
//  ScoreBoard
//
//  Created by Dave Verwer on 02/08/2009.
//  Copyright Shiny Development Ltd. 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScoreBoardViewController;

@interface ScoreBoardAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ScoreBoardViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ScoreBoardViewController *viewController;

@end

