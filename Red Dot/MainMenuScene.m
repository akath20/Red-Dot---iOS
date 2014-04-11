//
//  MainMenuScene.m
//  Red Dot
//
//  Created by Alex Atwater on 4/6/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "MainMenuScene.h"
#import "GameModeScene.h"
#import "SharedValues.h"
#import "SettingsScene.h"

@implementation MainMenuScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        //create scene
        self.backgroundColor = [SKColor whiteColor];
        
        //create the red dot
        CGRect circle = CGRectMake(0, 0, 120.0, 120.0);
        _redCircle = [[SKShapeNode alloc] init];
        _redCircle.position = CGPointMake(size.width/2-circle.size.width/2, size.height/2);
        _redCircle.path = [UIBezierPath bezierPathWithOvalInRect:circle].CGPath;
        _redCircle.fillColor = [UIColor redColor];
        _redCircle.name = @"redCircle";
        [self addChild:_redCircle];
        
        //add the animation
        SKAction *wait = [SKAction waitForDuration:3];
        SKAction *animate = [SKAction runBlock:^{
            _redCircle.fillColor = [[[SharedValues allValues] colorsArray] objectAtIndex:arc4random_uniform([[[SharedValues allValues] colorsArray] count])];
            
        }];
        SKAction *animateAndWait = [SKAction sequence:@[animate, [SKAction waitForDuration:1.5]]];
        SKAction *animateForever = [SKAction repeatActionForever:animateAndWait];
        [_redCircle runAction:[SKAction sequence:@[wait, animateForever]]];
        
        
        
        //create the buttons
        SKTexture *playButton = [SKTexture textureWithImageNamed:@"Play-Button.png"];
        SKSpriteNode *playButtonNode = [SKSpriteNode spriteNodeWithTexture:playButton];
        playButtonNode.name = @"playButtonNode";
        [playButtonNode setScale:.6];
        playButtonNode.position = CGPointMake(CGRectGetMidX(self.frame), playButtonNode.size.height/2+120);
        [self addChild:playButtonNode];
        
        
        //create the settings button
        SKTexture *settings = [SKTexture textureWithImageNamed:@"Settings.png"];
        SKSpriteNode *settingsButtonNode = [SKSpriteNode spriteNodeWithTexture:settings];
        settingsButtonNode.name = @"settingsButtonNode";
        [settingsButtonNode setScale:.6];
        settingsButtonNode.position = CGPointMake(settingsButtonNode.size.width/2+10, (self.scene.frame.size.height-(settingsButtonNode.size.height/2))-30);
        [self addChild:settingsButtonNode];
        
        
        
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint touchedPosition = [touch locationInNode:self];
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchedPosition];
    
    if ([[touchedNode name] isEqualToString:@"playButtonNode"]) {
        
        GameModeScene *gameModeScene = [GameModeScene sceneWithSize:self.scene.size];
        SKTransition *transition = [SKTransition fadeWithDuration:.5];
        [self.scene.view presentScene:gameModeScene transition:transition];
        
    } else if ([[touchedNode name] isEqualToString:@"settingsButtonNode"]) {
        
        SettingsScene *settingsScene = [SettingsScene sceneWithSize:self.scene.size];
        SKTransition *transition = [SKTransition fadeWithDuration:.5];
        [self.scene.view presentScene:settingsScene transition:transition];
        
        
    }
    
    
}





@end
