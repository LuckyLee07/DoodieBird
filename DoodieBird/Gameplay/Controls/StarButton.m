//
//  StarButton.m
//  cookgirl
//
//  Created by LuckyLee on 26-04-22.
//  Copyright FancyGame 2026年. All rights reserved.
//

#import "StarButton.h"
#import "SenceManager.h"


@implementation StarButton

@synthesize m_nIndex;
@synthesize m_nScore;

- (id) init
{
	self = [super init];
    m_nScore = 0;
	m_nIndex = 0;
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

-(void) ShowScore:(int)score :(CGPoint) pt;
{
    m_nScore = score;
    char strNum[64];
    sprintf(strNum, "%d",score);
    int len = strlen(strNum);
    for (int idx=0; idx<len; idx++) 
    {
        int nNumber = strNum[idx] - '0';
        NSString* strName =  [NSString stringWithFormat:@"LevelNumber_%d.png", nNumber];
        CCSprite* sp = [CCSprite spriteWithFile:strName];
        if(len <= 1)
        {
            sp.position = pt;
        }
        else
        {
            sp.position = ccp(pt.x + idx* 18 - 12, pt.y);
        }
        [self addChild:sp z:1 tag:20+idx];
    }
}

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
	if(!bStep)
	{
		m_VegetableBan = [CCSprite spriteWithFile:@"ban.png"];// rect:CGRectMake(0, 0, 523, 200)
		m_VegetableBan.position = ccp(pt.x-5, pt.y-25);
		[self addChild:m_VegetableBan z:0 tag:7];
	}
	if(bLock)
	{
		//中－－－－begin-----------
		m_VegetableSel = [CCSprite spriteWithFile:@"Level_Lock.png" ];
	}
	else 
	{
		if(strFileName)
		{
			m_VegetableSel = [CCSprite spriteWithFile:strFileName];
		}
        if(strFileSel)
        {
            m_ItemSel = [CCSprite spriteWithFile:strFileSel];
        }
	}
	if((m_VegetableSel && m_ItemSel) || bLock)
	{
		if((m_idTarget && m_selFunction)  || bLock)
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
            VSelMenuS.tag = m_nScore;
			CCMenu *menuVSel= [CCMenu menuWithItems: VSelMenuS, nil];
			[menuVSel setPosition:pt];
			//[menu setPosition:ccp(480 - 50, 320 - 30)];
			[self addChild: menuVSel];
			[self SetStarNum:nNumber];
		}

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
