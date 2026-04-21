//
//  MainGameSence.h
//  DoodieBird
//
//  Created by LuckyLee on 26-04-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCMyMapSprite.h"
#import "CCMyBridSprite.h"
#import "CCBridShitSprite.h"
#import "CCMyHunterSprite.h"
#import "CCMyBeanSprite.h"
#import "def.h"

//Add by zhengxf about "障碍物列表的数据结构" 2012-7-18 -------begin------
#define Obstacle_List_Count 3
#define PAUSE_LAYER_INDEX 3000

@interface  MyObstacle: NSObject
{
    bool m_bIsAdd;
    CCArray* m_ObstacleList;
}
@property (readwrite) bool m_bIsAdd;
@property (nonatomic, retain) CCArray* m_ObstacleList; 
@end 

//_Obstacle
//{
//    bool    b_isAdd;
//    CCArray* m_ObstacleList;
//}MyObstacle;
//Add by zhengxf about "障碍物列表的数据结构" 2012-7-18 -------end------

@interface MainGameLayer : CCLayer
{
    //大关的数据
    int m_nBigLevel;
    
    //小关的数据
    int m_nSmallLevel;
    
    //小鸟的图片
    CCSprite* m_spBrid;
    
    //本关的游戏星星数
    int m_nOldStar;
    
    //当前的豆子数
    int m_nBeanCount;
    
    //吃的豆子数
    int m_nEatBeanCount;
    
    //星星数
    int m_nStar;
    
    //是否成功
    bool m_bSuccess;
    
    CGSize m_winSize;
    
    //滚动背景的图片
    CCParallaxNode *m_BkGroundNode;
    
    //背景图片
    CCMyMapSprite* m_BkGroundB1;
    CCMyMapSprite* m_BkGroundB2;
    CCMyMapSprite* m_BkGroundB3;
    
    CCMyMapSprite* m_BKGroundM1;
    CCMyMapSprite* m_BKGroundM2;
    CCMyMapSprite* m_BKGroundM3;
    
    CCMyMapSprite* m_BKGroundF1;
    CCMyMapSprite* m_BKGroundF2;
    CCMyMapSprite* m_BKGroundF3;
    
    
    //鸟的图片
    CCMyBridSprite* m_BridSprite;
    CCBridShitSprite* m_ShitSprite;
    int nCount;
    //记时间器功能
    NSTimer *m_timer;
    NSTimer *m_BridTimer;
    
    //额外计算的计算器
    NSTimer *m_FithtTimer;
    
    //是否鼠标按下
    bool  m_nLeftSceneDown;
    bool  m_nRithtSceneDown;
    
    //加入对象管理列表
    //NSMutableArray *m_BackGroutArrar;
    
    //Add by zhengxf about "加载plist文件" 2012-7-5 ------begin------
    CCSpriteBatchNode* m_pBatchNode;
    //Add by zhengxf about "加载plist文件" 2012-7-5 ------end------
    
    //Add by zhengxf about "便便的列表" 2012-7-6 ------begin-------
    CCArray *m_ShitList;
    int      m_nShitIndex;
    //Add by zhengxf about "便便的列表" 2012-7-6 ------end-------
    
    //Add by zhengxf about "猎人的列表" 2012-7-8 -----begin-----
    CCArray *m_HunterList;
    int     m_nHunterIndex;
    //Add by zhengxf about "猎人的列表" 2012-7-8 -----end-----
    
    //Add by zhengxf about "豆子的列表" 2012-7-8 -----begin-----
    //CCArray *m_BeanList;
    //int      m_nBeanIndex;
    //Add by zhengxf about "豆子的列表" 2012-7-8 -----end-----
    
    //游戏停止 
    bool   m_bGameStop;
    
    //Add by zhengxf about "判断更换武器" 2012-7-10 ------begin-------
    bool   m_bChangeWeapon;
    CGRect m_RcChangeWeapon;
    int    m_nWeaponIndex;
    //Add by zhengxf about "判断更换武器" 2012-7-10 ------end-------
    
    bool   m_bHaveHunter; //屏幕可见范围是否有人
    bool   m_bBridIsHeight; //鸟是否在最高点
    
    //Add by zhengxf about "关卡的长度" 2012-7-18  -------begin-------
    int    m_nLevelLen;
    int    m_nObstacleIndex;
    int    m_nLevel; //当前是第几关
    
    int m_nLeveScore;       //本关得分
    int m_nNowLevelLen;     //目前的关卡长度
    //Add by zhengxf about "关卡的长度" 2012-7-18  -------end--------
    
    //Add by zhengxf about "障碍物数据链表" 2012-7-18 -------begin-------
    CCArray *m_ObstacleArray;
   // MyObstacle m_Obstacle[Obstacle_List_Count];
    //Add by zhengxf about "障碍物数据链表" 2012-7-18 -------end-------
    
    //Add by zhengxf about "加入图片数据缓存，提高程序的加载效率" 2012-7-19 ---------begin----------
    CCTexture2D * m_pBeanNomal;
    CCTexture2D * m_pShitNomal;
    CCTexture2D * m_pFlashing;
    CCTexture2D * m_pFlashingSecond;
    //Add by zhengxf about "加入图片数据缓存，提高程序的加载效率" 2012-7-19 ---------end----------
    
    //Add by zhengxf about "游戏结束的功能" 2012-8-15 ---------begin--------
    CCSprite* m_pTest;
    CCSprite* m_pPaperf;
    int  m_Index;
    bool m_bGameOver;    //游戏是否结束
    bool m_bCatchOrEnd;  //鸟被抓住，或者到关底
    //Add by zhengxf "是否允许touch" 2012-8-21 -----begin------
    bool m_bAllowTouch;
    //Add by zhengxf "是否允许touch" 2012-8-21 -----end------
    
    //Add by zhengxf about "豆子和分数计算列表" 2012-8-22 --------begin------
    CCArray * m_BeanList;
    CCArray * m_ScoreList;
    
    CGPoint m_pBeanPoint;
    CGPoint m_pScorePoint;
    
    CCSprite* m_spProgress;
    float       m_nProgressLen;
    //Add by zhengxf about "豆子和分数计算列表" 2012-8-22 --------end------
    //Add by zhengxf about "游戏结束的功能" 2012-8-15 ---------end--------
    
    //Add by zhengxf about "加入树洞的资源" 2012-8-24 -------begin----
    CCMyMapSprite* m_spTree;
    CCMyMapSprite* m_spSmallTree;
    CCMyMapSprite* m_spHole;
    bool           m_bAddHole;//树洞是否加入
    //Add by zhengxf about "加入树洞的资源" 2012-8-24 -------end----
    
    //Add by zhengxf about "加入随机系统" 2012-8-27 -------begin--------
    float m_nUseTime;       //用了多长时间
    bool  m_bStartHawk;     //随机系统是否开始
    bool  m_bStartPosition; //开始的位置
    bool  m_bHawk;
    bool  m_bRandSystem;    //随机系统开始
    
    CCSprite* m_spSigh;     //感叹号的图片
    CCSprite* m_spHawk;     //鹰的图片
    //Add by zhengxf about "加入随机系统" 2012-8-27 -------end--------
    
    //Add by zhengxf about "龙火的功能"  2012-8-28 -------begin------
    CCSprite* m_spDragonFrie;
    bool      m_bFrieDragon;
    //Add by zhengxf about "龙火的功能"  2012-8-28 -------end------
    
    //Add by zhengxf about "游戏暂停的状态" 2012-8-30 -------begin------
    bool      m_bPauseGame;
    //Add by zhengxf about "游戏暂停的状态" 2012-8-30 -------end------
    
    //Add by zhengxf about "加入游戏帮助功能" 2012-8-31 ------begin-----
    bool      m_bHelp;      //是否需要加入帮助
    bool      m_bHelp3;      //是否需要加入帮助
    int       m_nHelpIndex; //帮助的索引
    CCSprite* m_spHelp1;
    CCSprite* m_spHelp2;
    CCSprite* m_spHelp3; 
    //Add by zhengxf about "加入游戏帮助功能" 2012-8-31 ------end-----
    
    //Add by zhengxf about "每关便便的类型" 2012-9-3   -----begin-----
    int m_ShitOpenIndex;
    //Add by zhengxf about "每关便便的类型" 2012-9-3   -----end-----
    
    //Add by zhengxf about "加入划动方向的功能" 2012-9-7 ------begin------
    CGPoint m_ptWeaponPoint;
    //Add by zhengxf about "加入划动方向的功能" 2012-9-7 ------end------
    
    //两个点是否都在右边
    bool m_bAllRight;
}
//初始化函数
-(void) InitShit;           //加载便便
-(void) InitScene;          //加载场景
-(void) InitBrid;           //加载小鸟
-(void) InitHunterAndBean; //加载小鸟和动画
-(void) InitTreeHole;      //加载树洞的图片

 //Add by zhengxf about "加入图片缓存" 2012-8-28 -----begin----
-(void) AddPngCache;
 //Add by zhengxf about "加入图片缓存" 2012-8-28 -----end----

//场景中物品移动
-(void) MoveTreeHole;     //移动树洞的函数
-(void) MoveMap;
-(void) MoveBrid;
-(void) MoveShit;
-(void) MoveHunter;
-(void) MoveBean;

//检测小鸟是否碰撞
-(bool) BridIsTouch;
//检测便便是否碰撞
-(bool) ShitIsTouch;
//检测豆子是否碰撞
-(bool)BeanIsTouch;

//Add by zhengxf "游戏结束"
-(void)GameOver;

//改变便便
-(void) ChangeShit:(int) nIndex;

//Add by zhengxf about "加入随机系统" 2012-8-27 -------begin--------
-(void) HawkSystem;
//Add by zhengxf about "加入随机系统" 2012-8-27 -------end----------

@end
 
@interface MainGameScence : CCScene
{
    
}
+(id) ShowScene;
@end