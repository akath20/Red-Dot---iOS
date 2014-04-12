//
//  SettingsScene.m
//  Red Dot
//
//  Created by Alex Atwater on 4/11/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "SettingsScene.h"
#import "MainMenuScene.h"


@implementation SettingsScene


-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        //create the scene here
        self.backgroundColor = [UIColor whiteColor];
        
        int yOffset = 0;
        
        
        //add the logo to the background
        SKTexture *backgroundTexture = [SKTexture textureWithImageNamed:@"no-background.png"];
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithTexture:backgroundTexture];
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        background.alpha = .1;
        [background setScale:.6];
        [self addChild:background];
        
        //add dev by label
        SKLabelNode *devByLabel = [[SKLabelNode alloc] init];
        devByLabel.fontColor = [UIColor blackColor];
        devByLabel.fontSize = 20;
        devByLabel.text = @"Developed by: Alex Atwater";
        devByLabel.fontName = @"System Bold";
        devByLabel.position = CGPointMake(CGRectGetMidX(self.frame), 380+yOffset);
        devByLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        [self addChild:devByLabel];
        
        //add version label
        SKLabelNode *versionLabel = [[SKLabelNode alloc] init];
        versionLabel.fontColor = [UIColor blackColor];
        versionLabel.fontSize = 20;
        versionLabel.text = [NSString stringWithFormat:@"Version: %@", [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"]];
        versionLabel.fontName = @"System";
        versionLabel.position = CGPointMake(CGRectGetMidX(self.frame), 350+yOffset);
        versionLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        [self addChild:versionLabel];
        
        
        //add support label
        SKLabelNode *supportLabel = [[SKLabelNode alloc] init];
        supportLabel.fontColor = [UIColor blackColor];
        supportLabel.fontSize = 20;
        supportLabel.fontName = @"System Bold";
        supportLabel.text = @"Need Support?";
        supportLabel.position = CGPointMake(CGRectGetMidX(self.frame), 300+yOffset);
        supportLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        [self addChild:supportLabel];
        
        //add support buttons
        SKTexture *emailTexture = [SKTexture textureWithImageNamed:@"Email-Button.png"];
        SKSpriteNode *emailButton = [[SKSpriteNode alloc] initWithTexture:emailTexture];
        emailButton.name = @"emailButton";
        [emailButton setScale:.5];
        emailButton.position = CGPointMake(CGRectGetMidX(self.frame)-(emailButton.size.width/2)-10, 248+yOffset);
        
        SKTexture *websiteTexture = [SKTexture textureWithImageNamed:@"Website-Button.png"];
        SKSpriteNode *websiteButton = [[SKSpriteNode alloc] initWithTexture:websiteTexture];
        websiteButton.name = @"websiteButton";
        [websiteButton setScale:.5];
        websiteButton.position = CGPointMake(CGRectGetMidX(self.frame)+(emailButton.size.width/2)+10, 248+yOffset);
        
        [self addChild:emailButton];
        [self addChild:websiteButton];
        
        
        //add the back button
        SKTexture *backButtonTexture = [SKTexture textureWithImageNamed:@"Back-Button"];
        SKSpriteNode *backButton = [SKSpriteNode spriteNodeWithTexture:backButtonTexture];
        [backButton setScale:.4];
        backButton.position = CGPointMake(backButton.size.width/2+10, (self.scene.frame.size.height-(backButton.size.height/2))-30);
        backButton.name = @"backButton";
        [self addChild:backButton];
        
        
        
        
        
        
        
        
        
        
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
        
        //open my website
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://webpages.charter.net/akath20/"]];
        

    } else if ([[touchedNode name] isEqualToString:@"backButton"]) {
        
        MainMenuScene *mainMenu = [[MainMenuScene alloc] initWithSize:self.scene.size];
        SKTransition *transition = [SKTransition fadeWithDuration:.5];
        [self.scene.view presentScene:mainMenu transition:transition];
        
        
    }
    
    
}








@end
