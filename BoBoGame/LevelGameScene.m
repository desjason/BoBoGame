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
        
        Enemy* mogu = [Enemy enemyWithType:0];
        Enemy* wall1= [Enemy enemyWithType:1];
        Enemy* wall2= [Enemy enemyWithType:1];
        Enemy* wugui = [Enemy enemyWithType:2];
        mogu.scale = 0.5;
        wall1.scale = 0.75;
        wall2.scale = 0.75;
        wugui.scale = 1.0;
        mogu.visible = YES;
        wall1.visible = YES;
        wall2.visible = YES;
        wugui.visible = YES;
        //ParallaxBackground* background = [ParallaxBackground node];
        //background.position = CGPointMake(screenSize.width/2, screenSize.height);
        ParallaxBackgroundNew* background = [ParallaxBackgroundNew background];
        background.position = CGPointMake(screenSize.width/2, screenSize.height/2);
        
        LeverFinishingLine* line = [LeverFinishingLine finishingLine];
        [background addChild:line z:1 tag:LineTag];
        [background addChild:mogu z:1 tag:MoguTag];
        [background addChild:wall1 z:1 tag:WallTag1];
        [background addChild:wall2 z:1 tag:WallTag2];
        [background addChild:wugui z:1 tag:WuguiTag];
        
        CGSize size = background.contentSize;
        line.position = CGPointMake(size.width/2+2*screenSize.width, 1.63*screenSize.height);
        mogu.position = CGPointMake(size.width/2+screenSize.width/2, size.height/2);
        wall1.position = CGPointMake(size.width/2+screenSize.width, size.height*0.37);
        wall2.position = CGPointMake(size.width/2+screenSize.width, size.height*0.63);
        wugui.position = CGPointMake(size.width/2+1.5*screenSize.width, size.height/2);
        rectMogu = CGRectMake(mogu.position.x-size.width/2+screenSize.width/2-mogu.contentSize.width/2, mogu.position.y-size.height/2+screenSize.height/2-mogu.contentSize.height/2, mogu.contentSize.width, mogu.contentSize.height);
        rectWall1 = wall1.boundingBox;
        rectWall2 = wall2.boundingBox;
        rectWugui = wugui.boundingBox;
        rectLine = line.boundingBox;
        CCLOG(@"%f %f %f %f",rectMogu.origin.x,rectMogu.origin.y,rectMogu.size.width,rectMogu.size.height);
        CCLOG(@"%f %f %f %f",bubble.boundingBox.origin.x,bubble.boundingBox.origin.y,bubble.boundingBox.size.width,bubble.boundingBox.size.height);
        [self addChild:background z:1 tag:BackgroundTag];
        [self addChild:person z:1 tag:PersonTag];
        [self addChild:bubble z:1 tag:BubbleTag];
        
        
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

    GamePerson *person = (GamePerson *)nodePerson;
    GameBubble *bubble = (GameBubble *)nodeBubble;
    ParallaxBackgroundNew* backg = (ParallaxBackgroundNew*)back;

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
    //[self isGameFailedOrSuccessed];
}
-(void)isGameFailedOrSuccessed
{
    //CCNode *nodePerson = [self getChildByTag:PersonTag];
    CCNode *nodeBubble = [self getChildByTag:BubbleTag];
    CCNode *back = [self getChildByTag:BackgroundTag];

    //GamePerson *person = (GamePerson *)nodePerson;
    GameBubble *bubble = (GameBubble *)nodeBubble;
    ParallaxBackgroundNew* backg = (ParallaxBackgroundNew*)back;
    
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    CGSize size = backg.contentSize;
    rectMogu = CGRectMake(rectMogu.origin.x-(screenSize.width/2-backg.position.x)/2,rectMogu.origin.y-(screenSize.height/2-backg.position.y)/2,rectMogu.size.width,rectMogu.size.height);
    
    BOOL bool1 = CGRectIntersectsRect([bubble boundingBox], rectMogu);
    BOOL bool2 = CGRectIntersectsRect([bubble boundingBox], rectWall1);
    BOOL bool3 = CGRectIntersectsRect([bubble boundingBox], rectWall2);
    BOOL bool4 = CGRectIntersectsRect([bubble boundingBox], rectWugui);
    BOOL bool5 = CGRectIntersectsRect([bubble boundingBox], rectLine);
    if (bool1 || bool2 || bool3 || bool4) {
        bubble.visible = NO;
        /*GameBubble* bubbleFailed = [GameBubble bubble];
        bubbleFailed.visible = YES;
        bubbleFailed.scale = 0.5;
        bubbleFailed.position = CGPointMake(backg.position.x, backg.position.y/2);
        CCMoveTo* to = [CCMoveTo actionWithDuration:1 position:CGPointMake(backg.position.x, backg.position.y)];
        CCEaseInOut* ease = [CCEaseInOut actionWithAction:to rate:2];
        [bubbleFailed runAction:ease];*/
        //self.isTouchEnabled = NO;
    } else if(bool5){
        
        //GameBubble* bubbleSuccessed = [GameBubble bubble];
        //self.isTouchEnabled = NO;
    }

}
-(void) dealloc
{
    [super dealloc];
}
@end
