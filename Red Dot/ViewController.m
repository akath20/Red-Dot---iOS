//
//  ViewController.m
//  Red Dot
//
//  Created by Alex Atwater on 4/6/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "ViewController.h"
#import "SharedValues.h"
#import <sys/utsname.h>
#import "LevelsScene.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    SKView *skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    
    
    // Create and configure the scene.
    SKScene *levelsScene = [LevelsScene sceneWithSize:skView.bounds.size];
    levelsScene.scaleMode = SKSceneScaleModeAspectFill;

    
    // Present the scene.
    [skView presentScene:levelsScene];
    
    
    

    
    
    

    //set the notification watchers
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emailMessage) name:@"emailMessage" object:nil];
    
    
    
}

- (void)emailMessage {
    
    MFMailComposeViewController *emailSheet = [[MFMailComposeViewController alloc] init];
    
    emailSheet.mailComposeDelegate = self;
    
    // Fill out the email body text.

    //get the device type
    //*IMPORT* <sys/utsname.h>
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceType = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    
    
    NSString *emailBody = [NSString stringWithFormat:@"\n\r\n\r\n\riOS Version: %@\n\rDevice: %@\n\rApp Version: %@", [[UIDevice currentDevice] systemVersion], deviceType, [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"]];
    [emailSheet setMessageBody:emailBody isHTML:NO];
    
    // Present the mail composition interface.
    [self presentViewController:emailSheet animated:true completion:nil];
    
    
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [controller dismissViewControllerAnimated:true completion:nil];
}







@end
