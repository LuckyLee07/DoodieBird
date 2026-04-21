//
//  AppDelegate.m
//  DoodieBird
//
//  Created by LuckyLee on 26-04-22.
//  Copyright FancyGame 2026年. All rights reserved.
//

#import "cocos2d.h"

#import "AppDelegate.h"
#import "MusicMannger.h"
#import "MainMenuSence.h"

@interface LandscapeNavigationController : UINavigationController
@end

@implementation LandscapeNavigationController

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeRight;
}

@end

@implementation AppController

@synthesize window=window_, navController=navController_, director=director_;

- (BOOL)usesSceneLifecycle
{
    if (@available(iOS 13.0, *))
    {
        return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"UIApplicationSceneManifest"] != nil;
    }

    return NO;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    (void)application;
    (void)launchOptions;
	return YES;
}

- (void)configureMainInterfaceInWindow:(UIWindow *)window
{
    if (window_ != window)
    {
        [window_ release];
        window_ = [window retain];
    }

    if (director_ != nil)
    {
        [window_ setRootViewController:navController_];
        [window_ makeKeyAndVisible];
        return;
    }

 	// Create an CCGLView with a RGB565 color buffer, and a depth buffer of 0-bits
	CCGLView *glView = [CCGLView viewWithFrame:[window_ bounds]
								   pixelFormat:kEAGLColorFormatRGB565	//kEAGLColorFormatRGBA8
								   depthFormat:0	//GL_DEPTH_COMPONENT24_OES
							preserveBackbuffer:NO
									sharegroup:nil
								 multiSampling:NO
							   numberOfSamples:0];
    [glView setMultipleTouchEnabled:YES];
	director_ = (CCDirectorIOS*) [CCDirector sharedDirector];

	// Display FSP and SPF
	//[director_ setDisplayStats:YES];
    //[director_ setDisplayStats:FALSE];

	// set FPS at 60
	[director_ setAnimationInterval:1.0/60];

	// attach the openglView to the director
	[director_ setView:glView];

	// for rotation and other messages
	[director_ setDelegate:self];

	// 2D projection
	[director_ setProjection:kCCDirectorProjection2D];
//	[director setProjection:kCCDirectorProjection3D];

	// Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
	if( ! [director_ enableRetinaDisplay:YES] )
		CCLOG(@"Retina Display Not supported");

	// Create a Navigation Controller with the Director
	navController_ = [[LandscapeNavigationController alloc] initWithRootViewController:director_];
	navController_.navigationBarHidden = YES;

		// iOS requires a root view controller by the end of launch.
		[window_ setRootViewController:navController_];

	// make main window visible
	[window_ makeKeyAndVisible];

	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];

	// If the 1st suffix is not found and if fallback is enabled then fallback suffixes are going to searched. If none is found, it will try with the name without suffix.
	// On iPad HD  : "-ipadhd", "-ipad",  "-hd"
	// On iPad     : "-ipad", "-hd"
	// On iPhone HD: "-hd"
	CCFileUtils *sharedFileUtils = [CCFileUtils sharedFileUtils];
	[sharedFileUtils setEnableFallbackSuffixes:NO];				// Default: NO. No fallback suffixes are going to be used
	[sharedFileUtils setiPhoneRetinaDisplaySuffix:@"-hd"];		// Default on iPhone RetinaDisplay is "-hd"
	[sharedFileUtils setiPadSuffix:@"-ipad"];					// Default on iPad is "ipad"
	[sharedFileUtils setiPadRetinaDisplaySuffix:@"-ipadhd"];	// Default on iPad RetinaDisplay is "-ipadhd"

	// Assume that PVR images have premultiplied alpha
	[CCTexture2D PVRImagesHavePremultipliedAlpha:YES];

	// and add the main menu scene to the stack.
    [director_ runWithScene:[MainMenuSence ShowScene]];
    //Add by zhengxf about "" 2012-8-21 ------begin-------
    MusicMannger* pMusicMgr = [MusicMannger sharedMusicMannger];
    if(pMusicMgr)
    {
        [pMusicMgr PlayMusic:@"MusicBk.mp3" :true];
    }
    //Add by zhengxf about "" 2012-8-21 ------end-------
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    (void)application;
    (void)deviceToken;
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    (void)application;
    (void)window;
    return UIInterfaceOrientationMaskLandscape;
}

// Supported orientations: Landscape. Customize it for your own needs
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

// getting a call, pause the game
-(void) applicationWillResignActive:(UIApplication *)application
{
    (void)application;
    if ([self usesSceneLifecycle]) {
        return;
    }
    [self sceneWillResignActive];
}

// call got rejected
-(void) applicationDidBecomeActive:(UIApplication *)application
{
    (void)application;
    if ([self usesSceneLifecycle]) {
        return;
    }
    [self sceneDidBecomeActive];
}

-(void) applicationDidEnterBackground:(UIApplication*)application
{
    (void)application;
    if ([self usesSceneLifecycle]) {
        return;
    }
    [self sceneDidEnterBackground];
}

-(void) applicationWillEnterForeground:(UIApplication*)application
{
    (void)application;
    if ([self usesSceneLifecycle]) {
        return;
    }
    [self sceneWillEnterForeground];
}

// application will be killed
- (void)applicationWillTerminate:(UIApplication *)application
{
	CC_DIRECTOR_END();
}

- (void)application:(UIApplication *)application didChangeStatusBarOrientation:(UIInterfaceOrientation)oldStatusBarOrientation
{
    (void)application;
    (void)oldStatusBarOrientation;
}

// purge memory
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
	[[CCDirector sharedDirector] purgeCachedData];
}

// next delta time will be zero
-(void) applicationSignificantTimeChange:(UIApplication *)application
{
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (void)sceneWillResignActive
{
	if( [navController_ visibleViewController] == director_ )
		[director_ pause];
}

- (void)sceneDidBecomeActive
{
	if( [navController_ visibleViewController] == director_ )
		[director_ resume];
}

- (void)sceneDidEnterBackground
{
	if( [navController_ visibleViewController] == director_ )
		[director_ stopAnimation];
}

- (void)sceneWillEnterForeground
{
	if( [navController_ visibleViewController] == director_ )
		[director_ startAnimation];
}

- (void) dealloc
{
	[window_ release];
	[navController_ release];
	[super dealloc];
}
@end
