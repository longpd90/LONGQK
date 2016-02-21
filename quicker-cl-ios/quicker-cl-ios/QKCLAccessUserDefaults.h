//
//  QKAccessUserDefaults.h
//  quicker-cl-ios
//
//  Created by Viet on 5/6/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "chiase-ios-core/CCAccessUserDefaults.h"

@interface QKCLAccessUserDefaults : CCAccessUserDefaults

+ (void)clear;

+ (void)setUserId:(NSString *)val;
+ (NSString *)getUserId;

+ (void)setNewShopId:(NSString *)val;
+ (NSString *)getNewShopId;

+ (void)setActiveShopId:(NSString *)val;
+ (NSString *)getActiveShopId;

+ (void)setActiveShopName:(NSString *)val;
+ (NSString *)getActiveShopName;


+ (void)setJobTypeLCd:(NSString *)val;
+ (NSString *)getJobTypeLCd;

+ (void)setJobTypeMCd:(NSString *)val;
+ (NSString *)getJobTypeMCd;

+ (void)setExpireDate:(NSString *)val;
+ (NSString *)getExpireDate;

+ (void)setNotificationSetting:(NSString *)val;
+ (NSString *)getNotificationSetting;

+ (void)setPusnaDeviceId:(NSString *)val;
+ (NSString *)getPusnaDeviceId;

+ (void)setPaymentSetting:(NSString *)val;
+ (NSString *)getPaymentSetting;

+ (void)setPaymentShowDescription:(NSString *)val;
+ (NSString *)getPaymentShowDescription;

+ (void)setShowAutoMessage:(NSString *)val;
+ (NSString *)getShowAutoMessage;
@end
