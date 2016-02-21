//
//  QKLocalNotificationManager.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 6/16/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLLocalNotificationManager.h"
#import "QKCLNotificationItem.h"

@implementation QKCLLocalNotificationManager

+ (void)scheduleNotificationWithItem:(QKCLNotificationItem *)item isNeedRepeat:(BOOL)needRepeat {
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    if (localNotif == nil)
        return;
    localNotif.fireDate = item.fireDate;
    localNotif.timeZone = [NSTimeZone defaultTimeZone];
    localNotif.alertBody = item.alertBody;
    localNotif.userInfo = item.userInfo;
    if (needRepeat) {
        [localNotif setRepeatInterval:NSCalendarUnitDay];
    }
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
}

+ (void)cancelAllLocalNotification {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

@end
