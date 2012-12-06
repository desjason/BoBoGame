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
#import "ParallaxBackground.h"
#import "ParallaxBackgroundNew.h"
#import "EnemyCache.h"
#import "GameBubble.h"
#define PersonTag 10
#define BubbleTag 20
#define BackgroundTag 30
@interface LevelGameScene : CCLayer {
    
}
+(id) scene;
@end
