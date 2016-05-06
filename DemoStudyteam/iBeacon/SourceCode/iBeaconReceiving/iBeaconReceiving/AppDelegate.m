//
//  AppDelegate.m
//  iBeaconReceiving
//
//  Created by Tiep Nguyen on 5/25/15.
//  Copyright (c) 2015 Tiep Nguyen. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self requestLocaltionPermission:application];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//for iOS7
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    UIAlertView * av = [[UIAlertView alloc] initWithTitle:@"Find the iBeacon"
                                                  message:notification.alertBody
                                                 delegate:NULL
                                        cancelButtonTitle:@"OK"
                                        otherButtonTitles:nil, nil];
    [av show];
}

//for iOS8
//- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void(^)())completionHandler{
//    UIAlertView * av = [[UIAlertView alloc] initWithTitle:@"Find the treasure"
//                                                  message:notification.alertBody
//                                                 delegate:NULL
//                                        cancelButtonTitle:@"OK"
//                                        otherButtonTitles:nil, nil];
//    [av show];
//}

- (void)requestLocaltionPermission:(UIApplication *)application {
    //uilocalnotification request permission. Consult: http://stackoverflow.com/questions/24100313/ask-for-user-permission-to-receive-uilocalnotifications-in-ios-8
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]){
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
}
@end
