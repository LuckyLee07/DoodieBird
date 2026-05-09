//
//  DefaultFile.m
//  DoodieBird
//
//  Created by LuckyLee on 26-04-22.
//  Copyright (c) 2026年 FancyGame. All rights reserved.
//

#import "DefaultFile.h"

@implementation DefaultFile
@synthesize m_SwitchV;
@synthesize m_nAllScore;
//静态函数获取全局唯一的提示信息管理类
//定义全局静态对象
static DefaultFile *PromptMg = nil;

-(id) init
{
	self = [super init];
	if (self)
	{
		m_SwitchV = [NSUserDefaults standardUserDefaults];
	}
	return self;
}

+ (DefaultFile *) sharedDefaultFile
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        PromptMg = [[super allocWithZone:NULL] init];
    });
	return PromptMg;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
	{
        if(PromptMg == nil)
		{
            PromptMg = [super allocWithZone:zone];
        }
    }
    return PromptMg;
}

-(void)SetIntegerForKey:(int) nValue  ForKey:(NSString*)strKey
{
    if(m_SwitchV)
	{
		if(strKey)
		{
			[m_SwitchV setInteger:nValue forKey:strKey];
            [m_SwitchV synchronize];
		}
    }
}

-(int) GetIntegerForKey:(NSString*) strKey
{
    int nScore = 0;
	if(m_SwitchV && strKey)
	{
		nScore = (int)[m_SwitchV integerForKey:strKey];
	}
	return nScore;
}

- (BOOL)hasValueForKey:(NSString *)strKey
{
    if (m_SwitchV == nil || strKey == nil)
    {
        return NO;
    }

    return [m_SwitchV objectForKey:strKey] != nil;
}

//写入bool类型数据
-(void)SetBoolForKey:(bool) bValue ForKey:(NSString*) strKey
{
    if(m_SwitchV)
	{
		if(strKey)
		{
			[m_SwitchV setBool:bValue forKey:strKey];
            [m_SwitchV synchronize];
		}
    }
}

-(bool)GetBoolForKey:(NSString*) strKey
{
    bool bScore = 0;
	if(m_SwitchV && strKey)
	{
		bScore = [m_SwitchV boolForKey:strKey];
	}
	return bScore;
}

//获取所有的星星数
-(int) GetAllStar
{
    int nStar = 0;
    for(int i = 1; i<=3; i++)
    {
        for(int j= 1; j<=10; j++)
        {
            NSString* pKey = [NSString stringWithFormat:@"%@_%d_%d",LEVEL_STAR, i, j];
            int nLeveStar = (int)[m_SwitchV integerForKey:pKey];
            nStar+= nLeveStar;
        }
    }
    return nStar;
}
@end
