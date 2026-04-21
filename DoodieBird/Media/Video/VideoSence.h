//
//  ShopSence.h
//  DoodieBird
//
//  Created by LuckyLee on 26-04-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCVideoPlayer.h"


@interface VideoLayer : CCLayer <CCVideoPlayerDelegate>
{
    BOOL m_bMovieStarted;
    BOOL m_bDidEnterMenu;
}

- (void)enterMainMenuIfNeeded;
- (void)videoStartTimeout;
@end

@interface VideoSence : CCScene 
{
    
}
+(id) ShowScene;
@end
