//
//  PRSPush.h
//  PusnaRS
//
//  Created by KOSHIDA Takayoshi on 2013/10/02.
//  Copyright (c) 2013年 RSD. All rights reserved.
//

#import "PRSGlobal.h"

/*!
 @class PRSPush
 
 Pusna-RSへのPush関連の登録などを行います。
 */
@interface PRSPush : NSObject

PRS_SINGLETON_INTERFACE(PRSPush);

@property (nonatomic, copy, readonly) NSString *deviceToken;

/*!
 デバイスのRemote Notification登録を行います。
 
 -[UIApplication registerForRemoteNotifications] のwrapperとなりますが、
 当メソッドを代わりに呼ぶようにしてください。
 その際、UIUserNotificationSettingsの登録も必ず別途行うようにしてください。
 
 当メソッドはiOS8以降でのみ利用可能です。
 iOS7以下では -registerForRemoteNotificationTypes: を呼ぶように分岐してください。
 
 実装例：
 <pre>
 if ([[UIApplication sharedApplication] respondsToSelector:NSSelectorFromString(@"registerUserNotificationSettings:")]) {
    UIUserNotificationType types = UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge;
    NSSet *categories = [NSSet setWithObjects:inviteCategory, alarmCategory, ...];
    UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:categories];
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
 
    [[PRSPush shared] registerForRemoteNotifications];
 } else {
 UIRemoteNotificationType types = UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeBadge;
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    [[PRSPush shared] registerForRemoteNotificationTypes:types];
 #pragma GCC diagnostic pop
 }
 </pre>
 */
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000    // >= iOS8
- (void)registerForRemoteNotifications;
#endif

/*!
 デバイスのRemote Notification登録を行います。
 
 当メソッドはiOS8からdeprecatedとなります。
 
 -[UIApplication registerForRemoteNotificationTypes:] のwrapperとなりますが、
 当メソッドを代わりに呼ぶようにしてください。
 
 iOS8以降で当メソッドをコールすると、以下のようにNotification Actionの利用なし（categoriesにnil）として、
 UIUserNotificationSettingsの登録まで行います。
 <pre>
 UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
 [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
 [[UIApplication sharedApplication] registerForRemoteNotifications];
 </pre>
 
 iOS7以下では次の処理と同等です。
 <pre>
 [[UIApplication sharedApplication] registerForRemoteNotificationTypes:types];
 </pre>
 */
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000    // >= iOS8
- (void)registerForRemoteNotificationTypes:(UIRemoteNotificationType)types __attribute__((deprecated));
#else
- (void)registerForRemoteNotificationTypes:(UIRemoteNotificationType)types;
#endif

/*!
 デバイストークンをPusnaRSサーバーに登録します。
 
 Push Notification利用時に、
 -[application:didRegisterForRemoteNotificationsWithDeviceToken:]
 でコールしてデバイストークンをセットしてください。
 */
- (void)registerDeviceToken:(NSData *)deviceToken;

/*!
 Push受信時の時刻計測などを行います。
 
 -[application:didReceiveRemoteNotification:] でコールするようにしてください。
 */
- (void)handleNotification:(NSDictionary *)notification applicationState:(UIApplicationState)state;

@end
