//
//  GameOver.m
//  DoodieBird
//
//  Created by LuckyLee on 26-04-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PauseGame.h"
#import "AnimationDelegate.h"
#import "SenceManager.h"
#import "LevelManager.h"

@implementation PauseGame

- (id) init
{
	self = [super init];
    if(self)
    {
       //CGSize winSize = [CCDirector sharedDirector].winSize;
       CCSprite* m_BkGroundB1 = [CCSprite spriteWithFile:@"PauseGameBk.png"];
        m_BkGroundB1.position = ccp(0, 0);
        [self addChild:m_BkGroundB1 z:0 tag:1];
        
    
        //Add by zhengxf about "加入游戏功能按钮" 2012-8-16 -------begin-------
        //商场的按钮
        CCSprite *ShopNormal = [CCSprite spriteWithFile:@"MoneyNomal.png"];
		CCSprite *ShopSelected = [CCSprite spriteWithFile:@"MoneySel.png"];
		CCMenuItemSprite *ShopGame = [CCMenuItemSprite itemWithNormalSprite:ShopNormal selectedSprite:ShopSelected target:self selector:@selector(ShowShop:)];
		CCMenu *menuShop = [CCMenu menuWithItems: ShopGame, nil];
        [menuShop setAnchorPoint:ccp(0, 0)];
		[menuShop setPosition:ccp(-90, -40)];
		//[self addChild: menuShop z:1 tag:1];
        
        //返回大关的按钮
        CCSprite *ReturnNormal = [CCSprite spriteWithFile:@"ReturnLevelNomal.png"];
		CCSprite *ReturnSelected = [CCSprite spriteWithFile:@"ReturnLevelSel.png"];
		CCMenuItemSprite *ReturnGame = [CCMenuItemSprite itemWithNormalSprite:ReturnNormal selectedSprite:ReturnSelected target:self selector:@selector(ShowChapter:)];
		CCMenu *menuReturn = [CCMenu menuWithItems: ReturnGame, nil];
        [menuReturn setAnchorPoint:ccp(0, 0)];
		[menuReturn setPosition:ccp(-90, -40)];
		[self addChild: menuReturn z:1 tag:2];
        
        //重新开始的按钮
        CCSprite *restartNormal = [CCSprite spriteWithFile:@"GameOverReturnNomal.png"];
		CCSprite *restartSelected = [CCSprite spriteWithFile:@"GameOverReturnSel.png"];
		CCMenuItemSprite *restartGame = [CCMenuItemSprite itemWithNormalSprite:restartNormal selectedSprite:restartSelected target:self selector:@selector(GameContinue:)];
		CCMenu *menurestart = [CCMenu menuWithItems: restartGame, nil];
        [menurestart setAnchorPoint:ccp(0, 0)];
		[menurestart setPosition:ccp(-30, -40)];//ccp(30, -40)
		[self addChild: menurestart z:1 tag:2];
        
        //Add by zhengxf about "加入游戏功能按钮" 2012-8-16 -------end-------
    }
    return  self;
}

-(void) SetConturnBut:(id)Targer :(SEL)selFunction
{
    m_idTarget = Targer;
	m_selFunction = selFunction;
    if(m_idTarget && m_selFunction)
    {
        //下一关的按钮
        CCSprite *NextNormal = [CCSprite spriteWithFile:@"GameOver_Conturn0.png"];
        CCSprite *NextSelected = [CCSprite spriteWithFile:@"GameOver_Conturn1.png"];
        CCMenuItemSprite *NextGame = [CCMenuItemSprite itemWithNormalSprite:NextNormal selectedSprite:NextSelected target:m_idTarget selector:m_selFunction];
        CCMenu *menuNext = [CCMenu menuWithItems: NextGame, nil];
        [menuNext setAnchorPoint:ccp(0, 0)];
        [menuNext setPosition:ccp(90, -40)];
        [self addChild: menuNext z:1 tag:10];
    }
}



-(void) SetScore:(int)nBigLevel :(int)nSmallLevel
{
    //Add by zhengxf about "加入数字的显示" 2012-8-17 ------begin------
    //获取的豆子数
    [self ShowScore:nBigLevel :ccp(10, 8) :2];
    CCSprite *spMiddle = [CCSprite spriteWithFile:@"PauseNumber_middle.png"];
    spMiddle.position = ccp(25, 8);
    [self addChild:spMiddle];
    //游戏分数
    [self ShowScore:nSmallLevel :ccp(40, 8) :2];
}


-(void) ShowScore:(int)score :(CGPoint) pt :(int)nType;
{
    char strNum[64];
    sprintf(strNum, "%d",score);
    NSUInteger len = strlen(strNum);
    NSString* strName  = nil;
    for (NSUInteger idx = 0; idx < len; idx++) 
    {
        int nNumber = strNum[idx] - '0';
        strName =  [NSString stringWithFormat:@"PauseNumber%d.png", nNumber];
        CCSprite* sp = [CCSprite spriteWithFile:strName];
        switch (nType) 
        {
            case 1:
                sp.position = ccp(pt.x + 16 * idx, pt.y);
                sp.scale = 0.7;
                break;
            case 2:
                sp.position = ccp(pt.x + 21 * idx, pt.y);
                break;
            default:
                break;
        }
        
        [self addChild:sp z:1 tag:20+idx];
    }
}

-(void) GameContinue:(id) sender
{
    SenceManager* SManager = [SenceManager sharedSenceManager];
	if(SManager)
	{
        [SManager ShowGameSence];
    }
}

-(void) ShowShop:(id) sender
{
    SenceManager* SManager = [SenceManager sharedSenceManager];
	if(SManager)
	{
		[SManager ShowShopSence];
    }
}

-(void) ShowChapter:(id) sender
{
    SenceManager* SManager = [SenceManager sharedSenceManager];
    if(SManager)
    {
        [SManager ShowSelectChapterScene];
    }
}
@end
