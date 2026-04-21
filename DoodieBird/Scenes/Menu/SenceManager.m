//
//  SenceManager.m
//  cookgirl
//
//  Created by LuckyLee on 26-04-22.
//  Copyright FancyGame 2026年. All rights reserved.
//
#import "SenceManager.h"
#import "MainMenuSence.h"
#import "MainGameScence.h"
#import "ShopSence.h"
#import "SelectChapterScene.h"
#import "SelectLevelScene.h"
#import "SelectShitScene.h"
#import "PauseSence.h"
#import "GameCompleteScene.h"
#import "GameOver.h"

@implementation SenceManager
//定义全局静态对象
static SenceManager *sharedDataManager = nil;
+ (SenceManager *) sharedSenceManager
{
	@synchronized(self)
	{
        if (sharedDataManager == nil)
		{
            [[self alloc] init];
        }
    }
    return sharedDataManager;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
	{
        if(sharedDataManager == nil)
		{
            sharedDataManager = [super allocWithZone:zone];
            return sharedDataManager;
        }
    }
    return nil;
}

-(void) ShowGameSence
{
	CCScene *sc = [MainGameScence node];	
	[[CCDirector sharedDirector] replaceScene: [ CCTransitionFade  transitionWithDuration:0.3f scene:sc withColor:ccWHITE]];
	[[CCTextureCache sharedTextureCache ] removeUnusedTextures];
}

-(void) ShowMainMenuSence
{
	CCScene *sc = [MainMenuSence node];	
	[[CCDirector sharedDirector] replaceScene: [ CCTransitionFade  transitionWithDuration:0.3f scene:sc withColor:ccWHITE]];
	[[CCTextureCache sharedTextureCache ] removeUnusedTextures ];
}

-(void) ShowShopSence
{
    CCScene *sc = [ShopSence node];	
	[[CCDirector sharedDirector] replaceScene: [ CCTransitionFade  transitionWithDuration:0.3f scene:sc withColor:ccWHITE]];
	[[CCTextureCache sharedTextureCache ] removeUnusedTextures ];
}

-(void) ShowSelectChapterScene //选择章节的场景
{
    CCScene *sc = [SelectChapterSence node];	
	[[CCDirector sharedDirector] replaceScene: [ CCTransitionFade  transitionWithDuration:0.3f scene:sc withColor:ccWHITE]];
	[[CCTextureCache sharedTextureCache ] removeUnusedTextures ];
}

-(void) ShowLevelScene         //选择关卡的场景
{
    CCScene *sc = [SelectLevelScene node];	
	[[CCDirector sharedDirector] replaceScene: [ CCTransitionFade  transitionWithDuration:0.3f scene:sc withColor:ccWHITE]];
	[[CCTextureCache sharedTextureCache ] removeUnusedTextures ];
}

-(void) ShowShitScene          //选择便便的场景
{
    CCScene *sc = [SelectShitScene node];	
	[[CCDirector sharedDirector] replaceScene: [ CCTransitionFade  transitionWithDuration:0.3f scene:sc withColor:ccWHITE]];
	[[CCTextureCache sharedTextureCache ] removeUnusedTextures ];
}

-(void) ShowPauseScene         //暂停的场景
{
    CCScene *sc = [PauseSence node];	
	[[CCDirector sharedDirector] replaceScene: [ CCTransitionFade  transitionWithDuration:0.3f scene:sc withColor:ccWHITE]];
	[[CCTextureCache sharedTextureCache ] removeUnusedTextures ];
}

-(void) ShowGameCompleteScene  //游戏结束的场景
{
    CCScene *sc = [GameOverScence node];	
	[[CCDirector sharedDirector] replaceScene: [ CCTransitionFade  transitionWithDuration:0.3f scene:sc withColor:ccWHITE]];
	[[CCTextureCache sharedTextureCache ] removeUnusedTextures ];
}

-(void) ShowHeadStarMp4      //片头动画
{
    // Intro movie has been removed. Keep API for compatibility and go to main menu.
    [self ShowMainMenuSence];
}

@end
