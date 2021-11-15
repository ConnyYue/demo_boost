//
//  AppDelegate.m
//  Runner
//
//  Created by yuechen on 2021/11/15.
//  Copyright © 2021 TAL-Engineering. All rights reserved.
//

#import "AppDelegate.h"
#import "MyFlutterBoostDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    MyFlutterBoostDelegate* delegate=[[MyFlutterBoostDelegate alloc ] init];
    [[FlutterBoost instance] setup:application delegate:delegate callback:^(FlutterEngine *engine) { }];
    
    UIViewController *tabVC = [[UIViewController alloc] init];
    UINavigationController *rvc = [[UINavigationController alloc] initWithRootViewController:tabVC];
    delegate.navigationController=rvc;
    self.window.rootViewController = rvc;
    
    UIButton *nativeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nativeButton.frame = CGRectMake(self.window.frame.size.width * 0.5 - 60, 100, 120, 40);
    nativeButton.backgroundColor = [UIColor redColor];
    [nativeButton setTitle:@"跳转原生页" forState:UIControlStateNormal];
    [nativeButton addTarget:self action:@selector(pushNative) forControlEvents:UIControlEventTouchUpInside];
    [self.window addSubview:nativeButton];
    
    UIButton *pushEmbeded = [UIButton buttonWithType:UIButtonTypeCustom];
    pushEmbeded.frame = CGRectMake(self.window.frame.size.width * 0.5 - 60, 150, 120, 40);
    pushEmbeded.backgroundColor = [UIColor redColor];
    [pushEmbeded setTitle:@"跳转混合页" forState:UIControlStateNormal];
    [pushEmbeded addTarget:self action:@selector(pushEmbeded) forControlEvents:UIControlEventTouchUpInside];
    [self.window addSubview:pushEmbeded];
    
    return YES;
}

- (void)pushNative
{
    UINavigationController *nvc = (id)self.window.rootViewController;
    UIViewController *vc = [[UIViewController alloc] init];
    [nvc pushViewController:vc animated:YES];
}

- (void)pushEmbeded
{
    UINavigationController *nvc = (id)self.window.rootViewController;
    UIViewController *vc = [[UIViewController alloc] init];
    [nvc pushViewController:vc animated:YES];
}

- (void)applicationWillResignActive:(UIApplication *)application {}

- (void)applicationDidEnterBackground:(UIApplication *)application {}

- (void)applicationWillEnterForeground:(UIApplication *)application {}

- (void)applicationDidBecomeActive:(UIApplication *)application {}

- (void)applicationWillTerminate:(UIApplication *)application {}

@end
