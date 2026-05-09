//
//  GameOver.m
//  DoodieBird
//
//  Created by LuckyLee on 26-04-22.
//  Copyright (c) 2026年 FancyGame. All rights reserved.
//

#import "GameOver.h"
#import "AnimationDelegate.h"
#import "SenceManager.h"
#import "LevelManager.h"
#import "MusicMannger.h"
#import "DefaultFile.h"
#import "../../Gameplay/Shared/LayoutHelper.h"

//Add by zhengxf about "障碍物介绍" 2012-9-3 ------begin------
@implementation Introduce : CCLayer

-(id) init
{
    self = [super init];
    if(self)
    {
        [self setIsTouchEnabled:YES];
    }
    return self;
}

-(void)SetIntrodeceIndex:(int)nLevelIndex
{
    m_winSize = [CCDirector sharedDirector].winSize;
    m_nIndex = nLevelIndex;
    if(m_nIndex == 2)
    {
        m_spObstruct = [CCSprite spriteWithFile:[NSString stringWithFormat:@"Introduce_%d.png", m_nIndex -1]];
    }
    else 
    {
        m_spObstruct = [CCSprite spriteWithFile:[NSString stringWithFormat:@"Introduce_%d.png", nLevelIndex]];
    }
    m_spObstruct.position = DBLayoutPoint(m_winSize, 240.0f, 160.0f);
    m_spObstruct.scale = DBLayoutScale(m_winSize);
    [self addChild:m_spObstruct z:0 tag:1];
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
     //NSUInteger touchCount  = [touches count];
    if(m_nIndex == 2)
    {
        [self removeChild:m_spObstruct cleanup:YES];
        m_spObstruct = [CCSprite spriteWithFile:[NSString stringWithFormat:@"Introduce_%d.png", m_nIndex]];
        m_spObstruct.position = DBLayoutPoint(m_winSize, 240.0f, 160.0f);
        m_spObstruct.scale = DBLayoutScale(m_winSize);
        [self addChild:m_spObstruct z:0 tag:1];
        m_nIndex = 0;
    }
    else 
    {
       [self removeFromParentAndCleanup:YES]; 
    }
    
}

@end
//Add by zhengxf about "障碍物介绍" 2012-9-3 ------end------

@implementation GameOver

@synthesize m_nStar;
@synthesize m_nScore;
@synthesize m_nBean;
@synthesize m_nAddBean;
@synthesize m_bSuccess;
- (id) init
{
	self = [super init];
    if(self)
    {
       winSize = [CCDirector sharedDirector].winSize;
        const CGFloat layoutScale = DBLayoutScale(winSize);
        CCSprite* m_BkGroundB1 = [CCSprite spriteWithFile:DBWideAssetName(@"GameOverBk.png", winSize)];
        DBLayoutCoverSprite(m_BkGroundB1, winSize);
        [self addChild:m_BkGroundB1 z:0 tag:1];
        
        m_nAddBean = 0;
        m_bSuccess = false;
        m_nStartIndex = 0;
        //Add by zhengxf about "游戏标题" 2012-8-15 -------begin------
        //游戏标题
        CCSprite* BkTitle = [CCSprite spriteWithFile:@"GameOver_BkTitle.png"];
        BkTitle.position = DBLayoutPoint(winSize, 240.0f, 290.0f);
        BkTitle.scale = layoutScale;
        [self addChild:BkTitle z:0 tag:1];
        //Add by zhengxf about "游戏标题" 2012-8-15 -------end------
        
        //加入豆子的图标 2012-8-16 --------begin------
        CCSprite* BkBean = [CCSprite spriteWithFile:@"GameOver_Bean.png"];
        BkBean.position = DBLayoutPoint(winSize, 25.0f, 24.0f);
        BkBean.scale = layoutScale;
        [self addChild:BkBean z:0 tag:1];
        //加入豆子的图标 2012-8-16 --------end------
    }
    return  self;
}


-(void)ShowIcon:(int)nIndex
{
    CCSprite* BkIcon = nil;
    //游戏图标
    if(m_bSuccess)
    {
        BkIcon = [CCSprite spriteWithFile:@"GameOver_BkIoc.png"];
    }
    else 
    {
        BkIcon = [CCSprite spriteWithFile:@"GameOver_FailIoc.png"];
    }
    BkIcon.position = DBLayoutPoint(winSize, 130.0f, 155.0f);
    [self addChild:BkIcon z:0 tag:1];
    BkIcon.scale = 4.0f * DBLayoutScale(winSize);
    id pIconAction = [[AnimationDelegate shareAnimationDelegate] GameOverIcon:self Function:@selector(IconAction:)];
    [BkIcon runAction:pIconAction];
}

-(void)BeanRight:(CCNode *)node
{
    CCSprite* pTem = (CCSprite*)node;
    [pTem setFlipX:true];
}

-(void)BeanLeft:(CCNode *)node
{
    CCSprite* pTem = (CCSprite*)node;
    [pTem setFlipX:false];
}

-(void) SetScore:(int)nStar :(int)nScore :(int)nBean  :(int)nEatBean  :(bool)bSuccess
{
    m_nStar = nStar;
    m_nScore = nScore;
    m_nBean = nBean;
    m_bSuccess = bSuccess;
    m_nEatBean = nEatBean;
    
    //显示游戏图表
    [self performSelector:@selector(ShowIcon:) withObject:nil  afterDelay:0.2f];
    const CGFloat layoutScale = DBLayoutScale(winSize);
    
    //Add by zhengxf about "小熊" 2012-8-15 ----begin----
    CCSprite* pBear = [CCSprite spriteWithFile:@"Bear.png"];
    pBear.position = DBLayoutPoint(winSize, 120.0f, 290.0f);
    pBear.scale = layoutScale;
    [self addChild:pBear z:0 tag:1];
    
    id   BearAction1  = nil;
    if(m_bSuccess)
    {
        BearAction1 = [[AnimationDelegate shareAnimationDelegate] BearSuccess:self Function:@selector(BeanRight:) Function2:@selector(BeanLeft:)];
    }
    else 
    {
        BearAction1 = [[AnimationDelegate shareAnimationDelegate] BearFail];
    }
    [pBear runAction:BearAction1];
    
    CCSprite* pBear2 = [CCSprite spriteWithFile:@"Bear.png"];
    pBear2.position = DBLayoutPoint(winSize, 360.0f, 290.0f);
    pBear2.scale = layoutScale;
    [self addChild:pBear2 z:0 tag:1];
    [pBear2 setFlipX:true];
    id   BearAction2 = nil;
    if(m_bSuccess)
    {
        BearAction2 = [[AnimationDelegate shareAnimationDelegate] BearSuccess:self Function:@selector(BeanRight:) Function2:@selector(BeanLeft:)];
    }
    else 
    {
        BearAction2 = [[AnimationDelegate shareAnimationDelegate] BearFail];
    }
    [pBear2 runAction:BearAction2];
    //Add by zhengxf about "小熊" 2012-8-15 ----end----
    
    if(m_nStar>0)
    {
        m_nAddBean = 10 + (m_nStar - 1)*5;
    }
    else 
    {
        m_nAddBean = 0;
    }
    
    //Add by zhengxf about "加入数字的显示" 2012-8-17 ------begin------
    //获取的豆子数
    [self ShowScore:m_nEatBean :ccp(320, 230) :1];
    
    //游戏分数
    [self ShowScore:m_nScore :ccp(360, 201) :1];
    //总豆子数
    [self ShowScore:(m_nBean - m_nAddBean) :ccp(58, 22) :2];
    //Add by zhengxf about "加入数字的显示" 2012-8-17 ------end------
    
    //Add by zhengxf about "下一关按钮是否显示" 2012-8-22 -------begin------
    CCMenu *Next = (CCMenu*)[self getChildByTag:10];
    if(Next && !m_bSuccess)
    {
        [Next setVisible:false];
    }
    //Add by zhengxf about "下一关按钮是否显示" 201m_nBean2-8-22 -------end------
}


-(void) ShowScore:(int)score :(CGPoint) pt :(int)nType;
{
    char strNum[64];
    sprintf(strNum, "%d",score);
    NSUInteger len = strlen(strNum);
    NSString* strName  = nil;
    const CGFloat layoutScale = DBLayoutScale(winSize);
    for (NSUInteger idx = 0; idx < len; idx++) 
    {
        int nNumber = strNum[idx] - '0';
        strName =  [NSString stringWithFormat:@"Big_Number_%d.png", nNumber];
        CCSprite* sp = [CCSprite spriteWithFile:strName];
        switch (nType) 
        {
            case 1:
                sp.position = DBLayoutPoint(winSize, pt.x + 16.0f * idx, pt.y);
                sp.scale = layoutScale * 0.7f;
                break;
            case 2:
                sp.position = DBLayoutPoint(winSize, pt.x + 21.0f * idx, pt.y);
                sp.scale = layoutScale;
                break;
            default:
                break;
        }
        [self addChild:sp z:1 tag:nType*10 + 20+idx];
    }
}

-(void) ReMoveNumber:(int)bBeanCount :(int)nType
{
    if(nType == 2)
    {
        char strNum[64];
        sprintf(strNum, "%d",bBeanCount);
        NSUInteger len = strlen(strNum);
        for(NSUInteger n = 0; n < len; n++)
        {
            [self removeChildByTag:nType * 10 + 20 + (int)n cleanup:YES];
        }
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

-(void) GameNext:(id) sender
{
    SenceManager* SManager = [SenceManager sharedSenceManager];
	if(SManager)
	{

        int nSmallLevel = [[LevelManager sharedLevelMannger] GetLevel];
        int nBigLevel  = [[LevelManager sharedLevelMannger] GetBigLevel];
        nSmallLevel += 1;
        if(nSmallLevel > 10)
        {
            nBigLevel +=1;
            nSmallLevel = 1;
            if(nBigLevel <= 3)
            {
                [[LevelManager sharedLevelMannger] SetBigLevel:nBigLevel];
                [[LevelManager sharedLevelMannger] SetLevel:nSmallLevel];
            }
        }
        else 
        {
            [[LevelManager sharedLevelMannger] SetLevel:nSmallLevel];
        }
        
        if((nBigLevel-1) * 10 + nSmallLevel <= 30)
        {
            [SManager ShowGameSence];
        }
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

-(void)IconAction:(CCNode*)node
{
    if(m_nStartIndex < m_nStar)
    {
        CCSprite* pStar = [CCSprite spriteWithFile:@"GameOver_Star.png"];
        pStar.position = DBLayoutPoint(winSize, 291.0f + m_nStartIndex * 63.0f, 156.0f);
        pStar.scale = DBLayoutScale(winSize) * 0.5f;
        //Add by zhengxf about "星星的声音" 2012-9-6 -------begin--------
        MusicMannger* pMusicMgr = [MusicMannger sharedMusicMannger];
        if(pMusicMgr)
        {
            [pMusicMgr PlayEffect:@"StarOut.mp3"];
        }
        //Add by zhengxf about "星星的声音" 2012-9-6 -------end--------
        id pStarAction = [[AnimationDelegate shareAnimationDelegate] GameStart:self Function:@selector(IconAction:)];
        [pStar runAction:pStarAction];
        [self addChild:pStar z:0 tag:1];
    }
    else 
    {
        //加的豆子数
        [self ShowScore:m_nAddBean :ccp(320, 93) :1];
        [self performSelector:@selector(ShowUIButton:) withObject:nil  afterDelay:0.5f];
    }
    m_nStartIndex++;
}

-(void) ShowUIButton:(int) nIndex
{
    const CGFloat layoutScale = DBLayoutScale(winSize);
    //总豆子数
    [self ReMoveNumber:(m_nBean - m_nAddBean) :2];
    [self ShowScore:m_nBean :ccp(58, 22) :2];
    //控制按钮的移动入 
    //Add by zhengxf about "加入游戏功能按钮" 2012-8-16 -------begin-------
    //商场的按钮
    CCSprite *ShopNormal = [CCSprite spriteWithFile:@"MoneyNomal.png"];
    CCSprite *ShopSelected = [CCSprite spriteWithFile:@"MoneySel.png"];
    CCMenuItemSprite *ShopGame = [CCMenuItemSprite itemWithNormalSprite:ShopNormal selectedSprite:ShopSelected target:self selector:@selector(ShowShop:)];
    CCMenu *menuShop = [CCMenu menuWithItems: ShopGame, nil];
    [menuShop setPosition:DBLayoutPoint(winSize, 250.0f, -50.0f)];
    menuShop.scale = layoutScale;
    //[self addChild: menuShop z:1 tag:1];
    //[CCCallFuncN actionWithTarget:self selector:@selector(HawkMove:)],
    //[menuShop  runAction:[CCSequence actions:
    //                      [CCMoveBy actionWithDuration:0.4 position:ccp(0, 80)],
    //                      nil]];
    
    //返回大关的按钮
    CCSprite *ReturnNormal = [CCSprite spriteWithFile:@"ReturnLevelNomal.png"];
    CCSprite *ReturnSelected = [CCSprite spriteWithFile:@"ReturnLevelSel.png"];
    CCMenuItemSprite *ReturnGame = [CCMenuItemSprite itemWithNormalSprite:ReturnNormal selectedSprite:ReturnSelected target:self selector:@selector(ShowChapter:)];
    CCMenu *menuReturn = [CCMenu menuWithItems: ReturnGame, nil];
    [menuReturn setPosition:DBLayoutPoint(winSize, 310.0f, -50.0f)];
    menuReturn.scale = layoutScale;
    [self addChild: menuReturn z:1 tag:2];
    [menuReturn  runAction:[CCSequence actions:
                            [CCMoveBy actionWithDuration:0.4 position:DBLayoutOffset(winSize, 0.0f, 80.0f)],
                            nil]];
    
    //重新开始的按钮
    CCSprite *restartNormal = [CCSprite spriteWithFile:@"GameOverReturnNomal.png"];
    CCSprite *restartSelected = [CCSprite spriteWithFile:@"GameOverReturnSel.png"];
    CCMenuItemSprite *restartGame = [CCMenuItemSprite itemWithNormalSprite:restartNormal selectedSprite:restartSelected target:self selector:@selector(GameContinue:)];
    CCMenu *menurestart = [CCMenu menuWithItems: restartGame, nil];
    [menurestart setPosition:DBLayoutPoint(winSize, 372.0f, -50.0f)];
    menurestart.scale = layoutScale;
    [self addChild: menurestart z:1 tag:2];
    [menurestart  runAction:[CCSequence actions:
                             [CCMoveBy actionWithDuration:0.4 position:DBLayoutOffset(winSize, 0.0f, 80.0f)],
                             nil]];
    
    //下一关的按钮
    CCSprite *NextNormal = [CCSprite spriteWithFile:@"GameOver_Conturn0.png"];
    CCSprite *NextSelected = [CCSprite spriteWithFile:@"GameOver_Conturn1.png"];
    CCMenuItemSprite *NextGame = [CCMenuItemSprite itemWithNormalSprite:NextNormal selectedSprite:NextSelected target:self selector:@selector(GameNext:)];
    CCMenu *menuNext = [CCMenu menuWithItems: NextGame, nil];
    [menuNext setPosition:DBLayoutPoint(winSize, 437.0f, -50.0f)];
    menuNext.scale = layoutScale;
    [self addChild: menuNext z:1 tag:10];
    if(!m_bSuccess)
    {
        [menuNext setVisible:false];
    }
    else 
    {
        
        int nSmallLevel = [[LevelManager sharedLevelMannger] GetLevel];
        int nBigLevel  = [[LevelManager sharedLevelMannger] GetBigLevel];
        
        int nAllStar = [[DefaultFile sharedDefaultFile] GetAllStar];
        
        int nLevel = (nBigLevel-1) * 10 + nSmallLevel;
        if(nLevel == 10)
        {
            if(nAllStar >= 27)
            {
                NSString* pKey = [NSString stringWithFormat:@"%@_%d_%d",LEVEL_LOCK, nBigLevel, nSmallLevel+1];
                [[DefaultFile sharedDefaultFile] SetBoolForKey:true ForKey:pKey];
            }
            else 
            {
                [menuNext setVisible:false];
            }
        }
        else if(nLevel == 20)
        {
            if(nAllStar >= 54)
            {
                NSString* pKey = [NSString stringWithFormat:@"%@_%d_%d",LEVEL_LOCK, nBigLevel, nSmallLevel+1];
                [[DefaultFile sharedDefaultFile] SetBoolForKey:true ForKey:pKey];
            }
            else 
            {
                [menuNext setVisible:false];
            }
        }
        else if(nLevel == 30)
        {
            [menuNext setVisible:false];
        }
        else 
        {
            NSString* pKey = [NSString stringWithFormat:@"%@_%d_%d",LEVEL_LOCK, nBigLevel, nSmallLevel+1];
            [[DefaultFile sharedDefaultFile] SetBoolForKey:true ForKey:pKey];
        }
        [menuNext  runAction:[CCSequence actions:
                              [CCMoveBy actionWithDuration:0.4 position:DBLayoutOffset(winSize, 0.0f, 80.0f)],
                              [CCCallFuncN actionWithTarget:self selector:@selector(ButMoveEndAction:)],
                              nil]];
    }
    //Add by zhengxf about "加入游戏功能按钮" 2012-8-16 -------end-------
}

-(void)ButMoveEndAction:(CCNode*)node
{
    if(m_bSuccess)
    {
        //打开锁的功能  ---begin-----
//        int nSmallLevel = [[LevelManager sharedLevelMannger] GetLevel];
//        int nBigLevel  = [[LevelManager sharedLevelMannger] GetBigLevel];
//        NSString* pKey = [NSString stringWithFormat:@"%@_%d_%d",LEVEL_LOCK, nBigLevel, nSmallLevel];
//        [[DefaultFile sharedDefaultFile] SetBoolForKey:true ForKey:pKey];
        //打开锁的功能  ---end-----
        [self performSelector:@selector(ShowObject:) withObject:nil  afterDelay:0.5f];
    }
}

-(void) ShowObject:(int)nIndex
{
    //Add by zhengxf about “障碍物显示关卡” 2012-9-3  --------begin------
    //大关的数据
    int nBigLevel = [[LevelManager sharedLevelMannger] GetBigLevel];
    //小关的数据
    int nSmallLevel = [[LevelManager sharedLevelMannger] GetLevel];
    
    int nLevelIndex = (nBigLevel -1)*10 + nSmallLevel;
    for(int i=0; i<7; i++)
    {
        if(ObstacleLevel[i][0] == nLevelIndex )
        {
            Introduce * pIntroduce = [Introduce node];
            [pIntroduce SetIntrodeceIndex:ObstacleLevel[i][1]];
            [self addChild:pIntroduce z:2];
            break;
        }
    }
    //Add by zhengxf about “障碍物显示关卡” 2012-9-3  --------begin------
}

@end

//游戏主场景
@implementation GameOverScence
+(id) ShowScene
{
    GameOverScence *scene = [GameOverScence node];
    return scene;
}

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) 
	{
		GameOver* GameLayer = [GameOver node];
		[self addChild:GameLayer];
	}
	return self;
}

@end
