//
//  SceneDelegate.m
//  DoodieBird
//

#import "SceneDelegate.h"

#import "AppDelegate.h"

@implementation SceneDelegate

@synthesize window = window_;

- (void)scene:(UIScene *)scene
willConnectToSession:(UISceneSession *)session
      options:(UISceneConnectionOptions *)connectionOptions
{
    (void)session;
    (void)connectionOptions;

    if (![scene isKindOfClass:[UIWindowScene class]])
    {
        return;
    }

    self.window = [[[UIWindow alloc] initWithWindowScene:(UIWindowScene *)scene] autorelease];

    AppController *appController = (AppController *)[UIApplication sharedApplication].delegate;
    [appController configureMainInterfaceInWindow:self.window];
}

- (void)sceneDidDisconnect:(UIScene *)scene
{
    (void)scene;
    self.window = nil;
}

- (void)sceneDidBecomeActive:(UIScene *)scene
{
    (void)scene;
    AppController *appController = (AppController *)[UIApplication sharedApplication].delegate;
    [appController sceneDidBecomeActive];
}

- (void)sceneWillResignActive:(UIScene *)scene
{
    (void)scene;
    AppController *appController = (AppController *)[UIApplication sharedApplication].delegate;
    [appController sceneWillResignActive];
}

- (void)sceneWillEnterForeground:(UIScene *)scene
{
    (void)scene;
    AppController *appController = (AppController *)[UIApplication sharedApplication].delegate;
    [appController sceneWillEnterForeground];
}

- (void)sceneDidEnterBackground:(UIScene *)scene
{
    (void)scene;
    AppController *appController = (AppController *)[UIApplication sharedApplication].delegate;
    [appController sceneDidEnterBackground];
}

- (void)dealloc
{
    [window_ release];
    [super dealloc];
}

@end
