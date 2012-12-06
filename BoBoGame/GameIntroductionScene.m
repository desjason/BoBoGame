//
//  GameIntroductionScene.m
//  BoBoGame
//
//  Created by Lu Cao on 12-11-23.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameIntroductionScene.h"


@implementation GameIntroductionScene
+(id) scene
{
    CCScene * scene = [CCScene node];
    CCLayer * layer = [GameIntroductionScene node];
    [scene addChild:layer];
    return scene;

}
-(id) init
{
    if (self = [super init]) {
        CCLOG(@"%@:%@",NSStringFromSelector(_cmd),self);
        label = [CCLabelTTF labelWithString:@"非常好玩的游戏!" fontName:@"AppleGothic" fontSize:32];
        
        background = [CCSprite spriteWithFile:@"bb.png"];
        sprite = [CCSprite spriteWithFile:@"back.png"];
        [self addChild:background];
        [self addChild:sprite];
        [self addChild:label z:0 tag:Tag];
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        label.position = CGPointMake(screenSize.width/2, screenSize.height/2);
        float imagewidth = [sprite texture].contentSize.width;
        float imageheight = [sprite texture].contentSize.height;
        sprite.position = CGPointMake(screenSize.width-imagewidth, imageheight/2);
        background.position = CGPointMake(screenSize.width/2, screenSize.height/2);
        self.isTouchEnabled = YES;
        
    }
    return self;
}
-(CGPoint) locationFromTouch:(UITouch *)touches
{
    CGPoint touchLocation = [touches locationInView:[touches view]];
    return [[CCDirector sharedDirector] convertToGL:touchLocation];
}
-(void) registerWithTouchDispatcher
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-1 swallowsTouches:YES];
}
-(BOOL ) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint location = [self locationFromTouch:touch];
    BOOL touchedForMe = CGRectContainsPoint([sprite boundingBox], location);
    if (touchedForMe) {
        [[CCDirector sharedDirector] replaceScene:[BoBoGameScene scene]];
    }
    return touchedForMe;
}
-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    
}
-(void) dealloc
{
    [super dealloc];
}
@end
