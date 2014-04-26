//
//  GameplayScene.h
//  Red Dot
//
//  Created by Alex Atwater on 4/6/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface RaceTheClock : SKScene

@property SKShapeNode *redCircle;
@property SKSpriteNode *startButton;
@property BOOL currentlyPlaying;
@property SKLabelNode *timerLabel;
@property SKLabelNode *timerTextLabel;
@property SKSpriteNode *itsRedButton;
@property BOOL endOfGame;
@property BOOL userStart;
@property SKSpriteNode *playAgainButton;
@property SKSpriteNode *restartButton;
@property (strong, nonatomic) NSTimer *stopWatchTimer; 
@property (strong, nonatomic) NSDate *startDate;
@property SKLabelNode *statusLabel;
@property NSArray *colorsArray;

@end
