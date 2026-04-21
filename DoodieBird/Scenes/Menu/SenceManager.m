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

static void SMTransitionToScene(CCScene *scene)
{
    if (scene == nil)
    {
        return;
    }

    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.3f scene:scene withColor:ccWHITE]];
    [[CCTextureCache sharedTextureCache] removeUnusedTextures];
}

@implementation SenceManager
//定义全局静态对象
static SenceManager *sharedDataManager = nil;
+ (SenceManager *) sharedSenceManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDataManager = [[super allocWithZone:NULL] init];
    });
    return sharedDataManager;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
	{
        if(sharedDataManager == nil)
		{
            sharedDataManager = [super allocWithZone:zone];
        }
    }
    return sharedDataManager;
}

-(void) ShowGameSence
{
	SMTransitionToScene([MainGameScence node]);
}

-(void) ShowMainMenuSence
{
	SMTransitionToScene([MainMenuSence node]);
}

-(void) ShowShopSence
{
    SMTransitionToScene([ShopSence node]);
}

-(void) ShowSelectChapterScene //选择章节的场景
{
    SMTransitionToScene([SelectChapterSence node]);
}

-(void) ShowLevelScene         //选择关卡的场景
{
    SMTransitionToScene([SelectLevelScene node]);
}

-(void) ShowShitScene          //选择便便的场景
{
    SMTransitionToScene([SelectShitScene node]);
}

-(void) ShowPauseScene         //暂停的场景
{
    SMTransitionToScene([PauseSence node]);
}

-(void) ShowGameCompleteScene  //游戏结束的场景
{
    SMTransitionToScene([GameOverScence node]);
}

-(void) ShowHeadStarMp4      //片头动画
{
    // Intro movie has been removed. Keep API for compatibility and go to main menu.
    [self ShowMainMenuSence];
}

@end
