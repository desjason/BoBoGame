//
//  Enemy.h
//  BoBoGame
//
//  Created by Lu Cao on 12-11-30.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
typedef enum
{
	EnemyTypeMogu = 0,
	EnemyTypeWall,
	EnemyTypeWugui,
	
	EnemyType_MAX,
} EnemyTypes;
@interface Enemy : CCSprite {
    EnemyTypes type;
    float xPos;
    float yPos;
    int updateCount;
}
+(id) enemyWithType:(EnemyTypes) enemyType;
+(int) getSpawnFrequencyForEnemyType:(EnemyTypes)enemyType;
-(void) spawn;
@end
