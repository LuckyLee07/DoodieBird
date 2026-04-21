//
//  StarButton.h
//  cookgirl
//
//  Created by LuckyLee on 26-04-22.
//  Copyright FancyGame 2026年. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#define IRON_CHAIN 100
#define MENUE_ITEM_INDEX 300

@interface MainItemButton : CCLayer {
	CCSprite *m_VegetableSel;
    CCSprite *m_ItemSel;
	CCSprite *m_VegetableBan;
	CGPoint m_ptStart;
	int m_nIndex;
	id  m_idTarget;
	SEL m_selFunction;
	bool m_bColor;
	bool m_bStep;
    int  m_nScore;
}
@property (nonatomic,readwrite) int m_nIndex;
@property (readwrite) int m_nScore;
-(void)SetTarget:(id)idTarget :(SEL)selFunction;
-(void)SetStarNum:(int) nNumber;
-(void)SetVeg:(CGPoint) pt :(int) nIndex :(int)nNumber :(bool) bLock :(bool)bStep :(NSString*) strFileName :(NSString*) strFileSel;
-(void)SetColor:(bool)bColor;
//-(void)ShowScore:(int)score :(CGPoint) pt;
-(void) ShowScore:(int)score :(CGPoint) pt :(int)nType;
-(void)SetLocke:(bool)bColor; 
-(void)RunAction;
@end
