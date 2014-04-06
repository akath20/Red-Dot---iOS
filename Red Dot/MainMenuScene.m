//
//  MainMenuScene.m
//  Red Dot
//
//  Created by Alex Atwater on 4/6/14.
//  Copyright (c) 2014 Alex Atwater. All rights reserved.
//

#import "MainMenuScene.h"

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
        
        
        //create the buttons
        SKShapeNode *playButton = [[SKShapeNode alloc] init];
        
        
        
    }
    return self;
}





@end
