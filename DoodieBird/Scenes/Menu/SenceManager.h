//
//  SenceManager.h
//  cookgirl
//
//  Created by LuckyLee on 26-04-22.
//  Copyright FancyGame 2026年. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface SenceManager : NSObject 
{
    
}
+ (SenceManager *) sharedSenceManager;
-(void) ShowGameSence;          //主游戏场景
-(void) ShowMainMenuSence;      //游戏主菜单场景
-(void) ShowShopSence;         //游戏商场场景
-(void) ShowSelectChapterScene; //选择章节的场景
-(void) ShowLevelScene;         //选择关卡的场景
-(void) ShowShitScene;          //选择便便的场景
-(void) ShowPauseScene;         //暂停的场景
-(void) ShowGameCompleteScene;  //游戏结束的场景
-(void) ShowHeadStarMp4;        //片头动画
@end
