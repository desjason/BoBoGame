//
//  GamePerson.m
//  BoBoGame
//
//  Created by Lu Cao on 12-11-28.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GamePerson.h"
@interface GamePerson (PrivateMethods)
-(id) initWithPersonImage;
@end

@implementation GamePerson
+(id) person
{
    return [[self alloc] initWithPersonImage];
}
-(id) initWithPersonImage
{
    if (self = [super initWithFile:@"person.png"]) {
        [self scheduleUpdate];
    }
    return self;
}
-(void) update:(ccTime) delta
{
    
}
// override setPosition to keep ship within bounds
-(void) setPosition:(CGPoint)pos
{
	CGSize screenSize = [CCDirector sharedDirector].winSize;
	float halfWidth = contentSize_.width * 0.5f;
	float halfHeight = contentSize_.height * 0.5f;
	
	// Cap the position so the Ship's sprite stays on the screen
	if (pos.x < halfWidth)
	{
		pos.x = halfWidth;
	}
	else if (pos.x > (screenSize.width - halfWidth))
	{
		pos.x = screenSize.width - halfWidth;
	}
	
	if (pos.y < halfHeight)
	{
		pos.y = halfHeight;
	}
	else if (pos.y > (screenSize.height - halfHeight))
	{
		pos.y = screenSize.height - halfHeight;
	}
	
	// must call super with the new position
	[super setPosition:pos];
}
-(BOOL) isPersonAndEnemyColliding:(CGRect)rect
{
    return CGRectIntersectsRect([self boundingBox], rect);
    

}
-(BOOL) dispear
{
    self.visible = NO;
    return NO;
}
-(void) dealloc
{
    [super dealloc];
}
@end
