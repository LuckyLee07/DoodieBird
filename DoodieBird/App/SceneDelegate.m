//
//  SceneDelegate.m
//  DoodieBird
//

#import "SceneDelegate.h"

#import "AppDelegate.h"

@implementation SceneDelegate

@synthesize window = window_;

- (AppController *)appController
{
    id<UIApplicationDelegate> delegate = [UIApplication sharedApplication].delegate;
    if ([delegate isKindOfClass:[AppController class]])
    {
        return (AppController *)delegate;
    }
    return nil;
}

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

    AppController *appController = [self appController];
    if (appController == nil)
    {
        return;
    }
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
    AppController *appController = [self appController];
    [appController sceneDidBecomeActive];
}

- (void)sceneWillResignActive:(UIScene *)scene
{
    (void)scene;
    AppController *appController = [self appController];
    [appController sceneWillResignActive];
}

- (void)sceneWillEnterForeground:(UIScene *)scene
{
    (void)scene;
    AppController *appController = [self appController];
    [appController sceneWillEnterForeground];
}

- (void)sceneDidEnterBackground:(UIScene *)scene
{
    (void)scene;
    AppController *appController = [self appController];
    [appController sceneDidEnterBackground];
}

- (void)dealloc
{
    [window_ release];
    [super dealloc];
}

@end
