//
//  ParallaxBackgroundNew.m
//  BoBoGame
//
//  Created by Lu Cao on 12-12-3.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "ParallaxBackgroundNew.h"
@interface ParallaxBackgroundNew (PrivateMethods)
-(id)backGroundWithImage;
@end

@implementation ParallaxBackgroundNew
+(id)background
{
    return [[self alloc] backGroundWithImage];
}
-(id)backGroundWithImage
{
    CGRect rectRepeat = CGRectMake(-5000, -5000, 5000, 5000);
    if (self = [super initWithFile:@"bb.png" rect:rectRepeat]) {
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        self.position = CGPointMake(screenSize.width, screenSize.height);
        ccTexParams params = {
            GL_LINEAR,
            GL_LINEAR,
            GL_REPEAT,
            GL_REPEAT
        };
        //EnemyCache* enemy = [EnemyCache node];
        //[self addChild:enemy];
        [self.texture setTexParameters:&params];
        [self scheduleUpdate];
        
    }
    return self;
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
    CCMoveTo* mo = [CCMoveTo actionWithDuration:2 position:CGPointMake(self.position.x+xPos, self.position.y+yPos)];
    //CCMoveTo* mo1 = [CCMoveTo actionWithDuration:2 position:CGPointMake(0, sprite.position.y+y)];
    //CCSequence* sequence = [CCSequence actions:mo,mo1, nil];
    CCEaseInOut* ease = [CCEaseInOut actionWithAction:mo rate:2];
    [self runAction:ease];
}
@end
