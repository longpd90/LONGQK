//
//  QKAccessUserDefaults.h
//  quicker-cl-ios
//
//  Created by Viet on 5/6/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "chiase-ios-core/CCAccessUserDefaults.h"

@interface QKAccessUserDefaults : CCAccessUserDefaults

+ (void)clear;

+ (void)setUserId:(NSString *)val;
+ (NSString *)getUserId;

+ (void)setPassword:(NSString *)val;
+ (NSString *)getPassword;

+ (void)setFBAccessToken:(NSString *)val;
+ (NSString *)getFBAccessToken;

+ (void)setAuthTime:(NSString *)val;
+ (NSString *)getAuthTime;

+ (void)setNotificationSetting:(NSString *)val;
+ (NSString *)getNotificationSetting;

+ (void)setRecruitmentFilter:(NSObject *)val;
+ (NSObject *)getRecruitmentFilter;

+ (void)setShowAutoMessage:(NSString *)val;
+ (NSString *)getShowAutoMessage;

@end
