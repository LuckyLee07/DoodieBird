//
//  GameCompleteScene.m
//  DoodieBird
//
//  Created by LuckyLee on 26-04-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameCompleteScene.h"

@implementation GameCompleteLayer

- (id) init
{
	self = [super init];
	if (self)
	{
        CCSprite *sp = [CCSprite spriteWithFile:@"MainBk.png"];
		sp.anchorPoint = CGPointZero;
		[self addChild:sp z:0 tag:1];
    }
    return  self;
}

@end


@implementation GameCompleteScene
+(id) ShowScene
{
    // 'scene' is an autorelease object.
	CCScene *scene = [GameCompleteLayer node];
	// return the scene
	return scene;
}

-(id) init
{
	if( (self=[super init] )) 
	{
		GameCompleteLayer* mBk = [GameCompleteLayer node];
		[self addChild:mBk];
	}
	return self;
}
@end
