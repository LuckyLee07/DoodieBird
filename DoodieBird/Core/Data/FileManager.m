//
//  FileManager.m
//  DoodieBird
//
//  Created by LuckyLee on 26-04-22.
//  Copyright (c) 2026年 FancyGame. All rights reserved.
//

#import "FileManager.h"

static int FMIntValue(NSNumber *value)
{
    return value != nil ? (int)[value integerValue] : 0;
}

@implementation FileManager

-(id) init
{
    self = [super init];
    if(self)
    {
        m_pLevelList = nil;
        m_pBeanList = nil;
        m_pFlashingList = nil;
    }
    return self;
}

-(int) GetListCount:(int) nLevel
{
    int nCount = 0;
    NSLog(@"HunterCount = %lu", (unsigned long)[m_pLevelList count]);
    if(m_pLevelList && nLevel > 0 && (NSUInteger)nLevel <= [m_pLevelList count])
    {
        NSArray* HunterList =  [m_pLevelList objectAtIndex:nLevel-1];
        nCount = (int)[HunterList count];
    }
    return  nCount;
}

-(void) OpenHunterFile:(NSString*) strFileName
{
    NSString *filePath = nil;
    if(strFileName)
    {
        filePath = [[NSBundle mainBundle] pathForResource:@"HunterList" ofType:@"plist"];
    } 
	if(filePath)
	{
        [m_pLevelList release];
			m_pLevelList = [[NSArray alloc] initWithContentsOfFile:filePath];
	}
}

-(HunterMessage) GetHunterMessage:(int)nLevel :(int)nIndex;
{
    HunterMessage pTem = (HunterMessage){0};
	if(m_pLevelList && nLevel > 0 && nIndex >= 0 && m_pLevelList.count >= (NSUInteger)nLevel)
	{
        NSArray* HunterList =  [m_pLevelList objectAtIndex:nLevel -1];
        if(HunterList && HunterList.count > (NSUInteger)nIndex)
        {
            NSDictionary* DictionData =  [HunterList objectAtIndex:nIndex];
            if(DictionData)
            {
                pTem.m_nX = FMIntValue([DictionData objectForKey:@"X"]);
                pTem.m_nY = FMIntValue([DictionData objectForKey:@"Y"]);
                pTem.m_nAction = FMIntValue([DictionData objectForKey:@"nAction"]);
                pTem.m_nType = FMIntValue([DictionData objectForKey:@"nType"]);
            }
        }
	}
    return pTem;
}

//闪电的数据集合  ----------begin--------
-(void) OpenFlashingFile:(NSString*) strFileName//打开闪电的数据列表
{
    NSString *filePath = nil;
    if(strFileName)
    {
        filePath = [[NSBundle mainBundle] pathForResource:@"Flashing" ofType:@"plist"];
    } 
	if(filePath)
	{
        [m_pFlashingList release];
			m_pFlashingList = [[NSArray alloc] initWithContentsOfFile:filePath];
	}
}

-(int)  GetFlashingLevelTypeCount                  //获取豆子级别的列表
{ 
    return (int)[m_pFlashingList count];
}

-(int)  GetFlashingListCount:(int)nIndex
{
    int nCount = 0;
    if(m_pFlashingList && nIndex > 0 && (NSUInteger)nIndex <= [m_pFlashingList count])
    {
        NSArray*  BeanList =  [m_pFlashingList objectAtIndex:nIndex -1];
        if(BeanList)
        {
            nCount = (int)[BeanList count];
        }
    }
    return nCount;
}

-(BeanMessage) GetFlashingMessage:(int)nLevel :(int)nIndex
{
    BeanMessage pTem = (BeanMessage){0};
	if(m_pFlashingList && nLevel > 0 && nIndex >= 0 && m_pFlashingList.count >= (NSUInteger)nLevel)
	{
        NSArray* ArrayData =  [m_pFlashingList objectAtIndex:nLevel -1];
        if(ArrayData && ArrayData.count > (NSUInteger)nIndex)
        {
            NSDictionary* BeanDataList = [ArrayData objectAtIndex:nIndex];
            if(BeanDataList)
            {
                pTem.m_nX = FMIntValue([BeanDataList objectForKey:@"X"]);
                pTem.m_nY = FMIntValue([BeanDataList objectForKey:@"Y"]);
                pTem.m_nType = FMIntValue([BeanDataList objectForKey:@"nType"]);
                pTem.m_nIndex = FMIntValue([BeanDataList objectForKey:@"nIndex"]);
            }
        }
	}
    return pTem;
}

//闪电的数据集合  ----------end--------

//豆子的数据操作集合 --------begin---------
-(int)  GetBeanLevelTypeCount                  //获取豆子级别的列表
{
    return (int)[m_pBeanList count];
}

-(int)  GetBeanListCount:(int)nIndex
{
    int nCount = 0;
    if(m_pBeanList && nIndex > 0 && (NSUInteger)nIndex <= [m_pBeanList count])
    {
        NSArray*  BeanList =  [m_pBeanList objectAtIndex:nIndex -1];
        if(BeanList)
        {
            nCount = (int)[BeanList count];
        }
    }
    return nCount;
}


-(void) OpenBeanFrile:(NSString*) strFileName
{
    NSString *filePath = nil;
    if(strFileName)
    {
        filePath = [[NSBundle mainBundle] pathForResource:@"BeanList" ofType:@"plist"];
    } 
	if(filePath)
	{
        [m_pBeanList release];
			m_pBeanList = [[NSArray alloc] initWithContentsOfFile:filePath];
	}
}

-(BeanMessage) GetBeanMessage:(int)nLevel :(int)nIndex
{
    BeanMessage pTem = (BeanMessage){0};
	if(m_pBeanList && nLevel > 0 && nIndex >= 0 && m_pBeanList.count >= (NSUInteger)nLevel)
	{
        NSArray* ArrayData =  [m_pBeanList objectAtIndex:nLevel -1];
        if(ArrayData && ArrayData.count > (NSUInteger)nIndex)
        {
            NSDictionary* BeanDataList = [ArrayData objectAtIndex:nIndex];
            if(BeanDataList)
            {
                pTem.m_nX = FMIntValue([BeanDataList objectForKey:@"X"]);
                pTem.m_nY = FMIntValue([BeanDataList objectForKey:@"Y"]);
                pTem.m_nType = FMIntValue([BeanDataList objectForKey:@"nType"]);
                pTem.m_nIndex = FMIntValue([BeanDataList objectForKey:@"nIndex"]);
            }
        }
	}
    return pTem;
}

-(void) WriteBeanList
{
    NSMutableArray* pArr = [[NSMutableArray alloc] init];
    if(m_pBeanList)
    {
        for(NSUInteger n = 0; n < m_pBeanList.count; n++)
        {
            NSArray* ArrayData =  [m_pBeanList objectAtIndex:n];
            NSMutableArray* pArrSecond = [[NSMutableArray alloc] init];
            if(ArrayData)
            {
                for (NSUInteger i = 0; i < ArrayData.count; i++) 
                {
                    NSMutableDictionary* BeanDataList = [[NSMutableDictionary alloc ] initWithDictionary:[ArrayData objectAtIndex:i]];
                    if(BeanDataList)
                    {
                        NSNumber* X = [BeanDataList objectForKey:@"X"];
                        if(X)
                        {
                            int m_nX = FMIntValue(X);
                            m_nX = m_nX/2;
                            //X = [NSNumber numberWithInteger:m_nX];
                            NSString* strName =  [NSString stringWithFormat:@"%d", m_nX];
                            [BeanDataList setObject:strName forKey:@"X"];
                            //[BeanDataList setValue:X forKey:@"X"];
                        }
                        NSNumber* Y = [BeanDataList objectForKey:@"Y"];
                        if(Y)
                        {
                            int m_nY = FMIntValue(Y);
                            m_nY = m_nY/2;
//                            Y = [NSNumber numberWithInteger:m_nY];
//                            [BeanDataList setObject:Y forKey:@"Y"];
                            NSString* strName =  [NSString stringWithFormat:@"%d", m_nY];
                            [BeanDataList setObject:strName forKey:@"Y"];
                        }
                        [pArrSecond addObject:BeanDataList];
                    }
                    [BeanDataList release];
                }
            }
            [pArr addObject:pArrSecond];
            [pArrSecond release];
        }
        
        NSArray *doc = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docPath = [ doc objectAtIndex:0 ];
        [pArr writeToFile:[docPath stringByAppendingPathComponent:@"BeanList11.plist"] atomically:YES ];
    }
    [pArr release];
}

static FileManager *FileMgr = nil;

+ (FileManager *) sharedFileManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        FileMgr = [[super allocWithZone:NULL] init];
    });
	return FileMgr;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
	{
        if(FileMgr == nil)
		{
            FileMgr = [super allocWithZone:zone];
        }
    }
    return FileMgr;
}
@end
