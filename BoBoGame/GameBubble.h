//
//  GameBubble.h
//  BoBoGame
//
//  Created by Lu Cao on 12-12-1.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameBubble : CCSprite {
    
}
+(id)bubble;
-(BOOL)isBubbleAndEnemyColliding:(CGRect)rect;
@end
