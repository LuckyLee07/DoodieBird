//
//  AnimationDelegate.m
//  DoodieBird
//
//  Created by LuckyLee on 26-04-22.
//  Copyright (c) 2026年 FancyGame. All rights reserved.
//

#import "AnimationDelegate.h"
#import "CCAnimationManager.h"

@implementation AnimationDelegate

static AnimationDelegate *pAnimationDelegate = nil;

#pragma mark  --鸟的动画集合
//鸟正常飞行的动画
-(id) BridFlyAnima
{
    CCAnimation *anim = [[CCAnimationManager sharedAnimationManager] NomalAnima:@"Bird_nomal_default.plist" FrameName:@"Brid_nomal" FrameCount:4 delay:0.1];
    CCAction* pBridAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:anim]];
    pBridAction.tag = 10;
    return  pBridAction;
}

//鸟加速的动画
-(id) BridAccAnima:(id)idTarget Function:(SEL)selFunction
{
    CCAnimation *anim = [[CCAnimationManager sharedAnimationManager] NomalAnima:@"Bird_nomal_default.plist" FrameName:@"Brid_nomal" FrameCount:4 delay:0.04];
    id BridAction = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:anim] times:4];
    id acf = [CCCallFuncN actionWithTarget:idTarget selector:selFunction];
    CCAction* Ac = [CCSequence actions:BridAction, acf, nil];
    return Ac;
}

//鸟落地的动画
-(id) BridLowAnima
{
    CCAnimation *anim = [[CCAnimationManager sharedAnimationManager] NomalAnima:@"Brid_low.plist" FrameName:@"bird_low" FrameCount:8 delay:0.062];
    CCAction* pBridAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:anim]];
    return  pBridAction;
}

//鸟闪电的动画
-(id) BridFlashingAnima;//:(id)idTarget Function:(SEL)selFunction
{
    CCAnimation *anim = [[CCAnimationManager sharedAnimationManager] NomalAnima:@"Brid_dead.plist" FrameName:@"bird_dead_1" FrameCount:3 delay:0.04];
    CCAction* pBridAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:anim]];
    //id BridAction = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:anim] times:4];
   // id acf = [CCCallFuncN actionWithTarget:idTarget selector:selFunction];
//    CCAction* BridDead = [CCSequence actions:BridAction, acf, nil];
//    return BridDead; 
    return pBridAction;
}

//鸟击中目标的动画
-(id) BridHit1Anima:(id)idTarget Function:(SEL)selFunction
{
    CCAnimation *anim = [[CCAnimationManager sharedAnimationManager] NomalAnima:@"Brid_hit1.plist" FrameName:@"bird_hit_1" FrameCount:4 delay:0.08];
    id BridAction = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:anim] times:2];
    id acf = [CCCallFuncN actionWithTarget:idTarget selector:selFunction];
    CCAction* BridDead = [CCSequence actions:BridAction, acf, nil];
    return BridDead; 
}

//鸟击中目标的2动画
-(id) BridHit2Anima:(id)idTarget Function:(SEL)selFunction
{
    CCAnimation *anim = [[CCAnimationManager sharedAnimationManager] NomalAnima:@"Brid_hit2.plist" FrameName:@"bird_hit_2" FrameCount:4 delay:0.08];
    id BridAction = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:anim] times:2];
    id acf = [CCCallFuncN actionWithTarget:idTarget selector:selFunction];
    CCAction* BridDead = [CCSequence actions:BridAction, acf, nil];
    return BridDead; 
}
//鸟击中目标的3动画
-(id) BridHit3Anima:(id)idTarget Function:(SEL)selFunction
{
    CCAnimation *anim = [[CCAnimationManager sharedAnimationManager] NomalAnima:@"Brid_hit3.plist" FrameName:@"bird_hit_3" FrameCount:4 delay:0.08];
    id BridAction = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:anim] times:2];
    id acf = [CCCallFuncN actionWithTarget:idTarget selector:selFunction];
    CCAction* BridDead = [CCSequence actions:BridAction, acf, nil];
    return BridDead; 
}


//鸟飞到最高点的动画
-(id) BridHighAnima
{
    CCAnimation *anim = [[CCAnimationManager sharedAnimationManager] NomalAnima:@"Brid_High.plist" FrameName:@"bird_high" FrameCount:4 delay:0.1];
    CCAction* BridDead = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:anim]];
    return  BridDead;
}

//鸟吃豆子的动画
-(id) BridEatAnima:(id)idTarger Function:(SEL)selFunction
{
    CCAnimation *anim = [[CCAnimationManager sharedAnimationManager] NomalAnima:@"Brid_eat.plist" FrameName:@"bird_eat" FrameCount:3 delay:0.06];
    id BridAction = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:anim] times:1];
    id acf = [CCCallFuncN actionWithTarget:idTarger selector:selFunction];
    CCAction* BridEat = [CCSequence actions:BridAction, acf, nil];
    return BridEat; 
}

//鸟被抓的画面
-(id) BridCatched:(id)idTarger Function:(SEL)selFunction
{
    CCAnimation *anim = [[CCAnimationManager sharedAnimationManager] NomalAnima:@"Brid_Smoke.plist" FrameName:@"Brid_Smoke" FrameCount:6 delay:0.07];
    id BridAction = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:anim] times:5];
    id acf = [CCCallFuncN actionWithTarget:idTarger selector:selFunction];
    CCAction* BridCatched = [CCSequence actions:BridAction, acf, nil];
    return BridCatched; 
}

//鸟肚子变大的效果
-(id) BridGreat:(id)idTarger Function:(SEL)selFunction
{   
    id actionScale = [CCScaleBy actionWithDuration:0.2 scale:1.1f];
    id acf = [CCCallFuncN actionWithTarget:idTarger selector:selFunction];
    //id Action= [CCRepeat actionWithAction:[CCSequence actions:actionScale, actionScale1, nil] times:3];
    CCAction* BridCatched = [CCSequence actions:actionScale, [actionScale reverse], acf, nil];
    return BridCatched;
}

//鸟睡觉的动画
-(id) BridSleep
{
    CCAnimation *anim = [[CCAnimationManager sharedAnimationManager] NomalAnima:@"Brid_Sleep.plist" FrameName:@"Shop_Brid" FrameCount:18 delay:0.1];
    CCAction* BridDead = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:anim]];
    return  BridDead;
}

#pragma mark  --小熊的动画集合
//小熊的动画-------------------begin----------------
//小熊获胜利的动画
-(id) BearSuccess:(id)idTarger Function:(SEL)selFunction Function2:(SEL)selFun2
{
    CCAnimation *anim = [[CCAnimationManager sharedAnimationManager] NomalAnima:@"Bear_Success.plist" FrameName:@"Bear_Success" FrameCount:7 delay:0.08];
    id acf1 = [CCCallFuncN actionWithTarget:idTarger selector:selFunction];
    id acf2 = [CCCallFuncN actionWithTarget:idTarger selector:selFun2];
    id BearAction = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:anim] times:1];
    id HunterAction = [CCRepeatForever actionWithAction:[CCSequence actions:BearAction, acf1, BearAction,  acf2,nil]];
    return HunterAction; 
}
//小熊失败的动画
-(id) BearFail
{
    CCAnimation *anim = [[CCAnimationManager sharedAnimationManager] NomalAnima:@"Bear_Fail.plist" FrameName:@"Bear_Fail" FrameCount:3 delay:0.1];
    id BearAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:anim]];
    return BearAction; 
}
//小熊的动画-------------------end----------------
#pragma mark ---游戏结束的动画集合
//游戏结束的动画集合
-(id)GameOverIcon:(id)idTarger Function:(SEL)selFunction
{
    id actionScale = [CCScaleBy actionWithDuration:0.2 scale:0.25f];
    //id actionScale2 = [CCScaleBy actionWithDuration:0.1 scale:1.0f];
    id acf = [CCCallFuncN actionWithTarget:idTarger selector:selFunction];
    //id Action= [CCRepeat actionWithAction:[CCSequence actions:actionScale, actionScale1, nil] times:3];
    CCAction* Action = [CCSequence actions:actionScale,  acf, nil];
    return Action;
}

-(id)GameStart:(id)idTarger Function:(SEL)selFunction //游戏星星动画
{
    id actionScale = [CCScaleBy actionWithDuration:0.2 scale:4.0f];
    id actionScale2 = [CCScaleBy actionWithDuration:0.2 scale:0.50f];
    id acf = [CCCallFuncN actionWithTarget:idTarger selector:selFunction];
    CCAction* Action = [CCSequence actions:actionScale, actionScale2, acf, nil];
    return Action;
}

#pragma mark  --图片遮罩动画集合
//图片遮罩的缩放
-(id) GameOverMask:(id)idTarger Function:(SEL)selFunction
{   
    id ac1 = [CCMoveBy actionWithDuration:1.0 position:ccp(480/4, 320/4 - 30)];
    id ac2 = [CCRotateBy actionWithDuration:1.0 angle:360*4];
    id ac3 = [CCScaleBy actionWithDuration:1.0 scale:1.8f];
    id ac4 = [CCSpawn actions:ac1, ac2, ac3, nil];
    id ac5 = [CCRotateBy actionWithDuration:0.02 angle:0];
    id acf = [CCCallFuncN actionWithTarget:idTarger selector:selFunction];
    CCAction* GameOver = [CCSequence actions:ac4, ac5, acf, nil];
    return GameOver;
}

#pragma mark  --人的动画集合
//人的动画--------------------begin-----------------
//人跑的动画
-(id)HunterRunAnima
{
    CCAnimation *anim = [[CCAnimationManager sharedAnimationManager] NomalAnima:@"Hunter_nomal.plist" FrameName:@"Hunter" FrameCount:3 delay:0.05];
    id HunterAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:anim]];
    return HunterAction; 
}

//人移动的动画
-(id)HunterMove:(id)idTarger Function:(SEL)selFunction Function2:(SEL)selFun2
{
    id ac1 = [CCMoveBy actionWithDuration:0.8 position:ccp(-150, 0)];
    id ac2 = [CCMoveBy actionWithDuration:0.8 position:ccp(5, 0)];
    id acf1 = [CCCallFuncN actionWithTarget:idTarger selector:selFunction];
    id acf2 = [CCCallFuncN actionWithTarget:idTarger selector:selFun2];
    id HunterAction = [CCRepeatForever actionWithAction:[CCSequence actions:ac1, acf1, ac2,  acf2,nil]];
    return  HunterAction;
}

//人物跳起的动画
-(id)HunterJump:(id)idTarger Function:(SEL)selFunction
{
    CCAnimation *Jumanim = [[CCAnimationManager sharedAnimationManager] NomalAnima:@"Hunter_Jump.plist" FrameName:@"Hunter_Jump" FrameCount:8 delay:0.09];
    id JumAction = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:Jumanim] times:2];
    id acf = [CCCallFuncN actionWithTarget:idTarger selector:selFunction];
    CCAction* HunterJum = [CCSequence actions: JumAction, acf, nil];
    return HunterJum;
}

//人物死掉的动画
-(id)HunterDead:(id)idTarger Function:(SEL)selFunction
{
    CCAnimation *Deadanim = [[CCAnimationManager sharedAnimationManager] NomalAnima:@"Hunter_dead.plist" FrameName:@"Hunter_Dead" FrameCount:8 delay:0.09];
    id JumAction = [CCAnimate actionWithAnimation:Deadanim];
    id acf = [CCCallFuncN actionWithTarget:idTarger selector:selFunction];
    CCAction* HunterDead = [CCSequence actions:JumAction, acf, nil];
    return HunterDead;
}

//人物被电的动画
-(id)HunterFlight:(id)idTarger Function:(SEL)selFunction
{
    CCAnimation *anim = [[CCAnimationManager sharedAnimationManager] NomalAnima:@"Hunter_Flight.plist" FrameName:@"Hunter_Flight" FrameCount:4 delay:0.05];
    id HunterAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:anim]];
    return HunterAction; 
}

//人物被烧的动画1
-(id)HunterBurn1:(id)idTarger Function:(SEL)selFunction
{
    CCAnimation *Burnanim1 = [[CCAnimationManager sharedAnimationManager] AnimationEx:@"Hunter_Burn1.plist" FrameName:@"Hunter_Burn" StartFrame:0 FrameCount:1 delay:0.1];
    id BurnAction1 = [CCAnimate actionWithAnimation:Burnanim1];
    
    CCAnimation *Burnanim2 = [[CCAnimationManager sharedAnimationManager] AnimationEx:@"Hunter_Burn1.plist" FrameName:@"Hunter_Burn" StartFrame:1 FrameCount:1 delay:0.05];
    id BurnAction2 = [CCAnimate actionWithAnimation:Burnanim2];
    
    CCAnimation *Burnanim3 = [[CCAnimationManager sharedAnimationManager] AnimationEx:@"Hunter_Burn1.plist" FrameName:@"Hunter_Burn" StartFrame:2 FrameCount:1 delay:0.05];
    id BurnAction3 = [CCAnimate actionWithAnimation:Burnanim3];
    
    CCAnimation *Burnanim4 = [[CCAnimationManager sharedAnimationManager] NomalAnima:@"Hunter_Smoke1.plist" FrameName:@"Hunter_Smoke" FrameCount:12 delay:0.05];
    id BurnAction4 = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:Burnanim4] times:100];
    
    CCAction* HunterBurn = [CCSequence actions:BurnAction1, BurnAction2, BurnAction3, BurnAction4, nil];
    return HunterBurn;
}

//人移动的动画
-(id)HunterBurn1Move
{
//    id ac1 = [CCMoveBy actionWithDuration:0.1 position:ccp(-25, 0)];
//    id ac2 = [CCMoveBy actionWithDuration:0.1 position:ccp(20, 0)];
    id ac2 = [CCMoveBy actionWithDuration:0.8 position:ccp(83, 0)];
    id ac1 = [CCMoveBy actionWithDuration:0.8 position:ccp(-83, 0)];
  
//    id acf1 = [CCCallFuncN actionWithTarget:idTarger selector:selFunction];
//    id acf2 = [CCCallFuncN actionWithTarget:idTarger selector:selFun2];
//    id HunterAction = [CCRepeatForever actionWithAction:[CCSequence actions:ac1, acf1, ac2,  acf2,nil]];
    id HunterAction = [CCRepeatForever actionWithAction:[CCSequence actions:ac1, ac2,nil]];
    return  HunterAction;
}

//人物被烧的动画
-(id)HunterBurn:(id)idTarger Function:(SEL)selFunction
{
    CCAnimation *Burnanim1 = [[CCAnimationManager sharedAnimationManager] AnimationEx:@"Hunter_Burn.plist" FrameName:@"Hunter_Burn" StartFrame:0 FrameCount:1 delay:0.1];
    id BurnAction1 = [CCAnimate actionWithAnimation:Burnanim1];
    
    CCAnimation *Burnanim2 = [[CCAnimationManager sharedAnimationManager] AnimationEx:@"Hunter_Burn.plist" FrameName:@"Hunter_Burn" StartFrame:1 FrameCount:2 delay:0.05];
    id BurnAction2 = [CCAnimate actionWithAnimation:Burnanim2];
    
    CCAnimation *Burnanim3 = [[CCAnimationManager sharedAnimationManager] AnimationEx:@"Hunter_Burn.plist" FrameName:@"Hunter_Burn" StartFrame:0 FrameCount:1 delay:0.05];
    id BurnAction3 = [CCAnimate actionWithAnimation:Burnanim3];
    
    CCAnimation *Burnanim4 = [[CCAnimationManager sharedAnimationManager] AnimationEx:@"Hunter_Burn.plist" FrameName:@"Hunter_Burn" StartFrame:1 FrameCount:2 delay:0.05];
    id BurnAction4 = [CCAnimate actionWithAnimation:Burnanim4];
    
    CCAnimation *Burnanim5 = [[CCAnimationManager sharedAnimationManager] AnimationEx:@"Hunter_Burn.plist" FrameName:@"Hunter_Burn" StartFrame:0 FrameCount:1 delay:0.05];
    id BurnAction5 = [CCAnimate actionWithAnimation:Burnanim5];
    
    CCAnimation *Burnanim6 = [[CCAnimationManager sharedAnimationManager] AnimationEx:@"Hunter_Burn.plist" FrameName:@"Hunter_Burn" StartFrame:2 FrameCount:3 delay:0.05];
    id BurnAction6 = [CCAnimate actionWithAnimation:Burnanim6];
    
    CCAnimation *Burnanim7 = [[CCAnimationManager sharedAnimationManager] AnimationEx:@"Hunter_Burn.plist" FrameName:@"Hunter_Burn" StartFrame:3 FrameCount:7 delay:0.1];
    id BurnAction7 = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:Burnanim7] times:4];
    
    CCAction* HunterBurn = [CCRepeatForever actionWithAction:[CCSequence actions:BurnAction1, BurnAction2, BurnAction3, BurnAction4, BurnAction5, BurnAction6, BurnAction7,  nil]];
    return HunterBurn;
}

//人物冒烟的动画
-(id)HunterSmoke:(id)idTarger Function:(SEL)selFunction
{
    CCAnimation *Smokeanim = [[CCAnimationManager sharedAnimationManager] NomalAnima:@"Hunter_Smoke.plist" FrameName:@"Hunter_Smoke" FrameCount:13 delay:0.05];
    id SmokeAction = [CCAnimate actionWithAnimation:Smokeanim];
    //id acf = [CCCallFuncN actionWithTarget:idTarger selector:selFunction];
    CCAction* HunterSmoke = [CCSequence actions:SmokeAction, nil];
    return HunterSmoke;
}

//二号人物的各种动画
//二号人物跑的动画
-(id)Hunter2Run
{
    CCAnimation *Runanim = [[CCAnimationManager sharedAnimationManager] NomalAnima:@"Hunter2_Run.plist" FrameName:@"Hunter2_Run" FrameCount:3 delay:0.05];
    id HunterAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:Runanim]];
    return HunterAction; 
}

//二号人物死掉的动画
-(id)Hunter2Dead:(id)idTarger Function:(SEL)selFunction
{
    CCAnimation *Deadanim = [[CCAnimationManager sharedAnimationManager] NomalAnima:@"Hunter2_dead.plist" FrameName:@"Hunter2_dead" FrameCount:3 delay:0.09];
    id DeadAction = [CCAnimate actionWithAnimation:Deadanim];
    id DAction = [CCRepeat actionWithAction:DeadAction times:7];
    id acf = [CCCallFuncN actionWithTarget:idTarger selector:selFunction];
    CCAction* Hunter2Dead = [CCSequence actions:DAction, acf, nil];
    return Hunter2Dead;
}

//二号人物跳起的动画
-(id)Hunter2Jump:(id)idTarger Function:(SEL)selFunction
{
    CCAnimation *Jumanim = [[CCAnimationManager sharedAnimationManager] NomalAnima:@"Hunter2_Jump.plist" FrameName:@"Hunter2_Jump" FrameCount:15 delay:0.09];
    id JumAction = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:Jumanim] times:2];
    id acf = [CCCallFuncN actionWithTarget:idTarger selector:selFunction];
    CCAction* HunterJum = [CCSequence actions: JumAction, acf, nil];
    return HunterJum;
}

//二号人物骂人的动画
-(id)Hunter2Scold:(id)idTarger Function:(SEL)selFunction
{
    CCAnimation *Scoldanim = [[CCAnimationManager sharedAnimationManager] NomalAnima:@"Hunter2_Scold.plist" FrameName:@"Hunter2_Scold" FrameCount:3 delay:0.09];
    id ScoldAction = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:Scoldanim] times:2];
    id acf = [CCCallFuncN actionWithTarget:idTarger selector:selFunction];
    CCAction* Hunter2Scold= [CCSequence actions: ScoldAction, acf, nil];
    return Hunter2Scold;
}

//三号人物跑的动画
-(id)Hunter3Run
{
    CCAnimation *Runanim = [[CCAnimationManager sharedAnimationManager] NomalAnima:@"Hunter3_Run.plist" FrameName:@"Hunter3_Run" FrameCount:3 delay:0.05];
    id HunterAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:Runanim]];
    return HunterAction; 
}

//三号人物死掉的动画
-(id)Hunter3Dead:(id)idTarger Function:(SEL)selFunction
{
    CCAnimation *Deadanim = [[CCAnimationManager sharedAnimationManager] NomalAnima:@"Hunter3_dead.plist" FrameName:@"Hunter3_Dead" FrameCount:3 delay:0.09];
    id DeadAction = [CCAnimate actionWithAnimation:Deadanim];
    id DAction = [CCRepeat actionWithAction:DeadAction times:7];
    id acf = [CCCallFuncN actionWithTarget:idTarger selector:selFunction];
    CCAction* Hunter2Dead = [CCSequence actions:DAction, acf, nil];
    return Hunter2Dead;
}

//三号人物跳起的动画
-(id)Hunter3Jump:(id)idTarger Function:(SEL)selFunction
{
    CCAnimation *Jumanim = [[CCAnimationManager sharedAnimationManager] NomalAnima:@"Hunter3_Jump.plist" FrameName:@"Hunter3_Jump" FrameCount:15 delay:0.09];
    id JumAction = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:Jumanim] times:2];
    id acf = [CCCallFuncN actionWithTarget:idTarger selector:selFunction];
    CCAction* HunterJum = [CCSequence actions: JumAction, acf, nil];
    return HunterJum;
}

//三号人物骂人的动画
-(id)Hunter3Scold:(id)idTarger Function:(SEL)selFunction
{
    CCAnimation *Scoldanim = [[CCAnimationManager sharedAnimationManager] NomalAnima:@"Hunter3_Scold.plist" FrameName:@"Hunter3_Scold" FrameCount:3 delay:0.09];
    id ScoldAction = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:Scoldanim] times:5];
    id acf = [CCCallFuncN actionWithTarget:idTarger selector:selFunction];
    CCAction* Hunter2Scold= [CCSequence actions: ScoldAction, acf, nil];
    return Hunter2Scold;
}

//四号人物跑的动画
-(id)Hunter4Run
{
    CCAnimation *Runanim = [[CCAnimationManager sharedAnimationManager] NomalAnima:@"Hunter4_Run.plist" FrameName:@"Hunter4_Run" FrameCount:3 delay:0.05];
    id HunterAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:Runanim]];
    return HunterAction; 
}

//四号人物死掉的动画
-(id)Hunter4Dead:(id)idTarger Function:(SEL)selFunction
{
    CCAnimation *Deadanim = [[CCAnimationManager sharedAnimationManager] NomalAnima:@"Hunter4_dead.plist" FrameName:@"Hunter4_Dead" FrameCount:5 delay:0.09];
    id DeadAction = [CCAnimate actionWithAnimation:Deadanim];
    id DAction = [CCRepeat actionWithAction:DeadAction times:4];
    id acf = [CCCallFuncN actionWithTarget:idTarger selector:selFunction];
    CCAction* Hunter2Dead = [CCSequence actions:DAction, acf, nil];
    return Hunter2Dead;
}

//四号人物跳起的动画
-(id)Hunter4Jump:(id)idTarger Function:(SEL)selFunction
{
    CCAnimation *Jumanim = [[CCAnimationManager sharedAnimationManager] NomalAnima:@"Hunter4_Jump.plist" FrameName:@"Hunter4_Jump" FrameCount:13 delay:0.09];
    id JumAction = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:Jumanim] times:2];
    id acf = [CCCallFuncN actionWithTarget:idTarger selector:selFunction];
    CCAction* HunterJum = [CCSequence actions: JumAction, acf, nil];
    return HunterJum;
}

//四号人物骂人的动画
-(id)Hunter4Scold:(id)idTarger Function:(SEL)selFunction
{
    CCAnimation *Scoldanim = [[CCAnimationManager sharedAnimationManager] NomalAnima:@"Hunter4_Scold.plist" FrameName:@"Hunter4_Scold" FrameCount:3 delay:0.09];
    id ScoldAction = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:Scoldanim] times:5];
    id acf = [CCCallFuncN actionWithTarget:idTarger selector:selFunction];
    CCAction* Hunter2Scold= [CCSequence actions: ScoldAction, acf, nil];
    return Hunter2Scold;
}
//人的动画--------------------end-----------------

#pragma mark ---组合动画，一边燃烧一边冒烟
-(id)HunterBurnSmoke:(id)idTarger Function:(SEL)selFunction
{
    id BurnAction = [self HunterBurn:nil Function:nil];
    id SomkeAction = [self HunterSmoke:nil  Function:nil];
    CCAction* HunterBurnS = [CCSpawn actions:BurnAction,  SomkeAction, nil];
    return HunterBurnS;
}

//闪电便便的动画
-(id)ShitFlight
{
    CCAnimation *anim = [[CCAnimationManager sharedAnimationManager] NomalAnima:@"Shit_Flight.plist" FrameName:@"Shit_Flight" FrameCount:2 delay:0.05];
    id HunterAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:anim]];
    return HunterAction;
}

//龙便便的动画
-(id)ShitDragon
{
    CCAnimation *anim = [[CCAnimationManager sharedAnimationManager] NomalAnima:@"Dragon_Shit.plist" FrameName:@"DragonShit" FrameCount:2 delay:0.03];
    id HunterAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:anim]];
    return HunterAction;
}

//龙便便横行出火
-(id)FrieDragon
{
    CCAnimation *anim = [[CCAnimationManager sharedAnimationManager] NomalAnima:@"Dragon_Frie.plist" FrameName:@"Dragon_Frie" FrameCount:9 delay:0.05];
    id HunterAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:anim]];
    return HunterAction;
}

//小鸟前进的动画
-(id)BridProgress
{
    CCAnimation *Runanim = [[CCAnimationManager sharedAnimationManager] NomalAnima:@"Brid_Progress.plist" FrameName:@"Brid_Progress" FrameCount:15 delay:0.05];
    id HunterAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:Runanim]];
    return HunterAction; 
}

//鸟摔下来的动画
-(id)BridDown:(id)idTarger Function:(SEL)selFunction
{
    id ac1 = [CCMoveTo actionWithDuration:0.8 position:ccp(165, 30)];
    id acf = [CCCallFuncN actionWithTarget:idTarger selector:selFunction];
    CCAction* BridDown = [CCSequence actions: ac1, acf, nil];
    return BridDown; 
}

//鸟如树洞的动画
-(id)BridInHole:(id)idTarger Function:(SEL)selFunction
{
    id ac1 = [CCMoveTo actionWithDuration:3.0 position:ccp(500, 160)];
    id acf = [CCCallFuncN actionWithTarget:idTarger selector:selFunction];
    CCAction* BridIn = [CCSequence actions: ac1, acf, nil];
    return BridIn;
}
#pragma mark  --障碍物动画集合
//障碍物动画-----------------begin-------------
-(id) FlashingAnimaSecond
{
    CCAnimation *anim = [[CCAnimationManager sharedAnimationManager] NomalAnima:@"Flashing_Second.plist" FrameName:@"Flashing_Second" FrameCount:4 delay:0.07];
    id FlashingAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:anim]];
    return  FlashingAction;
}

//闪电的动画
-(id) FlashingAnima
{
    CCAnimation *anim = [[CCAnimationManager sharedAnimationManager] NomalAnima:@"Flashing_Nomal.plist" FrameName:@"Flashing_Nomal" FrameCount:4 delay:0.07];
    id FlashingAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:anim]];
    return  FlashingAction;
}

//障碍物动画-----------------end-------------

//鹰和感叹号的动画
-(id) SighFlight:(id)idTarger Function:(SEL)selFunction
{
    CCAnimation *anim = [[CCAnimationManager sharedAnimationManager] NomalAnima:@"Sigh_Flight.plist" FrameName:@"Sigh_Flight" FrameCount:4 delay:0.07];
    id ac1 = [CCRepeat actionWithAction:[CCAnimate actionWithAnimation:anim] times:2];
    id acf = [CCCallFuncN actionWithTarget:idTarger selector:selFunction];
    CCAction* FlashingAction = [CCSequence actions: ac1, acf, nil];
    return  FlashingAction;
}

-(id) SighNomal
{
    CCAnimation *anim = [[CCAnimationManager sharedAnimationManager] NomalAnima:@"Sigh_Nomal.plist" FrameName:@"Sigh_Nomal" FrameCount:2 delay:0.07];
    id FlashingAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:anim]];
    return  FlashingAction;
}

-(id) HawkFlyAnima
{
    CCAnimation *anim = [[CCAnimationManager sharedAnimationManager] NomalAnima:@"Hawk_Fly.plist" FrameName:@"Hawk_Fly" FrameCount:6 delay:0.05];
    id FlashingAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:anim]];
    return  FlashingAction;
}

//Add by zhengxf about “变化数据的颜色” 2012-913 ------begin-------
-(id) ColorBy:(GLshort)r green:(GLshort)g blue:(GLshort)b
{
    id ac1 = [CCTintBy actionWithDuration:0.1 red:r green:g blue:b];
    CCAction* ColorByAction = [CCSequence actions: ac1, [ac1 reverse], nil];
    return ColorByAction;
}
//Add by zhengxf about “变化数据的颜色” 2012-913 ------end-------

//Add by zhengxf about “上传豆子的数据变化” 2012-913 ------begin-------
-(id) UpLoadBean
{
    CCAnimation *anim = [[CCAnimationManager sharedAnimationManager] NomalAnima:@"UpLoading_Bean.plist" FrameName:@"UpLoadingBean" FrameCount:5 delay:0.05];
    id UpBeanAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:anim]];
    return  UpBeanAction;
}
//Add by zhengxf about “上传豆子的数据变化” 2012-913 ------begin-------

+(AnimationDelegate *) shareAnimationDelegate
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pAnimationDelegate = [[super allocWithZone:NULL] init];
    });
	return pAnimationDelegate;
}

+(id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
	{
        if(pAnimationDelegate == nil)
		{
            pAnimationDelegate = [super allocWithZone:zone];
        }
    }
    return pAnimationDelegate;
}
@end
