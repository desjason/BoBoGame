//
//  Enemy.m
//  BoBoGame
//
//  Created by Lu Cao on 12-11-30.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Enemy.h"


@implementation Enemy
-(id) initWithType:(EnemyTypes)enemyType
{
	type = enemyType;
	
	NSString* enemyFrameName;
	
	// HACK: always spawn bosses
	//type = EnemyTypeBoss;
	
	switch (type)
	{
		case EnemyTypeMogu:
			enemyFrameName = @"mogu.png";
			break;
		case EnemyTypeWall:
			enemyFrameName = @"wall.png";
			break;
		case EnemyTypeWugui:
			enemyFrameName = @"wugui.png";
			break;
			
		default:
			[NSException exceptionWithName:@"EnemyEntity Exception"
									reason:@"unhandled enemy type"
								  userInfo:nil];
	}
    //CGRect rect1 = CGRectMake(200, 200, 400, 400);
	self = [super initWithFile:enemyFrameName];
	if (self)
	{		
		// enemies start invisible
		self.visible = NO;
		
		[self initSpawnFrequency];
	}
	
	return self;
}

+(id) enemyWithType:(EnemyTypes)enemyType
{
	return [[self alloc] initWithType:enemyType];
}

static NSMutableArray* spawnFrequency = nil;

-(void) initSpawnFrequency
{
	// initialize how frequent the enemies will spawn
	if (spawnFrequency == nil)
	{
		spawnFrequency = [NSMutableArray arrayWithCapacity:EnemyType_MAX];
		[spawnFrequency insertObject:[NSNumber numberWithInt:40] atIndex:EnemyTypeMogu];
		[spawnFrequency insertObject:[NSNumber numberWithInt:100] atIndex:EnemyTypeWall];
		[spawnFrequency insertObject:[NSNumber numberWithInt:200] atIndex:EnemyTypeWugui];
		
		// spawn one enemy immediately
		[self spawn];
	}
}

+(int) getSpawnFrequencyForEnemyType:(EnemyTypes)enemyType
{
	NSAssert(enemyType < EnemyType_MAX, @"invalid enemy type");
	NSNumber* number = [spawnFrequency objectAtIndex:enemyType];
	return number.intValue;
}

-(void) spawn
{
    updateCount += 100;
	CCLOG(@"spawn enemy");
	
	// Select a spawn location just outside the right side of the screen, with random y position
    CGSize screenSize = [CCDirector sharedDirector].winSize;
	CGSize spriteSize = self.contentSize;
    xPos = updateCount;
    yPos = screenSize.height * 0.3;
    //CCLOG(@"%  %di \n",xPos,yPos);
    //CGPoint point = [self.parent convertToWorldSpace:CGPointMake(xPos, yPos)];
	self.position = CGPointMake(xPos, yPos);
    //CCLOG(@"%d  %d \n",point.x,point.y);
	// Finally set yourself to be visible, this also flag the enemy as "in use"
	self.visible = YES;

}
@end
