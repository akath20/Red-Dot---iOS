//
//  Levels.m
//  Red Dot
//
//  Created by Alex Atwater on 4/19/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "LevelsScene.h"
#import "SharedValues.h"

@implementation LevelsScene

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
        
        //create the settings button
        SKTexture *settings = [SKTexture textureWithImageNamed:@"Settings.png"];
        SKSpriteNode *settingsButtonNode = [SKSpriteNode spriteNodeWithTexture:settings];
        settingsButtonNode.name = @"settingsButton";
        [settingsButtonNode setScale:.4];
        settingsButtonNode.position = CGPointMake(settingsButtonNode.size.width/2+10, (self.scene.frame.size.height-(settingsButtonNode.size.height/2))-30);
        [self addChild:settingsButtonNode];
        
        //here is the bottem button location
        CGPoint bottomPoint = CGPointMake(CGRectGetMidX(self.frame), _playButton.size.height/2+120);
        float buttonScale = .6;
        
        //create the start button
        SKTexture *startTexture = [SKTexture textureWithImageNamed:@"Start-Button.png"];
        _playButton = [SKSpriteNode spriteNodeWithTexture:startTexture];
        _playButton.position = bottomPoint;
        _playButton.name = @"startButton";
        [_playButton setScale:buttonScale];
        [self addChild:_playButton];
        
        //create the it's red button
        SKTexture *itsRedButtonTexture = [SKTexture textureWithImageNamed:@"Its-Red-Button.png"];
        _itsRedButton = [SKSpriteNode spriteNodeWithTexture:itsRedButtonTexture];
        _itsRedButton.position = bottomPoint;
        [_itsRedButton setScale:buttonScale];
        _itsRedButton.name = @"itsRedButton";
        
        
        //create the play again button
        SKTexture *playAgainTexture = [SKTexture textureWithImageNamed:@"Play-Again"];
        _playAgainButton = [SKSpriteNode spriteNodeWithTexture:playAgainTexture];
        _playAgainButton.position = bottomPoint;
        [_playAgainButton setScale:buttonScale];
        _playAgainButton.name = @"playAgainButton";
        
        //create the score label
        _scoreLabel = [[SKLabelNode alloc] init];
        _scoreLabel.fontColor = [UIColor blackColor];
        _scoreLabel.position = CGPointMake(CGRectGetMidX(self.frame), (_redCircle.position.y+circle.size.height)+40);
        _scoreLabel.text = @"";
        
        
        //create the restart button
        SKTexture *restartButtonTexture = [SKTexture textureWithImageNamed:@"Restart-Button.png"];
        _pauseButton = [SKSpriteNode spriteNodeWithTexture:restartButtonTexture];
        [self.pauseButton setScale:.4];
        _pauseButton.position = CGPointMake((self.scene.frame.size.width-(self.pauseButton.size.width/2))-10, (self.scene.frame.size.height-(self.pauseButton.size.height/2))-30);
        _pauseButton.name = @"restartButton";
        
        //create the status label
        _statusLabel = [[SKLabelNode alloc] init];
        _statusLabel.fontColor = [UIColor blackColor];
        _statusLabel.text = @"";
        _statusLabel.fontSize = 18;
        _statusLabel.position = CGPointMake(bottomPoint.x, bottomPoint.y+(_playButton.size.height/2)+25);
        [self addChild:_statusLabel];
        
        //other variables
        _colorsArray = [[SharedValues allValues] colorsArray];
        _gameStarted = false;
        _currentColor = nil;
        _lastColor = nil;
        
        
        
        
        
    }
    
    return self;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint touchedPosition = [touch locationInNode:self];
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchedPosition];
    
    if (_gameStarted) {
        
        //if the game is being played
        
        if ([[touchedNode name] isEqualToString:@"itsRedButton"]) {
            
            if ([_currentColor isEqual:[UIColor redColor]]) {
                //put the score up and move on
                //make a method to evaluate when score moved up to make game harder
                
                
                
                _lastRedNoTap = false;
                
                
            } else {
                
                //end game here
                [self gameOver];
                
            }
            
            
            
        }
        
        //pause button
        
        
    } else {
        //game isn't being played
        
        if ([[touchedNode name] isEqualToString:@"startButton"]) {
            
            [self startGame];
            
            
        }
        
        
        //settings button
        
        
        
    }
    
    
    
    
}


- (void)setupGame {
    
    //start the game here
    
    //NEED A PAUSE BUTTON
    __block BOOL x = true;
    
    
    [_playButton removeFromParent];
    
    //countdown timer
    SKAction *timer3 = [SKAction customActionWithDuration:1 actionBlock:^(SKNode *node, CGFloat elapsedTime) {
        _statusLabel.text = @"3";
    }];
    SKAction *timer2 = [SKAction customActionWithDuration:1 actionBlock:^(SKNode *node, CGFloat elapsedTime) {
        _statusLabel.text = @"2";
    }];
    SKAction *timer1 = [SKAction customActionWithDuration:1 actionBlock:^(SKNode *node, CGFloat elapsedTime) {
        _statusLabel.text = @"1";
        
    }];
    SKAction *timerGo = [SKAction customActionWithDuration:1 actionBlock:^(SKNode *node, CGFloat elapsedTime) {
        _statusLabel.text = @"Go!";
        
        if (x) {
            [self startGame];
            x = false;
        }

    }];
    
    [_statusLabel runAction:[SKAction sequence:[NSArray arrayWithObjects:timer3, timer2, timer1, timerGo, nil]]];
    
    _score = 0;
    
    //in seconds
    _pauseInterval = 2.0;
    _lastRedNoTap = false;
    
    

}

- (void)startGame {
    
    
    _gameStarted = true;
    
    //remove status label
    SKAction *wait = [SKAction waitForDuration:1];
    SKAction *removeFromParent = [SKAction removeFromParent];
    [_statusLabel runAction:[SKAction sequence:[NSArray arrayWithObjects:wait, removeFromParent, nil]]];
    
    
    //add the its red button
    [self addChild:_itsRedButton];
    
    //in seconds
    _pauseInterval = 2.0;
    
    //add the game function here
    //MIGHT NOT UPDATE THE PAUSE DURATION HERE
    SKAction *pause = [SKAction waitForDuration:_pauseInterval];
    SKAction *changeColor = [SKAction runBlock:^{
        //get the one before change
        _lastColor = _redCircle.fillColor;
        _redCircle.fillColor = [_colorsArray objectAtIndex:arc4random_uniform((int)[_colorsArray count])];
        //get the current one after change
        _currentColor = _redCircle.fillColor;
        
        //evaluate here if the last color was red and if the user missed it or not
        //if the last color was red and the user didn't tap it
        if ([_lastColor isEqual:[UIColor redColor]] && _lastRedNoTap) {
            [self gameOver];
        }
        
    }];
    [_redCircle runAction:[SKAction repeatActionForever:[SKAction sequence:[NSArray arrayWithObjects:pause, changeColor, nil]]]];
    
    
    
    
}

- (void)gameOver {
    
    
    
}






























































@end
