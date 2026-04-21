//
//  MusicMannger.m
//  cookgirl
//
//  Created by LuckyLee on 26-04-22.
//  Copyright FancyGame 2026年. All rights reserved.
//

#import "MusicMannger.h"
@implementation MusicMannger

-(id) init
{
	self = [super init];
	if (self)
	{
		m_bIsOpenMusic = true;
	}
	return self;
}
//静态函数获取全局唯一的提示信息管理类
//定义全局静态对象
static MusicMannger *MusicMgr = nil;
+ (MusicMannger *) sharedMusicMannger
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


-(void) SetIsOpenMusic:(bool)IsOpen
{
	if( IsOpen != m_bIsOpenMusic )
	{
		m_bIsOpenMusic = IsOpen;
	}
}

-(bool) GetIsOpenMusic
{
	return m_bIsOpenMusic;
}

-(void) SetIsRestBeforeOpenMusic:(bool)IsOpen
{ 
	m_bIsRestBeforeOpenMusic = IsOpen; 
}

-(bool) GetIsRestBeforeOpenMusic
{ 
	return m_bIsRestBeforeOpenMusic; 
}

-(void) PlayMusic:(NSString*) pszFilePath :(bool)bLoop
{
	if(m_bIsOpenMusic)
	{
		SimpleAudioEngine* pSimpleAE =[SimpleAudioEngine sharedEngine];
		if(pSimpleAE)
		{
			[pSimpleAE playBackgroundMusic:pszFilePath loop:bLoop];
		}
	}
}

-(void) PlayEffect:(NSString*) pszFilePath
{
	if(m_bIsOpenMusic)
	{
		SimpleAudioEngine* pSimpleAE = [SimpleAudioEngine sharedEngine];
		if(pSimpleAE)
		{
			[pSimpleAE playEffect:pszFilePath];
		}
	}
}

-(float) GetBkMusicV
{
	float fResult = 0.0f;
	SimpleAudioEngine* pSimpleAE =[SimpleAudioEngine sharedEngine];
	if(pSimpleAE)
	{
		fResult = [pSimpleAE backgroundMusicVolume];
	}
	return fResult;
}

-(void) SetBkMusicV:(float)fVulm;
{
	SimpleAudioEngine* pSimpleAE =[SimpleAudioEngine sharedEngine];
	if(pSimpleAE)
	{
		[pSimpleAE setBackgroundMusicVolume:fVulm];
	}
}

-(float) GetEfMusicV
{
	float fResult = 0.0f;
	SimpleAudioEngine* pSimpleAE =[SimpleAudioEngine sharedEngine];
	if(pSimpleAE)
	{
		fResult = [pSimpleAE effectsVolume];
	}
	return fResult;
}

-(void) PauseMusic //暂停游戏的音效
{
    SimpleAudioEngine* pSimpleAE =[SimpleAudioEngine sharedEngine];
	if(pSimpleAE)
	{
        [pSimpleAE stopBackgroundMusic];
    }
}

-(void) PlayBackGroudMusic
{
    SimpleAudioEngine* pSimpleAE =[SimpleAudioEngine sharedEngine];
	if(pSimpleAE)
	{
        [pSimpleAE playBackgroundMusic:@"MusicBk.mp3"];
    }
}

-(void) SetEfMusicV:(float)fVulm;
{
	SimpleAudioEngine* pSimpleAE =[SimpleAudioEngine sharedEngine];
	if(pSimpleAE)
	{
		[pSimpleAE setEffectsVolume:fVulm];
	}
}
@end
