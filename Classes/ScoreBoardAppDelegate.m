//
//  ScoreBoardAppDelegate.m
//  ScoreBoard
//
//  Created by Dave Verwer on 02/08/2009.
//  Copyright Shiny Development Ltd. 2009. All rights reserved.
//

#import "ScoreBoardAppDelegate.h"
#import "ScoreBoardViewController.h"

@implementation ScoreBoardAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
