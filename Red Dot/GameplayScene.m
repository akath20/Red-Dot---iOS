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
        _redCircle.position = CGPointMake(size.width/2-circle.size.width/2, size.height/2);
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
        
        //here is the bottem button location
        CGPoint bottomPoint = CGPointMake(CGRectGetMidX(self.frame), _startButton.size.height/2+120);
        float buttonScale = .6;
        
        //create the start button
        SKTexture *startTexture = [SKTexture textureWithImageNamed:@"Start-Button.png"];
        _startButton = [SKSpriteNode spriteNodeWithTexture:startTexture];
        _startButton.position = bottomPoint;
        _startButton.name = @"startButton";
        [_startButton setScale:buttonScale];
        [self addChild:_startButton];
        
        
        //create the timer
        _timerLabel = [[SKLabelNode alloc] init];
        _timer = 0.000;
        _timerLabel.text = [NSString stringWithFormat:@"%.2f", _timer];
        _timerLabel.fontColor = [UIColor blackColor];
        _timerLabel.position = CGPointMake(CGRectGetMidX(self.frame)+50, (_redCircle.position.y+circle.size.height)+40);
        _timerTextLabel = [[SKLabelNode alloc] init];
        _timerTextLabel.text = @"Timer:";
        _timerTextLabel.fontColor = [UIColor blackColor];
        _timerTextLabel.position = CGPointMake(CGRectGetMidX(self.frame)-50, (_redCircle.position.y+circle.size.height)+40);
        
        
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
        
        
        //create the tap to begin label
        _tapToBegin = [[SKLabelNode alloc] init];
        _tapToBegin.fontColor = [UIColor blackColor];
        _tapToBegin.text = @"Tap the dot to start";
        _tapToBegin.position = bottomPoint;
        
        
        //create the restart button
        SKTexture *restartButtonTexture = [SKTexture textureWithImageNamed:@"Restart-Button.png"];
        _restartButton = [SKSpriteNode spriteNodeWithTexture:restartButtonTexture];
        [self.restartButton setScale:.4];
        _restartButton.position = CGPointMake((self.scene.frame.size.width-(self.restartButton.size.width/2))-10, (self.scene.frame.size.height-(self.restartButton.size.height/2))-30);
        _restartButton.name = @"restartButton";
        
        
        
        //other variables
        _currentlyPlaying = false;
        _endOfGame = false;
        _userStart = false;
        
        
    }
    
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint touchedPosition = [touch locationInNode:self];
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchedPosition];
    
    
    if ([[touchedNode name] isEqualToString:@"redCircle"]) {
        
        if (!_endOfGame) {
            //if it's note the end of the game
            _redCircle.fillColor = [UIColor colorWithRed:drand48() green:drand48() blue:drand48() alpha:1];
        }
        
        if (_userStart) {
            [self startGame];
            _userStart = false;
        }
        
        
    } else if ([[touchedNode name] isEqualToString:@"backButton"]) {
        
        MainMenuScene *mainMenu = [MainMenuScene sceneWithSize:self.scene.size];
        SKTransition *transition = [SKTransition fadeWithDuration:.5];
        [self.scene.view presentScene:mainMenu transition:transition];
        
    } else if ([[touchedNode name] isEqualToString:@"startButton"]) {
        
        [self setupGame];
        //remove the button
        [_startButton removeFromParent];
        
    } else if ([[touchedNode name] isEqualToString:@"itsRedButton"]) {
        
        //this is the end of the game
        [self endGame];
        
    } else if ([[touchedNode name] isEqualToString:@"playAgainButton"]) {
        
        //remove button
        [_playAgainButton removeFromParent];
        [_timerLabel removeFromParent];
        [_timerTextLabel removeFromParent];
        
        //setup the game again
        [self setupGame];
        
    } else if ([[touchedNode name] isEqualToString:@"restartButton"]) {
        
        [self restartGame];
        
    }
    
    
    
    
}

- (void)setupGame {
    
    //setup the game here
    
    
    
    
    _currentlyPlaying = false;
    _endOfGame = false;
    _userStart = true;
    _redCircle.fillColor = [UIColor redColor];
    
    if (_timer != 0.00) {
        _timer = 0.00;
    }
    
    _timerLabel.text = [NSString stringWithFormat:@"%.2f", _timer];
    
    //show the timer
    [self addChild:_timerLabel];
    [self addChild:_timerTextLabel];
    [self addChild:_tapToBegin];
    
    
    
    
    
}

- (void)startGame {
     
    _currentlyPlaying = true;
    _endOfGame = false;
    _userStart = false;
    
    
    
    [self startTimer];
    
    //put the ending button in
    [self addChild:_itsRedButton];
    [_tapToBegin removeFromParent];
    [self addChild:_restartButton];
    
    
     
}

- (void)restartGame {
    
    [_restartButton removeFromParent];
    [_timerLabel removeFromParent];
    [_timerTextLabel removeFromParent];
    [_itsRedButton removeFromParent];
    
    //stop the timer
    [_timerLabel removeActionForKey:@"timer"];
    
    [self setupGame];
    
    
    
}

- (void)endGame {
    
    _endOfGame = true;
    _userStart = false;
    
    //stop the timer
    [_timerLabel removeActionForKey:@"timer"];
    
    //evaluate if a valid score here
    
    
    
    
    
    
    
    //get ready to go again
    [_itsRedButton removeFromParent];
    [self addChild:_playAgainButton];
    [_restartButton removeFromParent];
    
    
    
    
    
}

- (void)startTimer {
    
    float interval = .01;
    
    SKAction *wait = [SKAction waitForDuration:interval];
    SKAction *addToTimer = [SKAction runBlock:^{
        //update the timer
        _timer += interval;
        _timerLabel.text = [NSString stringWithFormat:@"%.2f", _timer];
        
    }];
    SKAction *theTimer = [SKAction sequence:@[wait, addToTimer]];
    SKAction *repeatTimer = [SKAction repeatActionForever:theTimer];
    [_timerLabel runAction:repeatTimer withKey:@"timer"];
    
}












@end
