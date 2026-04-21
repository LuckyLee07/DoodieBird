//
//  DefaultFile.h
//  DoodieBird
//
//  Created by LuckyLee on 26-04-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ALL_BEAN_COUNT  @"ALL_BEAN_COUNT"
#define ALL_SCORE       @"ALL_SCORE"
#define LEVEL_STAR      @"Level_Star"
#define NOW_STAR        @"Now_Star"
#define LEVEL_LOCK      @"Level_Lock"
#define IS_FRIST_LEVEL1 @"Is_Frist_LEVEL1"
#define IS_FRIST_LEVEL3 @"Is_Frist_LEVEL3"
#define FRIST_LOGIN     @"Frist_Login"
#define IS_UPLOAD_BEAN  @"Is_UpLoad_Bean"
#define MUSIC_IS_OPEN   @"Music_Is_Open"

@interface DefaultFile : NSObject
{
    //Add by zhengxf "Read and Write File"  -------begin-------
	int m_nIsFrist;
	NSUserDefaults* m_SwitchV;
	//Add by zhengxf "Read and Write File"  -------end-------
    
    //Add by zhengxf about "" 2012-8-7 -------begin---------
    int m_nAllScore;
    //Add by zhengxf about "" 2012-8-7 -------begin---------
}
@property (nonatomic,retain) NSUserDefaults* m_SwitchV;
@property (readwrite) int m_nAllScore;

//静态函数获取全局唯一的蔬菜管理类
+(DefaultFile *) sharedDefaultFile;

-(void)SetIntegerForKey:(int) nValue  ForKey:(NSString*)strKey;
-(int) GetIntegerForKey:(NSString*) strKey;
- (BOOL)hasValueForKey:(NSString *)strKey;

//写入bool类型数据
-(void)SetBoolForKey:(bool) bValue ForKey:(NSString*) strKey;
-(bool)GetBoolForKey:(NSString*) strKey;

//获取所有的星星数
-(int) GetAllStar;
@end
