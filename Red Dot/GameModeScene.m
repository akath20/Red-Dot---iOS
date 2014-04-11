//
//  GameModeScene.m
//  Red Dot
//
//  Created by Alex Atwater on 4/11/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "GameModeScene.h"

#define HighScores [[NSUserDefaults standardUserDefaults] objectForKey:@"highScores"]

@implementation GameModeScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        //create the scene here
        self.backgroundColor = [UIColor whiteColor];
        
        //mid y value
        //offset left for the high scores
        double xMid = CGRectGetMidX(self.frame)-20;
        
        
        //add the label
        SKLabelNode *pickLabel = [[SKLabelNode alloc] init];
        pickLabel.fontColor = [UIColor blackColor];
        pickLabel.text = @"Pick a Game Mode.";
        pickLabel.position = CGPointMake(xMid, self.frame.size.height-30);
        [self addChild:pickLabel];
        
        
        //Race the Clock button + HS
        SKTexture *raceTheClock = [SKTexture textureWithImageNamed:@"Race The Clock.png"];
        SKSpriteNode *raceTheClockButton = [SKSpriteNode spriteNodeWithTexture:raceTheClock];
        raceTheClockButton.position = CGPointMake(xMid, pickLabel.position.y-30);
        SKLabelNode *raceClockHSLabel = [[SKLabelNode alloc] init];
        raceClockHSLabel.fontColor = [UIColor blackColor];
        raceClockHSLabel.position = CGPointMake(xMid+raceTheClockButton.size.width/2+20, raceTheClockButton.position.y);
        raceClockHSLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        if ([HighScores objectForKey:@"raceTheClock"]) {
            //if a valid high score
            raceClockHSLabel.text = [NSString stringWithFormat:@"Fasteset Time:\n%@", [HighScores objectForKey:@"raceTheClock"]];
        } else {
            raceClockHSLabel.text = @"Fastest Time:\nN/A";
        }
        
        [self addChild:raceTheClockButton];
        [self addChild:raceClockHSLabel];
        
        
        
    }
    
    return self;
}


@end
