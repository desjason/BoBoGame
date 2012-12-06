//
//  ParallaxBackground.m
//  BoBoGame
//
//  Created by Lu Cao on 12-11-30.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "ParallaxBackground.h"


@implementation ParallaxBackground
-(id)init{
    if (self = [super init]) {
        //CCTexture2D* gameArtTexture = [[CCTextureCache sharedTextureCache] addImage:@"game-art.pvr.ccz"];
		
		// Create the background spritebatch
		//spriteBatch = [CCSpriteBatchNode batchNodeWithTexture:gameArtTexture];
        //[self addChild:spriteBatch];
        CGRect repeatRect = CGRectMake(-5000, -5000, 5000, 5000);
        sprite = [CCSprite spriteWithFile:@"bb.png" rect:repeatRect ];
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        sprite.position = CGPointMake(screenSize.width, screenSize.height);
        ccTexParams params = {
            GL_LINEAR,
            GL_LINEAR,
            GL_REPEAT,
            GL_REPEAT
        };
        
        [sprite.texture setTexParameters:&params];
        [self addChild:sprite z:-1];
        
        //EnemyCache* enemy = [EnemyCache node];
        //[sprite addChild:enemy];
        [self scheduleUpdate];
    }
    return self;
}
-(id)getSprite
{
    return sprite;
}
-(void) update:(ccTime) delta
{
    //CGPoint pos = sprite.position;
    //pos.x -= delta*20;
    //sprite.position = pos;
}
-(void)move:(float)x :(float)y
{
    float xPos = 12000*x/(x*x+y*y);
    float yPos = 12000*y/(x*x+y*y);
    CCMoveTo* mo = [CCMoveTo actionWithDuration:2 position:CGPointMake(sprite.position.x+xPos, sprite.position.y+yPos)];
    //CCMoveTo* mo1 = [CCMoveTo actionWithDuration:2 position:CGPointMake(0, sprite.position.y+y)];
    //CCSequence* sequence = [CCSequence actions:mo,mo1, nil];
    CCEaseInOut* ease = [CCEaseInOut actionWithAction:mo rate:2];
    [sprite runAction:ease];
}
@end
