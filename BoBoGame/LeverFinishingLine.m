//
//  LeverFinishingLine.m
//  BoBoGame
//
//  Created by Lu Cao on 12-12-6.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "LeverFinishingLine.h"
@interface LeverFinishingLine (PrivateMethods)
-(id)initWithFinishingLine;
@end

@implementation LeverFinishingLine
+(id)finishingLine
{
    return [[self alloc] initWithFinishingLine];
}
-(id)initWithFinishingLine
{
    if (self = [super initWithFile:@"huoquan.png"]) {
        CGSize screenSize = [CCDirector sharedDirector].winSize;
        self.visible = YES;
        self.scale = 0.14;
        CGSize contentSize = self.contentSize;
        //self.position = CGPointMake(contentSize.width/2+screenSize.width, screenSize.height);
        [self scheduleUpdate];
    }
    return self;
}
-(void)update:(ccTime)delta
{
    
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
