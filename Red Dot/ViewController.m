//
//  ViewController.m
//  Red Dot
//
//  Created by Alex Atwater on 4/6/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "ViewController.h"
#import "MainMenuScene.h"
#import "SharedValues.h"
#import <sys/utsname.h>

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    SKView *skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SKScene *mainMenu = [MainMenuScene sceneWithSize:skView.bounds.size];
    mainMenu.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:mainMenu];
    
    NSArray *colorsArray = [[NSArray alloc] initWithObjects:[UIColor blackColor], [UIColor grayColor], [UIColor redColor], [UIColor greenColor], [UIColor blueColor], [UIColor cyanColor], [UIColor yellowColor], [UIColor magentaColor], [UIColor orangeColor], [UIColor purpleColor], [UIColor brownColor], nil];
    
    [[SharedValues allValues] setColorsArray:[NSArray arrayWithArray:colorsArray]];
    
    
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
