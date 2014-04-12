//
//  SettingsScene.m
//  Red Dot
//
//  Created by Alex Atwater on 4/11/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "SettingsScene.h"


@implementation SettingsScene


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        //create the scene here
        self.backgroundColor = [UIColor whiteColor];
        
        
        //add the logo to the background
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"no-background.png"];
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        background.alpha = .1;
        [self addChild:background];
        
        //add dev by label
        SKLabelNode *devByLabel = [[SKLabelNode alloc] init];
        devByLabel.fontColor = [UIColor blackColor];
        devByLabel.fontSize = 20;
        devByLabel.text = @"Developed by: Alex Atwater";
        devByLabel.fontName = @"System Bold";
        devByLabel.position = CGPointMake(20, 138);
        devByLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        [self addChild:devByLabel];
        
        //add version label
        SKLabelNode *versionLabel = [[SKLabelNode alloc] init];
        versionLabel.fontColor = [UIColor blackColor];
        versionLabel.fontSize = 20;
        versionLabel.text = [NSString stringWithFormat:@"Version: %@", [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"]];
        versionLabel.fontName = @"System";
        versionLabel.position = CGPointMake(20, 167);
        versionLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        [self addChild:versionLabel];
        
        
        //add support label
        SKLabelNode *supportLabel = [[SKLabelNode alloc] init];
        supportLabel.fontColor = [UIColor blackColor];
        supportLabel.fontSize = 20;
        supportLabel.fontName = @"System Bold";
        supportLabel.text = @"Need Support?";
        supportLabel.position = CGPointMake(20, 216);
        supportLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        [self addChild:supportLabel];
        
        //add support buttons
        SKTexture *emailTexture = [SKTexture textureWithImageNamed:@"Email-Button.png"];
        SKSpriteNode *emailButton = [[SKSpriteNode alloc] initWithTexture:emailTexture];
        emailButton.name = @"emailButton";
        emailButton.position = CGPointMake(CGRectGetMidX(self.frame)-(emailButton.size.width/2)-20, 248);
        
        SKTexture *websiteTexture = [SKTexture textureWithImageNamed:@"Website-Button.png"];
        SKSpriteNode *websiteButton = [[SKSpriteNode alloc] initWithTexture:websiteTexture];
        emailButton.name = @"websiteButton";
        emailButton.position = CGPointMake(CGRectGetMidX(self.frame)+(emailButton.size.width/2)+20, 248);
        
        [self addChild:emailButton];
        [self addChild:websiteButton];
        
        
        
        
        
        
        
        
        
        
    }
    
    return self;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    UITouch *touch = [touches anyObject];
    CGPoint touchedPosition = [touch locationInNode:self];
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchedPosition];
    
    if ([[touchedNode name] isEqualToString:@"emailButton"]) {
        
        //if the email button -> notifify ViewController to present the email view
        [[NSNotificationCenter defaultCenter] postNotificationName:@"emailMessage" object:nil];
        
        
    } else if ([[touchedNode name] isEqualToString:@"websiteButton"]) {
        
        
        
    }
    
    
}








@end
