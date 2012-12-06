//
//  ParallaxBackground.h
//  BoBoGame
//
//  Created by Lu Cao on 12-11-30.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "EnemyCache.h"

@interface ParallaxBackground : CCNode {
    CCSprite *sprite;
    //CCSpriteBatchNode *spriteBatch;
}
-(void)move:(float)x:(float)y;
-(id)getSprite;
@end
