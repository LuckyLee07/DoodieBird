//
//  FileManager.m
//  DoodieBird
//
//  Created by LuckyLee on 26-04-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FileManager.h"

@implementation FileManager

-(id) init
{
    self = [super init];
    if(self)
    {
        m_pLevelList = nil;
    }
    return self;
}

-(int) GetListCount:(int) nLevel
{
    int nCount = 0;
    NSLog(@"HunterCount = %d", [m_pLevelList count]);
    if(m_pLevelList && nLevel <= [m_pLevelList count])
    {
        NSArray* HunterList =  [m_pLevelList objectAtIndex:nLevel-1];
        nCount =  [HunterList  count];
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
		m_pLevelList = [[NSArray alloc] initWithContentsOfFile:filePath];
	}
}

-(HunterMessage) GetHunterMessage:(int)nLevel :(int)nIndex;
{
    HunterMessage pTem;
	if(m_pLevelList && m_pLevelList.count >= nLevel)
	{
        NSArray* HunterList =  [m_pLevelList objectAtIndex:nLevel -1];
        if(HunterList && HunterList.count > nIndex)
        {
            NSDictionary* DictionData =  [HunterList objectAtIndex:nIndex];
            if(DictionData)
            {
                NSNumber* X = [DictionData objectForKey:@"X"];
                if(X)
                {
                    pTem.m_nX = [X integerValue];
                }
                NSNumber* Y = [DictionData objectForKey:@"Y"];
                if(Y)
                {
                    pTem.m_nY = [Y integerValue];
                }
                NSNumber* nAction = [DictionData objectForKey:@"nAction"];
                if(nAction)
                {
                    pTem.m_nAction = [nAction integerValue];
                }
                NSNumber* nType = [DictionData objectForKey:@"nType"];
                if(nType)
                {
                    pTem.m_nType = [nType integerValue];
                }
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
		m_pFlashingList = [[NSArray alloc] initWithContentsOfFile:filePath];
	}
}

-(int)  GetFlashingLevelTypeCount                  //获取豆子级别的列表
{ 
    int nCount = 0;
    nCount = [m_pFlashingList count];
    return nCount;
}

-(int)  GetFlashingListCount:(int)nIndex
{
    int nCount = 0;
    if(m_pFlashingList && nIndex <= [m_pFlashingList count])
    {
        NSArray*  BeanList =  [m_pFlashingList objectAtIndex:nIndex -1];
        if(BeanList)
        {
            nCount = [BeanList count];
        }
    }
    return nCount;
}

-(int)  GetFlashingType:(int)nIndex
{
    int nResult = 0;
    if(m_pFlashingList && nIndex <= [m_pFlashingList count])
    {
        NSDictionary* BeanDiction =  [m_pFlashingList objectAtIndex:nIndex -1];
        if(BeanDiction && BeanDiction.count > nIndex)
        {
            NSNumber* xoffset = [BeanDiction objectForKey:@"Xoffset"];
            if(xoffset)
            {
                nResult= [xoffset integerValue];
            }
        }
    }
    return nResult;
}


-(BeanMessage) GetFlashingMessage:(int)nLevel :(int)nIndex
{
    BeanMessage pTem;
	if(m_pFlashingList && m_pFlashingList.count >= nLevel)
	{
        NSArray* ArrayData =  [m_pFlashingList objectAtIndex:nLevel -1];
        if(ArrayData)
        {
            NSDictionary* BeanDataList = [ArrayData objectAtIndex:nIndex];
            if(BeanDataList)
            {
                NSNumber* X = [BeanDataList objectForKey:@"X"];
                if(X)
                {
                    pTem.m_nX = [X integerValue];
                }
                NSNumber* Y = [BeanDataList objectForKey:@"Y"];
                if(Y)
                {
                    pTem.m_nY = [Y integerValue];
                }
                NSNumber* nType = [BeanDataList objectForKey:@"nType"];
                if(nType)
                {
                    pTem.m_nType = [nType integerValue];
                }
                NSNumber* nIndex = [BeanDataList objectForKey:@"nIndex"];
                if(nIndex)
                {
                    pTem.m_nIndex = [nIndex integerValue];
                }
            }
        }
	}
    return pTem;
}

//闪电的数据集合  ----------end--------

//豆子的数据操作集合 --------begin---------
-(int)  GetBeanLevelTypeCount                  //获取豆子级别的列表
{
    int nCount = 0;
    nCount = [m_pBeanList count];
    return nCount;
}

-(int)  GetBeanListCount:(int)nIndex
{
    int nCount = 0;
    if(m_pBeanList && nIndex <= [m_pBeanList count])
    {
        NSArray*  BeanList =  [m_pBeanList objectAtIndex:nIndex -1];
        if(BeanList)
        {
            nCount = [BeanList count];
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
		m_pBeanList = [[NSArray alloc] initWithContentsOfFile:filePath];
	}
}

-(int)  GetBeanXOffset:(int)nIndex
{
    int nResult = 0;
    if(m_pBeanList && nIndex <= [m_pBeanList count])
    {
        NSDictionary* BeanDiction =  [m_pBeanList objectAtIndex:nIndex -1];
        if(BeanDiction && BeanDiction.count > nIndex)
        {
            NSNumber* xoffset = [BeanDiction objectForKey:@"Xoffset"];
            if(xoffset)
            {
               nResult= [xoffset integerValue];
            }
        }
    }
    return nResult;
}

-(int)  GetBeanType:(int)nIndex
{
    int nResult = 0;
    if(m_pBeanList && nIndex <= [m_pBeanList count])
    {
        NSDictionary* BeanDiction =  [m_pBeanList objectAtIndex:nIndex -1];
        if(BeanDiction && BeanDiction.count > nIndex)
        {
            NSNumber* xoffset = [BeanDiction objectForKey:@"Xoffset"];
            if(xoffset)
            {
                nResult= [xoffset integerValue];
            }
        }
    }
    return nResult;
}

-(BeanMessage) GetBeanMessage:(int)nLevel :(int)nIndex
{
    BeanMessage pTem;
	if(m_pBeanList && m_pBeanList.count >= nLevel)
	{
        NSArray* ArrayData =  [m_pBeanList objectAtIndex:nLevel -1];
        if(ArrayData)
        {
            NSDictionary* BeanDataList = [ArrayData objectAtIndex:nIndex];
            if(BeanDataList)
            {
                NSNumber* X = [BeanDataList objectForKey:@"X"];
                if(X)
                {
                    pTem.m_nX = [X integerValue];
                }
                NSNumber* Y = [BeanDataList objectForKey:@"Y"];
                if(Y)
                {
                    pTem.m_nY = [Y integerValue];
                }
                NSNumber* nType = [BeanDataList objectForKey:@"nType"];
                if(nType)
                {
                    pTem.m_nType = [nType integerValue];
                }
                NSNumber* nIndex = [BeanDataList objectForKey:@"nIndex"];
                if(nIndex)
                {
                    pTem.m_nIndex = [nIndex integerValue];
                }
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
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"BeanList11" ofType:@"plist"];
        for(int n= 0; n< m_pBeanList.count; n++)
        {
            NSArray* ArrayData =  [m_pBeanList objectAtIndex:n];
            NSMutableArray* pArrSecond = [[NSMutableArray alloc] init];
            if(ArrayData)
            {
                for (int i = 0; i<ArrayData.count; i++) 
                {
                    NSMutableDictionary* BeanDataList = [[NSMutableDictionary alloc ] initWithDictionary:[ArrayData objectAtIndex:i]];
                    if(BeanDataList)
                    {
                        NSNumber* X = [BeanDataList objectForKey:@"X"];
                        if(X)
                        {
                            int m_nX = [X integerValue];
                            m_nX = m_nX/2;
                            //X = [NSNumber numberWithInteger:m_nX];
                            NSString* strName =  [NSString stringWithFormat:@"%d", m_nX];
                            [BeanDataList setObject:strName forKey:@"X"];
                            //[BeanDataList setValue:X forKey:@"X"];
                        }
                        NSNumber* Y = [BeanDataList objectForKey:@"Y"];
                        if(Y)
                        {
                            int m_nY = [Y integerValue];
                            m_nY = m_nY/2;
//                            Y = [NSNumber numberWithInteger:m_nY];
//                            [BeanDataList setObject:Y forKey:@"Y"];
                            NSString* strName =  [NSString stringWithFormat:@"%d", m_nY];
                            [BeanDataList setObject:strName forKey:@"Y"];
                        }
                        [pArrSecond addObject:BeanDataList];
                        //[BeanDataList writeToFile:filePath atomically:YES];
                    }
                }
            }
            [pArr addObject:pArrSecond];
        }
        
        NSArray *doc = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docPath = [ doc objectAtIndex:0 ];
        [pArr writeToFile:[docPath stringByAppendingPathComponent:@"BeanList11.plist"] atomically:YES ];
        //[ pArr writeToFile:filePath atomically:YES ];
    }
}

static FileManager *FileMgr = nil;

+ (FileManager *) sharedFileManager
{
	@synchronized(self)
	{
		if(nil == FileMgr)
		{
			[[self alloc] init];
		}
	}
	return FileMgr;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
	{
        if(FileMgr == nil)
		{
            FileMgr = [super allocWithZone:zone];
            return FileMgr;
        }
    }
    return nil;
}
@end
