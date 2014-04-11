//
//  GameplayScene.m
//  Red Dot
//
//  Created by Alex Atwater on 4/6/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "GameplayScene.h"
#import "MainMenuScene.h"
#import "SharedValues.h"

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
        _timerLabel.fontColor = [UIColor blackColor];
        _timerLabel.position = CGPointMake(CGRectGetMidX(self.frame)+70, (_redCircle.position.y+circle.size.height)+40);
        _timerTextLabel = [[SKLabelNode alloc] init];
        _timerTextLabel.text = @"Timer:";
        _timerTextLabel.fontColor = [UIColor blackColor];
        _timerTextLabel.position = CGPointMake(CGRectGetMidX(self.frame)-70, (_redCircle.position.y+circle.size.height)+40);
        
        
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
        _statusLabel.position = bottomPoint;
        [self addChild:_statusLabel];
        
        
        //create the high score label
        _highScoreLabel = [[SKLabelNode alloc] init];
        _highScoreLabel.fontColor = [UIColor blackColor];
        _highScoreLabel.text = [NSString stringWithFormat:@"High Score: %@", [[[NSUserDefaults standardUserDefaults] objectForKey:@"highScore"] objectForKey:@"raceTheClock"]];
        _highScoreLabel.position = CGPointMake(CGRectGetMidX(self.frame), _timerTextLabel.position.y+25);
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"highScores"] objectForKey:@"raceTheClock"]) {
            //if a score there
            _highScoreLabel.hidden = false;
        } else {
            _highScoreLabel.hidden = true;
        }
        [self addChild:_highScoreLabel];
        

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
            _redCircle.fillColor = [[[SharedValues allValues] colorsArray] objectAtIndex:arc4random_uniform([[[SharedValues allValues] colorsArray] count])];
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
    
    
    [self updateTimer];
    _timerLabel.text = [NSString stringWithFormat:@"00.000"];
    
    //show the timer
    
    [self addChild:_timerLabel];
    [self addChild:_timerTextLabel];
    _statusLabel.text = @"Tap the dot to begin.";
    
    
    
    
    
    
}

- (void)startGame {
     
    _currentlyPlaying = true;
    _endOfGame = false;
    _userStart = false;
    

    [self startTimer];
    
    //put the ending button in
    [self addChild:_itsRedButton];
    [self addChild:_restartButton];
    _statusLabel.text = @"";
    
    
     
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
    [self.stopWatchTimer invalidate];
    self.stopWatchTimer = nil;
    [self updateTimer];
    
    //evaluate if a valid score here
    
    if ([_redCircle fillColor] == [UIColor redColor]) {
        //if a valid score
        
        //get the time as a value
        
        double time = [_timerLabel.text doubleValue];
        
        if ((time < [[[[NSUserDefaults standardUserDefaults] objectForKey:@"highScores"] objectForKey:@"raceTheClock"] doubleValue]) || (![[[NSUserDefaults standardUserDefaults] objectForKey:@"highScores"] objectForKey:@"raceTheClock"])) {
            //if beat high score or there is no high score on file
            
            //put in the save file
            [[[NSUserDefaults standardUserDefaults] objectForKey:@"highScores"] setDouble:time forKey:@"raceTheClock"];
            
            //update the text and make sure it's showing
            _highScoreLabel.text = [NSString stringWithFormat:@"Fastest Time: %@", [[[NSUserDefaults standardUserDefaults] objectForKey:@"highScore"] objectForKey:@"raceTheClock"]];
            _highScoreLabel.hidden = false;
            
            //tell the user of their new time
            _statusLabel.text = @"New Fastest Time!";
            
            
            
            
        } else {
            //if didn't beat high score
            
            //update the text and make sure it's showing
            _highScoreLabel.text = [NSString stringWithFormat:@"Fastest Time: %@", [[[NSUserDefaults standardUserDefaults] objectForKey:@"highScore"] objectForKey:@"raceTheClock"]];
            _highScoreLabel.hidden = false;
            
        }
        
        
        
    } else {
        //if an invalid score
        
        _statusLabel.text = @"That's not red! Time not recorded.";
        
        
        
    }
    
    
    
    
    
    
    //get ready to go again
    [_itsRedButton removeFromParent];
    [self addChild:_playAgainButton];
    [_restartButton removeFromParent];
    
    
    
    
    
}

- (void)startTimer {
    
    self.startDate = [NSDate date];
    
    // Create the stop watch timer
    self.stopWatchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/1000.0
                                                           target:self
                                                         selector:@selector(updateTimer)
                                                         userInfo:nil
                                                          repeats:YES];
    
}

- (void)updateTimer {
    
    // Create date from the elapsed time
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:self.startDate];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    // Create a date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"ss.SSS"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    
    // Format the elapsed time and set it to the label
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    _timerLabel.text = timeString;
    
    
}












@end
