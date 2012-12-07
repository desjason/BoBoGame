//
//  ParallaxBackgroundNew.h
//  BoBoGame
//
//  Created by Lu Cao on 12-12-3.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "EnemyCache.h"
#import "LeverFinishingLine.h"
#import "Enemy.h"
@interface ParallaxBackgroundNew : CCSprite {
    
}
+(id)background;
-(void)move:(float)x :(float)y;
@end
