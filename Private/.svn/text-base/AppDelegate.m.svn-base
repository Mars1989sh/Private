//
//  AppDelegate.m
//  Private
//
//  Created by Mars on 14/11/5.
//  Copyright (c) 2014年 MarsZhang. All rights reserved.
//

#import "AppDelegate.h"
#import "TestViewController.h"
#define AUTOTIME @"auto_time"
#define FIRST @"first_start"


@interface AppDelegate ()
{
    NSInteger _time;
    TestViewController *lockVc;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
#if TARGET_IPHONE_SIMULATOR
    // where are you?
    NSLog(@"Documents Directory: %@", [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);
#endif
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSTimeInterval date = [[NSDate date] timeIntervalSince1970];
    _time = date;
    [lockVc.view removeFromSuperview];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}



- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    BOOL first = ([[NSUserDefaults standardUserDefaults] valueForKey:FIRST]) ? YES: NO;
    if (first) {
        BOOL isPatternSet = ([[NSUserDefaults standardUserDefaults] valueForKey:kCurrentPattern]) ? YES: NO;
        lockVc = [[TestViewController alloc]init];
        if(self.window.rootViewController.presentingViewController == nil && isPatternSet){
            NSTimeInterval date = [[NSDate date] timeIntervalSince1970];
            NSUserDefaults *stdDefault = [NSUserDefaults standardUserDefaults];
            NSInteger autoLock = [[stdDefault valueForKey:AUTOTIME] integerValue];
            if ((date-_time) >= autoLock*60) {
                lockVc.infoLabelStatus = InfoStatusNormal;
                NSLog(@"%@ root",self.window.rootViewController);
                [self.window addSubview:lockVc.view];
//                [self.window.rootViewController presentViewController:lockVc animated:NO completion:^{}];
                
            }
        }else{
            lockVc.infoLabelStatus = InfoStatusFirstTimeSetting;
            [self.window addSubview:lockVc.view];
//            [self.window.rootViewController presentViewController:lockVc animated:NO completion:^{}];
        }
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
