//
//  MusicMannger.h
//  cookgirl
//
//  Created by LuckyLee on 26-04-22.
//  Copyright FancyGame 2026年. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SimpleAudioEngine.h"

@interface MusicMannger : NSObject 
{
	bool m_bIsOpenMusic;
	bool m_bIsRestBeforeOpenMusic;
}
+(MusicMannger *) sharedMusicMannger;

-(void) SetIsOpenMusic:(bool)IsOpen;
-(bool) GetIsOpenMusic;
-(void) SetIsRestBeforeOpenMusic:(bool)IsOpen;
-(bool) GetIsRestBeforeOpenMusic;
-(void) PlayMusic:(NSString*) pszFilePath :(bool)bLoop;
-(void) PlayEffect:(NSString*) pszFilePath;
-(float) GetBkMusicV;
-(void) SetBkMusicV:(float)fVulm;
-(float) GetEfMusicV;
-(void) SetEfMusicV:(float)fVulm;
-(void) PauseMusic; //暂停游戏的音效
-(void) PlayBackGroudMusic;
@end
