//
//  SelectLevelScene.m
//  DoodieBird
//
//  Created by LuckyLee on 26-04-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SelectLevelScene.h"
#import "SenceManager.h"
#import "StarButton.h"
#import "LevelManager.h"
#import "DefaultFile.h"
#import "def.h"

@implementation SelectLevelLayer

- (id) init
{
	self = [super init];
	if (self)
	{
        //大关的数据
        m_nBigLevel = [[LevelManager sharedLevelMannger] GetBigLevel];
        
        CCSprite *sp = nil;
        int nBigLevel = [[LevelManager sharedLevelMannger] GetBigLevel];
        switch (nBigLevel) {
            case 1:
                sp = [CCSprite spriteWithFile:@"LevelSenceBk1.png"];
                break;
            case 2:
                sp = [CCSprite spriteWithFile:@"LevelSenceBk2.png"];
                break;
            case 3:
                sp = [CCSprite spriteWithFile:@"LevelSenceBk3.png"];
                break;
                
            default:
                break;
        }
		sp.anchorPoint = CGPointZero;
		[self addChild:sp z:0 tag:1];
        
         m_winSize = [CCDirector sharedDirector].winSize;
        
        CCSprite* spSelectChapter = [CCSprite spriteWithFile:@"SelectCommon.png"];
        spSelectChapter.position = ccp(m_winSize.width/2 , m_winSize.height - 60);
        [self addChild:spSelectChapter];
        
        CCSprite* spSelectTitle = [CCSprite spriteWithFile:@"SelectLeveTitle.png"];
        spSelectTitle.position = ccp(spSelectChapter.position.x, spSelectChapter.position.y);
        [self addChild:spSelectTitle];
        
        //Add by zhengxf about "加入选关的概念" 2012-8-1 --------begin------- 
        for(int i=0; i< 10; i++)
        {
            CGPoint pt;
            if(i < 5)
            {
                pt.x = 100 + i* 75;
                pt.y =180;
            }
            else 
            {
                pt.x = 100 + (i - 5) * 75;
                pt.y =180 - 70;
            }
            StarButton* BtFrist = [StarButton node];
            
            [BtFrist SetTarget:self :@selector(newGame:)];
            int nBigLevel = [[LevelManager sharedLevelMannger] GetBigLevel];
           // int nLevel = [[LevelManager sharedLevelMannger] GetLevel];
            NSString* pKey = [NSString stringWithFormat:@"%@_%d_%d",LEVEL_STAR, nBigLevel, i+1];
            int nStar = [[DefaultFile sharedDefaultFile] GetIntegerForKey:pKey];
            
            pKey = [NSString stringWithFormat:@"%@_%d_%d",LEVEL_LOCK, nBigLevel, i+1];
            bool bLock = [[DefaultFile sharedDefaultFile] GetBoolForKey:pKey];
            if(nStar > 0 || ((m_nBigLevel == 1 || m_nBigLevel == 2|| m_nBigLevel == 3) && i == 0))
            {
                bLock = true;
            }
            if(bLock)
            {
                [BtFrist ShowScore:i+1 :pt];
            }
            [BtFrist SetVeg:pt :1 :nStar :!bLock :true :@"LevelNomal.png" :@"LevelSel.png"];
            //[BtFrist ShowScore:i+1 :pt];
            //[BtFrist SetVeg:pt :1 :nStar :false :true :@"LevelNomal.png" :@"LevelSel.png"];
            [self addChild:BtFrist z:0 tag:LEVEL_ITEM_INDEX + i];
        }
        //Add by zhengxf about "加入选关的概念" 2012-8-1 --------end------- 
    
        //返回－－－－begin-----------
		CCSprite *ReturnNormal = [CCSprite spriteWithFile:@"ReturnNoml.png"];
		CCSprite *ReturnSelected = [CCSprite spriteWithFile:@"ReturnSel.png"];
		CCMenuItemSprite *ReturnCook = [CCMenuItemSprite itemWithNormalSprite:ReturnNormal selectedSprite:ReturnSelected target:self selector:@selector(Return:)];
        ReturnCook.tag = 100;
		CCMenu *menuReturn = [CCMenu menuWithItems: ReturnCook, nil];
		[menuReturn setPosition:ccp(40,20)];
		[self addChild: menuReturn z:1 tag:GAME_RETURN];
		//返回 －－－－end-----------
    }
    return  self;
}

-(void) Return:(id) sender
{
    SenceManager* SManager = [SenceManager sharedSenceManager];
    if(SManager)
    {
        [SManager ShowSelectChapterScene];
    }
}

-(void) newGame:(id) sender
{
    CCMenuItemSprite* pNode = (CCMenuItemSprite*)sender;
    int nTag  = [pNode tag];
    [[LevelManager sharedLevelMannger] SetLevel:nTag];
    SenceManager* SManager = [SenceManager sharedSenceManager];
    if(SManager)
    {
        [SManager ShowGameSence];
    } 
}

@end

@implementation SelectLevelScene


+(id) ShowScene
{
    // 'scene' is an autorelease object.
	CCScene *scene = [SelectLevelLayer node];
	// return the scene
	return scene;
}

-(id) init
{
	if( (self=[super init] )) 
	{
		SelectLevelLayer* mBk = [SelectLevelLayer node];
		[self addChild:mBk];
	}
	return self;
}

@end
