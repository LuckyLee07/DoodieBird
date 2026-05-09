//
//  def.h
//  DoodieBird
//
//  Created by LuckyLee on 26-04-22.
//  Copyright (c) 2026年 FancyGame. All rights reserved.
//

#ifndef DoodieBird_def_h
#define DoodieBird_def_h

//小鸟图片Tag值
#define SPRITE_BRID 1
#define SPRITE_SHIT 2  //便便的Tag值 便便的值范围是 1-6

#define SELEST_SHIT       10    //选择子弹
#define SHIT_BULLET_NUMAL 11    //正常子弹
#define SHIT_BULLET_FIRE  12    //火子弹
#define SHIT_BULLET_FLIGHT  13  //闪电便便
#define SHIT_BULLET_DRAGON  14  //龙便便

#define SHIT_NUMBER_NUMAL  20   //正常子弹的豆子数
#define SHIT_NUMBER_FIRE   21   //火子弹的豆子数
#define SHIT_NUMBER_FLIGHT 22   //闪电子弹的豆子数
#define SHIT_NUMBER_DRAGON 23   //龙子弹的豆子数

#define SHIT_SCENE_COUNT 6 //屏幕显示的最大便便数

//地图图片Tag值
#define  MAP_BK_B1 100
#define  MAP_BK_B2 101
#define  MAP_BK_B3 102

#define  MAP_BK_M1 103
#define  MAP_BK_M2 104

#define  MAP_BK_F1 105
#define  MAP_BK_F2 106
#define  MAP_BK_F3 107

#define  MAP_BK_D_INDEX 200 //前景下资源
#define  MAP_BK_U_INDEX 300 //前景上资源
#define  MAP_BK_M_INDEX 400 //中景资源
#define  TREE_BK_INDEX  500 //树资源

//小鸟初速率
#define  BRID_START_SPEED 0.5f
#define  BRID_ADD_SPEED   0.1f

//便便的初速率
#define SHIT_START_SPEED 1.0f
#define SHIT_ADD_SPEED   0.5f

//前背景移动的速率
#define FORWARD_MOVE_RATIO 8.0f

//便便最大的下落时间
#define SHIT_DOWN_TIME     0.6f

#define  GAME_RETURN    1

typedef struct _LevelNode
{
    int  m_nOffset;
    int  m_nDifficulty;
    bool m_bisAdd;
}LevelNode;

typedef struct _LevelNodeList
{
    int n_Count;
    LevelNode * pLevelList;
}LevelNodeList;

typedef struct _BFlashing
{
    int nOffset;
    int nLen;
}BFlashing;

//豆子的分数
#define BEAN_SCORE   10

////关卡便便的类型数据
//static const int WeaponLevel[3][2] = {{3, 2}, {6, 3}, {9, 4}};

//障碍物介绍
static const int ObstacleLevel[7][2] = {{1, 2}, {2, 3}, {3, 4}, {5, 5}, {6, 6}, {7, 7}, {14, 8}};

//便便消耗豆子的分数
static const int UseBean[4] = {1, 2,  3, 15};

//关卡的长度, 以屏为单位
static const int LevelLen[30] = {5,  17, 19, 21, 21, 25, 27, 29, 29, 31, 19,
                                25, 37, 45, 45, 47, 51, 51, 53, 53,
                                21, 33, 43, 49, 55, 61, 63, 67, 67, 75};

//每关的总分
static const int LevelAllScore[30]  = 
{
    66,
    1270,
    2057,
    2676,
    3757,
    5474,
    7125,
    8336,
    8058,
    12204,
    5054,
    7980,
    8652,
    10845,
    7776,
    12971,
    15426,
    15238,
    19380,
    16711,
    8172,
    9462,
    16701,
    26505,
    17271,
    25320,
    24900,
    25680,
    26600,
    42680
};

//人物的积分
static const int HunterScore[4] = {100, 240, 390, 960};

//人物的血量值
static const int HunterBlood[4] ={1, 2, 3, 6};

//Add by zheng xingfeng about "便便和人物对应伤害关系表" 2012-8-8 --------begin-------
//4种猎人 5个便便
static const int HunterAndShit[4][5] = 
{
    {1, 1, 1, 1, 2}, 
    {1, 2, 1, 1, 1}, 
    {1, 1, 3, 1, 1},
    {1, 2, 1, 3, 3}
};
//Add by zheng xingfeng about "便便和人物对应伤害关系表" 2012-8-8 --------end-------

//豆子闪电级别对应表
static const BFlashing BeanAndFlashing[] = {{0, 10}, {10, 6}, {16, 5}, {21, 4}, {0, 3}, {3, 4}, {7, 4}, {11, 4}};

//游戏第一关显示的豆子列表
static const int LevelListCount[] = {30, 0};

//游戏第二关显示的豆子列表

//关卡1	
static  const LevelNode Level1[] = {{480*2, 1, false}};	

//关卡2	
static  const LevelNode Level2[] = {{480*4, 5, false}, {480*7, 1, false}, {480*9, 2, false},{480*12, 5, false}, {480*15, 1, false}, {480*17, 2, false}};

//关卡3	
static  const LevelNode Level3[] = {{480*3, 5, false}, {480*6, 1, false}, {480*10, 2, false},{480*12, 5, false}, {480*15, 1, false}, {480*19, 2, false}};

//关卡4	
static  const LevelNode Level4[] = {{480*3, 5, false}, {480*5, 1, false}, {480*7, 2, false}, {480*10, 6, false},{480*13, 5, false}, {480*15, 1, false}, {480*17, 2, false}, {480*20, 6, false}};

//关卡5	
static  const LevelNode Level5[] = {{480*3, 1, false}, {480*5, 5, false}, {480*7, 2, false}, {480*9, 3, false}, {480*11, 6, false},{480*13, 1, false}, {480*15, 5, false}, {480*17, 2, false}, {480*19, 3, false}, {480*21, 6, false}};

//关卡6	
static  const LevelNode Level6[] = {{480*3, 1, false}, {480*5, 5, false}, {480*7, 2, false}, {480*9, 5, false}, {480*12, 6, false}, {480*13, 3, false},{480*15, 1, false}, {480*17, 5, false}, {480*19, 2, false}, {480*21, 5, false}, {480*24, 6, false}, {480*25, 3, false}};

//关卡7	
static  const LevelNode Level7[] = {{480*2, 5, false}, {480*4, 5, false}, {480*6, 1, false}, {480*8, 6, false}, {480*11, 2, false}, {480*12, 6, false}, {480*14, 3, false},{480*15, 5, false}, {480*17, 5, false}, {480*19, 1, false}, {480*21, 6, false}, {480*24, 2, false}, {480*25, 6, false}, {480*27, 3, false}};

//关卡8	
static  const LevelNode Level8[] = {{480*3, 5, false}, {480*6, 6, false}, {480*8, 1, false}, {480*10, 2, false}, {480*11, 6, false}, {480*13, 5, false},{480*17, 5, false}, {480*20, 6, false}, {480*22, 1, false}, {480*24, 2, false}, {480*25, 6, false}, {480*27, 5, false}};

//关卡9	
static  const LevelNode Level9[] = {{480*4, 6, false}, {480*6, 1, false}, {480*8, 1, false}, {480*9, 6, false}, {480*12, 2, false}, {480*14, 7, false}, {480*15, 3, false},{480*18, 6, false}, {480*20, 1, false}, {480*22, 1, false}, {480*23, 6, false}, {480*26, 2, false}, {480*28, 7, false}, {480*29, 3, false}};

//关卡10	
static  const LevelNode Level10[] = {{480*3, 6, false}, {480*5, 1, false}, {480*7, 6, false}, {480*9, 2, false}, {480*11, 1, false}, {480*13, 3, false}, {480*15, 7, false},{480*18, 6, false}, {480*20, 1, false}, {480*22, 6, false}, {480*24, 2, false}, {480*26, 1, false}, {480*28, 3, false}, {480*30, 7, false}};

//关卡11	
static  const LevelNode Level11[] = {{480*3, 5, false}, {480*7, 1, false},{480*12, 5, false}, {480*16, 1, false}};	

//关卡12	
static  const LevelNode Level12[] = {{480*2, 5, false}, {480*7, 1, false}, {480*10, 2, false}, {480*12, 6, false},{480*14, 5, false}, {480*19, 1, false}, {480*22, 2, false}, {480*24, 6, false}}; 

//关卡13	
static  const LevelNode Level13[] = {{480*3, 5, false}, {480*7, 5, false}, {480*9, 1, false}, {480*15, 1, false}, {480*17, 6, false}, {480*19, 2, false},{480*21, 5, false}, {480*25, 5, false}, {480*27, 1, false}, {480*33, 1, false}, {480*35, 6, false}, {480*37, 2, false}};

//关卡14	
static  const LevelNode Level14[] = {{480*3, 2, false}, {480*6, 5, false}, {480*9, 2, false}, {480*12, 5, false}, {480*14, 1, false}, {480*19, 6, false}, {480*21, 1, false}, {480*22, 6, false},{480*25, 2, false}, {480*28, 5, false}, {480*31, 2, false}, {480*34, 5, false}, {480*36, 1, false}, {480*41, 6, false}, {480*43, 1, false}, {480*44, 6, false}};

//关卡15	
static  const LevelNode Level15[] = {{480*3, 5, false}, {480*5, 1, false}, {480*7, 6, false}, {480*12, 1, false}, {480*15, 6, false}, {480*17, 2, false}, {480*19, 2, false},{480*25, 5, false}, {480*27, 1, false}, {480*29, 6, false}, {480*34, 1, false}, {480*37, 6, false}, {480*39, 2, false}, {480*41, 2, false}};

//关卡16	
static  const LevelNode Level16[] = {{480*3, 2, false}, {480*5, 6, false}, {480*8, 6, false}, {480*11, 2, false}, {480*14, 7, false}, {480*17, 7, false}, {480*18, 1, false}, {480*21, 1, false}, {480*24, 3, false},{480*26, 2, false}, {480*28, 6, false}, {480*31, 6, false}, {480*34, 2, false}, {480*37, 7, false}, {480*40, 7, false}, {480*41, 1, false}, {480*44, 1, false}, {480*47, 3, false}}; 

//关卡17	
static  const LevelNode Level17[] = {{480*5, 7, false}, {480*7, 1, false}, {480*10, 6, false}, {480*12, 1, false}, {480*15, 7, false}, {480*18, 2, false}, {480*21, 6, false}, {480*24, 5, false}, {480*26, 2, false},{480*30, 7, false}, {480*32, 1, false}, {480*35, 6, false}, {480*37, 1, false}, {480*40, 7, false}, {480*43, 2, false}, {480*46, 6, false}, {480*49, 5, false}, {480*51, 2, false}}; 

//关卡18	
static  const LevelNode Level18[] = {{480*3, 5, false}, {480*5, 1, false}, {480*10, 1, false}, {480*12, 5, false}, {480*15, 2, false}, {480*18, 6, false}, {480*21, 6, false}, {480*23, 2, false}, {480*26, 3, false},{480*28, 5, false}, {480*30, 1, false}, {480*35, 1, false}, {480*37, 5, false}, {480*40, 2, false}, {480*43, 6, false}, {480*46, 6, false}, {480*48, 2, false}, {480*51, 3, false}}; 

//关卡19	
static  const LevelNode Level19[] = {{480*4, 5, false}, {480*6, 1, false}, {480*8, 6, false}, {480*11, 2, false}, {480*14, 5, false}, {480*16, 3, false}, {480*20, 1, false}, {480*23, 6, false}, {480*24, 3, false}, {480*26, 2, false},{480*30, 5, false}, {480*32, 1, false}, {480*34, 6, false}, {480*37, 2, false}, {480*40, 5, false}, {480*42, 3, false}, {480*46, 1, false}, {480*49, 6, false}, {480*50, 3, false}, {480*52, 2, false}};

//关卡20	
static  const LevelNode Level20[] = {{480*3, 5, false}, {480*5, 1, false}, {480*9, 6, false}, {480*11, 1, false}, {480*13, 8, false}, {480*15, 2, false}, {480*17, 5, false}, {480*20, 2, false}, {480*22, 6, false}, {480*24, 3, false}, {480*25, 7, false}, {480*27, 3, false},{480*29, 5, false}, {480*31, 1, false}, {480*35, 6, false}, {480*37, 1, false}, {480*39, 8, false}, {480*41, 2, false}, {480*43, 5, false}, {480*46, 2, false}, {480*48, 6, false}, {480*50, 3, false}, {480*51, 7, false}, {480*53, 3, false}};

//关卡21	
static  const LevelNode Level21[] = {{480*5, 5, false}, {480*9, 1, false},{480*15, 5, false}, {480*19, 1, false}};

//关卡22	
static  const LevelNode Level22[] = {{480*4, 5, false}, {480*5, 1, false}, {480*9, 5, false}, {480*11, 2, false}, {480*14, 6, false}, {480*16, 7, false},{480*20, 5, false}, {480*21, 1, false}, {480*25, 5, false}, {480*27, 2, false}, {480*30, 6, false}, {480*32, 7, false}};

//关卡23	
static  const LevelNode Level23[] = {{480*2, 1, false}, {480*4, 5, false}, {480*7, 5, false}, {480*9, 1, false}, {480*12, 6, false}, {480*15, 2, false}, {480*18, 7, false}, {480*21, 8, false}, {480*22, 3, false},{480*23, 1, false}, {480*25, 5, false}, {480*28, 5, false}, {480*30, 1, false}, {480*33, 6, false}, {480*36, 2, false}, {480*39, 7, false}, {480*42, 8, false}, {480*43, 3, false}};	
//关卡24	
static  const LevelNode Level24[] = {{480*3, 5, false}, {480*5, 1, false}, {480*8, 8, false}, {480*11, 7, false}, {480*13, 1, false}, {480*14, 8, false}, {480*16, 2, false}, {480*19, 6, false}, {480*22, 2, false}, {480*24, 5, false},{480*27, 5, false}, {480*29, 1, false}, {480*32, 8, false}, {480*35, 7, false}, {480*37, 1, false}, {480*38, 8, false}, {480*40, 2, false}, {480*43, 6, false}, {480*46, 2, false}, {480*48, 5, false}};

//关卡25	
static  const LevelNode Level25[] = {{480*3, 3, false}, {480*5, 8, false}, {480*8, 5, false}, {480*11, 2, false}, {480*13, 8, false}, {480*16, 5, false}, {480*18, 2, false}, {480*20, 7, false}, {480*22, 1, false}, {480*25, 6, false}, {480*27, 1, false},{480*30, 3, false}, {480*32, 8, false}, {480*35, 5, false}, {480*38, 2, false}, {480*40, 8, false}, {480*43, 5, false}, {480*45, 2, false}, {480*47, 7, false}, {480*49, 1, false}, {480*52, 6, false}, {480*54, 1, false}};

//关卡26	
static  const LevelNode Level26[] = {{480*3, 5, false}, {480*5, 3, false}, {480*8, 8, false}, {480*11, 3, false}, {480*13, 7, false}, {480*16, 2, false}, {480*18, 8, false}, {480*20, 1, false}, {480*23, 6, false}, {480*26, 1, false}, {480*28, 5, false}, {480*30, 2, false},{480*33, 5, false}, {480*35, 3, false}, {480*38, 8, false}, {480*41, 3, false}, {480*43, 7, false}, {480*46, 2, false}, {480*48, 8, false}, {480*50, 1, false}, {480*53, 6, false}, {480*56, 1, false}, {480*58, 5, false}, {480*60, 2, false}};

//关卡27	
static  const LevelNode Level27[] = {{480*3, 5, false}, {480*5, 3, false}, {480*8, 8, false}, {480*10, 2, false}, {480*12, 6, false}, {480*14, 1, false}, {480*18, 8, false}, {480*19, 4, false}, {480*21, 7, false}, {480*24, 5, false}, {480*29, 7, false}, {480*31, 1, false},{480*34, 5, false}, {480*36, 3, false}, {480*39, 8, false}, {480*41, 2, false}, {480*43, 6, false}, {480*45, 1, false}, {480*49, 8, false}, {480*50, 4, false}, {480*52, 7, false}, {480*55, 5, false}, {480*60, 7, false}, {480*62, 1, false}};

//关卡28	
static  const LevelNode Level28[] = {{480*3, 8, false}, {480*7, 7, false}, {480*10, 4, false}, {480*12, 8, false}, {480*15, 3, false}, {480*17, 6, false}, {480*19, 2, false}, {480*22, 5, false}, {480*24, 2, false}, {480*26, 1, false}, {480*28, 5, false}, {480*30, 1, false}, {480*32, 5, false},{480*36, 8, false}, {480*40, 7, false}, {480*43, 4, false}, {480*45, 8, false}, {480*48, 3, false}, {480*50, 6, false}, {480*52, 2, false}, {480*55, 5, false}, {480*57, 2, false}, {480*59, 1, false}, {480*61, 5, false}, {480*63, 1, false}, {480*65, 5, false}};

//关卡29	
static  const LevelNode Level29[] = {{480*2, 8, false}, {480*4, 4, false}, {480*8, 7, false}, {480*12, 5, false}, {480*14, 3, false}, {480*16, 6, false}, {480*19, 2, false}, {480*21, 8, false}, {480*24, 2, false}, {480*26, 5, false}, {480*29, 1, false}, {480*31, 5, false}, {480*33, 1, false},{480*35, 8, false}, {480*37, 4, false}, {480*41, 7, false}, {480*45, 5, false}, {480*47, 3, false}, {480*49, 6, false}, {480*52, 2, false}, {480*54, 8, false}, {480*57, 2, false}, {480*59, 5, false}, {480*62, 1, false}, {480*64, 5, false}, {480*66, 1, false}};

//关卡30	
static  const LevelNode Level30[] = {{480*3, 4, false}, {480*5, 8, false}, {480*8, 5, false}, {480*11, 8, false}, {480*12, 4, false}, {480*17, 7, false}, {480*19, 3, false}, {480*22, 7, false}, {480*24, 1, false}, {480*27, 2, false}, {480*30, 2, false}, {480*32, 6, false}, {480*35, 5, false}, {480*37, 1, false}, {480*38, 5, false},{480*40, 4, false}, {480*42, 8, false}, {480*45, 5, false}, {480*48, 8, false}, {480*49, 4, false}, {480*54, 7, false}, {480*56, 3, false}, {480*59, 7, false}, {480*61, 1, false}, {480*64, 2, false}, {480*67, 2, false}, {480*69, 6, false}, {480*72, 5, false}, {480*74, 1, false}, {480*75, 5, false}};
#endif
