//
//  StarButton.m
//  cookgirl
//
//  Created by LuckyLee on 26-04-22.
//  Copyright FancyGame 2026年. All rights reserved.
//

#import "MainItemButton.h"
#import "SenceManager.h"


@implementation MainItemButton

@synthesize m_nIndex;
@synthesize m_nScore;

- (id) init
{
	self = [super init];
	m_nIndex = 0;
    m_nScore = 0;
	m_idTarget = nil;
	m_selFunction = nil;
	m_bColor = false;
	m_bStep = false;
	if (self)
	{
		m_VegetableSel = nil;
		m_VegetableBan = nil;
	}
	return self;
}

-(void) ShowScore:(int)score :(CGPoint) pt :(int)nType;
{
    m_nScore = score;
    char strNum[64];
    sprintf(strNum, "%d",score);
    NSUInteger len = strlen(strNum);
    NSString* strName  = nil;
    CCSprite* psLock = (CCSprite*)[self getChildByTag: IRON_CHAIN+1];
    for (NSUInteger idx = 0; idx < len; idx++) 
    {
        int nNumber = strNum[idx] - '0';
        switch (nType) 
        {
            case 1:
                strName =  [NSString stringWithFormat:@"RightNumber%d.png", nNumber];
                break;
            case 2:
                strName =  [NSString stringWithFormat:@"LockNumber%d.png", nNumber];
                break;
            default:
                break;
        }
        CCSprite* sp = [CCSprite spriteWithFile:strName];
        if(psLock)
        {
            sp.position = ccp(psLock.position.x + 13*idx, psLock.position.y - 15);
            [self addChild:sp z:1 tag:IRON_CHAIN + 20+idx];
        }
    }
}

-(void) cleanScore
{
    char strNum[64];
    sprintf(strNum, "%d",m_nScore);
    NSUInteger len = strlen(strNum);
    for(NSUInteger n = 0; n < len; n++)
    {
        CCSprite* ps = (CCSprite*)[self getChildByTag: IRON_CHAIN + 20 + (int)n];
        if(ps)
        {
            ps.visible = false;
            [self removeChild:ps cleanup:YES];
        }
    }
}

//-(void) ShowScore:(int)score :(CGPoint) pt;
//{
//    char strNum[64];
//    sprintf(strNum, "%d",score);
//    int len = strlen(strNum);
//    for (int idx=0; idx<len; idx++) 
//    {
//        int nNumber = strNum[idx] - '0';
//        NSString* strName =  [NSString stringWithFormat:@"LevelNumber_%d.png", nNumber];
//        CCSprite* sp = [CCSprite spriteWithFile:strName];
//        if(len <= 1)
//        {
//            sp.position = pt;
//        }
//        else
//        {
//            sp.position = ccp(pt.x + idx* 18 - 12, pt.y);
//        }
//        [self addChild:sp z:1 tag:20+idx];
//    }
//}

-(void)SetStarNum:(int) nNumber
{
	for(int i=0; i<nNumber; i++)
	{
		CCSprite *StarSprite = [CCSprite spriteWithFile:@"LevelStar.png"];
		if(m_bStep)
		{
			StarSprite.position = ccp(m_ptStart.x +i*(10+12) -25, m_ptStart.y-25);
		}
		else 
		{
			StarSprite.position = ccp(m_ptStart.x +i*(10+2) -26, m_ptStart.y-53);
		}
		[self addChild:StarSprite z:0 tag:i+2];
	}
}


-(void)SetVeg:(CGPoint) pt :(int) nIndex :(int)nNumber  :(bool) bLock  :(bool)bStep :(NSString*) strFileName :(NSString*) strFileSel
{
	m_ptStart = pt;
	m_nIndex = nIndex;
	m_bStep = bStep;
    [self removeChildByTag:MENUE_ITEM_INDEX cleanup:YES];
    if(strFileName)
    {
        m_VegetableSel = [CCSprite spriteWithFile:strFileName];
    }
    if(strFileSel)
    {
        m_ItemSel = [CCSprite spriteWithFile:strFileSel];
    }

	if(m_VegetableSel && m_ItemSel)
	{
		if((m_idTarget && m_selFunction) || bLock)
		{
			CCMenuItemSprite *VSelMenuS = nil;
			if(bLock)
			{
				VSelMenuS = [CCMenuItemSprite itemWithNormalSprite:m_VegetableSel selectedSprite:m_ItemSel target:self selector:@selector(MenuAction:)];
			}
			else 
			{
				VSelMenuS = [CCMenuItemSprite itemWithNormalSprite:m_VegetableSel selectedSprite:m_ItemSel target:m_idTarget selector:m_selFunction];
			}
			CCMenu *menuVSel= [CCMenu menuWithItems: VSelMenuS, nil];
			[menuVSel setPosition:pt];
			//[menu setPosition:ccp(480 - 50, 320 - 30)];
			[self addChild: menuVSel z:0 tag:MENUE_ITEM_INDEX];
			[self SetStarNum:nNumber];
		}

	}
}

-(void)SetLocke:(bool)bColor
{
    //Add by zhengxf about "主要是加入精灵" 2012-8-2 ------begin-------
    m_ptStart.x = m_ptStart.x + 7;
    m_ptStart.y = m_ptStart.y - 8;
    CCSprite *LockSprite = [CCSprite spriteWithFile:@"Lock.png"];
    LockSprite.position = ccp(m_ptStart.x - 12, m_ptStart.y - 25);
    [self addChild:LockSprite z:1 tag:IRON_CHAIN+1];
    
    CCSprite *ironSprite1 = [CCSprite spriteWithFile:@"iron chain0.png"];
    ironSprite1.position = ccp(m_ptStart.x - 40, m_ptStart.y - 7);;
    [self addChild:ironSprite1 z:1 tag:IRON_CHAIN+2];
    
    CCSprite *ironSprite2 = [CCSprite spriteWithFile:@"iron chain1.png"];
    ironSprite2.position = ccp(m_ptStart.x - 10, m_ptStart.y + 30);
    [self addChild:ironSprite2 z:1 tag:IRON_CHAIN+3];
    
    CCSprite *ironSprite3 = [CCSprite spriteWithFile:@"iron chain2.png"];
    ironSprite3.position = ccp(m_ptStart.x + 28, m_ptStart.y + 48);
    [self addChild:ironSprite3 z:1 tag:IRON_CHAIN+4];
    
    CCSprite *ironSprite4 = [CCSprite spriteWithFile:@"iron chain3.png"];
    ironSprite4.position = ccp(m_ptStart.x + 25, m_ptStart.y + 3);
    [self addChild:ironSprite4 z:1 tag:IRON_CHAIN+5];
    
    CCSprite *ironSprite5 = [CCSprite spriteWithFile:@"iron chain4.png"];
    ironSprite5.position = ccp(m_ptStart.x + 25, m_ptStart.y - 10);;
    [self addChild:ironSprite5 z:1 tag:IRON_CHAIN+6];
    //Add by zhengxf about "主要是加入精灵" 2012-8-2 ------end-------
}

-(void)RunAction
{
    [self cleanScore];
    //CCMenuItemSprite* pItem = [pArray objectAtIndex:0];
    id SetAction = [CCRotateBy actionWithDuration:0.05f  angle:2];
    id ARotate  = [CCRepeat actionWithAction:[CCSequence actions:SetAction, [SetAction reverse], nil] times:10];
    id acf = [CCCallFuncN actionWithTarget:self selector:@selector(MoveIron:)];
    CCAction* HunterDead = [CCSequence actions:ARotate, acf, nil];
    [self runAction:HunterDead];
}

-(void)MoveIron:(CCNode *)node
{
    for(int i = 1; i < 7; i++)
    {
        CCSprite* sp = (CCSprite*)[self getChildByTag:IRON_CHAIN + i];
        CGPoint pt;
        float bTime;
        switch (i) 
        {
            case 1:
                pt = ccp(0, -100);
                bTime = 1.0f;
                break;
            case 2:
                pt = ccp(-200, 110);
                bTime = 0.5f;
                break;
            case 3:
                pt = ccp(-30, 200);
                bTime = 0.8f;
                break;
            case 4:
                pt = ccp(200, 200);
                bTime = 0.6f;
                break;
            case 5:
                pt = ccp(200, 60);
                bTime = 0.7f;
                break;
            case 6:
                pt = ccp(200, -30);
                bTime = 0.9f;
                break;
            default:
                break;
        }
        id ac1 = [CCMoveBy actionWithDuration:0.8 position:pt];
        id ac2 = [CCRotateBy actionWithDuration:0.8 angle:270];
        id ac3 = [CCFadeOut actionWithDuration:0.8];
        id ac4 = [CCSpawn actions:ac1, ac2, ac3, nil];
        [sp runAction:ac4];
    }
}

-(void)SetTarget:(id)idTarget :(SEL)selFunction;
{
	m_idTarget = idTarget;
	m_selFunction = selFunction;
} 

- (void) MenuAction:(id) sender
{

}
-(void)SetColor:(bool)bColor
{
	m_bColor = bColor;
}

@end
