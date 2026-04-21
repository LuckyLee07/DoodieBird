//
//  AnimationDelegate.h
//  DoodieBird
//
//  Created by LuckyLee on 26-04-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnimationDelegate : NSObject
{

}
+(AnimationDelegate*) shareAnimationDelegate;

#pragma mark  --鸟的动画集合
//鸟的动画---------------------begin------------------

//鸟正常飞行的动画
-(id) BridFlyAnima;
//鸟加速的动画
-(id) BridAccAnima:(id)idTarget Function:(SEL)selFunction;
//鸟落地的动画
-(id) BridLowAnima;
//鸟闪电的动画
-(id) BridFlashingAnima;//:(id)idTarget Function:(SEL)selFunction;

//鸟击中目标的1动画
-(id) BridHit1Anima:(id)idTarget Function:(SEL)selFunction;
//鸟击中目标的2动画
-(id) BridHit2Anima:(id)idTarget Function:(SEL)selFunction;
//鸟击中目标的3动画
-(id) BridHit3Anima:(id)idTarget Function:(SEL)selFunction;


//鸟飞到最高点的动画
-(id) BridHighAnima;
//鸟吃豆子的动画
-(id) BridEatAnima:(id)idTarger Function:(SEL)selFunction;
//鸟被抓的动画
-(id) BridCatched:(id)idTarger Function:(SEL)selFunction;
//鸟肚子变大的效果
-(id) BridGreat:(id)idTarger Function:(SEL)selFunction;
//鸟睡觉的动画
-(id) BridSleep;
//鸟的动画---------------------end------------------

#pragma mark  --图片遮罩动画集合
//图片遮罩的缩放
-(id) GameOverMask:(id)idTarger Function:(SEL)selFunction;

#pragma mark  --小熊的动画集合
//小熊的动画-------------------begin----------------
//小熊获胜利的动画
-(id) BearSuccess:(id)idTarger Function:(SEL)selFunction Function2:(SEL)selFun2;
//小熊失败的动画
-(id) BearFail;
//小熊的动画-------------------end----------------

#pragma mark  --人的动画集合
//人的动画--------------------begin-----------------

//人跑的动画
-(id)HunterRunAnima;
//人移动的动画
-(id)HunterMove:(id)idTarger Function:(SEL)selFunction Function2:(SEL)selFun2;
//人物跳起的动画
-(id)HunterJump:(id)idTarger Function:(SEL)selFunction;
//人物死掉的动画
-(id)HunterDead:(id)idTarger Function:(SEL)selFunction;
//人物被烧的动画
-(id)HunterBurn:(id)idTarger Function:(SEL)selFunction;

//人物被烧的动画1
-(id)HunterBurn1:(id)idTarger Function:(SEL)selFunction;

//火烧人移动的动画
-(id)HunterBurn1Move;

//人物冒烟的动画
-(id)HunterSmoke:(id)idTarger Function:(SEL)selFunction;

//二号人物的各种动画
//二号人物跑的动画
-(id)Hunter2Run;

//二号人物死掉的动画
-(id)Hunter2Dead:(id)idTarger Function:(SEL)selFunction;

//二号人物跳起的动画
-(id)Hunter2Jump:(id)idTarger Function:(SEL)selFunction;

//二号人物骂人的动画
-(id)Hunter2Scold:(id)idTarger Function:(SEL)selFunction;

//三号人物的各种动画
//三号人物跑的动画
-(id)Hunter3Run;

//三号人物死掉的动画
-(id)Hunter3Dead:(id)idTarger Function:(SEL)selFunction;

//三号人物跳起的动画
-(id)Hunter3Jump:(id)idTarger Function:(SEL)selFunction;

//三号人物骂人的动画
-(id)Hunter3Scold:(id)idTarger Function:(SEL)selFunction;

//四号人物的各种动画
//四号人物跑的动画
-(id)Hunter4Run;

//四号人物死掉的动画
-(id)Hunter4Dead:(id)idTarger Function:(SEL)selFunction;

//四号人物跳起的动画
-(id)Hunter4Jump:(id)idTarger Function:(SEL)selFunction;

//四号人物骂人的动画
-(id)Hunter4Scold:(id)idTarger Function:(SEL)selFunction;
//人的动画--------------------end-----------------


//人物被电的动画
-(id)HunterFlight:(id)idTarger Function:(SEL)selFunction;

//闪电便便的动画
-(id)ShitFlight;

//龙便便的动画
-(id)ShitDragon;

//龙便便横行出火
-(id)FrieDragon;
//龙便便火攻击的动画

#pragma mark ---组合动画，一边燃烧一边冒烟
-(id)HunterBurnSmoke:(id)idTarger Function:(SEL)selFunction;

//小鸟前进的动画
-(id)BridProgress;

//鸟摔下来的动画
-(id)BridDown:(id)idTarger Function:(SEL)selFunction;

//鸟如树洞的动画
-(id)BridInHole:(id)idTarger Function:(SEL)selFunction;

#pragma mark  --障碍物动画集合

#pragma mark ---游戏结束的动画集合
//游戏结束的动画集合
-(id)GameOverIcon:(id)idTarger Function:(SEL)selFunction;//游戏图标动画
-(id)GameStart:(id)idTarger Function:(SEL)selFunction;//游戏星星动画

//障碍物动画-----------------begin-------------

//闪电的动画
-(id) FlashingAnima;
-(id) FlashingAnimaSecond;
//障碍物动画-----------------end-------------

//鹰和感叹号的动画
-(id) SighFlight:(id)idTarger Function:(SEL)selFunction;
-(id) SighNomal;
-(id) HawkFlyAnima;

//Add by zhengxf about “变化数据的颜色” 2012-913 ------begin-------
-(id) ColorBy:(GLshort)r green:(GLshort)g blue:(GLshort)b;
//Add by zhengxf about “变化数据的颜色” 2012-913 ------end-------

//Add by zhengxf about “上传豆子的数据变化” 2012-913 ------begin-------
-(id) UpLoadBean;
//Add by zhengxf about “上传豆子的数据变化” 2012-913 ------begin-------

@end