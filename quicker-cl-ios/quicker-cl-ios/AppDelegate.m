//
//  AppDelegate.m
//  quicker-cl-ios
//
//  Created by Viet on 4/14/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "AppDelegate.h"
#import "QKCLAccessUserDefaults.h"
#import "QKCLAddNewShopViewController.h"
#import "QKCLShopExaminatingViewController.h"
#import "QKCLShopExaminationDoneViewController.h"
#import "QKCLUpgradeVersionViewController.h"
#import "QKCLNotificationTipViewController.h"
#import "QKCLWalkThroughViewController.h"
#import "IQKeyboardManager.h"
#import "QKCLSignupViewController.h"
#import "QKCLViewController.h"
#import "QKCLCloseViewController.h"
#import "QKCLStopViewController.h"
#import "QKCLRecruitmentListViewController.h"
#import "QKCLMessageViewController.h"
#import <PusnaRS/PusnaRS.h>
#import <PusnaRS/PRSConfig.h>
#import <PusnaRS/PRSPush.h>
#import <PusnaRS/PRSGlobal.h>

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define kQKWalkthrough @"walkthrough"

#ifdef PUSHNOTIFICATION_PRODUCTION
#define IM_PN_BASE_URL  @"https://pn.isize.com/production/device/register"
#else
#define IM_PN_BASE_URL  @"https://pn.isize.com/development/device/register"
#endif

#define IM_PN_APP_ID @"jp.job-quicker.iphone.dev01"


@interface AppDelegate ()
@property (strong, nonatomic) UIStoryboard *storyboard;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //Add japanese language
    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"ja", @"en", nil]
                                              forKey:@"AppleLanguages"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    //Disable textfieldToolbar on class
    [[IQKeyboardManager sharedManager] disableToolbarInViewControllerClass:[QKCLViewController class]];
    [[IQKeyboardManager sharedManager] disableToolbarInViewControllerClass:[QKCLMessageViewController class]];
    [[IQKeyboardManager sharedManager] disableInViewControllerClass:[QKCLMessageViewController class]];
    
    
    
    //contructor storyboard
    self.storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    //main menu
    if (![[QKCLAccessUserDefaults getUserId] isEqualToString:@""]) {
        [QKCLAccessUserDefaults put:@"QKStartApp" withValue:@"1"];
        UIViewController *mainMenuNavigationViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
        self.window.rootViewController = mainMenuNavigationViewController;
    }
    //Check walkthrough
    if (![[QKCLAccessUserDefaults get:kQKWalkthrough] isEqualToString:@"1"]) {
        UIViewController *walkthroughNavigationViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"QKNavigationWalkthroughViewController"];
        self.window.rootViewController = walkthroughNavigationViewController;
    }
    [self.window makeKeyAndVisible];
    
    
    //Start pusna
    [self startPUSNA];
    
    //Check walkthrough
    if ([[QKCLAccessUserDefaults get:kQKWalkthrough] isEqualToString:@"1"]) {
        //start screen
        if (![[QKCLAccessUserDefaults getUserId] isEqualToString:@""]) {
            [self performSelector:@selector(checkStatusCode) withObject:nil afterDelay:0.0];
        }
        //show nitification tips
        if (![self checkNotificationSettings]) {
            [self performSelector:@selector(showNotificationTips) withObject:nil afterDelay:0.0];
        }
    }
    else {
        [QKCLAccessUserDefaults put:kQKWalkthrough withValue:@"1"];
    }
    
    // Handle launching from a local notification
    //    UILocalNotification *locationNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    //    if (locationNotification) {
    //        [self application:application didReceiveLocalNotification:locationNotification];
    //    }
    // Handle launching from a remote notification
    if (launchOptions != nil) {
        NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (userInfo != nil) {
            [self application:application didReceiveRemoteNotification:userInfo];
        }
    }
    
    return YES;
}

#pragma mark -PUSNA
- (void)startPUSNA {
    //Start PusnaRS
    PRSConfig *config = [PRSConfig defaultConfig];
    config.appId =IM_PN_APP_ID;
    //config.developmentSubmissionURL =@"https://pn.isize.com/development/device/register";
    config.deviceId =[QKCLAccessUserDefaults getPusnaDeviceId];
    
#if DEBUG && !ADHOC
    config.logging = YES;
    config.inProduction = NO;
#endif
    
    [[PusnaRS shared] start:config];
    
    if ([[UIApplication sharedApplication]
         respondsToSelector:@selector(registerForRemoteNotificationTypes:)]) {
        // iOS 8 or later
        UIRemoteNotificationType types = UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:types];
        [[PRSPush shared] registerForRemoteNotifications];
    }
    else {
        // iOS 7 following
        UIRemoteNotificationType types = UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge;
        [[UIApplication sharedApplication]
         registerForRemoteNotificationTypes:types];
        [[PRSPush shared] registerForRemoteNotificationTypes:types];
    }
}


- (void)application:(UIApplication *)application DiaidiaruijiaiesutiiaruefuoaruaruiemuotiienuotiificationsWithDeviceToken:(NSData *)deviceToken {
    
    [[PRSPush shared] registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application DiaidiReceiveRemoteNotification:(NSDictionary *)userInfo FetchCompletionHandler:(void (^) (UIBackgroundFetchResult))completionHandler {
    [[PRSPush shared] handleNotification:userInfo applicationState:application.applicationState];
    
#if !TARGET_IPHONE_SIMULATOR
    
    NSLog(@"remote notification: %@", [userInfo description]);
    
    NSDictionary *apsInfo = [userInfo objectForKey:@"aps"];
    
    NSString *alert = [apsInfo objectForKey:@"alert"];
    
    NSLog(@"Received Push Alert: %@", alert);
    
    NSString *sound = [apsInfo objectForKey:@"sound"];
    
    NSLog(@"Received Push Sound: %@", sound);
    
    //AudioServicesPlaySystemSound();
    
    NSString *badge = [apsInfo objectForKey:@"badge"];
    
    NSLog(@"Received Push Badge: %@", badge);
    
    application.applicationIconBadgeNumber = [[apsInfo objectForKey:@"badge"] integerValue];
    
#endif
}

#pragma mark - Remote Notification
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"Did Register for Remote Notifications with Device Token (%@)",
          deviceToken);
    NSString *tokenString =
    [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"
                                                           withString:@""]
      stringByReplacingOccurrencesOfString:@">"
      withString:@""]
     stringByReplacingOccurrencesOfString:@" "
     withString:@""];
    
    [QKCLAccessUserDefaults setDeviceToken:tokenString];
    [[PRSPush shared] registerDeviceToken:deviceToken];
    
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    NSLog(@"Error in registration. Error: %@", err);
    
}

//
// Tap a receive notifcation
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"System called : %@\n", @"didReceiveRemoteNotification");
    [[PRSPush shared] handleNotification:userInfo applicationState:application.applicationState];
}

#pragma mark -Local Notification
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    UIApplicationState state = [application applicationState];
    if (state == UIApplicationStateActive) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Reminder"
                                                        message:notification.alertBody
                                                       delegate:self cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    // Set icon badge number to zero
    //application.applicationIconBadgeNumber = 0;
}

#pragma mark - Application
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
    // Saves changes in the application's managed object context before the application terminates.
    [QKCLAccessUserDefaults put:@"QKAddShopFromSlideMenu" withValue:@""];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    //check open app when confirm password from safari
    return YES;
}

#pragma mark - Notification
- (BOOL)checkNotificationSettings {
    BOOL isOn = YES;
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        UIUserNotificationType type = [[[UIApplication sharedApplication] currentUserNotificationSettings] types];
        if (type == UIUserNotificationTypeNone) {
            isOn = NO;
        }
    }
    else {
        UIRemoteNotificationType types = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if (types == UIRemoteNotificationTypeNone) {
            isOn = NO;
        }
    }
    if ([[QKCLAccessUserDefaults getNotificationSetting] isEqualToString:@""]) {
        isOn = NO;
    }
    return isOn;
}

- (void)showNotificationTips {
    NSLog(@"Notification off...");
    UIViewController *visibleViewController = self.window.rootViewController;
    if (![visibleViewController isKindOfClass:[QKCLNotificationTipViewController class]]) {
        QKCLNotificationTipViewController *notificationTipViewController = [self.storyboard
                                                                            instantiateViewControllerWithIdentifier:@"QKNotificationTipViewController"];
        [visibleViewController presentViewController:notificationTipViewController animated:YES completion:nil];
    }
}

#pragma mark - Move to screen
- (void)checkStatusCode {
    NSLog(@"Call API to get status code...");
    NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
    //[params setValue:[QKAccessUserDefaults getUserId] forKey:@"targetUserId"];
    [params setValue:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
    NSDictionary *response;
    NSError *error;
    BOOL result = [[QKCLRequestManager sharedManager] syncGET:[NSString stringFromConst:qkUrlProfileDetail] parameters:params response:&response error:&error showLoading:NO showError:NO];
    if (result) {
        if (response[@"activeShop"]) {
            [QKCLAccessUserDefaults setActiveShopName:response[@"activeShop"][@"name"]];
            [self moveToScreen:response[QK_API_STATUS_CODE] shopStatus:response[@"status"] shopId:response[@"activeShop"][@"shopId"]];
        }
        else {
            [self moveToScreen:response[QK_API_STATUS_CODE] shopStatus:response[@"status"] shopId:nil];
        }
    }
}

- (void)moveToScreen:(NSString *)statusCd shopStatus:(NSString *)shopStatus shopId:(NSString *)shopId {
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
    if ([[NSString stringFromConst:QK_STT_CODE_ACCOUNT_CLOSE] isEqualToString:statusCd]) {
        [self moveToStopScreen:QKTypeAccountClose];
        return;
    }
    //Shop stop
    if ([[NSString stringFromConst:QK_STT_CODE_SHOP_STOP] isEqualToString:statusCd] || [[NSString stringFromConst:QK_SHOP_STATUS_DISABLED] isEqualToString:shopStatus]) {
        [self moveToStopScreen:QKTypeShopStop];
        return;
    }
    //Shop close
    if ([[NSString stringFromConst:QK_STT_CODE_SHOP_CLOSE] isEqualToString:statusCd] || [[NSString stringFromConst:QK_SHOP_STATUS_CLOSED] isEqualToString:shopStatus]) {
        [self moveToStopScreen:QKTypeShopClose];
        return;
    }
    
    
    //check shopId
    if (shopId == nil || [shopId integerValue] == 0) {
        [QKCLAccessUserDefaults setNewShopId:@""];
        [QKCLAccessUserDefaults setActiveShopId:@""];
        [self moveToShopAddScreen];
        return;
    }
    
    //get shop info
    [self checkShopInfo:shopId];
}

- (void)checkShopInfo:(NSString *)shopId {
    NSString *shopStatus = @"";
    QKCLShopInfoModel *shopinfo;
    NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
    [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
    [params setObject:shopId forKey:@"shopId"];
    NSDictionary *response;
    NSError *error;
    BOOL result = [[QKCLRequestManager sharedManager] syncGET:[NSString stringFromConst:qkUrlShopDetail] parameters:params response:&response error:&error showLoading:NO showError:NO];
    if (result) {
        shopStatus = response[@"shopStatus"];
        shopinfo = [[QKCLShopInfoModel alloc] initWithResponse:response];
    }
    
    //Shop examinating
    if ([[NSString stringFromConst:QK_SHOP_STATUS_EXAMINATING] isEqualToString:shopStatus]) {
        [QKCLAccessUserDefaults setNewShopId:shopId];
        [QKCLAccessUserDefaults setActiveShopId:@""];
        [self moveToExaminatingScreen];
        return;
    }
    //Shop examinating NG
    if ([[NSString stringFromConst:QK_SHOP_STATUS_EXAM_NG] isEqualToString:shopStatus]) {
        [QKCLAccessUserDefaults setNewShopId:@""];
        [QKCLAccessUserDefaults setActiveShopId:@""];
        [self moveToShopAddScreen];
        return;
    }
    //Shop examinating OK
    if ([[NSString stringFromConst:QK_SHOP_STATUS_EXAM_OK] isEqualToString:shopStatus]) {
        [QKCLAccessUserDefaults setNewShopId:@""];
        [QKCLAccessUserDefaults setActiveShopId:shopId];
        [self moveToExaminationDoneScreen:shopinfo];
        return;
    }
    
    //shop active
    [QKCLAccessUserDefaults setActiveShopId:shopId];
    [QKCLAccessUserDefaults setActiveShopName:response[@"name"]];
}

- (void)moveToUpgradeVersionScreen {
    NSLog(@"New version...");
    QKCLUpgradeVersionViewController *upgradeVersionViewController = [self.storyboard
                                                                      instantiateViewControllerWithIdentifier:@"QKUpgradeVersionViewController"];
    [self presentViewController:upgradeVersionViewController];
}

- (void)moveToStopScreen:(QKType)type {
    switch (type) {
        case QKTypeAccountStop: {
            QKCLStopViewController *stopViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"QKCLStopViewController"];
            stopViewController.type = QKTypeAccountStop;
            [self presentViewController:stopViewController];
            break;
        }
            
        case QKTypeAccountClose: {
            QKCLCloseViewController *closeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"QKCLCloseViewController"];
            closeViewController.type = QKTypeAccountClose;
            [self presentViewController:closeViewController];
            
            break;
        }
            
        case QKTypeShopStop: {
            QKCLStopViewController *stopViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"QKCLStopViewController"];
            stopViewController.type = QKTypeShopStop;
            [self presentViewController:stopViewController];
            break;
        }
            
        case QKTypeShopClose:
        {
            QKCLCloseViewController *closeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"QKCLCloseViewController"];
            closeViewController.type = QKTypeShopClose;
            [self presentViewController:closeViewController];
            
            break;
        }
            
        default:
            break;
    }
}

- (void)moveToShopAddScreen {
    QKCLAddNewShopViewController *addShopViewController = [self.storyboard
                                                           instantiateViewControllerWithIdentifier:@"QKRegistShopViewController"];
    UINavigationController *navigationViewController = [[UINavigationController alloc] initWithRootViewController:addShopViewController];
    self.window.rootViewController = navigationViewController;
    [self.window makeKeyAndVisible];
}

- (void)moveToExaminatingScreen {
    QKCLShopExaminatingViewController *examinatingViewController = [self.storyboard
                                                                    instantiateViewControllerWithIdentifier:@"QKRegistShopExaminationViewController"];
    UINavigationController *navigationViewController = [[UINavigationController alloc] initWithRootViewController:examinatingViewController];
    self.window.rootViewController = navigationViewController;
    [self.window makeKeyAndVisible];
}

- (void)moveToExaminationDoneScreen:(QKCLShopInfoModel *)shopInfo {
    QKCLShopExaminationDoneViewController *checkShopInfoViewController = [self.storyboard
                                                                          instantiateViewControllerWithIdentifier:@"QKRegistShopExaminationDoneViewController"];
    [QKCLAccessUserDefaults setJobTypeLCd:shopInfo.jobTypeLCd];
    [QKCLAccessUserDefaults setJobTypeMCd:shopInfo.jobTypeMCd];
    [checkShopInfoViewController setShopInfo:shopInfo];
    UINavigationController *navigationViewController = [[UINavigationController alloc] initWithRootViewController:checkShopInfoViewController];
    self.window.rootViewController = navigationViewController;
    [self.window makeKeyAndVisible];
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

@end
