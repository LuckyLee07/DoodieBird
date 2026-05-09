//
//  MainMenuSence.m
//  cookgirl
//  Created by LuckyLee on 26-04-22.
//  Copyright FancyGame 2026年. All rights reserved.
//

#import "MainMenuSence.h"
#import "CCTransition.h"
#import "SenceManager.h"
#import "MusicMannger.h"
#import "DefaultFile.h"
#import "../../Gameplay/Shared/LayoutHelper.h"

@implementation SysMenu
- (id) init
{
	self = [super init];
	if (self)
	{
        m_nCount = 0;
		m_nFristLogin = 0;
        m_bSetGame = false;
        m_bIsMove = false;
        DefaultFile *defaultFile = [DefaultFile sharedDefaultFile];
        if (![defaultFile hasValueForKey:MUSIC_IS_OPEN])
        {
            [defaultFile SetBoolForKey:true ForKey:MUSIC_IS_OPEN];
        }
        m_bMusicOpen = [defaultFile GetBoolForKey:MUSIC_IS_OPEN];
        [[MusicMannger sharedMusicMannger] SetIsOpenMusic:m_bMusicOpen];
        m_winSize = [CCDirector sharedDirector].winSize;
        const CGFloat layoutScale = DBLayoutScale(m_winSize);
        
		CCSprite *sp = [CCSprite spriteWithFile:DBWideAssetName(@"MainBk.png", m_winSize)];
        DBLayoutCoverSprite(sp, m_winSize);
		[self addChild:sp z:0 tag:1];
		[CCMenuItemFont setFontName:@"Marker Felt"];
		[CCMenuItemFont setFontSize:25];

        CCSprite* spTitle = [CCSprite spriteWithFile:@"MainMenuTitle.png"];
        spTitle.position = DBLayoutPoint(m_winSize, 260.0f, 260.0f);
        spTitle.scale = layoutScale;
        [self addChild:spTitle z:0 tag:1];

        
		//开始－－－－begin-----------
		CCSprite *StartNormal = [CCSprite spriteWithFile:@"StartCookBut1.png"];
		CCSprite *StartSelected = [CCSprite spriteWithFile:@"StartCookBut2.png"];
        
		CCMenuItemSprite *StartCook = [CCMenuItemSprite itemWithNormalSprite:StartNormal selectedSprite:StartSelected target:self selector:@selector(newGame:)];
		CCMenu *menuStart = [CCMenu menuWithItems: StartCook, nil];
		[menuStart setPosition:DBLayoutPoint(m_winSize, 320.0f, 160.0f)];
        menuStart.scale = layoutScale;
		[self addChild: menuStart z:1 tag:START_ITEM];
		//开始 －－－－end-----------
        
        //Add by zhengxf about "设置，商场" 2012-7-25 ------begin--------        
        //音效，音乐设置
        CCSprite *MusicNormal = nil;
        CCSprite *MusicSelected = nil;
        if(m_bMusicOpen)
        {
            MusicNormal = [CCSprite spriteWithFile:@"GameMusicSel.png"];
            MusicSelected = [CCSprite spriteWithFile:@"GameMusic.png"];
        }
        else 
        {
            MusicNormal = [CCSprite spriteWithFile:@"GameMusic.png"];
            MusicSelected = [CCSprite spriteWithFile:@"GameMusicSel.png"];
        }

		CCMenuItemSprite *MusicGame = [CCMenuItemSprite itemWithNormalSprite:MusicNormal selectedSprite:MusicSelected target:self selector:@selector(MusicGame:)];
		CCMenu *menuMusic = [CCMenu menuWithItems: MusicGame, nil];
		[menuMusic setPosition:DBLayoutPoint(m_winSize, 30.0f, 300.0f)];
        menuMusic.scale = layoutScale;
		[self addChild: menuMusic z:1 tag:MUSIC_ITEM];
        
        //语言
//        CCSprite *LanguageNormal = [CCSprite spriteWithFile:@"GameLanguage.png"];
//		CCSprite *LanguageSelected = [CCSprite spriteWithFile:@"GameLanguage.png"];
//		CCMenuItemSprite *LanguageGame = [CCMenuItemSprite itemWithNormalSprite:LanguageNormal selectedSprite:LanguageSelected target:self selector:@selector(MusicGame:)];
//		CCMenu *menuLanguage = [CCMenu menuWithItems: LanguageGame, nil];
//		[menuLanguage setPosition:ccp(menuMusic.position.x, menuMusic.position.y)];
		//[self addChild: menuLanguage z:1 tag:LANGUAGE_ITEM];
        
        //帮助
//        CCSprite *HelpNormal = [CCSprite spriteWithFile:@"GameHelp.png"];
//		CCSprite *HelpSelected = [CCSprite spriteWithFile:@"GameHelp.png"];
//		CCMenuItemSprite *HelpGame = [CCMenuItemSprite itemWithNormalSprite:HelpNormal selectedSprite:HelpSelected target:self selector:@selector(MusicGame:)];
//		CCMenu *menuHelp = [CCMenu menuWithItems: HelpGame, nil];
//		[menuHelp setPosition:ccp(menuMusic.position.x, menuMusic.position.y)];
		//[self addChild: menuHelp z:1 tag:HELP_ITEM];
        
        //制作人名单
//        CCSprite *ProducerNormal = [CCSprite spriteWithFile:@"GameProducer.png"];
//		CCSprite *ProducerSelected = [CCSprite spriteWithFile:@"GameProducer.png"];
//		CCMenuItemSprite *ProducerpGame = [CCMenuItemSprite itemWithNormalSprite:ProducerNormal selectedSprite:ProducerSelected target:self selector:@selector(MusicGame:)];
//		CCMenu *menuProducer = [CCMenu menuWithItems: ProducerpGame, nil];
//		[menuProducer setPosition:ccp(menuMusic.position.x, menuMusic.position.y)];
		//[self addChild: menuProducer z:1 tag:PRODUCER_ITEM];
        
        //设置的下拉按钮
        CCSprite *SetNormal = [CCSprite spriteWithFile:@"GameSet.png"];
		CCSprite *SetSelected = [CCSprite spriteWithFile:@"GameSet.png"];
		CCMenuItemSprite *SetGameItem = [CCMenuItemSprite itemWithNormalSprite:SetNormal selectedSprite:SetSelected target:self selector:@selector(SetGame:)];
		CCMenu *menuSet = [CCMenu menuWithItems: SetGameItem, nil];
		[menuSet setPosition:ccp(menuMusic.position.x, menuMusic.position.y)];
        menuSet.scale = layoutScale;
		[self addChild: menuSet z:1 tag:SET_ITEM];

        //商场的按钮
        CCSprite *ShopNormal = [CCSprite spriteWithFile:@"GameShop.png"];
		CCSprite *ShopSelected = [CCSprite spriteWithFile:@"GameShop.png"];
		CCMenuItemSprite *ShopGame = [CCMenuItemSprite itemWithNormalSprite:ShopNormal selectedSprite:ShopSelected target:self selector:@selector(ShopGame:)];
		CCMenu *menuShop = [CCMenu menuWithItems: ShopGame, nil];
		[menuShop setPosition:DBLayoutPoint(m_winSize, 80.0f, 300.0f)];
        menuShop.scale = layoutScale;
		//[self addChild: menuShop z:1 tag:2];
        
        //GameCenter
//      CCSprite *GameCenterNormal = [CCSprite spriteWithFile:@"GameCenter.png"];
//		CCSprite *GameCenterSelected = [CCSprite spriteWithFile:@"GameCenter.png"];
//		CCMenuItemSprite *GameCenterGame = [CCMenuItemSprite itemWithNormalSprite:GameCenterNormal selectedSprite:GameCenterSelected target:            self selector:nil];//@selector(ShowGameOver:)
//		CCMenu *menuGameCenter = [CCMenu menuWithItems: GameCenterGame, nil];
//		[menuGameCenter setPosition:ccp(450, m_winSize.height - 20)];
//		[self addChild: menuGameCenter z:1 tag:2];
        //Add by zhengxf about "设置，商场" 2012-7-25 ------end--------
	}
	return self;
}

- (void) newGame:(id) sender
{
    MusicMannger* pMusicMgr = [MusicMannger sharedMusicMannger];
	if(pMusicMgr)
	{
		//[pMusicMgr PlayEffect:@"22.caf"]; 
	}
    SenceManager* SManager = [SenceManager sharedSenceManager];
	if(SManager)
	{
        [SManager ShowSelectChapterScene];
        //[SManager ShowHeadStarMp4];
		//[SManager ShowGameSence];
    }
}

-(void) SetGame:(id) sender
{
    if(!m_bIsMove)
    {
        m_bIsMove = true;
        m_bSetGame = !m_bSetGame;
        //设置按钮做旋转动画
        CCMenu * SetmenuItem = (CCMenu*)[self getChildByTag: SET_ITEM];
        if(SetmenuItem)
        {
            CCArray *pArray =  [SetmenuItem children];
            CCMenuItemSprite* pItem = [pArray objectAtIndex:0];
            id SetAction = [CCRotateBy actionWithDuration:0.3f  angle:90];
            if(m_bSetGame)
            {
                [pItem runAction:SetAction];
            }
            else
            {
                [pItem runAction:[SetAction reverse]];
            }
        }
        for(int i = 0; i< 1; i++)
        {
            CCMenu * menuItem = (CCMenu*)[self getChildByTag:  MUSIC_ITEM +i];
            if(menuItem)
            {
                id  pAction = [CCMoveBy actionWithDuration:0.3  position:DBLayoutOffset(m_winSize, 0.0f, -40.0f * (i+1))];
                if(m_bSetGame)
                {
                    if(i == 0)
                    {
                        id acf = [CCCallFuncN actionWithTarget:self selector:@selector(IsEnd:)];
                        CCAction* MoveEnd = [CCSequence actions:pAction, acf, nil];
                        [menuItem runAction:MoveEnd];
                    }
                    else 
                    {
                        [menuItem runAction:pAction];
                    }
                }
                else 
                {
                    if(i == 0)
                    {
                        id acf = [CCCallFuncN actionWithTarget:self selector:@selector(IsEnd:)];
                        CCAction* MoveEnd = [CCSequence actions:[pAction reverse], acf, nil];
                        [menuItem runAction:MoveEnd];
                    }
                    else 
                    {
                        [menuItem runAction:[pAction reverse]];
                    }
                } 
            }
        }

    }
}

-(void)IsEnd:(CCNode *)node 
{
    m_bIsMove = false;
}


-(void) MusicGame:(id) sender
{
    m_bMusicOpen = !m_bMusicOpen;
    [[DefaultFile sharedDefaultFile] SetBoolForKey:m_bMusicOpen ForKey:MUSIC_IS_OPEN];
    CCMenu *menuMusic = (CCMenu *)[self getChildByTag: MUSIC_ITEM];
    CCArray *pArray =  [menuMusic children];
    CCMenuItemSprite* pItem = [pArray objectAtIndex:0];
    CCSprite *MusicNormal = [CCSprite spriteWithFile:@"GameMusic.png"];
    CCSprite *MusicSelected = [CCSprite spriteWithFile:@"GameMusicSel.png"];
     MusicMannger* pMusicMgr = [MusicMannger sharedMusicMannger];
    if(pMusicMgr)
    {
        [pMusicMgr SetIsOpenMusic:m_bMusicOpen];
    }
    if(m_bMusicOpen)
    {
        [pItem setNormalImage:MusicSelected];
        [pItem setSelectedImage:MusicNormal];
        if(pMusicMgr)
        {
            [pMusicMgr PlayBackGroudMusic];
        }
    }
    else 
    {
        [pItem setNormalImage:MusicNormal];
        [pItem setSelectedImage:MusicSelected];
        if(pMusicMgr)
        {
            [pMusicMgr PauseMusic];
        }
    }
}

-(void) ShowGameOver:(id) sender
{
    SenceManager* SManager = [SenceManager sharedSenceManager];
	if(SManager)
	{
		[SManager ShowGameCompleteScene];
    }
}

-(void) ShopGame:(id) sender
{
    SenceManager* SManager = [SenceManager sharedSenceManager];
	if(SManager)
	{
		[SManager ShowShopSence];
    }
}

-(void) onQuit: (id) sender
{
    
}

-(void) onExit
{
	[super onExit];
}

//推出函数
-(void)exitAciton
{
    m_bMusicOpen = false;
    [[DefaultFile sharedDefaultFile] SetBoolForKey:false ForKey:MUSIC_IS_OPEN];
    CCMenu *menuMusic = (CCMenu *)[self getChildByTag: MUSIC_ITEM];
    CCArray *pArray =  [menuMusic children];
    CCMenuItemSprite* pItem = [pArray objectAtIndex:0];
    CCSprite *MusicNormal = [CCSprite spriteWithFile:@"GameMusic.png"];
    CCSprite *MusicSelected = [CCSprite spriteWithFile:@"GameMusicSel.png"];
    if(m_bMusicOpen)
    {
        [pItem setNormalImage:MusicSelected];
        [pItem setSelectedImage:MusicNormal];
    }
    else 
    {
        [pItem setNormalImage:MusicNormal];
        [pItem setSelectedImage:MusicSelected];
    }
    MusicMannger *musicManager = [MusicMannger sharedMusicMannger];
    [musicManager SetIsOpenMusic:m_bMusicOpen];
    [musicManager PauseMusic];
}

- (void) dealloc
{
	NSLog(@"dealloc in Main sence");
	[super dealloc];
}
@end

@implementation MainMenuSence
+(id) ShowScene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [MainMenuSence node];
	// return the scene
	return scene;
}

-(id) init
{
	if( (self=[super init] )) 
	{
		SysMenu* mBk = [SysMenu node];
		[self addChild:mBk];
	}
	return self;
}
@end
