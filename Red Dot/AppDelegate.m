//
//  AppDelegate.m
//  Red Dot
//
//  Created by Alex Atwater on 4/6/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    //set up the high score is they arn't there alread
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"highScores"]) {
        
        NSMutableDictionary *highScoresDic = [[NSMutableDictionary alloc] init];
        [[NSUserDefaults standardUserDefaults] setObject:highScoresDic forKey:@"highScores"];
        
        /*
          Current Names for High Score Games
         
         raceTheClock
         
         
         
         
         
         
         */
    }
    
    
    return YES;


}



@end

