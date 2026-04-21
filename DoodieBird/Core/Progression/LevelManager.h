//
//  LevelManager.h
//  DoodieBird
//
//  Created by LuckyLee on 26-04-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "def.h"

@interface LevelManager : NSObject
{
    int m_nBigLevel;
    int m_nLevel;
    LevelNodeList LevList[30];
}
+(LevelManager *) sharedLevelMannger;
-(void) SetBigLevel:(int) nBigLevel;
-(int)  GetBigLevel;

-(void) SetLevel:(int) nLevel;
-(int)  GetLevel;

//创建关卡列表
-(void) CreateLevelList;

//获取关卡数据
-(LevelNodeList) GetLevelList:(int) nIndex;
@end
