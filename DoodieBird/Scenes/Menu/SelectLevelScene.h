//
//  SelectLevelScene.h
//  DoodieBird
//
//  Created by LuckyLee on 26-04-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#define  START_ITEM    1
#define  LEVEL_ITEM_INDEX 20

@interface SelectLevelLayer : CCLayer
{
    CGSize m_winSize;
    int m_nBigLevel;
}
@end

@interface SelectLevelScene  : CCScene 
{
    
}
+(id) ShowScene;
@end
