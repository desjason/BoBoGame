//
//  GameBubble.m
//  BoBoGame
//
//  Created by Lu Cao on 12-12-1.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameBubble.h"
@interface GameBubble (PrivateMethods)
-(id) initWithBubbleImage;
@end

@implementation GameBubble
+(id)bubble
{
    return [[self alloc] initWithBubbleImage];
}
-(id)initWithBubbleImage
{
    if (self = [super initWithFile:@"ball1.png"]) {
        [self scheduleUpdate];
    }
    return self;
}
-(void)update:(ccTime)delta
{
    
}
-(BOOL)isBubbleAndEnemyColliding:(CGRect)rect
{
    return YES;
}
@end
