//
//  ViewController.h
//  Red Dot
//

//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <MessageUI/MessageUI.h>
#import <iAd/iAd.h>

@interface ViewController : UIViewController <MFMailComposeViewControllerDelegate, ADBannerViewDelegate>

@property (strong, nonatomic) IBOutlet ADBannerView *adBanner;


@end
