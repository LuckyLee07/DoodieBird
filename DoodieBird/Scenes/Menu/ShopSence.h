//
//  ShopSence.h
//  DoodieBird
//
//  Created by LuckyLee on 26-04-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"

#define FREE_ICON_INDEX  100

#define BUY_BUTTON_INDEX 200



@interface ShopLayer : CCLayer
{

}
-(void) AddFreeIcon;
-(void) AddBuyIcon;
@end

@interface ShopSence : CCScene 
{
    
}
+(id) ShowScene;
@end

