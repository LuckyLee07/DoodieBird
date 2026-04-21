//
//  CCAnimtionManager.m
//  DoodieBird
//
//  Created by LuckyLee on 26-04-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CCAnimationManager.h"

@implementation CCAnimationManager

static CCAnimationManager *AnimationMgr = nil;

#pragma mark  --将数据加载到缓存中，提高程序的运行效率
-(void) AddAllAnima
{
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Bird_nomal_default.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Brid_low.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Brid_dead.plist"];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Brid_hit1.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Brid_hit2.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Brid_hit3.plist"];
    
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Brid_High.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Brid_eat.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Brid_Smoke.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Flashing_Nomal.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Hunter_Smoke.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Flashing_Second.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Brid_Sleep.plist"];
    //小熊
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Bear_Fail.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Bear_Success.plist"];
    
    //一号猎人的动画
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Hunter_nomal.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Hunter_Jump.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Hunter_dead.plist"];
    //[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Hunter_Burn.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Hunter_Burn1.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Hunter_Smoke.plist"];
    
    //二号猎人的动画
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Hunter2_dead.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Hunter2_Jump.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Hunter2_Run.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Hunter2_Scold.plist"];
    
    //三号猎人的动画
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Hunter3_Dead.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Hunter3_Jump.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Hunter3_Run.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Hunter3_Scold.plist"];
    
    //四号猎人的动画
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Hunter4_Dead.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Hunter4_Jump.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Hunter4_Run.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Hunter4_Scold.plist"];
    
    //人物被电的动画
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Hunter_Flight.plist"];
    
    //闪电便便的动画
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Shit_Flight.plist"];
    
    //龙便便的动画
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Dragon_Shit.plist"];

    //火龙动画
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Dragon_Frie.plist"];
    
    //小鸟进度的动画
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Brid_Progress.plist"];
    
    //鹰和感叹号的动画
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Hawk_Fly.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Sigh_Flight.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Sigh_Nomal.plist"];
    
    //上传豆子的的动画
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"UpLoading_Bean.plist"];
}

//生成动画的主函数
-(CCAnimation *)NomalAnima:(NSString *)animPlist FrameName:(NSString*)FrameName FrameCount:(int)nCount delay:(float)delay
{
    CCAnimation* pResult = nil;
    if(nCount > 0)
    {
        NSMutableArray *animFrames = [NSMutableArray array]; 
        //[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:animPlist]; // 3
        for(int i=0; i< nCount; i++)
        {
            NSString* strName = [NSString stringWithFormat:@"%@_%d.png", FrameName, i];
            [animFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:strName]];
        }
        pResult=  [CCAnimation animationWithSpriteFrames:animFrames delay:delay]; 
    }
    return pResult;
}

//扩展动画，加入起始的针序号
-(CCAnimation *)AnimationEx:(NSString *)animPlist FrameName:(NSString*)FrameName StartFrame:(int)nStar FrameCount:(int)nCount delay:(float)delay
{
    CCAnimation* pResult = nil;
    if(nCount > 0)
    {
        NSMutableArray *animFrames = [NSMutableArray array]; 
        //[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:animPlist]; // 3
        for(int i= nStar; i< nCount; i++)
        {
            NSString* strName = [NSString stringWithFormat:@"%@_%d.png", FrameName, i];
            [animFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:strName]];
        }
        pResult=  [CCAnimation animationWithSpriteFrames:animFrames delay:delay]; 
    }
    return pResult;
}

+ (CCAnimationManager *) sharedAnimationManager
{
	@synchronized(self)
	{
		if(nil == AnimationMgr)
		{
			[[self alloc] init];
            [AnimationMgr AddAllAnima];
		}
	}
	return AnimationMgr;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
	{
        if(AnimationMgr == nil)
		{
            AnimationMgr = [super allocWithZone:zone];
            return AnimationMgr;
        }
    }
    return nil;
}
@end
