//
//  MainMenuSence.h
//  cookgirl
//
//  Created by LuckyLee on 26-04-22.
//  Copyright FancyGame 2026年. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#define  START_ITEM    1
#define  SET_ITEM      2
#define  MUSIC_ITEM    3
#define  LANGUAGE_ITEM 4
#define  HELP_ITEM     5  
#define  PRODUCER_ITEM 6

@interface SysMenu : CCLayer
{
	CCLabelTTF* m_MyLable; //显示提示信息
	CCSprite* m_spDialog1;
	CCSprite* m_spDialog2;
	int       m_nCount;
	int		  m_nFristLogin;
    CGSize    m_winSize;
    
    bool      m_bSetGame;
    bool      m_bIsMove;
    
    bool      m_bMusicOpen;
}
@end

@interface MainMenuSence : CCScene 
{

}
+(id) ShowScene;
@end
