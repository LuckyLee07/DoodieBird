//
//  AppDelegate.h
//  DoodieBird
//
//  Created by LuckyLee on 26-04-22.
//  Copyright FancyGame 2026年. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

@interface AppController : NSObject <UIApplicationDelegate, CCDirectorDelegate>
{
	UIWindow *window_;
	UINavigationController *navController_;

	CCDirectorIOS	*director_;							// weak ref
}

@property (nonatomic, retain) UIWindow *window;
@property (readonly) UINavigationController *navController;
@property (readonly) CCDirectorIOS *director;

- (void)configureMainInterfaceInWindow:(UIWindow *)window;
- (void)sceneWillResignActive;
- (void)sceneDidBecomeActive;
- (void)sceneDidEnterBackground;
- (void)sceneWillEnterForeground;

@end
