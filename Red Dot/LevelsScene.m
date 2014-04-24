//
//  Levels.m
//  Red Dot
//
//  Created by Alex Atwater on 4/19/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "LevelsScene.h"
#import "SharedValues.h"
#import "SettingsScene.h"

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
        _settingsButton = [SKSpriteNode spriteNodeWithTexture:settings];
        _settingsButton.name = @"settingsButton";
        [_settingsButton setScale:.4];
        _settingsButton.position = CGPointMake(_settingsButton.size.width/2+10, (self.scene.frame.size.height-(_settingsButton.size.height/2))-30);
        [self addChild:_settingsButton];
        
        //create the settings scene
        _settingsScene = [[SettingsScene alloc] initWithSize:self.frame.size];
        
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
        _scoreLabel.name = @"scoreLabel";
        [self addChild:_scoreLabel];
        
        
        //create the restart button
        SKTexture *restartButtonTexture = [SKTexture textureWithImageNamed:@"Restart-Button.png"];
        _restartButton = [SKSpriteNode spriteNodeWithTexture:restartButtonTexture];
        [self.restartButton setScale:.4];
        _restartButton.position = CGPointMake((self.scene.frame.size.width-(self.restartButton.size.width/2))-10, (self.scene.frame.size.height-(self.restartButton.size.height/2))-30);
        _restartButton.name = @"restartButton";
        
        //create the status label
        _statusLabel = [[SKLabelNode alloc] init];
        _statusLabel.fontColor = [UIColor blackColor];
        _statusLabel.text = @"";
        _statusLabel.fontSize = 18;
        _statusLabel.position = CGPointMake(bottomPoint.x, bottomPoint.y+(_playButton.size.height/2)+25);
        [self addChild:_statusLabel];
        
        //other variables
        [[SharedValues allValues] createColors];
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
                
                //update score
                _score += 1;
                _scoreLabel.text = [NSString stringWithFormat:@"%d", _score];
                
                //other variables
                _lastRedWasTapped = true;
                
                
                //change the speed
                
            
                //change the time
                if (_score%5 == 0 && !(_score == 0)) {
                    //if the score is up 5 and not 0 and didn't already change for this number
                    if (!_pauseInterval <= .3) {
                        //if it's not less than 3 then change it
                        _pauseInterval -= .1;
                        _pauseAction.duration = _pauseInterval;
                    }
                
                }
                
                
                
                
                
                
                
                
                
                
                
                
            } else {
                
                //end game here
                [self gameOver];
                
            }
            
        } else if ([[touchedNode name] isEqualToString:@"pauseButton"]) {
            
            //pause button
            
        } else if ([[touchedNode name] isEqualToString:@"restartButton"]) {
            
            [_redCircle removeAllActions];
            [self setupGame];
            
        }
        
        
        
    } else {
        //game isn't being played
        
        if ([[touchedNode name] isEqualToString:@"startButton"]) {
            
            [self setupGame];
            
        } else if ([[touchedNode name] isEqualToString:@"settingsButton"]) {
            
            //settings button
            SKTransition *transition = [SKTransition fadeWithDuration:.5];
            [self.scene.view presentScene:_settingsScene transition:transition];
            
        } else if ([[touchedNode name] isEqualToString:@"playAgainButton"]) {
            
            [self setupGame];
            
        }
        
    }
    
}


- (void)setupGame {
    
    //start the game here
   
    
    if (_playButton.parent) {
        [_playButton removeFromParent];
    }
    
    if (_playAgainButton.parent) {
        [_playAgainButton removeFromParent];
    }
    
    if (_itsRedButton.parent) {
        [_itsRedButton removeFromParent];
    }
    
    if (!_statusLabel.parent) {
        [self addChild:_statusLabel];
    }
    
    _redCircle.fillColor = [UIColor redColor];
    
    
    [_settingsButton removeFromParent];
    
    
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
    SKAction *timerGo = [SKAction runBlock:^{
        
        _statusLabel.text = @"Go!";
        [self startGame];
        
    }];
    
    [_statusLabel runAction:[SKAction sequence:[NSArray arrayWithObjects:timer3, timer2, timer1, timerGo, nil]]];
    
    _score = 0;
    _scoreLabel.text = @"0";
    
   
    //other variables
    _lastRedWasTapped = YES;
    _notRedCount = 0;
    _pauseInterval = .7;
    _pauseAction.duration = 1;


}

- (void)startGame {
    
    
    _gameStarted = true;
    
    //remove status label
    SKAction *wait = [SKAction waitForDuration:1];
    SKAction *removeFromParent = [SKAction removeFromParent];
    [_statusLabel runAction:[SKAction sequence:[NSArray arrayWithObjects:wait, removeFromParent, nil]]];
    
    //add the its red button
    [self addChild:_itsRedButton];
    
    if (!_restartButton.parent) {
        [self addChild:_restartButton];
    }
    
    //add the game function here
    //MIGHT NOT UPDATE THE PAUSE DURATION HERE
    
    _changeColorAction = [SKAction runBlock:^{
        
        
        //get the one before change
        _lastColor = _redCircle.fillColor;
        
        
        //see if the last color was red and wasn't clicked
        if ([_lastColor isEqual:[UIColor redColor]] && !_lastRedWasTapped) {
            
            [self gameOver];
            
        } else {
            //if that's all set the continue to evaluate
            
            //make sure you don't get same color twice
            UIColor *newColor = [_colorsArray objectAtIndex:arc4random_uniform([_colorsArray count])];
            while ([_lastColor isEqual:newColor]) {
                newColor = [_colorsArray objectAtIndex:arc4random_uniform([_colorsArray count])];
            }
            
            
            //make sure the game doesn't go forever without getting red, keep track
            if (![newColor isEqual:[UIColor redColor]]) {
                //if it's not red, up the count
                _notRedCount += 1;
                
            } else {
                //if it is red, restart the cout
                _notRedCount = 0;
            }
            
            
            if (_notRedCount >= 13) {
                //really 12 becuase starts at zero
                //if it hasn't been red for 7 or more times, make it red and reset the count;
                newColor = [UIColor redColor];
                _notRedCount = 0;
            }

            
            _redCircle.fillColor = newColor;
            
            //get the current one after change
            _currentColor = _redCircle.fillColor;
            
            _lastRedWasTapped = false;
            
        }
        
    }];
    _pauseAction = [SKAction waitForDuration:_pauseInterval];
    
    [self changeColor];
    
    
    
}

- (void)changeColor {
    
    [_redCircle runAction:[SKAction sequence:[NSArray arrayWithObjects:_pauseAction, _changeColorAction, nil]] completion:^{
        if (_gameStarted) {
            //if game is still being played, repeat
            [self changeColor];
        }
    }];
    
    
    
    
    
    
    
}

- (void)gameOver {
    
    //when the game is over
    _gameStarted = false;
    
    [_redCircle removeAllActions];
    [_itsRedButton removeFromParent];
    [_pauseButton removeFromParent];
    [_restartButton removeFromParent];
    [self addChild:_settingsButton];
    
    //fade in the button so they don't accidently click it
    _playAgainButton.alpha = 0.0;
    SKAction *wait = [SKAction waitForDuration:1];
    SKAction *addChild = [SKAction runBlock:^{
        [self addChild:_playAgainButton];
    }];
    SKAction *fadeIn = [SKAction fadeInWithDuration:.5];
    
    NSArray *allActions = [NSArray arrayWithObjects:wait, addChild, fadeIn, nil];
    
    SKAction *all = [SKAction sequence:allActions];
    
    [_playAgainButton runAction:all];
    
    
    //add Game Center here
    //overlay a solid colored background with score like 2048
    
    
    
}






























































@end
