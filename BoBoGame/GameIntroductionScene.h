//
//  GameIntroductionScene.h
//  BoBoGame
//
//  Created by Lu Cao on 12-11-23.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BoBoGameScene.h"
#define Tag 1
@interface GameIntroductionScene : CCLayer {
    CCLabelTTF* label;
    CCSprite*    sprite;
    CCSprite*    background;
}
+(id) scene;
-(CGPoint) locationFromTouch:(UITouch *)touches;
@end
