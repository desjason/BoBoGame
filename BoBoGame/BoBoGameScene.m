//
//  BoBoGameScene.m
//  BoBoGame
//
//  Created by Lu Cao on 12-11-23.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "BoBoGameScene.h"


@implementation BoBoGameScene
+(id) scene
{
    CCScene * scene = [CCScene node];
    CCLayer * layer = [BoBoGameScene node];
    [scene addChild:layer];
    
    return scene;
}
-(id) init
{
    if(self = [super init])
    {
        CCLOG(@"%@:%@",NSStringFromSelector(_cmd),self);
        gameLevelChoose  = [CCLabelTTF labelWithString:@"游戏选关" fontName:@"AppleGothic" fontSize:32];
        gameIntroduction = [CCLabelTTF labelWithString:@"游戏介绍" fontName:@"AppleGothic" fontSize:32];
        gameSetting = [CCLabelTTF labelWithString:@"游戏设置" fontName:@"AppleGothic" fontSize:32];
        gameBegin = [CCLabelTTF labelWithString:@"游戏开始" fontName:@"AppleGothic" fontSize:32];
        sprite = [CCSprite spriteWithFile:@"back3.png"];
        [self addChild:sprite];
        [self addChild:gameLevelChoose z:1 tag:GameLevelChooseTag];
        [self addChild:gameIntroduction z:2 tag:GameIntroductionTag];
        [self addChild:gameSetting z:3 tag:GameSettingTag];
        [self addChild:gameBegin z:4 tag:GameBeginTag];
        self.isTouchEnabled = YES;
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        gameLevelChoose.position = CGPointMake(screenSize.width/2, screenSize.height*0.4);
        gameIntroduction.position = CGPointMake(screenSize.width/2, screenSize.height*0.5);
        gameSetting.position = CGPointMake(screenSize.width/2, screenSize.height*0.6);
        gameBegin.position = CGPointMake(screenSize.width/2, screenSize.height*0.7);
        sprite.position = ccp(screenSize.width/2, screenSize.height/2);
    }
    return self;
   
}

-(void) registerWithTouchDispatcher
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:-1 swallowsTouches:YES];
    //[super registerWithTouchDispatcher];
}
-(CGPoint) locationFromTouch:(UITouch *)touches
{
    CGPoint touchLocation = [touches locationInView:[touches view]];
    return [[CCDirector sharedDirector] convertToGL:touchLocation];
}
-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint location = [self locationFromTouch:touch];
    CCNode * nodeIntroduction = [self getChildByTag:GameIntroductionTag];
    CCNode * nodeSetting = [self getChildByTag:GameSettingTag];
    CCNode * nodeLevel = [self getChildByTag:GameLevelChooseTag];
    CCNode * nodeBegin = [self getChildByTag:GameBeginTag];
    BOOL introduction = CGRectContainsPoint([nodeIntroduction boundingBox], location);
    BOOL setting = CGRectContainsPoint([nodeSetting boundingBox], location);
    BOOL level = CGRectContainsPoint([nodeLevel boundingBox], location);
    BOOL begin = CGRectContainsPoint([nodeBegin boundingBox], location);
    if (introduction) {
        [[CCDirector sharedDirector] replaceScene:[GameIntroductionScene scene]];
    }else if (setting){
        [[CCDirector sharedDirector] replaceScene:[GameIntroductionScene scene]];
    }else if (level){
        [[CCDirector sharedDirector] replaceScene:[GameIntroductionScene scene]];
    }else if (begin){
        [[CCDirector sharedDirector] replaceScene:[LevelGameScene scene]];
    }

    return introduction && setting && level && begin;
}
-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    
}
-(void) dealloc
{
    CCLOG(@"%@:%@",NSStringFromSelector(_cmd),self);
    [super dealloc];
}
@end
