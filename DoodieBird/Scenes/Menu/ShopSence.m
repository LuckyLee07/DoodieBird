
//
//  ShopSence.m
//  DoodieBird
//
//  Created by LuckyLee on 26-04-22.
//  Copyright (c) 2026年 FancyGame. All rights reserved.
//

#import "ShopSence.h"
#import "SenceManager.h"
#import "AnimationDelegate.h"
#import "def.h"
#import "../../Gameplay/Shared/LayoutHelper.h"

@implementation ShopLayer

- (id) init
{
	self = [super init];
	if (self)
	{
        CGSize winSize = [CCDirector sharedDirector].winSize;
        CCSprite *sp = [CCSprite spriteWithFile:DBWideAssetName(@"ShopBk.png", winSize)];
        DBLayoutCoverSprite(sp, winSize);
		[self addChild:sp z:0 tag:1];
        
        
        CCSprite *pShopSprite = [CCSprite spriteWithFile:@"Brid.png"];
        pShopSprite.position = ccp(400, 95);
        id ShopBridAction = [[AnimationDelegate shareAnimationDelegate] BridSleep];
        [pShopSprite runAction:ShopBridAction];
        [self addChild:pShopSprite];
//        
//        //Add by zhengxf about "Free按钮" 2012-8-10  ------begin-------
        CCSprite *FreeNormal = [CCSprite spriteWithFile:@"FreeButNomal.png"];
		CCSprite *FreeSelected = [CCSprite spriteWithFile:@"FreeButSel.png"];
		CCMenuItemSprite *FreeCook = [CCMenuItemSprite itemWithNormalSprite:FreeNormal selectedSprite:FreeSelected target:self selector:@selector(FreeBut:)];
		CCMenu *menuFree = [CCMenu menuWithItems: FreeCook, nil];
		[menuFree setPosition:ccp(80,290)];
		[self addChild: menuFree z:1 tag:GAME_RETURN];
//        //Add by zhengxf about "Free按钮" 2012-8-10  ------end-------
//        
//        //Add by zhengxf about "加入按钮" 2012-8-10  ------begin-------
        CCSprite *BeanNormal = [CCSprite spriteWithFile:@"BeanButNomal.png"];
		CCSprite *BeanSelected = [CCSprite spriteWithFile:@"BeanButSel.png"];
		CCMenuItemSprite *BeanCook = [CCMenuItemSprite itemWithNormalSprite:BeanNormal selectedSprite:BeanSelected target:self selector:@selector(BuyBut:)];
		CCMenu *menuBean = [CCMenu menuWithItems: BeanCook, nil];
		[menuBean setPosition:ccp(155,290)];
		[self addChild: menuBean z:1 tag:GAME_RETURN];
//        //Add by zhengxf about "加入按钮" 2012-8-10  ------end-------
//        
//        //加入萤火虫
        CCSprite *FireFly = [CCSprite spriteWithFile:@"Firefly.png"];
        FireFly.position = ccp(420, 150);
        [self addChild:FireFly];
//        
        [self AddBuyIcon];
        [self  AddFreeIcon];
        [self FreeBut:nil];
//        
//        //返回－－－－begin-----------
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

- (void) Return:(id) sender
{
    SenceManager* SManager = [SenceManager sharedSenceManager];
	if(SManager)
	{
		[SManager ShowMainMenuSence];
    }
}

-(void) AddFreeIcon
{
    CCSprite *FreeIco0 = [CCSprite spriteWithFile:@"FreeIoc0.png"];
    FreeIco0.position = ccp(95, 232);
    FreeIco0.visible = false;
    [self addChild:FreeIco0 z:0 tag: FREE_ICON_INDEX + 0];
}

-(void) AddBuyIcon
{
    ////加入数据显示图标 ------begin----------
    CCSprite *ShopIco0 = [CCSprite spriteWithFile:@"ShopIoc0.png"];
    ShopIco0.position = ccp(95, 232);
    ShopIco0.visible = false;
    [self addChild:ShopIco0 z:0 tag: BUY_BUTTON_INDEX + 0];
    //        
    //        //1
    CCSprite *ShopIco1 = [CCSprite spriteWithFile:@"ShopIoc1.png"];
    ShopIco1.position = ccp(262, 232);
    ShopIco1.visible = false;
    [self addChild:ShopIco1 z:0 tag: BUY_BUTTON_INDEX + 1];
    //        
    //        //2
    CCSprite *ShopIco2 = [CCSprite spriteWithFile:@"ShopIoc2.png"];
    ShopIco2.position = ccp(95, 163);
    ShopIco2.visible = false;
    [self addChild:ShopIco2 z:0 tag: BUY_BUTTON_INDEX + 2];
    //        
    //        //3
    CCSprite *ShopIco3 = [CCSprite spriteWithFile:@"ShopIoc3.png"];
    ShopIco3.position = ccp(262, 163);
    ShopIco3.visible = false;
    [self addChild:ShopIco3 z:0 tag: BUY_BUTTON_INDEX + 3];
    //        
    //        //4
    CCSprite *ShopIco4 = [CCSprite spriteWithFile:@"ShopIoc4.png"];
    ShopIco4.position = ccp(95, 95);
    ShopIco4.visible = false;
    [self addChild:ShopIco4 z:0 tag: BUY_BUTTON_INDEX + 4];
    //        
    //        //5
    CCSprite *ShopIco5 = [CCSprite spriteWithFile:@"ShopIoc5.png"];
    ShopIco5.position = ccp(262, 95);
    ShopIco5.visible = false;
    [self addChild:ShopIco5 z:0 tag: BUY_BUTTON_INDEX + 5];
    //加入数据显示图标 ------end----------
}

- (void) FreeBut:(id) sender
{
    for(int i=0; i<=5; i++)
    {
        CCSprite * pIcon = (CCSprite *)[self getChildByTag: BUY_BUTTON_INDEX + i];
        pIcon.visible = false;
    }
    CCSprite * pFreeIcon = (CCSprite *)[self getChildByTag: FREE_ICON_INDEX + 0];
    pFreeIcon.visible = true;
}

-(void) BuyBut:(id) sender
{
    CCSprite * pFreeIcon = (CCSprite *)[self getChildByTag: FREE_ICON_INDEX + 0];
    pFreeIcon.visible = false;
    for(int i=0; i<=5; i++)
    {
        CCSprite * pIcon = (CCSprite *)[self getChildByTag: BUY_BUTTON_INDEX + i];
        pIcon.visible = true;
    }
}

@end

@implementation ShopSence

+(id) ShowScene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [ShopSence node];
	// return the scene
	return scene;
}

-(id) init
{
	if( (self=[super init] )) 
	{
		ShopLayer* mBk = [ShopLayer node];
		[self addChild:mBk];
	}
	return self;
}

@end
