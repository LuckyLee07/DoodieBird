//
//  CCMyBridSprite.h
//  DoodieBird
//
//  Created by LuckyLee on 26-04-22.
//  Copyright (c) 2026年 FancyGame. All rights reserved.
//

#import "CMySprite.h"


enum BRID_STATE {
	BRID_STATE_NOMAL = 0,       //正常状态
	BRID_STATE_ACCELERATE,		//加速状态
	BRID_STATE_LOW,             //落到地面的状态
	BRID_STATE_HEIGHT,          //飞到最上的状态
	BRID_STATE_HUNT1,           //击中状态1
    BRID_STATE_HUNT2,           //击中状态2
    BRID_STATE_EAT,              //吃豆子的动画
    BRID_STATE_CATCHED,          //鸟被抓的动画
    BRID_STATE_LIGHTNING         //鸟被电到
};

@interface CCMyBridSprite : CMySprite
{
    int m_nBridState;
}
@property int m_nBridState;
@end
