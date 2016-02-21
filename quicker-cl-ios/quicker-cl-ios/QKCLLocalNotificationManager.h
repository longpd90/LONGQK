//
//  QKLocalNotificationManager.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 6/16/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "QKCLNotificationItem.h"

@interface QKCLLocalNotificationManager : NSObject

+ (void)scheduleNotificationWithItem:(QKCLNotificationItem *)item isNeedRepeat:(BOOL)needRepeat;
+ (void)cancelAllLocalNotification;

@end
