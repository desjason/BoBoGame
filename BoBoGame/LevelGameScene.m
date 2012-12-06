//
//  LevelGameScene.m
//  BoBoGame
//
//  Created by Lu Cao on 12-11-28.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "LevelGameScene.h"


@implementation LevelGameScene
+(id) scene
{
    CCScene *scene = [CCScene node];
    CCLayer *layer = [LevelGameScene node];
    [scene addChild:layer];
    return  scene;
}

-(id) init
{
    if (self = [super init]) {
        glClearColor(1, 1, 1, 1);
        //CCSpriteFrameCache* frameCache = [CCSpriteFrameCache sharedSpriteFrameCache];
		//[frameCache addSpriteFramesWithFile:@"enemy.plist"];
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        GamePerson *person = [GamePerson person];
        person.position = CGPointMake(80, screenSize.height / 2);
        person.scale = 0.5;
        person.visible = NO;
        person.tag = PersonTag;
        GameBubble *bubble = [GameBubble bubble];
        bubble.position = CGPointMake(screenSize.width/2, screenSize.height/2);
        bubble.visible = YES;
        bubble.scale = 0.3;
        self.isTouchEnabled = YES;
        //ParallaxBackground* background = [ParallaxBackground node];
        //background.position = CGPointMake(screenSize.width/2, screenSize.height);
        ParallaxBackgroundNew* background = [ParallaxBackgroundNew background];
        background.position = CGPointMake(screenSize.width/2, screenSize.height);
        //EnemyCache* enemyCache = [EnemyCache node];
        //[background addChild:enemyCache z:-1];
        [self addChild:background z:-1 tag:BackgroundTag];
        [self addChild:person z:-1 tag:PersonTag];
        [self addChild:bubble z:0 tag:BubbleTag];
        
        EnemyCache* enemyCache = [EnemyCache node];
		[self addChild:enemyCache];
        [self scheduleUpdate];
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
    CCNode *nodePerson = [self getChildByTag:PersonTag];
    CCNode *nodeBubble = [self getChildByTag:BubbleTag];
    CCNode *back = [self getChildByTag:BackgroundTag];
    //CCNode *nodeBackground = [self getChildByTag:BackgroundTag];
    //NSAssert([node isKindOfClass:CCSpriteIndexNotInitialized], ;)
    CCSprite *person = (GamePerson *)nodePerson;
    CCSprite *bubble = (GameBubble *)nodeBubble;
    ParallaxBackgroundNew* backg = (ParallaxBackgroundNew*)back;
    //ParallaxBackground* background = (ParallaxBackground*)nodeBackground;
    BOOL touchedForMe = CGRectContainsPoint([bubble boundingBox], location);
    if (!touchedForMe) {
        person.position = CGPointMake(location.x, location.y);
        person.visible = YES;
        person.flipX = YES;
        if (location.x <= bubble.position.x) {
            id flpx = [CCOrbitCamera actionWithDuration:2 radius:1 deltaRadius:0 angleZ:-90 deltaAngleZ:-90 angleX:0 deltaAngleX:0];
            CCCallFunc* func = [CCCallFunc actionWithTarget:self selector:@selector(onCallFunc)];
            CCSequence* sequence = [CCSequence actions:flpx,func, nil];
            [person runAction:sequence];
        }else{
            id flpx = [CCOrbitCamera actionWithDuration:2 radius:1 deltaRadius:0 angleZ:-90 deltaAngleZ:-90 angleX:0 deltaAngleX:0];
            CCRotateBy* rotateby = [CCRotateBy actionWithDuration:0 angle:90];
            CCCallFunc* func = [CCCallFunc actionWithTarget:self selector:@selector(onCallFunc)];
            CCSequence* sequence = [CCSequence actions:flpx,rotateby,func, nil];
            [person runAction:sequence];
        }
        
        float xPos = location.x-bubble.position.x;
        float yPos = location.y-bubble.position.y;
        //[background move:xPos:yPos];
        [backg move:xPos :yPos];
    }
    
    return !touchedForMe;
}
-(void)onCallFunc
{
    CCNode* node = [self getChildByTag:PersonTag];
    NSAssert([node isKindOfClass:[GamePerson class]], @"not a GamePerson");
    CCSprite* person = (GamePerson*)node;
    person.visible = NO;
}
-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    
}
-(void)update:(ccTime)delta
{
    CCNode* node = [self getChildByTag:PersonTag];
    NSAssert([node isKindOfClass:[GamePerson class]], @"not a GamePerson");
    CCSprite* person = (GamePerson*)node;
    if (person.visible == YES) {
        self.isTouchEnabled = NO;
    }else{
        self.isTouchEnabled = YES;
    }
}
-(void) dealloc
{
    [super dealloc];
}
@end
