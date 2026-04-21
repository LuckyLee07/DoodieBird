//
//  SelectChapter.m
//  DoodieBird
//
//  Created by LuckyLee on 26-04-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SelectChapterScene.h"
#import "SenceManager.h"
#import "MainItemButton.h"
#import "LevelManager.h"
#import "DefaultFile.h"
#import "def.h"

@implementation SelectChapter

- (id) init
{
	self = [super init];
	if (self)
	{
        //Add by zhengxf about "加入游戏总分数的概念" 2012-8-7 -------begin-------
        int nAllScore = [[DefaultFile sharedDefaultFile] GetIntegerForKey:ALL_SCORE];
        int nStar = [[DefaultFile sharedDefaultFile] GetIntegerForKey:NOW_STAR];
        //Add by zhengxf about "加入游戏总分数的概念" 2012-8-7 -------end-------
        
        CCSprite *sp = [CCSprite spriteWithFile:@"SelectChapterBk.png"];
		sp.anchorPoint = CGPointZero;
		[self addChild:sp z:0 tag:1];
        
        m_winSize = [CCDirector sharedDirector].winSize;
        
        //Add by zhengxf about "选择章节" 2012-7-31 ------begin-------
        CCSprite* spSelectChapter = [CCSprite spriteWithFile:@"SelectCommon.png"];
        spSelectChapter.position = ccp(m_winSize.width/2 , m_winSize.height - 60);
        [self addChild:spSelectChapter];
        
        
        CCSprite* spSelectTitle = [CCSprite spriteWithFile:@"SelectChapterTitle.png"];
        spSelectTitle.position = ccp(spSelectChapter.position.x, spSelectChapter.position.y);
        [self addChild:spSelectTitle];
        //Add by zhengxf about "选择章节" 2012-7-31 ------end-------
        
        //Add by zhengxf about "选择关卡的按钮" 2012-7-30 -------begin--------
        //章节1－－－－begin-----------
        MainItemButton* BtFrist = [MainItemButton node];
        [BtFrist SetTarget:self :@selector(ChapterFrist:)];
        [BtFrist SetVeg:ccp(m_winSize.width/ 2 - 150,m_winSize.height /2 - 50) :1 :0 :false :true :@"Chapter1Noml.png" :@"Chapter1Sel.png"];
        //[BtFrist ShowScore:100 :ccp(0,0) :2];
        //[BtFrist SetLocke:false];
        //[BtFrist RunAction];
        [self addChild:BtFrist z:0 tag:GAME_CHAPTER_FRIST];
        //章节1 －－－－end-----------
        
        //章节3
        
        NSString* pKey = [NSString stringWithFormat:@"%@_%d",LEVEL_LOCK, 3];
        bool bLock = [[DefaultFile sharedDefaultFile] GetBoolForKey:pKey];
        MainItemButton* BtThrid = [MainItemButton node];
        [BtThrid SetTarget:self :@selector(ChapterThrid:)];
        [BtThrid SetVeg:ccp(m_winSize.width / 2 + 150, m_winSize.height/ 2 - 50) :1 :0 :!bLock :true :@"Chapter3Noml.png" :@"Chapter3Sel.png"];
        if(!bLock)
        {
            [BtThrid SetLocke:!bLock];
            [BtThrid ShowScore:54 :ccp(0,0) :2];
        }

        int nAllStar = [[DefaultFile sharedDefaultFile] GetAllStar];
        if(nAllStar >= 54 && !bLock)
        {
            [BtThrid RunAction];
            [[DefaultFile sharedDefaultFile] SetBoolForKey:true ForKey:pKey];
            bLock = true;
            [BtThrid SetVeg:ccp(m_winSize.width / 2 + 150, m_winSize.height/ 2 - 50) :1 :0 :!bLock :true :@"Chapter3Noml.png" :@"Chapter3Sel.png"];
        }
        [self addChild:BtThrid z:0 tag:GAME_CHAPTER_THRID];
        
        //章节2
        pKey = [NSString stringWithFormat:@"%@_%d",LEVEL_LOCK, 2];
        bLock = [[DefaultFile sharedDefaultFile] GetBoolForKey:pKey];
        MainItemButton* BtSecond = [MainItemButton node];
        [BtSecond SetTarget:self :@selector(ChapterSecond:)];
        [BtSecond SetVeg:ccp(m_winSize.width / 2, m_winSize.height/ 2 - 50) :1 :0 :!bLock :true :@"Chapter2Noml.png" :@"Chapter2Sel.png"];
        if(!bLock)
        {
            [BtSecond SetLocke:!bLock];
            [BtSecond ShowScore:27 :ccp(0,0) :2];
        }
        //[BtSecond SetLocke:true];
        
        if(nAllStar >= 27 && !bLock)
        {
            [BtSecond RunAction];
            [[DefaultFile sharedDefaultFile] SetBoolForKey:true ForKey:pKey];
            bLock = true;
            [BtSecond SetVeg:ccp(m_winSize.width / 2, m_winSize.height/ 2 - 50) :1 :0 :!bLock :true :@"Chapter2Noml.png" :@"Chapter2Sel.png"];
        }        
        [self addChild:BtSecond z:0 tag:GAME_CHAPTER_SECOND];
        
        //Add by zhengxf about "显示星星的背景" 2012-8-7 -------begin------
        CCSprite* pSp = [CCSprite  spriteWithFile:@"StarBk.png"];
        pSp.position = ccp(m_winSize.width -[pSp textureRect].size.width/2, [pSp textureRect].size.height/2 + 5);
        [self addChild:pSp];
        
        CCSprite* pSpStar = [CCSprite  spriteWithFile:@"ChapterStar.png"];
        pSpStar.position = ccp(pSp.position.x - [pSp textureRect].size.width/2 + 10, pSp.position.y);
        [self addChild:pSpStar];
        [self ShowScore:nAllStar :ccp(pSpStar.position.x + 45, pSpStar.position.y) :1];
        
        CCSprite* pNumberMid = [CCSprite  spriteWithFile:@"RightNumber_mid.png"];
        pNumberMid.position = ccp(pSpStar.position.x + 80, pSpStar.position.y);
        [self addChild:pNumberMid];
        [self ShowScore:90 :ccp(pNumberMid.position.x + 25, pNumberMid.position.y) :1];
        //Add by zhengxf about "显示星星的背景" 2012-8-7 -------begin------
        
        //返回－－－－begin-----------
		CCSprite *ReturnNormal = [CCSprite spriteWithFile:@"ReturnNoml.png"];
		CCSprite *ReturnSelected = [CCSprite spriteWithFile:@"ReturnSel.png"];
		CCMenuItemSprite *ReturnCook = [CCMenuItemSprite itemWithNormalSprite:ReturnNormal selectedSprite:ReturnSelected target:self selector:@selector(Return:)];
		CCMenu *menuReturn = [CCMenu menuWithItems: ReturnCook, nil];
		[menuReturn setPosition:ccp(40,20)];
		[self addChild: menuReturn z:1 tag:GAME_RETURN];
		//返回 －－－－end-----------
    }
    return  self;
}

-(void) ShowScore:(int)score :(CGPoint) pt :(int)nType;
{
    char strNum[64];
    sprintf(strNum, "%d",score);
    int len = strlen(strNum);
    NSString* strName  = nil;
    for (int idx=0; idx<len; idx++) 
    {
        int nNumber = strNum[idx] - '0';
        CCSprite* sp = nil;
        switch (nType) 
        {
            case 1:
                strName =  [NSString stringWithFormat:@"RightNumber%d.png", nNumber];
                sp = [CCSprite spriteWithFile:strName];
                sp.position = ccp(pt.x + 18 * idx, pt.y);
                break;
            case 2:
                strName =  [NSString stringWithFormat:@"LockNumber%d.png", nNumber];
                sp = [CCSprite spriteWithFile:strName];
                sp.position = ccp(pt.x + 16 * idx, pt.y);
                break;
            default:
                break;
        }
        [self addChild:sp z:1 tag:20+idx];
    }
}

-(void) ChapterFrist:(id) sender
{
    [[LevelManager sharedLevelMannger] SetBigLevel:1];
    SenceManager* SManager = [SenceManager sharedSenceManager];
	if(SManager)
	{
		[SManager ShowLevelScene];
    }
}

-(void) ChapterSecond:(id) sender
{
    [[LevelManager sharedLevelMannger] SetBigLevel:2];
    SenceManager* SManager = [SenceManager sharedSenceManager];
	if(SManager)
	{
		[SManager ShowLevelScene];
    }
}

-(void) ChapterThrid:(id) sender
{
    [[LevelManager sharedLevelMannger] SetBigLevel:3];
    SenceManager* SManager = [SenceManager sharedSenceManager];
	if(SManager)
	{
		[SManager ShowLevelScene];
    }
}

-(void) Return:(id) sender
{
    SenceManager* SManager = [SenceManager sharedSenceManager];
	if(SManager)
	{
		[SManager ShowMainMenuSence];
    }
}

@end

@implementation SelectChapterSence

+(id) ShowScene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [SelectChapterSence node];
	// return the scene
	return scene;
}

-(id) init
{
	if( (self=[super init] )) 
	{
		SelectChapter* mBk = [SelectChapter node];
		[self addChild:mBk];
	}
	return self;
}
@end