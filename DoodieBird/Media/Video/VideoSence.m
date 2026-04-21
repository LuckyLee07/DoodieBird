
//
//  ShopSence.m
//  DoodieBird
//
//  Created by LuckyLee on 26-04-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "VideoSence.h"
#import "SenceManager.h"
#import "AnimationDelegate.h"
#import "def.h"

@implementation VideoLayer

- (id) init
{
	self = [super init];
	if (self)
	{
        m_bMovieStarted = NO;
        m_bDidEnterMenu = NO;

        // Avoid prolonged black screen if video backend fails to start.
        CCSprite *splash = [CCSprite spriteWithFile:@"Default.png"];
        splash.position = ccp([CCDirector sharedDirector].winSize.width * 0.5f,
                              [CCDirector sharedDirector].winSize.height * 0.5f);
        [self addChild:splash z:-1];

        [CCVideoPlayer setDelegate: self];
        [CCVideoPlayer setNoSkip: NO];
        [CCVideoPlayer playMovieWithFile: @"HeadStar.mp4"];//播放视频

        [self performSelector:@selector(videoStartTimeout) withObject:nil afterDelay:6.0f];
    }
    return  self;
}

- (void) Return:(id) sender
{
    [self enterMainMenuIfNeeded];
}

- (void) moviePlaybackFinished  
{  
    CCLOG(@"moviePlaybackFinished");  
    [self enterMainMenuIfNeeded];
}  

- (void) movieStartsPlaying
{
    m_bMovieStarted = YES;
    [NSObject cancelPreviousPerformRequestsWithTarget:self
                                             selector:@selector(videoStartTimeout)
                                               object:nil];
    CCLOG(@"movieStartsPlaying");
}

- (void)videoStartTimeout
{
    if (!m_bMovieStarted) {
        CCLOG(@"video start timeout, skip intro movie");
        [self enterMainMenuIfNeeded];
    }
}

- (void)enterMainMenuIfNeeded
{
    if (m_bDidEnterMenu) {
        return;
    }
    m_bDidEnterMenu = YES;
    [NSObject cancelPreviousPerformRequestsWithTarget:self];

    [CCVideoPlayer cancelPlaying];
    SenceManager* SManager = [SenceManager sharedSenceManager];
	if(SManager)
	{
        [SManager ShowMainMenuSence];
    }
}

#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED  
// Updates orientation of CCVideoPlayer. Called from SharedSources/RootViewController.m  
- (void) updateOrientationWithOrientation: (UIDeviceOrientation) newOrientation  
{  
    CCLOG(@"updateOrientationWithOrientation");  
    [CCVideoPlayer updateOrientationWithOrientation:newOrientation ];  
}  
#endif 

- (void)dealloc
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [CCVideoPlayer setDelegate:nil];
    [super dealloc];
}

@end

@implementation VideoSence

+(id) ShowScene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [VideoSence node];
	// return the scene
	return scene;
}

-(id) init
{
	if( (self=[super init] )) 
	{
		VideoLayer* mBk = [VideoLayer node];
		[self addChild:mBk];
	}
	return self;
}

@end
