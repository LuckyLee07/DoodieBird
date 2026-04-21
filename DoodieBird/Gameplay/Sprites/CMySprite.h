//
//  CMySprite.h
//  DoodieBird
//
//  Created by LuckyLee on 26-04-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CCSprite.h"

@interface CMySprite : CCSprite
{
    int m_nType;
    int m_nIndex;
    float m_nMoveValuey;
    float m_nMoveValueX;
    int m_nActionIndex;
}
@property int m_nType;
@property int m_nIndex;
@property float m_nMoveValuey;
@property float m_nMoveValueX;
@property int m_nActionIndex;
@end
