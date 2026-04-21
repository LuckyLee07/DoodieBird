//
//  MainGameSence.m
//  DoodieBird
//
//  Created by LuckyLee on 26-04-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.

#import "MainGameScence.h"
#import "CCParallaxNode-Extras.h"
#import "FileManager.h"
#import "CCAnimationManager.h"
#import "AnimationDelegate.h"
#import "SenceManager.h"
#import "LevelManager.h"
#import "DefaultFile.h"
#import "cocos2d.h"
#import "GameOver.h"
#import "MusicMannger.h"
#import "PauseGame.h"

@implementation MyObstacle

@synthesize m_bIsAdd;
@synthesize m_ObstacleList;

@end

@implementation MainGameLayer
- (id) init
{
	self = [super init];
	if (self)
	{
        m_bAllRight = false;
        m_ShitOpenIndex = 0;
        //大关的数据
        m_nBigLevel = [[LevelManager sharedLevelMannger] GetBigLevel];
        //小关的数据
        m_nSmallLevel = [[LevelManager sharedLevelMannger] GetLevel];
        
        //Add by zhengxf about "游戏暂停的状态" 2012-8-30 -------begin------
        m_bPauseGame = false;
        //Add by zhengxf about "游戏暂停的状态" 2012-8-30 -------end------

        //加入图片缓存
        [self AddPngCache];
        //豆子数
        
        //Add by zhengxf about "第一次登陆加入三百个豆子" 2012-9-10 ------begin---------
        bool bFristLogin = [[DefaultFile sharedDefaultFile] GetBoolForKey:FRIST_LOGIN];
        if(!bFristLogin)
        {
            [[DefaultFile sharedDefaultFile] SetBoolForKey:true ForKey:FRIST_LOGIN];
            [[DefaultFile sharedDefaultFile] SetIntegerForKey:500 ForKey:ALL_BEAN_COUNT];
        }
        m_nBeanCount = [[DefaultFile sharedDefaultFile] GetIntegerForKey:ALL_BEAN_COUNT];
        //Add by zhengxf about "第一次登陆加入三百个豆子" 2012-9-10 ------end---------
        //m_nBeanCount = 100;
        
        m_nEatBeanCount = 0;
        
        m_nStar = 0;
        m_bSuccess = false;

        NSString* pKey = [NSString stringWithFormat:@"%@_%d_%d",LEVEL_STAR, m_nBigLevel, m_nSmallLevel];
        
        //以前的星星数
        m_nOldStar = [[DefaultFile sharedDefaultFile] GetIntegerForKey:pKey];
        
        m_timer = [[NSTimer  scheduledTimerWithTimeInterval:0.02 target:self
												  selector:@selector(onTimer) userInfo:nil repeats:YES]retain];
        
        m_BridTimer = [[NSTimer scheduledTimerWithTimeInterval:0.02 target:self
                                                      selector:@selector(onBridTimer) userInfo:nil repeats:YES]retain];
        
        //额外计算的计算器
        m_FithtTimer = [[NSTimer scheduledTimerWithTimeInterval:0.02 target:self
                                                       selector:@selector(OnFightTimer) userInfo:nil repeats:YES]retain];;
        [self setIsTouchEnabled:YES];
        
        //Add by zhengxf about "加载图片" 2012-7-5 -------end-------
        m_HunterList = nil;
        m_nHunterIndex = 0;
        
        m_bHaveHunter = false; //屏幕可见范围是否有人
        m_bBridIsHeight = false;//鸟在最高点
        m_bChangeWeapon = false;
        m_bAddHole = false;
        
        int nLevelIndex = (m_nBigLevel - 1)*10 + m_nSmallLevel -1;
        //m_nLeveScore = LevelAllScore[nLevelIndex];
        m_nLeveScore = 0;
        m_nLevelLen = 480 * (LevelLen[nLevelIndex] + 2);
        
        //Add by zhengxf about "加载数据缓存" 2012-7-19 --------begin----------
        //豆子的数据缓存
        m_pBeanNomal = [[CCTextureCache sharedTextureCache] addImage:@"BeanNomal.png"];
        m_pShitNomal = [[CCTextureCache sharedTextureCache] addImage:@"Shit.png"];
        m_pFlashing = [[CCTextureCache sharedTextureCache] addImage:@"Flashing.png"];
        m_pFlashingSecond = [[CCTextureCache sharedTextureCache] addImage:@"Flashing_Second.png"];
        //Add by zhengxf about "加载数据缓存" 2012-7-19 --------end----------
        
        m_nLevel = 1;
        m_nObstacleIndex = 0; //障碍物的位置索引
        
        m_bGameStop = false;    //游戏停止
        m_bCatchOrEnd = false;  //鸟被抓住，或者游戏结束
        m_bGameOver = false;
        m_bAllowTouch = true;
        
        m_nShitIndex = 0;
        nCount = 0;
        m_nLeftSceneDown = false;
        m_nRithtSceneDown = false;
        m_winSize = [CCDirector sharedDirector].winSize;
        
        //添加背景图  2012-7-3 ------begin------
        //后背景图
        
        m_BkGroundB1 = [CCMyMapSprite spriteWithFile:[NSString stringWithFormat:@"SceneB_%d.png",m_nBigLevel]];
        //m_BkGroundB1 = [CCMyMapSprite spriteWithFile:@"SceneB.png"];
        [m_BkGroundB1.texture setAliasTexParameters];
        m_BkGroundB1.m_nMapType = 3;
        m_BkGroundB1.m_fMoveRate = 0.6;
        //m_BkGroundB1.scale= 2.0;
        m_BkGroundB1.position = ccp(m_winSize.width/2, m_winSize.height * 0.5 + 10);
        [self addChild:m_BkGroundB1 z:0 tag:MAP_BK_B1];
        
        //Add by zhengxf about "按钮和信息显示条" 2012-7-10 ------begin--------
        //暂停－－－－begin-----------
		CCSprite *StopNormal = [CCSprite spriteWithFile:@"StopBut.png"];
        //StopNormal.scale = 1.2;
		CCSprite *StopSelected = [CCSprite spriteWithFile:@"StopBut.png"];
        //StopSelected.scale = 1.2;
        
		CCMenuItemSprite *StopGame = [CCMenuItemSprite itemWithNormalSprite:StopNormal selectedSprite:StopSelected target:self selector:@selector(StopGame:)];
        
		CCMenu *menuStop = [CCMenu menuWithItems: StopGame, nil];
		[menuStop setPosition:ccp(20,300)];
		//[menu setPosition:ccp(480 - 50, 320 - 30)];
		[self addChild: menuStop z:2 tag:0];
		//暂停 －－－－end-----------
        
        //进度条 --------begin------
        CCSprite *ProgressNormal = [CCSprite spriteWithFile:@"progress.png"];
        ProgressNormal.position = ccp(menuStop.position.x + 120, menuStop.position.y);
        [self addChild:ProgressNormal z:2 tag:0];
        m_nProgressLen = ProgressNormal.contentSize.width - 50;
        
        m_spProgress = [CCSprite spriteWithFile:@"BridProgress.png"];
        m_spProgress.position = ccp(menuStop.position.x + 90, menuStop.position.y + 8);
        //m_spProgress.blendFunc = (ccBlendFunc){GL_SRC_ALPHA, GL_ONE_MINUS_SRC_COLOR};
        id HunterAction = [[AnimationDelegate shareAnimationDelegate] BridProgress];
        [m_spProgress runAction:HunterAction];
        [self addChild:m_spProgress z:2 tag:0];;
        //进度条 ---------end-------
        
        //便便更换 --------begin-------
        CCSprite *ArrowsNormal = [CCSprite spriteWithFile:@"SelectArrows.png"];
        ArrowsNormal.position = ccp(m_winSize.width - ArrowsNormal.contentSize.width/2 - 10, menuStop.position.y - 20);
        [self addChild:ArrowsNormal z:2 tag: SELEST_SHIT];
        
        m_RcChangeWeapon = [ArrowsNormal textureRect];
        m_RcChangeWeapon.size.width += 80;
        m_RcChangeWeapon.size.height += 30;
        m_RcChangeWeapon.origin.x = ArrowsNormal.position.x - m_RcChangeWeapon.size.width /2;
        m_RcChangeWeapon.origin.y = ArrowsNormal.position.y - m_RcChangeWeapon.size.height /2;
        
        //便便图
        m_nWeaponIndex = 0;//便便武器索引
        //设置便便开启
        [self setShitOpen];
        
        CCSprite *NormalShit = [CCSprite spriteWithFile:@"NomalShit.png"];
        NormalShit.position = ccp(ArrowsNormal.position.x, ArrowsNormal.position.y);
        [self addChild:NormalShit z:2 tag: SHIT_BULLET_NUMAL];
        
        CCSprite *NumberShit = [CCSprite spriteWithFile:@"ShitNumber.png"];
        NumberShit.position = ccp(ArrowsNormal.position.x, ArrowsNormal.position.y - 20);
        [self addChild:NumberShit z:2 tag: SHIT_NUMBER_NUMAL];
        
        CCSprite *NumberFireShit = [CCSprite spriteWithFile:@"FrieShitNumber.png"];
        NumberFireShit.position = ccp(ArrowsNormal.position.x, ArrowsNormal.position.y - 20);
        NumberFireShit.visible = false;
        [self addChild:NumberFireShit z:2 tag: SHIT_NUMBER_FIRE];
        
        CCSprite *NumberFlightShit = [CCSprite spriteWithFile:@"FlashingShitNumber.png"];
        NumberFlightShit.position = ccp(ArrowsNormal.position.x, ArrowsNormal.position.y - 20);
        NumberFlightShit.visible = false;
        [self addChild:NumberFlightShit z:2 tag: SHIT_NUMBER_FLIGHT];
        
        CCSprite *NumberDragonShit = [CCSprite spriteWithFile:@"DragonShitNumber.png"];
        NumberDragonShit.position = ccp(ArrowsNormal.position.x, ArrowsNormal.position.y - 20);
        NumberDragonShit.visible = false;
        [self addChild:NumberDragonShit z:2 tag: SHIT_NUMBER_DRAGON];
        
        //火便便图
        CCSprite *FireShit = [CCSprite spriteWithFile:@"FireShit.png"];
        FireShit.position = ccp(ArrowsNormal.position.x, ArrowsNormal.position.y + 8);
        FireShit.visible = false;
        [self addChild:FireShit z:2 tag: SHIT_BULLET_FIRE];
        
        //闪电便便图
        CCSprite *FlightShit = [CCSprite spriteWithFile:@"FlashingShit.png"];
        FlightShit.position = ccp(ArrowsNormal.position.x, ArrowsNormal.position.y + 8);
        FlightShit.scale = 0.7;
        FlightShit.visible = false;
        [self addChild:FlightShit z:2 tag: SHIT_BULLET_FLIGHT];
        
        //闪电便便图
        CCSprite *DragonShit = [CCSprite spriteWithFile:@"DragonShit.png"];
        DragonShit.position = ccp(ArrowsNormal.position.x, ArrowsNormal.position.y + 8);
        DragonShit.scale = 0.7;
        DragonShit.visible = false;
        [self addChild:DragonShit z:2 tag: SHIT_BULLET_DRAGON];
        
        //便便更换 --------end-------
        [self InitBrid];            //加载小鸟
        [self InitScene];           //加载场景
        [self InitShit];            //加载便便
        [self InitHunterAndBean];   //加载人物和豆子
        [self InitTreeHole];
        
        //豆子和分数列表的初始化  ----begin-----
        
        //游戏分数的显示 ------begin-------
        CCSprite *pGameScore = [CCSprite spriteWithFile:@"GameScore.png"];
        pGameScore.position = ccp(m_winSize.width - pGameScore.contentSize.width/2 - 80, menuStop.position.y);
        [self addChild:pGameScore z:1 tag:0];
        //游戏分数的显示 ------end-------
        
        //游戏豆数的显示 ------begin-----
        CCSprite *pGameBean = [CCSprite spriteWithFile:@"GameOver_Bean.png"];
        pGameBean.position = ccp(pGameScore.contentSize.width /2 - 25, pGameBean.contentSize.height/2+ 10);
        [self addChild:pGameBean z:1 tag:0];
        //游戏豆数的显示 ------end-----
        //Add by zhengxf about "按钮和信息显示条" 2012-7-10 ------end--------
        
        m_pBeanPoint = ccp(45, 25);
        m_pScorePoint = ccp(405, 300);;
        
        m_BeanList = [[CCArray alloc] initWithCapacity:6];
        m_ScoreList = [[CCArray alloc] initWithCapacity:6];
        //Add by zhengxf about "豆子消耗数" 2012-8-22 --------begin-------
        [self ShowScore:m_nBeanCount :m_pBeanPoint :1 :0];
        [self ShowScore:m_nLeveScore :m_pScorePoint :2 :0];
        //Add by zhengxf about "豆子消耗数" 2012-8-22 --------end-------
        //豆子和分数列表的初始化  ----end-----
        
        //Add by zhengxf about "加入随机系统" 2012-8-27 -------begin--------
        m_nUseTime = 0.0f;     //用了多长时间
        m_bStartHawk = false;  //随机系统是否开始
        m_bHawk = false;
        m_bRandSystem = false;
        //Add by zhengxf about "加入随机系统" 2012-8-27 -------end--------
        
        //Add by zhengxf about "龙火的功能"  2012-8-28 -------begin------
        m_spDragonFrie = nil;
        m_bFrieDragon = false;
        //Add by zhengxf about "龙火的功能"  2012-8-28 -------end------
        
        //新手引导系统
        [self InitHelpSys];
        //新手引导系统
        //感叹号的图片
        m_spSigh = nil;
        m_spHawk = nil;
        m_Index = 0;
    }
    return self;
}

//Add by zhengxf about "加入图片缓存" 2012-8-28 -----begin----
-(void) AddPngCache
{
    //龙便便便火的缓存
    CCSpriteBatchNode *DragonFrie = [CCSpriteBatchNode batchNodeWithFile:@"Dragon_Frie.png"];
    [self addChild:DragonFrie];
    
    //一号怪的缓存
    CCSpriteBatchNode *Hunter1Fight = [CCSpriteBatchNode batchNodeWithFile:@"Hunter_Jump.png"];
    [self addChild:Hunter1Fight];
    
    //二号怪的缓存
    CCSpriteBatchNode *Hunter2Fight = [CCSpriteBatchNode batchNodeWithFile:@"Hunter2_Jump.png"];
    [self addChild:Hunter2Fight];
    
    //三号怪的缓存
    CCSpriteBatchNode *Hunter3Fight = [CCSpriteBatchNode batchNodeWithFile:@"Hunter3_Jump.png"];
    [self addChild:Hunter3Fight];
    
    //四号怪的缓存
    CCSpriteBatchNode *Hunter4Fight = [CCSpriteBatchNode batchNodeWithFile:@"Hunter4_Jump.png"];
    [self addChild:Hunter4Fight];
    
    //鹰的数据缓存
    CCSpriteBatchNode *HawkFight = [CCSpriteBatchNode batchNodeWithFile:@"Hawk_Fly.png"];
    [self addChild:HawkFight];
    
    //人烟动画的数据缓存
    CCSpriteBatchNode *HunterSmoke = [CCSpriteBatchNode batchNodeWithFile:@"Hunter_Smoke.png"];
    [self addChild:HunterSmoke];
}
//Add by zhengxf about "加入图片缓存" 2012-8-28 -----end----

//初始化函数
-(void) InitShit           //加载便便
{
    //Add by zhengxf about "便便的列表" 2012-7-6  ------begin-----
    m_ShitList = [[CCArray alloc] initWithCapacity:SHIT_SCENE_COUNT];
    for(int i = 0; i < SHIT_SCENE_COUNT; ++i) 
    {
        CCBridShitSprite *Shit = [CCBridShitSprite spriteWithTexture:m_pShitNomal];
        Shit.m_nShitType = 0;
        Shit.visible = NO;
        [self addChild:Shit z: 0 tag:SPRITE_SHIT + i];
        [m_ShitList addObject:Shit];
    }
    //Add by zhengxf about "便便的列表" 2012-7-6  ------end-----
}

-(void) InitScene  //加载场景
{
    //加载中景资源
    for(int i=0; i<3; i++)
    {
        CCMyMapSprite *spTem = [CCMyMapSprite spriteWithFile:[NSString stringWithFormat:@"SceneM_%d_%d.png",m_nBigLevel, i]];
        if(spTem)
        {
            if(0 == i)
            {
                spTem.position = ccp(spTem.contentSize.width*0.5, m_winSize.height - spTem.contentSize.height*0.5  - 30);
            }
            else
            {
                int nTag = MAP_BK_M_INDEX + i -1;
                CCMyMapSprite* pTem = (CCMyMapSprite*)[self getChildByTag:nTag];
                if(pTem)
                {
                    spTem.position = ccp(pTem.position.x + pTem.contentSize.width, pTem.position.y);
                }
            }
            spTem.m_nMapType = 4;
            spTem.m_fMoveRate = 2.0;
            [self addChild:spTem z:0 tag:MAP_BK_M_INDEX + i];
        }
    }
    
    //加载树资源
    for(int i=0; i<=5; i++)
    {
        CCMyMapSprite *spTem = [CCMyMapSprite spriteWithFile:[NSString stringWithFormat:@"Tree_%d_%d.png",m_nBigLevel, i]];
        if(spTem)
        {
            if(0 == i)
            {
                spTem.position = ccp(spTem.contentSize.width*0.5, m_winSize.height - spTem.contentSize.height*0.5 - 30);
            }
            else
            {
                int nTag = MAP_BK_U_INDEX + i -1;
                CCMyMapSprite* pTem = (CCMyMapSprite*)[self getChildByTag:nTag];
                if(pTem)
                {
                    spTem.position = ccp(pTem.position.x + pTem.contentSize.width + 50, pTem.position.y);
                }
            }
            spTem.m_nMapType = 4;
            if(4== i || 5 == i )
            {
                spTem.m_fMoveRate = FORWARD_MOVE_RATIO;
            }
            else 
            {
                spTem.m_fMoveRate = 6.0;
            }
            //spTem.m_fMoveRate = 6.0;
            [self addChild:spTem z:0 tag:TREE_BK_INDEX + i];
        }
    }
    //添加前景下
    for(int i=0; i<5; i++)
    {
        CCMyMapSprite *spTem = [CCMyMapSprite spriteWithFile:[NSString stringWithFormat:@"SceneF_D_%d_%d.png",m_nBigLevel, i]];
        if(spTem)
        {
            if(0 == i)
            {
                spTem.position = ccp(spTem.contentSize.width*0.5, spTem.contentSize.width*0.5 +17);
            }
            else
            {
                int nTag = MAP_BK_D_INDEX + i -1;
                CCMyMapSprite* pTem = (CCMyMapSprite*)[self getChildByTag:nTag];
                if(pTem)
                {
                    spTem.position = ccp(pTem.position.x + pTem.contentSize.width, pTem.position.y);
                }
            }
            spTem.m_nMapType = 1;
            spTem.m_fMoveRate = FORWARD_MOVE_RATIO;
            [self addChild:spTem z:0 tag:MAP_BK_D_INDEX + i];
        }
    }

    //Add by zhengxf "测试粒子效果" 2012-7-10 --------begin-------
    CCParticleSystem* particle = [CCParticleSystemQuad particleWithFile:@"Leaf4.plist"];
    particle.positionType = kCCPositionTypeFree; 
    particle.position = ccp(240,250);
    [self addChild:particle z:0];
    //Add by zhengxf "测试粒子效果" 2012-7-10 --------end-------
    //添加前景上
    for(int i=0; i<6; i++)
    {
        CCMyMapSprite *spTem = [CCMyMapSprite spriteWithFile:[NSString stringWithFormat:@"SceneF_U_%d_%d.png",m_nBigLevel, i]];
        if(spTem)
        {
            if(0 == i)
            {
                spTem.position = ccp(spTem.contentSize.width*0.5, m_winSize.height - spTem.contentSize.width*0.5+7);
            }
            else
            {
                int nTag = MAP_BK_U_INDEX + i -1;
                CCMyMapSprite* pTem = (CCMyMapSprite*)[self getChildByTag:nTag];
                if(pTem)
                {
                    spTem.position = ccp(pTem.position.x + pTem.contentSize.width, pTem.position.y);
                }
            }
            spTem.m_nMapType = 4;
            spTem.m_fMoveRate = FORWARD_MOVE_RATIO;
            [self addChild:spTem z:1 tag:MAP_BK_U_INDEX + i];
        }
    }
}
-(void) InitBrid           //加载小鸟
{
    //加入小鸟和动画
    //添加动画箭头
    m_BridSprite = [CCMyBridSprite spriteWithFile:@"Brid.png"];
    m_BridSprite.position = ccp(160, m_winSize.height/2);
    m_BridSprite.m_nMoveValuey = 0.0f;
    m_BridSprite.m_nBridState = BRID_STATE_NOMAL;
    [self addChild:m_BridSprite z:2 tag:SPRITE_BRID];
    
    //小鸟正常飞的动画
    CCAction* pBridAction = [[AnimationDelegate shareAnimationDelegate] BridFlyAnima];
    [m_BridSprite runAction:pBridAction];
}

-(void) InitHunterAndBean //加载小鸟和动画
{
    //Add by zhengxf about "加入人物的列表" ------2012-7-8 ------begin-----
    m_HunterList = [[CCArray alloc] initWithCapacity:SHIT_SCENE_COUNT];
    FileManager* pFileManager = [FileManager sharedFileManager];
    //Add by zhengxf about "打开所有的文件 提高程序的运行效率" 2012-7-19 --------begin---------- 
    if(pFileManager)
    {
        [pFileManager OpenHunterFile:@"HunterList"];
        [pFileManager OpenBeanFrile:@""];
        [pFileManager OpenFlashingFile:@""];
    }
    //Add by zhengxf about "加载豆子列表" 2012-7-18 -------begin------
    if(pFileManager)
    {
        //Add by zhengxf about "根据关卡选择豆子豆子列表" 2012-8-8-----begin----------
        int nIndex = (m_nBigLevel - 1)*10 + m_nSmallLevel - 1;
        //Add by zhengxf about "根据关卡选择豆子豆子列表" 2012-8-8-----end----------
        LevelNodeList NodeList = [[LevelManager sharedLevelMannger] GetLevelList: nIndex];
        int nLevelcount =  NodeList.n_Count;
        m_ObstacleArray = [[CCArray alloc] initWithCapacity:20];
        for(int i=0; i< nLevelcount; i++)
        {
            NSLog(@"i = %d", i);
            MyObstacle* pObstacleNode = [[[MyObstacle alloc] init] retain];
            //pObstacleNode.m_bIsAdd = Level1[i].m_bisAdd;
            pObstacleNode.m_bIsAdd = NodeList.pLevelList[i].m_bisAdd;
            pObstacleNode.m_ObstacleList = [[CCArray alloc] initWithCapacity:25];
            
            //Add by zhengxf about "随机抽取某个级别的豆子关卡" 2012-7-19 ---------begin----------
            int nDifficulty = NodeList.pLevelList[i].m_nDifficulty;//注：游戏的难度分八级别，1-4，是豆子的级别，5-8是是闪电的级别
                                                                   //豆子： 1(D)对应的是前1-11， 2(C)对应的是12-17 3(B)对应的是
                                                                   //18 - 22 4(A)对应的是23-26 
                                                                   //5-8对应的是闪电级别 闪电：5(D）对应的是前0-2， 6(C)对应的是3-6，
                                                                   //7(B)对应的是7-10    8(A)对应的是11-14 
            BFlashing BF =  BeanAndFlashing[nDifficulty - 1];
             NSLog(@"nDifficulty = %d", nDifficulty);
            //Add by zhengxf about "根据不不同级别来取网和豆子" 2012-8-6 --------begin---------
            //int nBeanTypeCount =0;
            int nBeanTypeIndex = 0;
            int nBeanCount = 0;
            
            if(nDifficulty <= 4)
            {
                //nBeanTypeCount = [pFileManager GetBeanLevelTypeCount];
                nBeanTypeIndex = arc4random()%BF.nLen + BF.nOffset + 1;
                nBeanCount = [pFileManager GetBeanListCount:nBeanTypeIndex];
            }
            else 
            {
                //nBeanTypeCount = [pFileManager GetFlashingLevelTypeCount];
                nBeanTypeIndex = arc4random()%BF.nLen + BF.nOffset + 1;
                nBeanCount = [pFileManager GetFlashingListCount:nBeanTypeIndex];
            }
            NSLog(@"nBeanTypeIndex = %d", nBeanTypeIndex);
            //Add by zhengxf about "根据不不同级别来取网和豆子" 2012-8-6 --------end---------
            
            //Add by zhengxf about "随机抽取某个级别的豆子关卡" 2012-7-19 ---------end----------
            id FlashingAction = nil;
            for(int n = 0; n < nBeanCount; n++)
            {
                BeanMessage pTem;
                CCMyBeanSprite* pBeanSprite = nil;
                if(nDifficulty <= 4)
                {
                    pBeanSprite = [CCMyBeanSprite spriteWithTexture:m_pBeanNomal];
                    pTem = [pFileManager GetBeanMessage:nBeanTypeIndex :n];
                }
                else 
                {
                    pTem = [pFileManager GetFlashingMessage:nBeanTypeIndex :n];
                    switch (pTem.m_nIndex) 
                    {
                        case 0:
                            pBeanSprite = [CCMyBeanSprite spriteWithTexture:m_pFlashing];
                            //FlashingAction = [[AnimationDelegate shareAnimationDelegate] FlashingAnima];
                            //[pBeanSprite runAction:FlashingAction];
                            break;
                        case 1:
                            pBeanSprite = [CCMyBeanSprite spriteWithTexture:m_pFlashingSecond];
                            //FlashingAction = [[AnimationDelegate shareAnimationDelegate] FlashingAnimaSecond];
                            //[pBeanSprite runAction:FlashingAction];
                        break;
                    }
                }
                pBeanSprite.m_bTouch = false;
                pBeanSprite.visible = false;
                //pBeanSprite.position = ccp(pTem.m_nX * 0.5 + 480 + Level1[i].m_nOffset, pTem.m_nY * 0.5 );
                pBeanSprite.position = ccp(pTem.m_nX * 0.5 + 480 + NodeList.pLevelList[i].m_nOffset, pTem.m_nY * 0.5 );
                pBeanSprite.m_nType = pTem.m_nType;
                pBeanSprite.anchorPoint = ccp(0.5, 0);
                
                //Add by zhengxf about "如果在屏幕范围内显示动画" 2012-8-13 ------begin--------
//                if(pBeanSprite.position.x >= 0 && pBeanSprite.position.x <= 480)
//                {
//                    if(nDifficulty > 4)
//                    {
//                        switch (pTem.m_nIndex) 
//                        {
//                            case 0:
//                                FlashingAction = [[AnimationDelegate shareAnimationDelegate] FlashingAnima];
//                                [pBeanSprite runAction:FlashingAction];
//                                break;
//                            case 1:
//                                FlashingAction = [[AnimationDelegate shareAnimationDelegate] FlashingAnimaSecond];
//                                [pBeanSprite runAction:FlashingAction];
//                                break;
//                        }
//                    }
//                }
                //Add by zhengxf about "如果在屏幕范围内显示动画" 2012-8-13 ------end--------
                
                [self addChild:pBeanSprite z:1 tag:0];
                [pObstacleNode.m_ObstacleList addObject:pBeanSprite];
            }
            [m_ObstacleArray addObject:pObstacleNode];
            [pObstacleNode release];
        }
        NSLog(@"m_ObstacleArray.count = %d", m_ObstacleArray.count);
    }
    //Add by zhengxf about "加载豆子列表" 2012-7-18 -------end------
    
    //Add by zhengxf about "打开所有的文件 提高程序的运行效率" 2012-7-19 --------begin---------- 
    if(pFileManager)
    {
        int nIndex = (m_nBigLevel - 1)*10 + m_nSmallLevel; 
        int nListCount = [pFileManager GetListCount:nIndex];
        for(int n= 0; n < nListCount; n++)
        {
            HunterMessage pTem = [pFileManager GetHunterMessage:nIndex :n];
            //Add by zhengxf "判断障碍物类型" 2012-7-10 ------begin--------
            CCMyHunterSprite* Hunter = nil;
            Hunter = [[CCMyHunterSprite spriteWithFile:@"Hunter.png"] retain];
            //switch (pTem.m_nType) 
            //{
            //     case 0:
            //        Hunter = [[CCMyHunterSprite spriteWithFile:@"Hunter.png"] retain];
            //        break;
            //     case 1:
            //        Hunter = [[CCMyHunterSprite spriteWithFile:@"Flashing.png"] retain];
            //        break;
            // }
            //Add by zhengxf "判断障碍物类型" 2012-7-10 ------end--------
            if(Hunter)
            {
                Hunter.position = ccp(pTem.m_nX, pTem.m_nY);
                Hunter.m_nType = pTem.m_nType;
                Hunter.m_nBlood = HunterBlood[Hunter.m_nType];
                Hunter.m_nActionIndex = pTem.m_nAction;
                Hunter.m_bActionRun = NO;
                Hunter.m_bDead = NO;
                Hunter.anchorPoint = ccp(0.5, 0);
                //Hunter.position = ccp(960, 40);
                if(Hunter.position.x >= 0 && Hunter.position.x <= 480)
                {
                    Hunter.visible = YES;
                    Hunter.m_bActionRun = YES;
                    id HunterAction = nil;
                    Hunter.m_nHunterState = HUNTER_STATE_NOMAL;
                    switch (Hunter.m_nType) 
                    {
                        case 0:
                            HunterAction = [[AnimationDelegate shareAnimationDelegate] HunterRunAnima];
                            [Hunter runAction:HunterAction];
                            break;
                        case 1:
                            HunterAction = [[AnimationDelegate shareAnimationDelegate] Hunter2Run];
                            [Hunter runAction:HunterAction];
                            break;
                        case 2:
                            HunterAction = [[AnimationDelegate shareAnimationDelegate] Hunter3Run];
                            [Hunter runAction:HunterAction];
                            break;
                        case 3:
                            HunterAction = [[AnimationDelegate shareAnimationDelegate] Hunter4Run];
                            [Hunter runAction:HunterAction];
                            break;
                    }
                }
                else 
                {
                    Hunter.visible = NO;
                }
                [self addChild:Hunter];
                [m_HunterList addObject:Hunter];
            }
        }
    }
    //Add by zhengxf about "加入人物的列表" ------2012-7-8 ------end-----
}

-(void) InitTreeHole      //加载树洞的图片
{
    //m_winSize.width + m_spTree.contentSize.width
    m_spTree = [CCMyMapSprite spriteWithFile:[NSString stringWithFormat:@"TreeHole_tree%d.png",m_nBigLevel]];
    m_spTree.position = ccp(m_winSize.width + m_spTree.contentSize.width, m_winSize.height - m_spTree.contentSize.height*0.5 - 30);
    m_spTree.m_nMapType = 7;
    m_spTree.m_fMoveRate = FORWARD_MOVE_RATIO;
    m_spTree.visible = false;
    [self addChild:m_spTree z:0 tag:0];
    
    m_spSmallTree = [CCMyMapSprite spriteWithFile:[NSString stringWithFormat:@"TreeHole_small%d.png",m_nBigLevel]];
    m_spSmallTree.position = ccp(m_spTree.position.x + m_spTree.contentSize.width/2-20 ,m_spTree.position.y + 25);
    m_spSmallTree.m_nMapType = 7;
    m_spSmallTree.m_fMoveRate = FORWARD_MOVE_RATIO;
    m_spSmallTree.visible = false;
    [self addChild:m_spSmallTree z:3 tag:0];

    
    m_spHole = [CCMyMapSprite spriteWithFile:[NSString stringWithFormat:@"TreeHole_hole%d.png",m_nBigLevel]];
    m_spHole.position = ccp(m_spTree.position.x  + m_spTree.contentSize.width/2-50,m_spTree.position.y + 25);
    m_spHole.m_nMapType = 7;
    m_spHole.m_fMoveRate = FORWARD_MOVE_RATIO;
    m_spHole.visible = false;
    [self addChild:m_spHole z:0 tag:0];
}

-(void) registerWithTouchDispatcher
{
   [[[CCDirector sharedDirector] touchDispatcher] addStandardDelegate:self priority:INT_MIN+1];
   //[[[CCDirector sharedDirector] touchDispatcher]addTargetedDelegate:self priority:INT_MIN+1 swallowsTouches:YES];
}

-(void) onExit
{
    [m_timer invalidate];
    [m_timer release];
    [m_BridTimer invalidate];
    [m_BridTimer release];
    //Add bu zhengxf about "游戏结束释放资源" 2012-7-26-----begin------
    for(int i= 0; i< m_ObstacleArray.count; i++)
    {
        MyObstacle* pObstacle = [m_ObstacleArray objectAtIndex:i];
       [pObstacle.m_ObstacleList removeAllObjects];
    }
    [m_ObstacleArray removeAllObjects];
    [m_HunterList removeAllObjects];
    [m_ShitList removeAllObjects];
    [self removeAllChildrenWithCleanup:YES];
    //Add bu zhengxf about "游戏结束释放资源" 2012-7-26-----end------
	[[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
    
	[super onExit];
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
    //Add by zhengxf about "新手引导的功能" -----begin------
    [self HelpUserSys];
    //Add by zhengxf about "新手引导的功能" -----end------
    
    if(m_bAllowTouch && !m_bCatchOrEnd && !m_bPauseGame)
    {
        //Add by zhengxf about "多点触控功能" 2012-7-6 -----begin-------
        UITouch* Second = nil;
        CGPoint  SecondPoint;
        NSUInteger touchCount  = [touches count];
        //Add by zhengxf about "判断修改" 2012-7-8-------begin-------
        for(int i=0; i< touchCount; i++)
        {
            Second = [[touches allObjects] objectAtIndex:i];
            SecondPoint = [Second locationInView: Second.view];
            SecondPoint = [[CCDirector sharedDirector] convertToGL:SecondPoint];
            if(SecondPoint.x <= m_winSize.width * 0.5)//左屏幕点击
            {
                m_nLeftSceneDown = true;
                //Add by zhengxf about "改变鸟的动画" 2012-7-11-------begin-------
                if(!m_bBridIsHeight && m_BridSprite.m_nBridState != BRID_STATE_ACCELERATE && m_BridSprite.m_nBridState != BRID_STATE_HUNT1
                   && m_BridSprite.m_nBridState !=  BRID_STATE_CATCHED &&  m_BridSprite.m_nBridState != BRID_STATE_LIGHTNING)
                {
                    m_BridSprite.m_nBridState = BRID_STATE_ACCELERATE;
                    [m_BridSprite stopAllActions];
                    //小鸟加速动画和回调
                    id ac = [[AnimationDelegate shareAnimationDelegate] BridAccAnima:self Function:@selector(ConturnBridAction:)];
                    [m_BridSprite runAction:ac];
//                    MusicMannger* pMusicMgr = [MusicMannger sharedMusicMannger];
//                    if(pMusicMgr)
//                    {
//                        [pMusicMgr PlayEffect:@"Fly.mp3"];
//                    }
                }
                //Add by zhengxf about "改变鸟的动画" 2012-7-11-------end-------
                if(m_BridSprite)
                {
                    m_BridSprite.m_nMoveValuey = 0.0f;
                }
            }
            else //右屏幕点击
            {
                //Add by zhengxf about "判断是否是换武器" 2012-7-10  -------begin-------
                if(CGRectContainsPoint(m_RcChangeWeapon, SecondPoint))
                {
                    m_bChangeWeapon = true;
                    m_ptWeaponPoint = SecondPoint;
                }
                //Add by zhengxf about "判断是否是换武器" 2012-7-10  -------end-------
                
                //小鸟拉便便的动画和回调
                //[m_BridSprite stopAllActions];
                //id ac = [[AnimationDelegate shareAnimationDelegate] BridGreat:self Function:@selector(ConturnBridAction:)];
                //[m_BridSprite runAction:ac];
                m_nRithtSceneDown = true;
                if(m_ShitSprite && !m_bChangeWeapon && !m_bFrieDragon)
                {
                    m_ShitSprite.position = ccp(m_BridSprite.position.x, m_BridSprite.position.y- m_BridSprite.contentSize.height/2);
                    [m_ShitSprite setVisible:true];
                }
                if(m_ShitList && !m_bChangeWeapon  && !m_bFrieDragon  && !m_bCatchOrEnd)
                {
                    CCBridShitSprite *ShitSprite = [m_ShitList objectAtIndex:m_nShitIndex];
                    if(ShitSprite)
                    {
                        m_nBeanCount -= UseBean[ShitSprite.m_nShitType];
                        if(m_nBeanCount >= 0)
                        {
                            m_nShitIndex++;
                            if (m_nShitIndex >= m_ShitList.count) m_nShitIndex = 0;
                            ShitSprite.position = ccp(m_BridSprite.position.x, m_BridSprite.position.y- m_BridSprite.contentSize.height/2);
                            ShitSprite.visible = YES;
                            
                            //Add by zhengxf about "豆子消耗数" 2012-8-22 --------begin-------
                            [self ShowScore:m_nBeanCount :m_pBeanPoint :1 :2];
                            //Add by zhengxf about "豆子消耗数" 2012-8-22 --------end-------
                            //Add by zhengxf about "闪电便便动画" 2012-8-25  ---------begin-------
                            if(ShitSprite.m_nShitType == 2)
                            {
                                id FlightAction = [[AnimationDelegate shareAnimationDelegate] ShitFlight];
                                [ShitSprite runAction:FlightAction];
                            }
                            else if(ShitSprite.m_nShitType == 3)
                            {
                                m_bFrieDragon = true;
                                id FlightAction = [[AnimationDelegate shareAnimationDelegate] ShitDragon];
                                [ShitSprite runAction:FlightAction];
                            }
                            //Add by zhengxf about "闪电便便动画" 2012-8-25  ---------end-------

                            float nTime = (ShitSprite.position.y * SHIT_DOWN_TIME)/(m_winSize.height - 60);//计算不同速率下落的时间
                            [ShitSprite runAction:[CCSequence actions:
                                                    [CCMoveBy actionWithDuration:nTime position:ccp(0, -ShitSprite.position.y + 30)],
                                                    [CCCallFuncN actionWithTarget:self selector:@selector(setInvisible:)],
                                                    nil]];

                            MusicMannger* pMusicMgr = [MusicMannger sharedMusicMannger];
                            if(pMusicMgr)
                            {
                                [pMusicMgr PlayEffect:@"Shit.mp3"];
                            }
                        }
                        else 
                        {
                            if(UseBean[ShitSprite.m_nShitType] > 1)
                            {
                                m_nBeanCount = UseBean[ShitSprite.m_nShitType] + m_nBeanCount;
                            }
                            else 
                            {
                                m_nBeanCount =0;
                            }
                            //Add by zhengxf about "豆子消耗数" 2012-8-22 --------begin-------
                            [self ShowScore:m_nBeanCount :m_pBeanPoint :1 :0];
                            //Add by zhengxf about "豆子消耗数" 2012-8-22 --------end-------
                            //豆子数不够
                            NSLog(@"豆子数不够");
                        }
                    }
                }
            }
        }
        //Add by zhengxf about "判断修改" 2012-7-8-------end-------
        //Add by zhengxf about "多点触控功能" 2012-7-6 -----end-------
    }
}

- (void)setInvisible:(CCNode *)node 
{
    node.visible = NO;
    CCBridShitSprite* pShit = (CCBridShitSprite*)node;
    if(pShit)
    {
        if(pShit.m_nShitType == 3)
        {
            //m_bFrieDragon = true;
            m_spDragonFrie = [CCSprite spriteWithFile:@"GameOver_Bean.png"];
            m_spDragonFrie.position = ccp(50, 40);
            [self addChild:m_spDragonFrie z:1 tag:0];
            
            id FlightAction = [[AnimationDelegate shareAnimationDelegate] FrieDragon];
            [m_spDragonFrie runAction:FlightAction];
            
            //Add by zhengxf about "龙哮的动画" 2012-9-5 ------begin--------
            MusicMannger* pMusicMgr = [MusicMannger sharedMusicMannger];
            if(pMusicMgr)
            {
                [pMusicMgr PlayEffect:@"DragonSing.mp3"];
            }
            //Add by zhengxf about "龙哮的动画" 2012-9-5 ------end--------
            
            //Add by zhengxf "测试粒子效果" 2012-7-10 --------begin-------
            CCParticleSystem* particle = [CCParticleSystemQuad particleWithFile:@"TestFrie11.plist"];
            particle.positionType = kCCPositionTypeFree; 
//            particle.position = ccp(240,80);
//            [self addChild:particle z:0 tag:1000];
            [m_spDragonFrie addChild:particle z:1];
            //Add by zhengxf "测试粒子效果" 2012-7-10 --------end-------
            
            [m_spDragonFrie runAction:[CCSequence actions:
                                   [CCMoveBy actionWithDuration:1.0 position:ccp(480, 0)],
                                   [CCCallFuncN actionWithTarget:self selector:@selector(FrieDragonOver:)],
                                   nil]];
            //龙便便横屏飞行的动画
        }
    }
}

- (void)FrieDragonOver:(CCNode *)node
{
    [self removeChild:m_spDragonFrie cleanup:YES];
    m_spDragonFrie = nil;
    m_bFrieDragon = false;
    [self removeChildByTag:1000 cleanup:YES];
}

-(void) ccTouchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
    if(!m_bGameOver)
    {
        bool bAllRight = true;
        for(int n=0; n< [touches count]; n++)
        {
            UITouch* temTouch = [[touches allObjects] objectAtIndex:n];
            CGPoint temPoint = [temTouch locationInView: temTouch.view];
            temPoint = [[CCDirector sharedDirector] convertToGL:temPoint];
            if(temPoint.x <= m_winSize.width * 0.5 || m_nRithtSceneDown)
            {
                bAllRight = false;
            }
        }
        NSLog(@"%d", [touches count]);
        NSLog(@"%d", bAllRight);
        m_bAllRight = bAllRight;
    }
    //Add by zhengxf about "判断是否是换武器" 2012-7-10  -------begin-------
    //UITouch* Second = nil;
    //CGPoint  SecondPoint;
    //NSUInteger touchCount  = [touches count];
    //Add by zhengxf about "判断修改" 2012-7-8-------begin-------
//    for(int i=0; i< touchCount; i++)
//    {
//        Second = [[touches allObjects] objectAtIndex:i];
//        SecondPoint = [Second locationInView: Second.view];
//        SecondPoint = [[CCDirector sharedDirector] convertToGL:SecondPoint];
//        if(m_bChangeWeapon && CGRectContainsPoint(m_RcChangeWeapon, SecondPoint))
//        {
//            m_bChangeWeapon = true;
//        }
//        else 
//        {
//            m_bChangeWeapon = false;
//        }
//    }
    //Add by zhengxf about "判断是否是换武器" 2012-7-10  -------end-------
}

-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(!m_bGameOver)
    {
        bool bAllRight = true;
        NSLog(@"%d", [touches count]);
        for(int n=0; n< [touches count]; n++)
        {
            UITouch* temTouch = [[touches allObjects] objectAtIndex:n];
            CGPoint temPoint = [temTouch locationInView: temTouch.view];
            temPoint = [[CCDirector sharedDirector] convertToGL:temPoint];
            if(temPoint.x <= m_winSize.width * 0.5)
            {
                //Add by zhengxf about "两个点是否都在右边" 2012-9-11 ------begin--------
                bAllRight = false;
                //Add by zhengxf about "两个点是否都在右边" 2012-9-11 ------end--------
                if(m_nLeftSceneDown && m_BridSprite)
                {
                    m_nLeftSceneDown = false;
                    m_BridSprite.m_nMoveValuey = 0.0f;
                }
            }
            else 
            {
                if(m_nRithtSceneDown && m_BridSprite)
                {
                    m_nRithtSceneDown = false;
                }
            }
            if(m_bChangeWeapon)
            {
                [self getChildByTag:SHIT_BULLET_NUMAL + m_nWeaponIndex].visible = false;
                [self getChildByTag:SHIT_NUMBER_NUMAL + m_nWeaponIndex].visible = false;
                if(m_ptWeaponPoint.x < temPoint.x)
                {
                    if(m_nWeaponIndex >= m_ShitOpenIndex)
                    {
                        m_nWeaponIndex =0;
                    }
                    else 
                    {
                        m_nWeaponIndex++;
                    }
                }
                else 
                {
                    if(m_nWeaponIndex > 0)
                    {
                        m_nWeaponIndex --;
                    }
                    else 
                    {
                        m_nWeaponIndex = m_ShitOpenIndex;
                    }
                }
                [self getChildByTag:SHIT_BULLET_NUMAL + m_nWeaponIndex].visible = true;
                [self getChildByTag:SHIT_NUMBER_NUMAL + m_nWeaponIndex].visible = true;
                [self ChangeShit:m_nWeaponIndex];
                m_bChangeWeapon = false;
            }
        }
//        NSLog(@"%d", bAllRight);
        if(m_bAllRight)
        {
            if(m_nLeftSceneDown && m_BridSprite)
            {
                m_nLeftSceneDown = false;
                m_BridSprite.m_nMoveValuey = 0.0f;
            }
        }
    }
}

-(void) ccTouchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

-(void) MoveBean
{
    
    for(int i =0; i< m_ObstacleArray.count; i++)
    {
        MyObstacle* pNode = [m_ObstacleArray objectAtIndex:i];
        if(!pNode.m_bIsAdd)
        {
            for(int j = 0; j< pNode.m_ObstacleList.count; j++)
            {
                CCMyBeanSprite* NodeMessage = [pNode.m_ObstacleList objectAtIndex:j];
                if(NodeMessage)
                {
                    if(NodeMessage.position.x >= 0 && NodeMessage.position.x <= 480)
                    {
                        if(!NodeMessage.visible && !NodeMessage.m_bTouch)
                        {
                            NodeMessage.visible = YES;
                            id FlashAction = nil;
                            if(NodeMessage.m_nType == 1)
                            {
                                m_bRandSystem = true;
                                switch (NodeMessage.m_nIndex) 
                                {
                                    case 0:
                                        FlashAction = [[AnimationDelegate shareAnimationDelegate]FlashingAnima];
                                        [NodeMessage runAction:FlashAction];
                                        break;
                                    case 1:
                                        FlashAction = [[AnimationDelegate shareAnimationDelegate] FlashingAnimaSecond];
                                        [NodeMessage runAction:FlashAction];                 
                                    default:
                                        break;
                                }
                            }
                        }
                    }
                    else 
                    {
                        NodeMessage.visible = NO;
                        if(NodeMessage.position.x < 0)
                        {
                            //[pNode.m_ObstacleList removeObjectAtIndex:j];
                            [self removeChild:NodeMessage cleanup:YES];
                        }
                    }
                    NodeMessage.position = ccpAdd(NodeMessage.position, ccp(-0.5 * FORWARD_MOVE_RATIO, 0));
                    if(j == pNode.m_ObstacleList.count -1 && NodeMessage.position.x <= -NodeMessage.contentSize.width)
                    {
                        [m_ObstacleArray removeObjectAtIndex:i];
                        NSLog(@"m_ObstacleArray.count = %d", m_ObstacleArray.count);
                        pNode.m_bIsAdd = true;
                    }
                }
            }
        }
    }
}

-(void) MoveHunter
{
    if(m_HunterList)
    {
        int nHunterCount = [self PlayHunterAction:false];
        //判断是否有可见猎人
        if(nHunterCount > 0)
        {
            m_bHaveHunter = true;//屏幕中有可见的猎人
        }
        else
        {
            m_bHaveHunter = false;
        }
    }
}

-(void) MoveBrid
{
    if(m_BridSprite)
    {
        if(m_nLeftSceneDown)
        {
            if(m_BridSprite.position.y <= m_winSize.height - 60)
            {
                m_bBridIsHeight = false;
                m_BridSprite.m_nMoveValuey += BRID_ADD_SPEED;
                m_BridSprite.position = ccpAdd(m_BridSprite.position,  ccp(0, m_BridSprite.m_nMoveValuey + BRID_START_SPEED));
            }
            else 
            {
                m_bBridIsHeight = true;
                if(m_bHaveHunter)
                {
                    //播放鸟在最高点，有猎人的动画
                    if(m_BridSprite.m_nBridState != BRID_STATE_HEIGHT && !m_bCatchOrEnd)
                    {
                        if(m_BridSprite.m_nBridState != BRID_STATE_HUNT1 && m_BridSprite.m_nBridState != BRID_STATE_EAT)
                        {
                            m_BridSprite.m_nBridState = BRID_STATE_HEIGHT;
                                [m_BridSprite stopAllActions];
                                //鸟最高点的动画
                                id pBridAction = [[AnimationDelegate shareAnimationDelegate]  BridHighAnima];
                                [m_BridSprite runAction:pBridAction];
                            }
                        }
                    }
                    else 
                    {
                        if(m_BridSprite.m_nBridState == BRID_STATE_HEIGHT && !m_bCatchOrEnd)
                        {
                            m_BridSprite.m_nBridState = BRID_STATE_NOMAL;
                            [m_BridSprite stopAllActions];
                            CCAction* pBridAction = [[AnimationDelegate shareAnimationDelegate] BridFlyAnima];
                            [m_BridSprite runAction:pBridAction];
                        }
                    }
                }
            }
            else 
            {
                m_bBridIsHeight = false;
                if(m_BridSprite.position.y >= 40)
                {
                    //Add by zhengxf about "如果在最高点落下，且是嘲笑状态，播放正常动画" 2012-7-12-----begin----
                    if(m_BridSprite.m_nBridState == BRID_STATE_HEIGHT && !m_bCatchOrEnd)
                    {
                        m_BridSprite.m_nBridState = BRID_STATE_NOMAL;
                        [m_BridSprite stopAllActions];
                        CCAction* pBridAction = [[AnimationDelegate shareAnimationDelegate] BridFlyAnima];
                        [m_BridSprite runAction:pBridAction];
                    }
                    //Add by zhengxf about "如果在最高点落下，且是嘲笑状态，播放正常动画" 2012-7-12-----end----
                    m_BridSprite.m_nMoveValuey -= BRID_ADD_SPEED;
                    m_BridSprite.position = ccpAdd(m_BridSprite.position,  ccp(0, m_BridSprite.m_nMoveValuey -BRID_START_SPEED));
                }
                else 
                {
                    if(m_BridSprite.m_nBridState != BRID_STATE_LOW && !m_bCatchOrEnd)
                    {
                       m_BridSprite.m_nBridState = BRID_STATE_LOW;
                       [m_BridSprite stopAllActions];
                       //鸟落地的动画
                       id pBridAction = [[AnimationDelegate shareAnimationDelegate]  BridLowAnima];
                       [m_BridSprite runAction:pBridAction];
                       MusicMannger* pMusicMgr = [MusicMannger sharedMusicMannger];
                       if(pMusicMgr)
                       {
                           [pMusicMgr PlayEffect:@"Run.mp3"];
                       }
                    }
                }
        }
        if(!m_bCatchOrEnd)
        {
            [self BridIsTouch];//鸟是否碰撞
            [self ShitIsTouch];//便便是否碰撞
            [self BeanIsTouch];
        }
    }
}

-(void) MoveShit
{
    if(m_ShitSprite)
    {
        if(m_nRithtSceneDown)
        {
            if(m_ShitSprite.position.y >= 40)
            {
                m_ShitSprite.m_nMoveValuey -= SHIT_ADD_SPEED;
                m_ShitSprite.position = ccpAdd(m_ShitSprite.position,  ccp(0, m_ShitSprite.m_nMoveValuey - SHIT_START_SPEED));
            }
            else 
            {
                m_ShitSprite.m_nMoveValuey = 0.0f;
                m_nRithtSceneDown = false;
                [m_ShitSprite setVisible:false];
            }
        }
    }
}

//改变便便
-(void) ChangeShit:(int) nIndex
{
    [m_ShitList removeAllObjects];
    CCBridShitSprite *Shit = nil;
    for(int i = 0; i < SHIT_SCENE_COUNT; ++i) {
        [self removeChildByTag: SPRITE_SHIT + i cleanup:true]; 
        switch(nIndex)
        {
            case 0:
                Shit = [CCBridShitSprite spriteWithFile:@"Shit.png"];
                break;
            case 1:
                Shit = [CCBridShitSprite spriteWithFile:@"FrieShit.png"];
                break;
            case 2:
                Shit = [CCBridShitSprite spriteWithFile:@"FlashingShit.png"];
                break;
            case 3:
                Shit = [CCBridShitSprite spriteWithFile:@"DragonShit.png"];
                break;
        }
        
        Shit.visible = NO;
        Shit.m_nShitType = nIndex;
        [self addChild:Shit z: 0 tag:SPRITE_SHIT + i];
        [m_ShitList addObject:Shit];
    }
}
-(void) MoveTreeHole
{
    m_spTree.position = ccpAdd(m_spTree.position, ccp(-0.5 * m_spTree.m_fMoveRate, 0));
    m_spSmallTree.position = ccpAdd(m_spSmallTree.position, ccp(-0.5 * m_spSmallTree.m_fMoveRate, 0));
    m_spHole.position = ccpAdd(m_spHole.position, ccp(-0.5 * m_spHole.m_fMoveRate, 0));
}

-(void) MoveMap
{
    //计算地图移动的距离
    m_nNowLevelLen +=  0.5 * FORWARD_MOVE_RATIO;
    float nMove = m_nProgressLen * 4/m_nLevelLen;
    m_spProgress.position = ccpAdd(m_spProgress.position, ccp(nMove, 0));
    //移动中景
    for(int i=0; i< 3; i++)
    {
        CCMyMapSprite *backGround =(CCMyMapSprite*)[self getChildByTag:MAP_BK_M_INDEX + i];
        backGround.position = ccpAdd(backGround.position, ccp(-0.5 * backGround.m_fMoveRate, 0));
        if(backGround.position.x <= -(backGround.contentSize.width* 0.5))
        {
            backGround.position = ccp(512 + backGround.contentSize.width* 0.5 -0.1, m_winSize.height - backGround.contentSize.height*0.5  - 20);
        }
    }
    //移动前背景下
    for(int i = 0; i<5; i++)
    {
       CCMyMapSprite *backGround =(CCMyMapSprite*)[self getChildByTag:MAP_BK_D_INDEX + i];
        backGround.position = ccpAdd(backGround.position, ccp(-0.5 * backGround.m_fMoveRate, 0));
        if(backGround.position.x <= -(backGround.contentSize.width* 0.5))
        {
            backGround.position = ccp(480 + backGround.contentSize.width* 0.5 -0.1, backGround.contentSize.width*0.5 + 15);
        }
    }
    //移动前背景上
    for(int i = 0; i<6; i++)
    {
        CCMyMapSprite *backGround =(CCMyMapSprite*)[self getChildByTag:MAP_BK_U_INDEX + i];
        backGround.position = ccpAdd(backGround.position, ccp(-0.5 * backGround.m_fMoveRate, 0));
        if(backGround.position.x <= -(backGround.contentSize.width* 0.5))
        {

            backGround.position = ccp(480 + backGround.contentSize.width* 0.5 -0.1, m_winSize.height - backGround.contentSize.width*0.5+5);
        }
    }
    //移动树
    for(int i=0; i<6; i++)
    {
        CCMyMapSprite *backGround =(CCMyMapSprite*)[self getChildByTag:TREE_BK_INDEX + i];
        backGround.position = ccpAdd(backGround.position, ccp(-0.5 * backGround.m_fMoveRate, 0));
        if(backGround.position.x <= -(backGround.contentSize.width* 0.5))
        {
            backGround.position = ccp(480 + backGround.contentSize.width* 0.5 -0.1, m_winSize.height - backGround.contentSize.height*0.5 - 30);
        }
    }
}

//检测便便是否碰撞
-(bool) ShitIsTouch
{
    bool bTouch = false;
    for(int j =0; j<SHIT_SCENE_COUNT; j++)
    {
        CCBridShitSprite *pShit = [m_ShitList objectAtIndex:j];
        if(pShit && pShit.visible && pShit.m_nShitType < 3)
        {
            for(int i = 0; i< m_HunterList.count; i++)
            {
                CCMyHunterSprite *pHunter = [m_HunterList objectAtIndex:i];
                if(pHunter && pHunter.visible  &&  !pHunter.m_bDead)//&& 0 == pHunter.m_nType
                {

                    CGRect ShitRect = [pShit textureRect];
                    ShitRect.origin.x = pShit.position.x - ShitRect.size.width /2;
                    ShitRect.origin.y = pShit.position.y - ShitRect.size.height /2;
                    
                    CGRect HunterRect = [pHunter textureRect];
                    HunterRect.origin.x = pHunter.position.x - HunterRect.size.width /2;
                    HunterRect.origin.y = pHunter.position.y;
                    
                    if(pShit.visible  && CGRectIntersectsRect(ShitRect, HunterRect))
                    {
                        MusicMannger* pMusicMgr = [MusicMannger sharedMusicMannger];
                        //add by zhengxf about "是否已经死亡" 2012-8-8 ------begin---------
                        //int nBoole = HunterAndShit[pHunter.m_nType][pShit.m_nShitType];
                        pHunter.m_nBlood -= HunterAndShit[pHunter.m_nType][pShit.m_nShitType];
                        //add by zhengxf about "是否已经死亡" 2012-8-8 ------end---------
                        if(pHunter.m_nBlood <= 0) //人物被便便击中，并且死亡
                        {
                            m_nLeveScore += HunterScore[pHunter.m_nType]; //打死敌人加分
                            [self ShowScore:m_nLeveScore :m_pScorePoint :2 :false];
                            //Add by zhengxf about "加入游戏的分数" 2012-8-22 -------begin------
                            
                            //Add by zhengxf about "加入游戏的分数" 2012-8-22 -------end------
                            pShit.visible = NO;
                            pHunter.m_bDead = YES;
                            //Add by zhengxf about "人死亡的动画"2012-7-16 --------begin--------
                            if( pHunter.m_nHunterState != HUNTER_STATE_DEAD)
                            {
                                pHunter.m_nHunterState =  HUNTER_STATE_DEAD;
                                [pHunter stopAllActions];
                                
                                //Add by zhengxf about "人物死的类型" 2012-7-17 ------begin-------
                                id pHunterAction = nil;
                                //id pHunterAction1 = nil;
                                switch (pShit.m_nShitType) //便便的类型
                                {
                                    case 0:
                                        switch (pHunter.m_nType) 
                                        {
                                            case 0:
                                                //人1死亡的动画
                                                pHunterAction = [[AnimationDelegate shareAnimationDelegate]  HunterDead:self Function:@selector(ConturnHunterAction:)];
                                                [pHunter runAction:pHunterAction];
                                                break;
                                            case 1:
                                                //人2死亡的动画
                                                pHunterAction = [[AnimationDelegate shareAnimationDelegate]  Hunter2Dead:self Function:@selector(ConturnHunterAction:)];
                                                [pHunter runAction:pHunterAction];
                                                break;
                                            case 2:
                                                //人4死亡的动画
                                                pHunterAction = [[AnimationDelegate shareAnimationDelegate]  Hunter3Dead:self Function:@selector(ConturnHunterAction:)];
                                                [pHunter runAction:pHunterAction];
                                                break;
                                            case 3:
                                                //人4死亡的动画
                                                pHunterAction = [[AnimationDelegate shareAnimationDelegate]  Hunter4Dead:self Function:@selector(ConturnHunterAction:)];
                                                [pHunter runAction:pHunterAction];
                                                break;
                                            default:
                                                break;
                                        }
                                        break;
                                    case 1:
                                        switch (pHunter.m_nType) 
                                        {
                                            case 1:
                                                //人2死亡的动画
                                                pHunter.scale = 1.1;
                                                break;
                                            case 2:
                                                //人4死亡的动画
                                                pHunter.scale = 1.2;
                                                break;
                                            case 3:
                                                //人4死亡的动画
                                                pHunter.scale = 1.3;
                                                break;
                                            default:
                                                break;
                                        }
                                        //Add by zhengxf about "人物被烧的动画" 2012-9-5 -----begin-----
                                        if(pMusicMgr)
                                        {
                                            [pMusicMgr PlayEffect:@"HunterBurn.mp3"];
                                        }
                                        //Add by zhengxf about "人物被烧的动画" 2012-9-5 -----end-----
                                        pHunter.m_nDeadType = HUNTER_DEAD_FIRE;
                                        pHunter.position = ccpAdd(pHunter.position, ccp(0, 30));
                                        pHunterAction = [[AnimationDelegate shareAnimationDelegate] HunterBurn1:self Function:@selector(ConturnHunterAction:)];
                                        [pHunter runAction:pHunterAction];
                                        
//                                        id BurnMove = [[AnimationDelegate shareAnimationDelegate] HunterBurn1Move];
//                                        [pHunter runAction:BurnMove];
                                        //人物燃烧冒烟的动画
                                        //                                    pHunterAction = [[AnimationDelegate shareAnimationDelegate] HunterBurnSmoke:self Function:@selector(ConturnHunterAction:)];
                                        //                                    [pHunter runAction:pHunterAction];
                                        
                                        //人物被烧的动画

                                        //                                    //人物冒烟的动画
                                        //                                    pHunterAction1 = [[AnimationDelegate shareAnimationDelegate] HunterSmoke:self Function:@selector(ConturnHunterAction:)];
                                        //                                    [pHunter runAction:pHunterAction1];
                                        
                                        break;
                                    case 2:
                                        switch (pHunter.m_nType) 
                                        {
                                            case 1:
                                                //人2死亡的动画
                                                pHunter.scale = 1.1;
                                                break;
                                            case 2:
                                                //人4死亡的动画
                                                pHunter.scale = 1.2;
                                                break;
                                            case 3:
                                                //人4死亡的动画
                                                pHunter.scale = 1.3;
                                                break;
                                            default:
                                                break;
                                        }
                                        
                                        //Add by zhengxf about "人物被电的动画" 2012-9-5 -----begin-----
                                        if(pMusicMgr)
                                        {
                                            [pMusicMgr PlayEffect:@"Filght_Hunter.mp3"];
                                        }
                                        //Add by zhengxf about "人物被电的动画" 2012-9-5 -----end-----
                                        pHunter.m_nDeadType = HUNTER_DEAD_FLIGHT;
                                        pHunterAction = [[AnimationDelegate shareAnimationDelegate] HunterFlight:self Function:@selector(ConturnHunterAction:)];
                                        [pHunter runAction:pHunterAction];
                                        break;
                                    default:
                                        break;
                                }
                                //Add by zhengxf about "人物死的类型" 2012-7-17 ------end-------
                            }
                            //Add by zhengxf about "人死亡的动画"2012-7-16 --------end--------
                        }
                        else  //人物被便便击中，但是受伤
                        {
                            pShit.visible = NO;
                            if( pHunter.m_nHunterState != HUNTER_STATE_BRUISE)
                            {
                                pHunter.m_nHunterState =  HUNTER_STATE_BRUISE;
                                [pHunter stopAllActions];
                                
                                //Add by zhengxf about "人物死的类型" 2012-7-17 ------begin-------
                                id pHunterAction = nil;
                                //id pHunterAction1 = nil;
                                switch (pHunter.m_nType) 
                                {
                                    case 1:
                                        //人2受伤的动画
                                        pHunterAction = [[AnimationDelegate shareAnimationDelegate]  Hunter2Scold:self Function:@selector(ConturnHunterAction:)];
                                        [pHunter runAction:pHunterAction];
                                        break;
                                    case 2:
                                        //人3受伤的动画
                                        pHunterAction = [[AnimationDelegate shareAnimationDelegate]  Hunter3Scold:self Function:@selector(ConturnHunterAction:)];
                                        [pHunter runAction:pHunterAction];
                                        break;
                                    case 3:
                                        //人4受伤的动画
                                        pHunterAction = [[AnimationDelegate shareAnimationDelegate]  Hunter4Scold:self Function:@selector(ConturnHunterAction:)];
                                        [pHunter runAction:pHunterAction];
                                        break;
                                    default:
                                        break;
                                }
                                MusicMannger* pMusicMgr = [MusicMannger sharedMusicMannger];
                                if(pMusicMgr)
                                {
                                    [pMusicMgr PlayEffect:@"Scold.mp3"];
                                }
                            //Add by zhengxf about "人物死的类型" 2012-7-17 ------end-------
                            }
                        }
                        //Add by zhengxf about "小鸟击中目标的动画" 2012-7-12  ---------begin---------
                        if(m_BridSprite.m_nBridState != BRID_STATE_HUNT1 && !m_bCatchOrEnd)
                        {
                            m_BridSprite.m_nBridState = BRID_STATE_HUNT1;
                            [m_BridSprite stopAllActions];
                            //鸟落地的动画
                            int nBridHitIndex = arc4random()%3 +1;
                            [self BridHitHunter:nBridHitIndex];
                        }
                        //Add by zhengxf about "小鸟击中目标的动画" 2012-7-12  ---------end---------
                    }
                }
            }
        }
    }
    return bTouch;
}

-(void) BridHitHunter:(int)nIndex
{
    MusicMannger* pMusicMgr = [MusicMannger sharedMusicMannger];
    id pBridAction = nil;
    switch (nIndex) {
        case 1:
            pBridAction = [[AnimationDelegate shareAnimationDelegate]  BridHit1Anima:self Function:@selector(ConturnBridAction:)];
            if(pMusicMgr)
            {
                [pMusicMgr PlayEffect:@"BridSmile.mp3"];
            }
            break;
        case 2:
           pBridAction = [[AnimationDelegate shareAnimationDelegate]  BridHit2Anima:self Function:@selector(ConturnBridAction:)];
            if(pMusicMgr)
            {
                [pMusicMgr PlayEffect:@"BridSmile.mp3"];
            }
            break;
        case 3:
            pBridAction = [[AnimationDelegate shareAnimationDelegate]  BridHit3Anima:self Function:@selector(ConturnBridAction:)];
            if(pMusicMgr)
            {
                [pMusicMgr PlayEffect:@"SpitTongue.mp3"];
            }
            break;
        default:
            break;
    }
    [m_BridSprite runAction:pBridAction];
}

//检测豆子是否碰撞
-(bool)BeanIsTouch
{
    bool bTouch = false;
    for(int i =0; i< m_ObstacleArray.count; i++)
    {
        MyObstacle* pNode = [m_ObstacleArray objectAtIndex:i];
        if(!pNode.m_bIsAdd)
        {
            for(int j = 0; j< pNode.m_ObstacleList.count; j++)
            {
                CCMyBeanSprite* NodeMessage = [pNode.m_ObstacleList objectAtIndex:j];
                if(NodeMessage)
                {
                    if(j == 0 && NodeMessage.position.x > 480)
                    {
                        break;
                    }
                    else 
                    {
                        if(m_BridSprite && NodeMessage && NodeMessage.visible && !NodeMessage.m_bTouch)
                        {
                            CGRect BridRect = [m_BridSprite textureRect];
                            BridRect.origin.x = m_BridSprite.position.x - BridRect.size.width /2;
                            BridRect.origin.y = m_BridSprite.position.y - BridRect.size.height /2;
                            BridRect.size.height -= 20;
                            
                            CGRect BeanRect = [NodeMessage textureRect];
                            BeanRect.origin.x = NodeMessage.position.x - BeanRect.size.width /2;
                            BeanRect.origin.y = NodeMessage.position.y;
                            if(CGRectIntersectsRect(BridRect, BeanRect))
                            {
                                switch (NodeMessage.m_nType) 
                                {
                                    case 0:
                                        NodeMessage.visible = false;
                                        
                                        //数据积分
                                        m_nBeanCount += 1;
                                        m_nEatBeanCount += 1;
                                        m_nLeveScore += BEAN_SCORE;
                                        
                                        //Add by zhengxf about "显示游戏的分数和豆子数" 2012-8-22 -------begin------
                                        [self ShowScore:m_nBeanCount :m_pBeanPoint :1 :1];
                                        [self ShowScore:m_nLeveScore :m_pScorePoint :2 :false];
                                        //Add by zhengxf about "显示游戏的分数和豆子数" 2012-8-22 -------end------
                                        
                                        NodeMessage.m_bTouch = true;
                                        //Add by zhengxf about "小鸟吃豆子的动画" 2012-7-12  ---------begin---------
                                        if(m_BridSprite.m_nBridState != BRID_STATE_EAT && !m_bCatchOrEnd)
                                        {
                                            m_BridSprite.m_nBridState = BRID_STATE_EAT;
                                            [m_BridSprite stopAllActions];
                                            //鸟吃豆子的动画
                                            id pBridAction = [[AnimationDelegate shareAnimationDelegate]  BridEatAnima:self Function:@selector(ConturnBridAction:)];
                                            [m_BridSprite runAction:pBridAction];
                                            MusicMannger* pMusicMgr = [MusicMannger sharedMusicMannger];
                                            if(pMusicMgr)
                                            {
                                                [pMusicMgr PlayEffect:@"Eat_Bean.mp3"];
                                            }
                                        }
                                        //Add by zhengxf about "小鸟吃豆子的动画" 2012-7-12  ---------end---------;
                                        break;
                                    case 1:
                                        if(m_BridSprite.m_nBridState != BRID_STATE_LIGHTNING && !m_bCatchOrEnd)
                                        {
                                           
                                            m_BridSprite.m_nBridState = BRID_STATE_LIGHTNING;
                                            [m_BridSprite stopAllActions];
//                                          id BridAction = [[AnimationDelegate shareAnimationDelegate] BridFlashingAnima:self Function:@selector(ConturnBridAction:)];
                                            id BridAction = [[AnimationDelegate shareAnimationDelegate] BridFlashingAnima];
                                            [m_BridSprite runAction:BridAction];
                                            MusicMannger* pMusicMgr = [MusicMannger sharedMusicMannger];
                                            if(pMusicMgr)
                                            {
                                                [pMusicMgr PlayEffect:@"Brit_Light.mp3"];
                                            }
                                            [self BridCatchRoEnd];
                                            m_bCatchOrEnd =  true;
                                        }
                                        break;
                                    default:
                                        break;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    return bTouch;
}

//检测小鸟是否碰撞
-(bool) BridIsTouch
{
    bool bTouch = false;
    for(int i = 0; i< m_HunterList.count; i++)
    {
        CCMyHunterSprite *pHunter = [m_HunterList objectAtIndex:i];
        if(m_BridSprite && pHunter && pHunter.visible && !pHunter.m_bDead)
        {
            CGRect BridRect = [m_BridSprite textureRect];
            BridRect.origin.x = m_BridSprite.position.x - BridRect.size.width /2;
            BridRect.origin.y = m_BridSprite.position.y - BridRect.size.height /2;
            
            CGRect HunterRect = [pHunter textureRect];
            HunterRect.origin.x = pHunter.position.x - HunterRect.size.width /2;
            HunterRect.origin.y = pHunter.position.y;
            
            if(CGRectIntersectsRect(BridRect, HunterRect))
            {
                if(m_BridSprite.m_nBridState != BRID_STATE_CATCHED)
                {
                    MusicMannger* pMusicMgr = [MusicMannger sharedMusicMannger];
                    if(pMusicMgr)
                    {
                        [pMusicMgr PlayEffect:@"Fight.mp3"];
                    }
                    m_BridSprite.m_nBridState = BRID_STATE_CATCHED;
                    [m_BridSprite stopAllActions];
                    id BridAction = [[AnimationDelegate shareAnimationDelegate] BridCatched:self Function:@selector(ConturnBridAction:)];
                    [m_BridSprite runAction:BridAction];
                    m_bCatchOrEnd = true;
                    [self BridCatchRoEnd];
//                    m_bGameStop = true;
//                    [self GameOver];
                    NSLog(@"is touch"); 
                }  
            }
        }
    }
    //Add by zhengxf about "鸟碰撞到鹰的动画“ 2012-8-27 ------begin-------
    if(m_spHawk && m_spHawk.visible)
    {
        CGRect BridRect = [m_BridSprite textureRect];
        BridRect.origin.x = m_BridSprite.position.x - BridRect.size.width /2;
        BridRect.origin.y = m_BridSprite.position.y - BridRect.size.height /2;
        BridRect.size.height -= 10;
        
        CGRect HunterRect = [m_spHawk textureRect];
        HunterRect.origin.x = m_spHawk.position.x - HunterRect.size.width /2;
        HunterRect.origin.y = m_spHawk.position.y;
        HunterRect.size.height -= 20;
        
        if(CGRectIntersectsRect(BridRect, HunterRect))
        {
            if(m_BridSprite.m_nBridState != BRID_STATE_CATCHED)
            {
                m_spHawk.visible = false;
                MusicMannger* pMusicMgr = [MusicMannger sharedMusicMannger];
                if(pMusicMgr)
                {
                    [pMusicMgr PlayEffect:@"Fight.mp3"];
                }
                m_BridSprite.m_nBridState = BRID_STATE_CATCHED;
                [m_BridSprite stopAllActions];
                id BridAction = [[AnimationDelegate shareAnimationDelegate] BridCatched:self Function:@selector(ConturnBridAction:)];
                [m_BridSprite runAction:BridAction];
                m_bCatchOrEnd = true;
                [self BridCatchRoEnd];
                //m_bGameStop = true;
                //[self GameOver];
                NSLog(@"is touch"); 
            }  
        }
    }
    //Add by zhengxf about "鸟碰撞到鹰的动画“ 2012-8-27 ------end-------
    return bTouch;
}
//Add by zhengxf about "时间更新函数" 2012-7-3 ------begin------
- (void)onTimer
{
    if(m_bGameOver)
    {
        m_Index ++;
        float nScale = 4 - m_Index*0.1;
        if(m_pTest && m_pTest.scale > 1 && nScale >= 1.0)//
        {
            m_pTest.scale = nScale;
            float nOffset = 1- m_pTest.scale;
            if(m_bSuccess)
            {
                m_pTest.position = ccp(421 * nOffset, 162 * nOffset);
            }
            else 
            {
                m_pTest.position = ccp(160 * nOffset, 57 * nOffset);
            }
        }
        else 
        {
            m_pTest.scale = 1;
            m_pTest.position = ccp(0, 0);
            [m_ShitList removeAllObjects];
            [m_HunterList removeAllObjects];
            m_HunterList = nil;
            m_ShitList = nil;
            m_BridSprite = nil;
            [self removeAllChildrenWithCleanup:YES];
            
            //Add by zhengxf about "清理缓存的功能" 2012-9-13 -------begin--------
            [[CCTextureCache sharedTextureCache ] removeUnusedTextures];
            //[[CCSpriteFrameCache sharedSpriteFrameCache] removeUnusedSpriteFrames];
            //Add by zhengxf about "清理缓存的功能" 2012-9-13 -------end--------
            
            m_pTest = nil;
            //播放旋转进入屏幕的动画
            m_pPaperf = [CCSprite spriteWithFile:@"GameOver_Second.png"];
            m_pPaperf.position = ccp(120, 120);
            //m_pPaperf.scale = 0.5;
            [self addChild:m_pPaperf];
            //Add by zhengxf about "报纸飞出的动画" 2012-9-6   -------begin----------
            MusicMannger* pMusicMgr = [MusicMannger sharedMusicMannger];
            if(pMusicMgr)
            {
                [pMusicMgr PlayEffect:@"PaperFly.mp3"];
            }
            //Add by zhengxf about "报纸飞出的动画" 2012-9-6   -------end----------
            id Action = [[AnimationDelegate shareAnimationDelegate] GameOverMask:self Function:@selector(MaskGameOver:)];
            [m_pPaperf runAction:Action];
            m_bGameOver = false;
        }
    }
    if(!m_bGameStop && !m_bPauseGame)
    {
        if(m_bAddHole)
        {
            [self MoveTreeHole];
        }
        [self HawkSystem];
        [self MoveMap];
        [self MoveHunter];
        [self MoveBean];
        [self ComputerScore];
    }
}

-(void) ComputerScore
{
    if(m_nNowLevelLen >= m_nLevelLen)
    {
        m_bSuccess = true;
        m_bCatchOrEnd = true;
        //开启下一关
        NSString* pKey = [NSString stringWithFormat:@"%@_%d_%d",LEVEL_LOCK, m_nBigLevel, m_nSmallLevel];
        [[DefaultFile sharedDefaultFile] SetBoolForKey:true ForKey:pKey];
        
        //Add by zhengxf "计算游戏的分数" 2012-8-9 ------begin-------
       // int nStar = 0;
        int nLeveScore = LevelAllScore[(m_nBigLevel-1) *10 + m_nSmallLevel-1];
        float nScore = (float)m_nLeveScore/(float)nLeveScore;
        if(nScore >= 0.8)
        {
            m_nStar = 3;
        }
        else if(nScore >= 0.50)
        {
            m_nStar = 2;
        }
        else if(nScore >= 0.20)
        {
            m_nStar = 1;
        }
        
        if(m_nStar > m_nOldStar)
        {
            NSString* pKey = [NSString stringWithFormat:@"%@_%d_%d",LEVEL_STAR, m_nBigLevel, m_nSmallLevel];
            [[DefaultFile sharedDefaultFile] SetIntegerForKey:m_nStar ForKey:pKey];
        }
        //根据星星数加豆子
        if(m_nStar == 3)
        {
            m_nBeanCount += 20;
        }
        else if(m_nStar == 2)
        {
            m_nBeanCount += 10;
        }
        else if(m_nStar == 1)
        {
            m_nBeanCount += 5;
        }
        [[DefaultFile sharedDefaultFile] SetIntegerForKey:m_nBeanCount ForKey:ALL_BEAN_COUNT];
        //m_bCatchOrEnd = true;
        m_bGameStop = true;
        [self BridInHoleing];
        //[self GameOver];
        //Add by zhengxf "计算游戏的分数" 2012-8-9 ------end-------
    }
    else if(m_nLevelLen - m_nNowLevelLen == 320 && !m_bAddHole)
    {
        m_bAddHole = true;
        m_spTree.visible = true;
        m_spSmallTree.visible = true;
        m_spHole.visible = true;
        //[self InitTreeHole];
    }
}

//Add by zhengxf about "龙便便打击效果" 2012-8-28 --------begin--------
-(void) DragonFight
{
    if(m_bFrieDragon)
    {
        if(m_spDragonFrie && m_spDragonFrie.visible)
        {
            for(int i = 0; i< m_HunterList.count; i++)
            {
                CCMyHunterSprite *pHunter = [m_HunterList objectAtIndex:i];
                if(pHunter && pHunter.visible  &&  !pHunter.m_bDead)//&& 0 == pHunter.m_nType
                {
                    CGRect ShitRect = [m_spDragonFrie textureRect];
                    ShitRect.origin.x = m_spDragonFrie.position.x - ShitRect.size.width /2;
                    ShitRect.origin.y = m_spDragonFrie.position.y - ShitRect.size.height /2;
                    
                    CGRect HunterRect = [pHunter textureRect];
                    HunterRect.origin.x = pHunter.position.x - HunterRect.size.width /2;
                    HunterRect.origin.y = pHunter.position.y;
                    
                    if(m_spDragonFrie.visible  && CGRectIntersectsRect(ShitRect, HunterRect))
                    {
                        pHunter.m_bDead = YES;
                        m_nLeveScore += HunterScore[pHunter.m_nType]; //打死敌人加分
                        [self ShowScore:m_nLeveScore :m_pScorePoint :2 :false];
                        //Add by zhengxf about "人死亡的动画"2012-7-16 --------begin--------
                        if(pHunter.m_nHunterState != HUNTER_STATE_DEAD)
                        {
                            pHunter.m_nHunterState =  HUNTER_STATE_DEAD;
                            pHunter.m_nDeadType = HUNTER_DEAD_FIRE;
                            
                            [pHunter stopAllActions];
                            
                            //Add by zhengxf about "人物死的类型" 2012-7-17 ------begin-------
                            id pHunterAction = nil;
                            switch (pHunter.m_nType) 
                            {
                                case 1:
                                    //人2死亡的动画
                                    pHunter.scale = 1.1;
                                    break;
                                case 2:
                                    //人4死亡的动画
                                    pHunter.scale = 1.2;
                                    break;
                                case 3:
                                    //人4死亡的动画
                                    pHunter.scale = 1.3;
                                    break;
                                default:
                                    break;
                            }
                            //Add by zhengxf about "人物被烧的动画" 2012-9-5 -----begin-----
                            MusicMannger* pMusicMgr = [MusicMannger sharedMusicMannger];
                            if(pMusicMgr)
                            {
                                [pMusicMgr PlayEffect:@"HunterBurn.mp3"];
                            }
                            //Add by zhengxf about "人物被烧的动画" 2012-9-5 -----end-----
                            pHunter.position = ccpAdd(pHunter.position, ccp(0, 30));
                            pHunterAction = [[AnimationDelegate shareAnimationDelegate] HunterBurn1:self Function:@selector(ConturnHunterAction:)];
                            [pHunter runAction:pHunterAction];
                            
//                            id BurnMove = [[AnimationDelegate shareAnimationDelegate] HunterBurn1Move];
//                            [pHunter runAction:BurnMove];
                        }
                        //Add by zhengxf about "小鸟击中目标的动画" 2012-7-12  ---------begin---------
                        if(m_BridSprite.m_nBridState != BRID_STATE_CATCHED && m_BridSprite.m_nBridState != BRID_STATE_HUNT1 && m_BridSprite.m_nBridState !=  BRID_STATE_LIGHTNING)
                        {
                            m_BridSprite.m_nBridState = BRID_STATE_HUNT1;
                            [m_BridSprite stopAllActions];
                            //鸟落地的动画
                            id pBridAction = [[AnimationDelegate shareAnimationDelegate]  BridHit1Anima:self Function:@selector(ConturnBridAction:)];
                            [m_BridSprite runAction:pBridAction];
                            MusicMannger* pMusicMgr = [MusicMannger sharedMusicMannger];
                            if(pMusicMgr)
                            {
                                [pMusicMgr PlayEffect:@"BridSmile.mp3"];
                            }
                        }
                        //Add by zhengxf about "小鸟击中目标的动画" 2012-7-12  ---------end---------
                    }
                }
            }
        }
    }
}
//Add by zhengxf about "龙便便打击效果" 2012-8-28 --------end--------

- (void)onBridTimer
{
    if(!m_bGameStop && !m_bPauseGame)
    {
        [self MoveBrid];
    }
}

- (void) OnFightTimer
{
    if(!m_bGameStop && !m_bPauseGame)
    {
        [self DragonFight];
    }
}

- (void) StopGame:(id) sender
{
    if(!m_bPauseGame)
    {
        //Add by zhengxf about "豆子数写入文件" 2012-9-13  -----begin-------
        [[DefaultFile sharedDefaultFile] SetIntegerForKey:m_nBeanCount ForKey:ALL_BEAN_COUNT];
        //Add by zhengxf about "豆子数写入文件" 2012-9-13  -----end-------
        
        CCActionManager* pActionManager =  [[CCDirector sharedDirector] actionManager];
        [pActionManager pauseTarget:m_BridSprite];
        PauseGame* GameLayer = [PauseGame node];
        GameLayer.position = ccp(240, 160);
        [GameLayer SetConturnBut:self :@selector(GameContrun:)];
        [GameLayer SetScore:m_nBigLevel :m_nSmallLevel];
        [self addChild:GameLayer z:4 tag: PAUSE_LAYER_INDEX];
        m_bAllowTouch = true;
        m_bPauseGame = true;
        [self PauseGameHunter: true];
    }
}

//暂停游戏中的猎人动画
-(void) PauseGameHunter:(bool) bPause
{
    CCActionManager* pActionManager =  [[CCDirector sharedDirector] actionManager];
    for(int n=0; n<m_HunterList.count; n++)
    {
        CCMyHunterSprite *Hunter = [m_HunterList objectAtIndex:n];
        if(Hunter && Hunter.position.x >= 0 && Hunter.position.x <= 480)
        {
            if(bPause)
            {
                [pActionManager pauseTarget:Hunter];
            }
            else 
            {
                [pActionManager resumeTarget:Hunter];
            }
        }
    }
}

//暂停回来，游戏继续开始
- (void) GameContrun:(id) sender
{
    m_bPauseGame = false;
    CCActionManager* pActionManager =  [[CCDirector sharedDirector] actionManager];
    [pActionManager resumeTarget:m_BridSprite];
    [self PauseGameHunter:false];
    [self removeChildByTag:PAUSE_LAYER_INDEX cleanup:YES];
}

-(int) PlayHunterAction:(bool)bConturn
{
    int nHunterCount = 0;
    for(int n=0; n<m_HunterList.count; n++)
    {
        CCMyHunterSprite *Hunter = [m_HunterList objectAtIndex:n];
        if(Hunter && Hunter.position.x >= 0 && Hunter.position.x <= 480)
        {
            if((!Hunter.visible || bConturn) && !Hunter.m_bDead)
            {
                Hunter.visible = YES;
                Hunter.m_bActionRun = YES;
                id HunterAction = nil;
                id HunterAction1 = nil;
                nHunterCount++;
                switch (Hunter.m_nType) 
                {
                    case 0:
                        HunterAction = [[AnimationDelegate shareAnimationDelegate] HunterRunAnima];
                        [Hunter runAction:HunterAction];
                        break;
                    case 1: 
                        HunterAction = [[AnimationDelegate shareAnimationDelegate] Hunter2Run];
                        [Hunter runAction:HunterAction];
                        break;
                    case 2: 
                        HunterAction = [[AnimationDelegate shareAnimationDelegate] Hunter3Run];
                        [Hunter runAction:HunterAction];
                        break;
                    case 3: 
                        HunterAction = [[AnimationDelegate shareAnimationDelegate] Hunter4Run];
                        [Hunter runAction:HunterAction];
                        break;
                }
                
                HunterAction1 = [[AnimationDelegate shareAnimationDelegate] HunterMove:self Function:@selector(MoveRight:) Function2:@selector(MoveLeft:)];
                [Hunter runAction:HunterAction1];
            }
            else if(Hunter.visible && !Hunter.m_bDead)//Hunter.m_nType == 0 && 
            {
                //人物有跳起的动画
                if(Hunter.m_nActionIndex == 1 && Hunter.position.x < 240)
                {
                    Hunter.m_nActionIndex = 0;
                    [Hunter stopAllActions];
                    Hunter.m_nHunterState = HUNTER_STATE_JUMP;
                    //Add by zhengxf about "人物跳起的动画，各种人物" 2012-8-20 -------begin----------
                    id HunterAction1  = nil;
                    switch (Hunter.m_nType) {
                        case 0:
                            HunterAction1 = [[AnimationDelegate shareAnimationDelegate] HunterJump:self Function:@selector(ConturnHunterAction:)];
                            [Hunter runAction:HunterAction1];
                            break;
                        case 1:
                            HunterAction1 = [[AnimationDelegate shareAnimationDelegate] Hunter2Jump:self Function:@selector(ConturnHunterAction:)];
                            [Hunter runAction:HunterAction1];
                            break;
                        case 2:
                            HunterAction1 = [[AnimationDelegate shareAnimationDelegate] Hunter3Jump:self Function:@selector(ConturnHunterAction:)];
                            [Hunter runAction:HunterAction1];
                            break;
                        case 3:
                            HunterAction1 = [[AnimationDelegate shareAnimationDelegate] Hunter4Jump:self Function:@selector(ConturnHunterAction:)];
                            [Hunter runAction:HunterAction1];
                            break;
                        default:
                            break;
                    }
                    //Add by zhengxf about "人物跳起的动画，各种人物" 2012-8-20 -------end----------
                }
                nHunterCount++;
            }
            else if((Hunter.visible && Hunter.m_bDead ) && bConturn) //人物已经死亡，且在画面中，继续游戏的画面
            {
                if(Hunter.m_nDeadType == HUNTER_DEAD_FIRE || Hunter.m_nDeadType == HUNTER_DEAD_FLIGHT)
                {
                    if(Hunter.m_nDeadType == HUNTER_DEAD_FIRE )
                    {
                        Hunter.m_nDeadType = HUNTER_DEAD_FIRE;
                        Hunter.position = ccpAdd(Hunter.position, ccp(0, 100));
                        id pHunterAction = [[AnimationDelegate shareAnimationDelegate] HunterBurn1:self Function:@selector(ConturnHunterAction:)];
                        [Hunter runAction:pHunterAction];
                        
//                        id BurnMove = [[AnimationDelegate shareAnimationDelegate] HunterBurn1Move];
//                        [Hunter runAction:BurnMove];
                    }
                    else if(Hunter.m_nDeadType == HUNTER_DEAD_FLIGHT)
                    {
                        Hunter.m_nDeadType = HUNTER_DEAD_FLIGHT;
                        id pHunterAction = [[AnimationDelegate shareAnimationDelegate] HunterFlight:self Function:@selector(ConturnHunterAction:)];
                        [Hunter runAction:pHunterAction];
                    }
                }
            }
        }
        else 
        {
            Hunter.visible = NO;
            Hunter.m_bActionRun = NO;
            [Hunter stopAllActions];
            if(Hunter.position.x < 0)
            {
                [self removeChild:Hunter cleanup:YES];
            }
        }
        Hunter.position = ccpAdd(Hunter.position, ccp(-0.5 * FORWARD_MOVE_RATIO, 0));
    }
    return  nHunterCount;
}

#pragma mark  --动画回调函数

-(void)MaskScale:(CCNode *)node
{
    
}

-(void)BridIsDowning:(CCNode *)node
{
    m_bGameStop = true;
    [self GameOver];
}

-(void)ConturnBridAction:(CCNode *)node 
{
    if(m_BridSprite.m_nBridState == BRID_STATE_LIGHTNING || m_BridSprite.m_nBridState == BRID_STATE_CATCHED)
    {
//        [self BridCatchRoEnd];
//        m_bCatchOrEnd =  true;
    }
    else 
    {
        m_BridSprite.m_nBridState = BRID_STATE_NOMAL;
        CCAction* pBridAction = [[AnimationDelegate shareAnimationDelegate] BridFlyAnima];
        [m_BridSprite runAction:pBridAction];
    }

}

-(void)MaskGameOver:(CCNode *)node
{
    GameOver* GameLayer = [GameOver node];
    GameLayer.anchorPoint = ccp(0, 0);
    GameLayer.position = ccp(0, 0);
//    NSString* pKey = [NSString stringWithFormat:@"%@_%d_%d",LEVEL_STAR, m_nBigLevel, m_nSmallLevel];
//    int nStar = [[DefaultFile sharedDefaultFile] GetIntegerForKey:pKey];
    [GameLayer SetScore:m_nStar :m_nLeveScore :m_nBeanCount :m_nEatBeanCount :m_bSuccess];
    [self addChild:GameLayer];
    m_bAllowTouch = true;
}

-(void)ConturnHunterAction:(CCNode*)node
{
    CCMyHunterSprite* pHunter = (CCMyHunterSprite*)node;
    if(pHunter)
    {
        id  HunterAction = nil;
        switch (pHunter.m_nHunterState) 
        {
            case HUNTER_STATE_JUMP:
            case HUNTER_STATE_BRUISE:
                    pHunter.m_nHunterState = HUNTER_STATE_NOMAL;
                    switch (pHunter.m_nType)
                    {
                        case 0:
                            HunterAction = [[AnimationDelegate shareAnimationDelegate] HunterRunAnima];
                            [pHunter runAction:HunterAction];
                            break;
                        case 1:
                            HunterAction = [[AnimationDelegate shareAnimationDelegate] Hunter2Run];
                            [pHunter runAction:HunterAction];
                            break;   
                        default:
                            break;
                    }
                id   HunterAction1 = [[AnimationDelegate shareAnimationDelegate] HunterMove:self Function:@selector(MoveRight:) Function2:@selector(MoveLeft:)];
                [pHunter runAction:HunterAction1];
                break;
            case HUNTER_STATE_DEAD:
                //pHunter.visible = false;
                ;
                break; 
            default:
                break;
        }
    }
}

-(void)MoveRight:(CCNode *)node
{
    CCMyHunterSprite* pTem = (CCMyHunterSprite*)node;
    [pTem setFlipX:true];
}

-(void)MoveLeft:(CCNode *)node
{
    CCMyHunterSprite* pTem = (CCMyHunterSprite*)node;
    [pTem setFlipX:false];
}

//Add by zhengxf "游戏结束"
-(void)GameOver
{
    m_bGameOver = true;
    m_bAllowTouch = false;
    //Add by zhengxf about "游戏关卡结束图片" 2012-8-15 -------begin--------
    if(m_bSuccess)
    {
        m_pTest = [CCSprite spriteWithFile:@"GameStopSBk.png"];
        m_pTest.anchorPoint = ccp(0, 0);
        m_pTest.position = ccp(0, 0);
        m_pTest.scale = 4;
        float nOffset = 1- m_pTest.scale;
        m_pTest.position = ccp(421 * nOffset, 162 * nOffset);
    }
    else 
    {
        m_pTest = [CCSprite spriteWithFile:@"GameStopBk.png"];
        m_pTest.anchorPoint = ccp(0, 0);
        m_pTest.position = ccp(0, 0);
        m_pTest.scale = 5;
        float nOffset = 1- m_pTest.scale;
        m_pTest.position = ccp(160 * nOffset, 57 * nOffset);
    }
    [self addChild:m_pTest z:3 tag:0];
    if(m_bSuccess)
    {
        MusicMannger* pMusicMgr = [MusicMannger sharedMusicMannger];
        if(pMusicMgr)
        {
            [pMusicMgr PlayEffect:@"Win.mp3"];
        }
    }
    else 
    {
        MusicMannger* pMusicMgr = [MusicMannger sharedMusicMannger];
        if(pMusicMgr)
        {
            [pMusicMgr PlayEffect:@"Fail.mp3"];
        }
    }
    //Add by zhengxf about "游戏结束的功能" 2012-8-15 ---------begin--------
    
    //Add by zhengxf about "游戏结束的功能" 2012-8-15 ---------end----------
    
//    [self removeAllChildrenWithCleanup:YES];
//    GameOver* GameLayer = [GameOver node];
//    GameLayer.anchorPoint = ccp(0, 0);
//    GameLayer.position = ccp(0, 0);
//    [self addChild:GameLayer];
    
    //Add by zhengxf about "游戏关卡结束图片" 2012-8-15 -------end--------
}

//显示游戏分数
-(void) ShowScore:(int)score :(CGPoint) pt :(int)nType :(int) bAdd;
{
    //Add by zhengxf about "移处原来的数据" 2012-8-22 ------begin-------
    int nCount = 0;
    switch (nType) {
        case 1:
            nCount = [m_BeanList count];
            if(nCount >0)
            {
                for(int i=0; i< nCount; i++)
                {
                    CCSprite* sp = (CCSprite*)[m_BeanList objectAtIndex:i];
                    if(sp)
                    {
                        sp.visible = false;
                        [self removeChild:sp cleanup:YES];
                    }
                }
                [m_BeanList removeAllObjects];
            }
            break;
        case 2:
            nCount = [m_ScoreList count];
            if(nCount >0)
            {
                for(int i=0; i< nCount; i++)
                {
                    CCSprite* sp = (CCSprite*)[m_ScoreList objectAtIndex:i];
                    if(sp)
                    {
                        sp.visible = false;
                        [self removeChild:sp cleanup:YES];
                    }
                }
                [m_ScoreList removeAllObjects];
            }
            break;
        default:
            break;
    }
    //Add by zhengxf about "移处原来的数据" 2012-8-22 ------end-------
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
                strName =  [NSString stringWithFormat:@"Big_Number_%d.png", nNumber];
                sp = [CCSprite spriteWithFile:strName];
                sp.position = ccp(pt.x + 14 * idx, pt.y);
                sp.scale = 0.6;
                //Add by zhengxf about "加入豆子变色的动画" 2012-9-13 ---------begin---------
                if(1 == bAdd) //分数增加
                {
                    id  ac = [[AnimationDelegate shareAnimationDelegate] ColorBy:255 green:0 blue:255];
                    [sp runAction:ac];
                }
                else if(2 == bAdd) //分数减少
                {
                    id  ac = [[AnimationDelegate shareAnimationDelegate] ColorBy:0 green:250 blue:100];
                    [sp runAction:ac]; 
                }
                //Add by zhengxf about "加入豆子变色的动画" 2012-9-13 ---------end---------
                [m_BeanList addObject:sp];
                break;
            case 2:
                strName =  [NSString stringWithFormat:@"Score_Number_%d.png", nNumber];
                sp = [CCSprite spriteWithFile:strName];
                sp.position = ccp(pt.x + 15 * idx, pt.y);
                [m_ScoreList addObject:sp];
                break;
            default:
                break;
        }
        [self addChild:sp z:1 tag:0];
    }
}

-(void) BridInHoleing
{
    //Add by zhengxf about "树洞粒子效果" 2012-9-5 -------begin-------
    //Add by zhengxf "测试粒子效果" 2012-7-10 --------begin-------
    CCParticleSystem* particle = [CCParticleSystemQuad particleWithFile:@"TestFrie.plist"];
    particle.positionType = kCCPositionTypeFree; 
    particle.position = ccp(440,155);
    [self addChild:particle z:0];
    //Add by zhengxf "测试粒子效果" 2012-7-10 --------end-------
    //Add by zhengxf about "树洞粒子效果" 2012-9-5 -------end-------
    id BridAction = [[AnimationDelegate shareAnimationDelegate] BridInHole:self Function:@selector(BridIsDowning:)];
    [m_BridSprite runAction:BridAction];
}

//Add by zhengxf about "小鸟被抓住掉地上的实现“ 2012-8-24 -------begin------
-(void)BridCatchRoEnd
{
    //[m_BridSprite stopAllActions];
    //Add by zhengxf about "失败改变豆子数" 2012-9-10 ------begin----------
    [[DefaultFile sharedDefaultFile] SetIntegerForKey:m_nBeanCount ForKey:ALL_BEAN_COUNT];
    //Add by zhengxf about "失败改变豆子数" 2012-9-10 ------end----------
    
    id BridAction = [[AnimationDelegate shareAnimationDelegate] BridDown:self Function:@selector(BridIsDowning:)];
    [m_BridSprite runAction:BridAction];
}
//Add by zhengxf about "小鸟被抓住掉地上的实现“ 2012-8-24 -------end------

//Add by zhengxf about "加入随机系统" 2012-8-27 -------begin--------
-(void) HawkSystem;
{
    if(m_bRandSystem && !m_bStartHawk)
    {
        m_bRandSystem = false;
        m_bStartHawk = true;
        m_spSigh = [CCSprite spriteWithFile:@"GameOver_Bean.png"];
        m_spSigh.position = ccp(440, m_BridSprite.position.y);
        [self addChild:m_spSigh z:2 tag:0];
        id SighAction = [[AnimationDelegate shareAnimationDelegate] SighNomal];
        [m_spSigh runAction:SighAction];
    }
    if(m_bStartHawk && !m_bHawk) //开始
    {
        if(m_nUseTime <= 2)
        {
            m_nUseTime += 0.01;
            m_spSigh.position = ccp(440, m_BridSprite.position.y);
            //改变感叹号的位置
        }
        else 
        {
            m_bHawk = true;
            //显示感叹号闪烁动画
            id SighAction = [[AnimationDelegate shareAnimationDelegate] SighFlight:self Function:@selector(SighFlight:)];
            [m_spSigh runAction:SighAction];
        }
    }
}

-(void)SighFlight:(CCNode *)node
{
    //鹰的图片
    m_spHawk = [CCSprite spriteWithFile:@"GameOver_Bean.png"];
    m_spHawk.position = ccp(520, m_spSigh.position.y);
    [self addChild:m_spHawk z:2 tag:0];
    [self removeChild:m_spSigh cleanup:YES];
    id HawkAction = [[AnimationDelegate shareAnimationDelegate] HawkFlyAnima];
    [m_spHawk runAction:HawkAction];
    
    //add by zhengxf about "鹰鸣声音的播放" 2012-9-5 -------begin-------
    MusicMannger* pMusicMgr = [MusicMannger sharedMusicMannger];
    if(pMusicMgr)
    {
        [pMusicMgr PlayEffect:@"HawkSing.mp3"];
    }
    //add by zhengxf about "鹰鸣声音的播放" 2012-9-5 -------end-------
    
    [m_spHawk runAction:[CCSequence actions:
                           [CCMoveBy actionWithDuration:0.9 position:ccp(-520, 0)],
                           [CCCallFuncN actionWithTarget:self selector:@selector(HawkMove:)],
                           nil]];
}

-(void)HawkMove:(CCNode *)node
{
    m_bStartHawk = false;
    m_nUseTime = 0;
    m_bHawk = false;
    [self removeChild:m_spHawk cleanup:YES];
    m_spHawk =  nil;
}
//Add by zhengxf about "加入随机系统" 2012-8-27 -------end----------

//Add by zhengxf about "新手引导功能" 2012-8-31 -------begin-----
-(void)InitHelpSys
{
    m_nHelpIndex = 0;
    
    bool bHelp1 = [[DefaultFile sharedDefaultFile] GetBoolForKey:IS_FRIST_LEVEL1];
    bool bHelp3 = [[DefaultFile sharedDefaultFile] GetBoolForKey:IS_FRIST_LEVEL3];
    int nLevel = (m_nBigLevel-1)*10 + m_nSmallLevel;
    if(nLevel == 1 && !bHelp1)
    {
        m_bHelp = true;
        //加入图片
        m_spHelp1 = [CCSprite spriteWithFile:@"GameHelp1.png"];
        m_spHelp1.position = ccp(m_winSize.width*0.5, m_winSize.height * 0.5);
        [self addChild:m_spHelp1 z:5 tag:0];
        m_bGameStop = true;
    }
    else if(nLevel == 3 && !bHelp3)
    {
        m_bHelp3 = true;
        //加入图片
        m_spHelp3 = [CCSprite spriteWithFile:@"GameHelp3.png"];
        m_spHelp3.position = ccp(m_winSize.width*0.5, m_winSize.height * 0.5);
        [self addChild:m_spHelp3 z:5 tag:0];
        m_bGameStop = true;
    }
}

-(void) HelpUserSys
{
    //Add by zhengxf about "新手引导的功能" -----begin------
    if(m_bHelp)
    {
        if(m_nHelpIndex == 0)
        {
            [self removeChild:m_spHelp1 cleanup:YES];
            m_spHelp2 = [CCSprite spriteWithFile:@"GameHelp2.png"];
            m_spHelp2.position = ccp(m_winSize.width*0.5, m_winSize.height * 0.5);
            [self addChild:m_spHelp2 z:5 tag:0];
        }
        else if(m_nHelpIndex == 1)
        {
            [self removeChild:m_spHelp2 cleanup:YES];
            //[[DefaultFile sharedDefaultFile] SetBoolForKey:true ForKey:IS_FRIST_LEVEL1];
            m_nHelpIndex = 0;
            m_bHelp = false;
            m_bAllowTouch = true;
            m_bGameStop = false;
        }
        m_nHelpIndex++;
    }
    else if(m_bHelp3)
    {
        [self removeChild:m_spHelp3 cleanup:YES];
        //[[DefaultFile sharedDefaultFile] SetBoolForKey:true ForKey:IS_FRIST_LEVEL3];
        m_nHelpIndex = 0;
        m_bHelp3 = false;
        m_bAllowTouch = true;
        m_bGameStop = false;
    }
    //Add by zhengxf about "新手引导的功能" -----end------
}
//Add by zhengxf about "新手引导功能" 2012-8-31 -------end-----


-(void)setShitOpen
{
    int nIndex = (m_nBigLevel-1) * 10 + m_nSmallLevel;
    if(nIndex < 3)
    {
        m_ShitOpenIndex = 0;
    }
    else if(nIndex >= 3 && nIndex <6)
    {
        m_ShitOpenIndex = 1;
    }
    else if(nIndex >= 6 && nIndex <8)
    {
        m_ShitOpenIndex = 2;
    }
    else if(nIndex >= 8)
    {
        m_ShitOpenIndex = 3;
    }
}

@end

//游戏主场景
@implementation MainGameScence
+(id) ShowScene
{
    MainGameScence *scene = [MainGameScence node];
    return scene;
}

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) 
	{
		MainGameLayer* GameLayer = [MainGameLayer node];
		[self addChild:GameLayer];
	}
	return self;
}

@end
