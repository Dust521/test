//
//  AppDelegate.m
//  0008
//
//  Created by 董亮 on 2018/8/7.
//  Copyright © 2018年 董亮. All rights reserved.
//

#import "AppDelegate.h"
#import "DLTabbarController.h"
#import "DLLoginpageViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //创建window
    self.window = [[UIWindow alloc]initWithFrame:KScreenSzie];
    
    //创建tabbarController
    //DLTabbarController *tabbarController = [[DLTabbarController alloc]init];
     DLLoginPageViewController *loginPageViewController = [[DLLoginPageViewController alloc]init];
//    //获取四个子控制器
//    UIViewController *v1 = [self loadSubViewControllerWithSBName:@"Home"];
//    UIViewController *v2 = [self loadSubViewControllerWithSBName:@"Recommend"];
//    UIViewController *v3 = [self loadSubViewControllerWithSBName:@"Retrospect"];
//    UIViewController *v4 = [self loadSubViewControllerWithSBName:@"Mine"];
//    
//    
//    
//    //设置tabbarController 子控制器
//    tabbarController.viewControllers = @[v1,v2,v3,v4];
//   
  
    
    //window设置根控制器
    //self.window.rootViewController = tabbarController;
    self.window.rootViewController = loginPageViewController;
    //window显示
    [self.window makeKeyAndVisible];
    return YES;
}

//根据sb名字返回这个sb箭头所指向的控制器

//-(UIViewController *)loadSubViewControllerWithSBName:(NSString *)name{
//    //获取sb对象
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:name bundle:nil];
//    return  [sb instantiateInitialViewController];
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
