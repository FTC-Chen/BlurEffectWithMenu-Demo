//
//  AppDelegate.m
//  BlurEffectWithMenu
//
//  Created by anyongxue on 2016/11/29.
//  Copyright © 2016年 cc. All rights reserved.
//

#import "AppDelegate.h"
#import "guideView.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //更新增加,启动页,
    //启动页的方式:1.创建VC,第一次进入到启动页VC;2.创建View,第一个加载View,之后隐藏,去掉
    //写进东西的方式可以是1.NSUserDefaults  2.沙盒中创建一个plist文件
    
    //添加启动页面
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLogin"]) {
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLogin"];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLogin"];
    
    }else{
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLogin"];
    }
    
    
    //如果是第一次登陆
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLogin"]) {
        
        //添加启动页面
        guideView *guide = [[guideView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        
        [self.window.rootViewController.view addSubview:guide];
        
        [UIView animateWithDuration:0.35 animations:^{
            
            guide.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
            
        }];

    }
    
    
    
    return YES;
}


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
