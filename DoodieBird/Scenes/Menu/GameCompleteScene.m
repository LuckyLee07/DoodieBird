//
//  GameCompleteScene.m
//  DoodieBird
//
//  Created by LuckyLee on 26-04-22.
//  Copyright (c) 2026年 FancyGame. All rights reserved.
//

#import "GameCompleteScene.h"
#import "../../Gameplay/Shared/LayoutHelper.h"

@implementation GameCompleteLayer

- (id) init
{
	self = [super init];
	if (self)
	{
        CGSize winSize = [CCDirector sharedDirector].winSize;
        CCSprite *sp = [CCSprite spriteWithFile:DBWideAssetName(@"MainBk.png", winSize)];
        DBLayoutCoverSprite(sp, winSize);
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
