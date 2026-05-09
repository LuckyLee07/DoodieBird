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

#define UPLOADING_BEAN   500

//Add by zhengxf about "障碍物介绍" 2012-9-3 ------begin------
@interface Introduce : CCLayer
{
    CCSprite* m_spObstruct;
    int m_nIndex;
    CGSize m_winSize;
}
-(void)SetIntrodeceIndex:(int)nLevelIndex;
@end
//Add by zhengxf about "障碍物介绍" 2012-9-3 ------end------

@interface GameOver : CCLayer
{
    int m_nStar;
    int m_nScore;
    int m_nBean;
    int m_nEatBean;
    bool m_bSuccess;
    //新加的豆子
    int m_nAddBean;
    int m_nStartIndex;
    CGSize winSize;
}
@property (readwrite) int m_nStar;
@property (readwrite) int m_nScore;
@property (readwrite) int m_nBean;
@property (readwrite) int m_nAddBean;
@property (readwrite) bool m_bSuccess;

-(void) SetScore:(int)nStar :(int)nScore :(int)nBean :(int)nEatBean :(bool)bSuccess;
@end

@interface GameOverScence : CCScene
{

}
+(id) ShowScene;
@end
