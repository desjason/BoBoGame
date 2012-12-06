//
//  EnemyCache.m
//  BoBoGame
//
//  Created by Lu Cao on 12-11-30.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "EnemyCache.h"
#import "Enemy.h"
#import "GamePerson.h"

@interface EnemyCache (PrivateMethods)
-(void) initEnemies;
@end


@implementation EnemyCache

+(id) cache
{
	return [[self alloc] init];
}

-(id) init
{
	if ((self = [super init]))
	{
		// get any image from the Texture Atlas we're using
        //CCSpriteFrame* frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"mogu.png"];
		/*batchMogu = [CCSpriteBatchNode batchNodeWithFile:@"mogu.png" capacity:6];
        batchWall = [CCSpriteBatchNode batchNodeWithFile:@"wall.png" capacity:3];
        batchWugui = [CCSpriteBatchNode batchNodeWithFile:@"wugui.png" capacity:1];
        
		[self addChild:batchMogu];
        [self addChild:batchWall];
        [self addChild:batchWugui];
        for (NSUInteger i = 0; i < EnemyType_MAX; i++)
        {
            if (i == 0) {
                for(NSUInteger j = 0; j < 6; j++)
                {
                    Enemy* enemy = [Enemy enemyWithType:i ];
                    [batchMogu addChild:enemy];
                }
            } else if(i ==1){
                for(NSUInteger j = 0; j < 3; j++)
                {
                    Enemy* enemy = [Enemy enemyWithType:i ];
                    [batchWall addChild:enemy];
                }
            }else
            {
                for(NSUInteger j = 0; j < 1; j++)
                {
                    Enemy* enemy = [Enemy enemyWithType:i ];
                    [batchWugui addChild:enemy];
                }
            }
        }*/
		//[self initEnemies];
		[self scheduleUpdate];
	}
	
	return self;
}

-(void) initEnemies
{
	// create the enemies array containing further arrays for each type
	//enemies = [NSMutableArray arrayWithCapacity:EnemyType_MAX];
	
	// create the arrays for each type
	for (NSUInteger i = 0; i < EnemyType_MAX; i++)
	{
		// depending on enemy type the array capacity is set to hold the desired number of enemies
		NSUInteger capacity;
		switch (i)
		{
			case EnemyTypeMogu:
				capacity = 6;
				break;
			case EnemyTypeWall:
				capacity = 3;
				break;
			case EnemyTypeWugui:
				capacity = 1;
				break;
				
			default:
				[NSException exceptionWithName:@"EnemyCache Exception" reason:@"unhandled enemy type" userInfo:nil];
				break;
		}
		
		//NSMutableArray* enemiesOfType = [NSMutableArray arrayWithCapacity:capacity];
		//[enemies addObject:enemiesOfType];
		
		for (NSUInteger j = 0; j < capacity; j++)
		{
			//Enemy* enemy = [Enemy enemyWithType:i];
            if (i == 0) {
                //[batchMogu addChild:enemy];
                //[enemiesOfType addObject:enemy];
            }else if (i == 1){
                //[batchWall addChild:enemy];
                //[enemiesOfType addObject:enemy];
            }else{
                //[batchWugui addChild:enemy];
                //[enemiesOfType addObject:enemy];
            }
			
			
		}
	
    
    }
}


-(void) spawnEnemyOfType:(EnemyTypes)enemyType
{
	//NSMutableArray* enemiesOfType = [enemies objectAtIndex:enemyType];
    /*for (Enemy* enemy in enemiesOfType) {
        if (enemy.visible == YES) {
            if (enemy.position.x < 0) {
                enemy.visible = NO;
            }
        }
    }
	for (Enemy* enemy in enemiesOfType)
	{
		// find the first free enemy and respawn it
		if (enemy.visible == NO)
		{
			//CCLOG(@"spawn enemy type %i", enemyType);
			[enemy spawn];
			break;
		}
        
	}*/
    
    /*if (enemyType == 0) {
        CCArray* enemy = [batchMogu children];
        CCNode* node = [enemy objectAtIndex:nextInactiveMogu];
        NSAssert([node isKindOfClass:[enemy class]], @"not a Mogu!");
        Enemy *nodeMogu = (Enemy *)node;
        [nodeMogu spawn];
        nextInactiveMogu ++;
        if (nextInactiveMogu >= [enemy count]) {
            nextInactiveMogu = 0;
        }
    } else if(enemyType == 1){
        CCArray* enemy = [batchWall children];
        CCNode* node = [enemy objectAtIndex:nextInactiveWall];
        NSAssert([node isKindOfClass:[enemy class]], @"not a wall!");
        Enemy *nodeWall = (Enemy *)node;
        [nodeWall spawn];
        nextInactiveWall ++;
        if (nextInactiveWall >= [enemy count]) {
            nextInactiveWall = 0;
        }
    }else{
        CCArray* enemy = [batchWugui children];
        CCNode* node = [enemy objectAtIndex:nextInactiveWugui];
        NSAssert([node isKindOfClass:[enemy class]], @"not a wugui!");
        Enemy *nodeWugui = (Enemy *)node;
        [nodeWugui spawn];
        nextInactiveWugui ++;
        if (nextInactiveWugui >= [enemy count]) {
            nextInactiveWugui = 0;
        }
    }*/
        Enemy* enemy = [Enemy enemyWithType:enemyType];
        enemy.scale = 0.5;
        [enemy spawn];
        [self addChild: enemy];

}

-(void) update:(ccTime)delta
{
	updateCount++;
    
	for (int i = (EnemyType_MAX - 1); i >= 0; i--)
	{
        NSUInteger capacity;
		//int spawnFrequency = [Enemy getSpawnFrequencyForEnemyType:i];
        switch (i)
		{
			case EnemyTypeMogu:
				capacity = 300;
				break;
			case EnemyTypeWall:
				capacity = 500;
				break;
			case EnemyTypeWugui:
				capacity = 800;
				break;
				
			default:
				[NSException exceptionWithName:@"EnemyCache Exception" reason:@"unhandled enemy type" userInfo:nil];
				break;
		}

		
		if ((updateCount % capacity) == 0)
		{
			[self spawnEnemyOfType:i];
			break;
		}
	}
	
	//[self checkForPersonAndEnemyCollisions];
}
/*
-(void) checkForPersonAndEnemyCollisions
{
	for (Enemy* enemy in batchMogu.children)
	{
		if (enemy.visible)
		{
			GamePerson *person = [GamePerson person];
			CGRect bbox = enemy.boundingBox;
			if ([person isPersonAndEnemyColliding:bbox])
			{
				
				[person dispear];
			}
		}
	}
}*/
@end
