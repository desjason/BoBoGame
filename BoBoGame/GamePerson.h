//
//  GamePerson.h
//  BoBoGame
//
//  Created by Lu Cao on 12-11-28.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GamePerson : CCSprite {
    
}
+(id) person;
-(BOOL) isPersonAndEnemyColliding:(CGRect) rect;
-(BOOL) dispear;
@end
