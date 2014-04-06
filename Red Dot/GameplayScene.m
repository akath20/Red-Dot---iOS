//
//  GameplayScene.m
//  Red Dot
//
//  Created by Alex Atwater on 4/6/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "GameplayScene.h"
#import "MainMenuScene.h"

@implementation GameplayScene

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
        
        //create the back button
        SKTexture *backButtonTexture = [SKTexture textureWithImageNamed:@"Back-Button"];
        SKSpriteNode *backButton = [SKSpriteNode spriteNodeWithTexture:backButtonTexture];
        [backButton setScale:.4];
        backButton.position = CGPointMake(backButton.size.width/2+10, (self.scene.frame.size.height-(backButton.size.height/2))-30);
        backButton.name = @"backButton";
        [self addChild:backButton];
        
        //create the start button
        SKTexture *startTexture = [SKTexture textureWithImageNamed:@"Start-Button.png"];
        _startButton = [SKSpriteNode spriteNodeWithTexture:startTexture];
        _startButton.name = @"startButton";
        [self addChild:_startButton];
        
        
        //create the timer
        _timerLabel = [[SKLabelNode alloc] init];
        _timer = 0.00;
        _timerLabel.text = [NSString stringWithFormat:@"Timer: %f", _timer];
        _timerLabel.position = CGPointMake(CGRectGetMinX(self.frame), _redCircle.position.y+30);
        
        
        //create the it's red button
        SKTexture *itsRedButtonTexture = [SKTexture textureWithImageNamed:@"Its-Red-Button.png"];
        _itsRedButton = [SKSpriteNode spriteNodeWithTexture:itsRedButtonTexture];
        _itsRedButton.name = @"itsRedButton";
        
        
        
        
        _currentlyPlaying = false;
        
        
    }
    return self;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint touchedPosition = [touch locationInNode:self];
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchedPosition];
    
    
    if ([[touchedNode name] isEqualToString:@"redCircle"]) {
        
        _redCircle.fillColor = [UIColor colorWithRed:drand48() green:drand48() blue:drand48() alpha:1];
        
    } else if ([[touchedNode name] isEqualToString:@"backButton"]) {
        
        MainMenuScene *mainMenu = [MainMenuScene sceneWithSize:self.scene.size];
        SKTransition *transition = [SKTransition fadeWithDuration:.5];
        [self.scene.view presentScene:mainMenu transition:transition];
        
    } else if ([[touchedNode name] isEqualToString:@"startButton"]) {
        
        [self setupGame];
    }
    
    
    
    
}

- (void)setupGame {
    
    //setup the game here
    
    //remove the button
    [_startButton removeFromParent];
    
    _currentlyPlaying = false;
    _redCircle.fillColor = [UIColor redColor];
    
    if (_timer != 0.00) {
        _timer = 0.00;
    }
    
    //show the timer
    [self addChild:_timerLabel];
    
    
    
    
    
}

- (void)startTimer {
    
    float interval = .001;
    
    SKAction *wait = [SKAction waitForDuration:interval];
    SKAction *addToTimer = [SKAction runBlock:^{
        //update the timer
        _timer += interval;
        _timerLabel.text = [NSString stringWithFormat:@"Timer: %f", _timer];
    }];
    SKAction *theTimer = [SKAction sequence:@[wait, addToTimer]];
    SKAction *repeatTimer = [SKAction repeatActionForever:theTimer];
    [_timerLabel runAction:repeatTimer];
    
}
     
- (void)startGame {
     
     _currentlyPlaying = true;
     [self startTimer];
    
    //change the buttons
    

     
     
     
     
     
 }















@end
