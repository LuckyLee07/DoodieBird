//
//  SelectChapter.h
//  DoodieBird
//
//  Created by LuckyLee on 26-04-22.
//  Copyright (c) 2026年 FancyGame. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#define GAME_CHAPTER_FRIST  1
#define GAME_CHAPTER_SECOND 2
#define GAME_CHAPTER_THRID  3

@interface SelectChapter : CCLayer
{
    CGSize m_winSize;
}
@end

@interface SelectChapterSence : CCScene 
{
    
}
+(id) ShowScene;
@end
