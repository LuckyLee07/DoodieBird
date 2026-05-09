//
//  CCMyHunterSprite.m
//  DoodieBird
//
//  Created by LuckyLee on 26-04-22.
//  Copyright (c) 2026年 FancyGame. All rights reserved.
//

#import "CCMyHunterSprite.h"

@implementation CCMyHunterSprite
@synthesize m_bActionRun;
@synthesize  m_bDead;
@synthesize  m_nHunterState;
@synthesize  m_nBlood;
@synthesize  m_nDeadType;

-(id) init
{
    self = [super init];
    if(self)
    {
        m_nBlood = 0;
        m_nDeadType = 0;
    }
    return  self;
}

@end
