//
//  QKNotificationItem.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 6/16/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLNotificationItem.h"

@implementation QKCLNotificationItem

- (instancetype)initWithFireDate:(NSDate *)fireDate userInfo:(NSDictionary *)userInfo alertBody:(NSString *)body {
    self = [super init];
    if (self) {
        self.fireDate = fireDate;
        self.userInfo = userInfo;
        self.alertBody = body;
    }
    return self;
}

@end
