//
//  AppDelegate.m
//  quicker-cs-ios
//
//  Created by Viet on 4/13/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "AppDelegate.h"
#import "QKAccessUserDefaults.h"
#import "QKGlobalDefines.h"
#import "QKCSWalkThroughViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "QKCSUpgradeVersionViewController.h"
#import "QKCSCloseViewController.h"
#import "QKCSStopViewController.h"
#import "IQKeyboardManager.h"
#import "QKCSMessageViewController.h"

@interface AppDelegate ()
@property (strong, nonatomic) UIStoryboard *storyboard;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //check Internet
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    //Add japanese language
    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"ja", @"en", nil]
                                              forKey:@"AppleLanguages"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //Disable IQkeyboardManager
    [[IQKeyboardManager sharedManager] disableToolbarInViewControllerClass:[QKCSMessageViewController class]];
    [[IQKeyboardManager sharedManager] disableInViewControllerClass:[QKCSMessageViewController class]];
    
    //contructor storyboard
    self.storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    //	make window
    if (![[QKAccessUserDefaults getUserId] isEqualToString:@""]) {
        //root is main menu
        [QKAccessUserDefaults put:@"StartApp" withValue:@"1"];
        UIViewController *mainMenuNavigationViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"QKNavigationMainMenuViewController"];
        self.window.rootViewController = mainMenuNavigationViewController;
        [self.window makeKeyAndVisible];
        [self checkStatusCode];
    }
    else {
        //show Walkthrough
        UIViewController *walkthroughNavigationViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"QKNavigationWalkthroughViewController"];
        self.window.rootViewController = walkthroughNavigationViewController;
        [self.window makeKeyAndVisible];
    }
    
    return YES;
}

#pragma mark -Actions


- (void)checkStatusCode {
    NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
    [params setObject:[QKAccessUserDefaults getUserId] forKey:@"userId"];
    
    [[QKRequestManager sharedManager]GET:[NSString stringFromConst:qkCSUrlProfileDetail] parameters:params success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        [QKAccessUserDefaults setNotificationSetting:responseObject[@"pushOn"]];
        [QKAccessUserDefaults setToken:responseObject[@"accessToken"]];
        [QKAccessUserDefaults setExpireDate:responseObject[@"expireDt"]];
        
        [self moveToScreen:responseObject[QK_API_STATUS_CODE]];
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error:%@", error);
    }];
}

- (void)moveToScreen:(NSString *)statusCd {
    //new version
    if ([[NSString stringFromConst:QK_STT_CODE_NEW_VERSION] isEqualToString:statusCd]) {
        [self moveToUpgradeVersionScreen];
        return;
    }
    //account stop
    if ([[NSString stringFromConst:QK_STT_CODE_ACCOUNT_STOP] isEqualToString:statusCd]) {
        [self moveToStopScreen:QKTypeAccountStop];
        return;
    }
    //account close
    if ([[NSString stringFromConst:QK_STT_CODE_ACCOUNT_CLOSED] isEqualToString:statusCd]) {
        [self moveToStopScreen:QKTypeAccountClose];
        return;
    }
}

- (void)moveToUpgradeVersionScreen {
    NSLog(@"New version...");
    QKCSUpgradeVersionViewController *upgradeVersionViewController = [self.storyboard
                                                                      instantiateViewControllerWithIdentifier:@"QKUpgradeVersionViewController"];
    [self presentViewController:upgradeVersionViewController];
}

- (void)moveToStopScreen:(QKType)type {
    switch (type) {
        case QKTypeAccountStop: {
            QKCSStopViewController *stopViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"QKCSStopViewController"];
            stopViewController.type = QKTypeAccountStop;
            [self presentViewController:stopViewController];
            break;
        }
            
        case QKTypeAccountClose: {
            QKCSCloseViewController *closeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"QKCSCloseViewController"];
            closeViewController.type = QKTypeAccountClose;
            [self presentViewController:closeViewController];
            
            break;
        }
            
        default:
            break;
    }
}

- (void)presentViewController:(UIViewController *)viewController {
    UIViewController *rootViewController = self.window.rootViewController;
    if (rootViewController.presentedViewController) {
        [rootViewController.presentedViewController dismissViewControllerAnimated:YES completion: ^{
            //present upgrade screen
            [rootViewController presentViewController:viewController animated:YES completion:nil];
        }];
    }
    else {
        //present upgrade screen
        [rootViewController presentViewController:viewController animated:YES completion:nil];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [QKAccessUserDefaults setRecruitmentFilter:nil];
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
    // Saves changes in the application's managed object context before the application terminates.
    //[self saveContext];
    [QKAccessUserDefaults setRecruitmentFilter:nil];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

@end
