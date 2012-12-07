//
//  LevelGameScene.h
//  BoBoGame
//
//  Created by Lu Cao on 12-11-28.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GamePerson.h"
#import "LeverFinishingLine.h"
#import "ParallaxBackground.h"
#import "ParallaxBackgroundNew.h"
#import "EnemyCache.h"
#import "GameBubble.h"
#import "Enemy.h"
#define PersonTag 10
#define BubbleTag 20
#define BackgroundTag 30
#define LineTag 40
#define MoguTag 50
#define WallTag1 60
#define WallTag2 70
#define WuguiTag 80
@interface LevelGameScene : CCLayer {
    CGRect rectMogu;
    CGRect  rectWall1;
    CGRect  rectWall2;
    CGRect  rectWugui;
    CGRect  rectLine;
}
+(id) scene;
-(void)isGameFailedOrSuccessed;
@end
