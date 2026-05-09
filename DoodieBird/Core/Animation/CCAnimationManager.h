//
//  CCAnimtionManager.h
//  DoodieBird
//
//  Created by LuckyLee on 26-04-22.
//  Copyright (c) 2026年 FancyGame. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CCAnimationManager : NSObject
{

}
+(CCAnimationManager*) sharedAnimationManager;

#pragma mark  --将数据加载到缓存中，提高程序的运行效率
-(void) AddAllAnima;

//生成动画的主函数
-(CCAnimation *)NomalAnima:(NSString *)animPlist FrameName:(NSString*)FrameName FrameCount:(int)nCount delay:(float)delay;

//扩展动画，加入起始的针序号
-(CCAnimation *)AnimationEx:(NSString *)animPlist FrameName:(NSString*)FrameName StartFrame:(int)nStar FrameCount:(int)nCount delay:(float)delay;
@end
