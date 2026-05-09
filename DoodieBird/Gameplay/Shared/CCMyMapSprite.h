//
//  CCMyMapSprite.h
//  DoodieBird
//
//  Created by LuckyLee on 26-04-22.
//      Copyright (c) 2026年 FancyGame. All rights reserved.
//

#import "CCSprite.h"

@interface CCMyMapSprite : CCSprite
{
    int m_nMapType;
    float m_fMoveRate;
}
@property int m_nMapType;
@property float m_fMoveRate;
@end
