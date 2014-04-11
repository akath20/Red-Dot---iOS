//
//  GameplayScene.h
//  Red Dot
//
//  Created by Alex Atwater on 4/6/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameplayScene : SKScene

@property SKShapeNode *redCircle;
@property SKSpriteNode *startButton;
@property BOOL currentlyPlaying;
@property SKLabelNode *timerLabel;
@property SKLabelNode *timerTextLabel;
@property SKSpriteNode *itsRedButton;
@property BOOL endOfGame;
@property BOOL userStart;
@property SKSpriteNode *playAgainButton;
@property SKLabelNode *tapToBegin;
@property SKSpriteNode *restartButton;
@property (strong, nonatomic) NSTimer *stopWatchTimer; 
@property (strong, nonatomic) NSDate *startDate;

@end
