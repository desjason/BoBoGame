//
//  BoBoGameScene.h
//  BoBoGame
//
//  Created by Lu Cao on 12-11-23.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameIntroductionScene.h"
#import "LevelGameScene.h"
#define GameLevelChooseTag 1
#define GameIntroductionTag 2
#define GameSettingTag 3
#define GameBeginTag 4
@interface BoBoGameScene : CCLayer {
    CCLabelTTF* gameLevelChoose;
    CCLabelTTF* gameIntroduction;
    CCLabelTTF* gameSetting;
    CCLabelTTF* gameBegin;
    CCSprite * sprite;
}
+(id) scene;
-(CGPoint) locationFromTouch:(UITouch *)touches;
@end
