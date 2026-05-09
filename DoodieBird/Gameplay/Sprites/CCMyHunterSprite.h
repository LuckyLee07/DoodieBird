//
//  CCMyHunterSprite.h
//  DoodieBird
//
//  Created by LuckyLee on 26-04-22.
//  Copyright (c) 2026年 FancyGame. All rights reserved.
//

#import "CMySprite.h"

enum HUNTER_STATE {
	HUNTER_STATE_NOMAL = 0,       //正常状态
	HUNTER_STATE_JUMP,            //加速状态
    HUNTER_STATE_DEAD,            //死亡状态
    HUNTER_STATE_BRUISE,          //人物受伤
};

enum HUNTER_DEAD_TYPE             //人物死亡的类型
{
    HUNTER_DEAD_FIRE = 1,
    HUNTER_DEAD_FLIGHT,
};

@interface CCMyHunterSprite : CMySprite
{
    bool m_bActionRun;
    bool m_bDead;
    int m_nHunterState;
    int m_nBlood; //人物的血量
    int m_nDeadType;
}
@property bool m_bActionRun;
@property bool m_bDead;
@property int  m_nHunterState;
@property int  m_nBlood;
@property int  m_nDeadType;
@end
