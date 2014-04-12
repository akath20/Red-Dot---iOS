//
//  GameModeScene.m
//  Red Dot
//
//  Created by Alex Atwater on 4/11/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "GameModeScene.h"
#import "MainMenuScene.h"

#define HighScores [[NSUserDefaults standardUserDefaults] objectForKey:@"highScores"]

@implementation GameModeScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        //create the scene here
        self.backgroundColor = [UIColor whiteColor];
        
        //mid y value
        //offset left for the high scores
        double xMidOffset = CGRectGetMidX(self.frame)-50;
        
        
        //add the label
        SKLabelNode *pickLabel = [[SKLabelNode alloc] init];
        pickLabel.fontColor = [UIColor blackColor];
        pickLabel.fontSize = 22;
        pickLabel.text = @"Select a Game Mode.";
        pickLabel.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height-60);
        [self addChild:pickLabel];
        
        
        //create the back button
        SKTexture *backButtonTexture = [SKTexture textureWithImageNamed:@"Back-Button"];
        SKSpriteNode *backButton = [SKSpriteNode spriteNodeWithTexture:backButtonTexture];
        [backButton setScale:.4];
        backButton.position = CGPointMake(backButton.size.width/2+10, (self.scene.frame.size.height-(backButton.size.height/2))-30);
        backButton.name = @"backButton";
        [self addChild:backButton];
        
        
        //Race the Clock button + HS
        SKTexture *raceTheClock = [SKTexture textureWithImageNamed:@"Race The Clock.png"];
        SKSpriteNode *raceTheClockButton = [SKSpriteNode spriteNodeWithTexture:raceTheClock];
        raceTheClockButton.position = CGPointMake(xMidOffset, pickLabel.position.y-60);
        [raceTheClockButton setScale:.6];
        
        //make two lines with one node
        //http://stackoverflow.com/questions/19179005/insert-line-break-using-sklabelnode-in-spritekit
        SKNode *raceClockHSLabel = [SKNode node];
        SKLabelNode *topLine = [[SKLabelNode alloc] init];
        topLine.fontSize = 14;
        topLine.fontColor = [UIColor blackColor];
        SKLabelNode *bottomLine = [[SKLabelNode alloc] init];
        bottomLine.fontSize = 14;
        bottomLine.fontColor = [UIColor blackColor];
        NSString *topText = @"Fastest Time:";
        NSString *bottomText = [[NSString alloc] init];
        if ([HighScores objectForKey:@"raceTheClock"]) {
            //if score on hand
            bottomText = [[HighScores objectForKey:@"raceTheClock"] stringValue];
        } else {
            //if no valid score on hand
            bottomText = @"N/A";
        }
        bottomLine.position = CGPointMake(bottomLine.position.x, bottomLine.position.y - 20);
        topLine.text = topText;
        bottomLine.text = bottomText;
        [raceClockHSLabel addChild:topLine];
        [raceClockHSLabel addChild:bottomLine];
        raceClockHSLabel.position = CGPointMake(CGRectGetMidX(self.frame)+raceTheClockButton.size.width/2+10, raceTheClockButton.position.y+5);

        [self addChild:raceTheClockButton];
        [self addChild:raceClockHSLabel];
        
        
        
    }
    
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    UITouch *touch = [touches anyObject];
    CGPoint touchedPosition = [touch locationInNode:self];
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchedPosition];
    
    if ([[touchedNode name] isEqualToString:@"backButton"]) {
     
        MainMenuScene *mainMenu = [[MainMenuScene alloc] initWithSize:self.frame.size];
        SKTransition *fade = [SKTransition fadeWithDuration:.5];
        
        
    }
    
    
}


@end
