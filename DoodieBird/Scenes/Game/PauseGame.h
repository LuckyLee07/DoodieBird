//
//  GameOver.h
//  DoodieBird
//
//  Created by LuckyLee on 26-04-22.
//  Copyright (c) 2026年 FancyGame. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCLayer.h"

@interface PauseGame : CCLayer
{
    //Add by zhengxf about "继续游戏回调函数的实现" 2012-8-30 --------begin-------
    id  m_idTarget;
	SEL m_selFunction;
    //Add by zhengxf about "继续游戏回调函数的实现" 2012-8-30 --------end-------
}

-(void) SetConturnBut:(id)Targer :(SEL)selFunction;
-(void) SetScore:(int)nBigLevel :(int)nSmallLevel;
@end
