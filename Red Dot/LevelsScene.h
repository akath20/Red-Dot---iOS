//
//  Levels.h
//  Red Dot
//
//  Created by Alex Atwater on 4/19/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface LevelsScene : SKScene

@property SKShapeNode *redCircle;
@property SKSpriteNode *playButton;
@property SKSpriteNode *itsRedButton;
@property SKSpriteNode *playAgainButton;
@property SKSpriteNode *pauseButton;
@property NSArray *colorsArray;
@property BOOL gameStarted;
@property SKLabelNode *statusLabel;
@property SKLabelNode *scoreLabel;
@property int score;
@property UIColor *currentColor;
@property UIColor *lastColor;
@property double pauseInterval;
@property BOOL lastRedWasTapped;
@property SKScene *settingsScene;
@property SKSpriteNode *settingsButton;
@property SKSpriteNode *restartButton;
@property SKAction *changeColorAction;
@property SKAction *pauseAction;
@property int notRedCount;
@property BOOL firstRun;

@end
