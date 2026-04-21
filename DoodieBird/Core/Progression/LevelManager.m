//
//  LevelManager.m
//  DoodieBird
//
//  Created by LuckyLee on 26-04-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LevelManager.h"

@implementation LevelManager
-(id) init
{
	self = [super init];
	if (self)
	{
		m_nBigLevel = 0;
        m_nLevel = 0;
        [self CreateLevelList];
	}
	return self;
}
//静态函数获取全局唯一的提示信息管理类
//定义全局静态对象
static LevelManager *MusicMgr = nil;
+ (LevelManager *) sharedLevelMannger
{
	@synchronized(self)
	{
		if(nil == MusicMgr)
		{
			[[self alloc] init];
		}
	}
	return MusicMgr;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
	{
        if(MusicMgr == nil)
		{
            MusicMgr = [super allocWithZone:zone];
            return MusicMgr;
        }
    }
    return nil;
}

//获取关卡数据
-(LevelNodeList) GetLevelList:(int) nIndex
{
    LevelNodeList pTem = LevList[nIndex];
    return  pTem;
}

//创建关卡列表
-(void) CreateLevelList
{
    //第1关 障碍物
    LevList[0].n_Count = 1;
    LevList[0].pLevelList = (LevelNode*)Level1;
    
    //第2关 障碍物
    LevList[1].n_Count = 3;
    LevList[1].pLevelList = (LevelNode*)Level2;
    
    //第3关 障碍物
    LevList[2].n_Count = 3;
    LevList[2].pLevelList = (LevelNode*)Level3;
    
    //第4关 障碍物
    LevList[3].n_Count = 4;
    LevList[3].pLevelList = (LevelNode*)Level4;
    
    //第5关 障碍物
    LevList[4].n_Count = 5;
    LevList[4].pLevelList = (LevelNode*)Level5;
    
    //第6关 障碍物
    LevList[5].n_Count = 6;
    LevList[5].pLevelList = (LevelNode*)Level6;
    
    //第7关 障碍物
    LevList[6].n_Count = 7;
    LevList[6].pLevelList = (LevelNode*)Level7;
    
    //第8关 障碍物
    LevList[7].n_Count = 6;
    LevList[7].pLevelList = (LevelNode*)Level8;
    
    //第9关 障碍物
    LevList[8].n_Count = 7;
    LevList[8].pLevelList = (LevelNode*)Level9;
    
    //第10关 障碍物
    LevList[9].n_Count = 7;
    LevList[9].pLevelList = (LevelNode*)Level10;
    
    //第11关 障碍物
    LevList[10].n_Count = 2;
    LevList[10].pLevelList = (LevelNode*)Level11;
    
    //第12关 障碍物
    LevList[11].n_Count = 4;
    LevList[11].pLevelList = (LevelNode*)Level12;
    
    //第13关 障碍物
    LevList[12].n_Count = 7;
    LevList[12].pLevelList = (LevelNode*)Level13;
    
    //第14关 障碍物
    LevList[13].n_Count = 8;
    LevList[13].pLevelList = (LevelNode*)Level14;
    
    //第15关 障碍物
    LevList[14].n_Count = 8;
    LevList[14].pLevelList = (LevelNode*)Level15;
    
    //第16关 障碍物
    LevList[15].n_Count = 9;
    LevList[15].pLevelList = (LevelNode*)Level16;
    
    //第17关 障碍物
    LevList[16].n_Count = 9;
    LevList[16].pLevelList = (LevelNode*)Level17;
    
    //第18关 障碍物
    LevList[17].n_Count = 10;
    LevList[17].pLevelList = (LevelNode*)Level18;
    
    //第19关 障碍物
    LevList[18].n_Count = 11;
    LevList[18].pLevelList = (LevelNode*)Level19;
    
    //第20关 障碍物
    LevList[19].n_Count = 12;
    LevList[19].pLevelList = (LevelNode*)Level20;
    
    //第21关 障碍物
    LevList[20].n_Count = 2;
    LevList[20].pLevelList = (LevelNode*)Level21;
    
    //第22关 障碍物
    LevList[21].n_Count = 6;
    LevList[21].pLevelList = (LevelNode*)Level22;
    
    //第23关 障碍物
    LevList[22].n_Count = 9;
    LevList[22].pLevelList = (LevelNode*)Level23;
    
    //第24关 障碍物
    LevList[23].n_Count = 10;
    LevList[23].pLevelList = (LevelNode*)Level24;
    
    //第25关 障碍物
    LevList[24].n_Count = 11;
    LevList[24].pLevelList = (LevelNode*)Level25;
    
    //第26关 障碍物
    LevList[25].n_Count = 12;
    LevList[25].pLevelList = (LevelNode*)Level26;
    
    //第27关 障碍物
    LevList[26].n_Count = 11;
    LevList[26].pLevelList = (LevelNode*)Level27;
    
    //第28关 障碍物
    LevList[27].n_Count = 13;
    LevList[27].pLevelList = (LevelNode*)Level28;
    
    //第29关 障碍物
    LevList[28].n_Count = 13;
    LevList[28].pLevelList = (LevelNode*)Level29;
    
    //第30关 障碍物
    LevList[29].n_Count = 15;
    LevList[29].pLevelList = (LevelNode*)Level30;
}

-(void) SetBigLevel:(int) nBigLevel
{
    m_nBigLevel = nBigLevel;
}

-(int)  GetBigLevel
{
    return m_nBigLevel;
}

-(void) SetLevel:(int) nLevel
{
    m_nLevel = nLevel;
}

-(int)  GetLevel
{
    return m_nLevel;
}
@end
