//
//  QKNotificationItem.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 6/16/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QKNotificationItem : NSObject

@property (strong, nonatomic) NSDate *fireDate;
@property (strong, nonatomic) NSDictionary *userInfo;
@property (strong, nonatomic) NSString *alertBody;

@end
