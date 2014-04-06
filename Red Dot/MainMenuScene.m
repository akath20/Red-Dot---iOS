//
//  MainMenuScene.m
//  Red Dot
//
//  Created by Alex Atwater on 4/6/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "MainMenuScene.h"
#import "GameplayScene.h"

@implementation MainMenuScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        //create scene
        self.backgroundColor = [SKColor whiteColor];
        
        //create the red dot
        CGRect circle = CGRectMake(0, 0, 120.0, 120.0);
        _redCircle = [[SKShapeNode alloc] init];
        _redCircle.position = CGPointMake(size.width/2-circle.size.width/2, size.height/2+40);
        _redCircle.path = [UIBezierPath bezierPathWithOvalInRect:circle].CGPath;
        _redCircle.fillColor = [UIColor redColor];
        _redCircle.name = @"redCircle";
        [self addChild:_redCircle];
        
        //add the animation
        SKAction *wait = [SKAction waitForDuration:3];
        SKAction *animate = [SKAction runBlock:^{
            _redCircle.fillColor = [UIColor colorWithRed:drand48() green:drand48() blue:drand48() alpha:1];
            
        }];
        SKAction *animateAndWait = [SKAction sequence:@[animate, [SKAction waitForDuration:1.5]]];
        SKAction *animateForever = [SKAction repeatActionForever:animateAndWait];
        [_redCircle runAction:[SKAction sequence:@[wait, animateForever]]];
        
        
        
        //create the buttons
        SKTexture *playButton = [SKTexture textureWithImageNamed:@"Play-Button.png"];
        SKSpriteNode *playButtonNode = [SKSpriteNode spriteNodeWithTexture:playButton];
        playButtonNode.name = @"playButtonNode";
        [playButtonNode setScale:.6];
        playButtonNode.position = CGPointMake(CGRectGetMidX(self.frame), playButtonNode.size.height/2+80);
        [self addChild:playButtonNode];
        
        
        
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint touchedPosition = [touch locationInNode:self];
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchedPosition];
    
    if ([[touchedNode name] isEqualToString:@"playButtonNode"]) {
        GameplayScene *gameScene = [GameplayScene sceneWithSize:self.scene.size];
        SKTransition *transition = [SKTransition fadeWithDuration:.5];
        [self.scene.view presentScene:gameScene transition:transition];
        
    }
    
    
}





@end
