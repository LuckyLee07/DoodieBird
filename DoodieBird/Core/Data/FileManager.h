//
//  FileManager.h
//  DoodieBird
//
//  Created by LuckyLee on 26-04-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

//猎人数据列表
typedef  struct _HunterMessage 
{
    int m_nX;
    int m_nY;
    int m_nType;
    int m_nAction;
}HunterMessage;

//豆子数据
typedef struct _BeanMessage
{
    int m_nOffset;
    int m_nBigType;
    int m_nX;
    int m_nY;
    int m_nType;
    int m_nIndex;
}BeanMessage;

@interface FileManager : NSObject
{
    NSArray* m_pLevelList;
    NSArray* m_pBeanList;
    NSArray* m_pFlashingList;
}
+(FileManager*) sharedFileManager;

//猎人的数据操作集合 ------begin--------
-(int) GetListCount:(int) nLevel;
-(void) OpenHunterFile:(NSString*) strFileName;
-(HunterMessage) GetHunterMessage:(int)nLevel :(int)nIndex;
//猎人的数据操作集合 ------end--------

//豆子的数据操作集合 --------begin---------
-(int)  GetBeanLevelTypeCount;                  //获取豆子级别的列表
-(int)  GetBeanListCount:(int)nIndex;           //获取单个豆子级别的列表
-(void) OpenBeanFrile:(NSString*) strFileName;  //打开豆子列表数据文件
-(BeanMessage) GetBeanMessage:(int)nLevel :(int)nIndex;
//豆子的数据操作集合 --------end---------

//闪电的数据集合  ----------begin--------
-(void) OpenFlashingFile:(NSString*) strFileName; //打开闪电的数据列表
-(int)  GetFlashingLevelTypeCount;
-(int)  GetFlashingListCount:(int)nIndex;
-(BeanMessage) GetFlashingMessage:(int)nLevel :(int)nIndex;
//闪电的数据集合  ----------end--------
@end
