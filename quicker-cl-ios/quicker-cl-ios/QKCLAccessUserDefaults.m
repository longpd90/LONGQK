//
//  QKAccessUserDefaults.m
//  quicker-cl-ios
//
//  Created by Viet on 5/6/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLAccessUserDefaults.h"
#import "QKCLEncryptUtil.h"

@implementation QKCLAccessUserDefaults

+ (void)clear {
    [self setUserId:@""];
    [self setMail:@""];
    [self setToken:@""];
    [self setExpireDate:@""];
    [self setActiveShopId:@""];
    [self setJobTypeLCd:@""];
    [self setJobTypeMCd:@""];
    [self setNewShopId:@""];
    [self setActiveShopName:@""];
    [self setPusnaDeviceId:@""];
    [self setPaymentSetting:@""];
    [self setPaymentShowDescription:@""];
    [self setShowAutoMessage:@""];
}

+ (void)setUserId:(NSString *)val {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:val forKey:@"USER_ID"];
}

+ (NSString *)getUserId {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *val = [ud stringForKey:@"USER_ID"];
    if (!val) {
        return @"";
    }
    //TEST server
    //return val;
    
    //Customer server
    return [QKCLEncryptUtil encyptBlowfish:val];
}

+ (void)setNewShopId:(NSString *)val {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:val forKey:@"NEW_SHOP_ID"];
}

+ (NSString *)getNewShopId {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *val = [ud stringForKey:@"NEW_SHOP_ID"];
    if (!val) {
        return @"";
    }
    return val;
}

+ (void)setActiveShopId:(NSString *)val {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:val forKey:@"ACTIVE_SHOP_ID"];
}

+ (NSString *)getActiveShopId {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *val = [ud stringForKey:@"ACTIVE_SHOP_ID"];
    if (!val) {
        return @"";
    }
    return val;
}

+ (void)setActiveShopName:(NSString *)val {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:val forKey:@"QK_CL_ACTIVE_SHOP_NAME"];
}

+ (NSString *)getActiveShopName {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *val = [ud stringForKey:@"QK_CL_ACTIVE_SHOP_NAME"];
    if (!val) {
        return @"";
    }
    return val;
}

+ (void)setJobTypeLCd:(NSString *)val {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:val forKey:@"ACTIVE_SHOP_JOBTYPE_L_CD"];
}

+ (NSString *)getJobTypeLCd {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *val = [ud stringForKey:@"ACTIVE_SHOP_JOBTYPE_L_CD"];
    if (!val) {
        return @"";
    }
    return val;
}

+ (void)setJobTypeMCd:(NSString *)val {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:val forKey:@"ACTIVE_SHOP_JOBTYPE_M_CD"];
}

+ (NSString *)getJobTypeMCd {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *val = [ud stringForKey:@"ACTIVE_SHOP_JOBTYPE_M_CD"];
    if (!val) {
        return @"";
    }
    return val;
}

+ (void)setExpireDate:(NSString *)val {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:val forKey:@"USER_EXPIRE_DATE"];
}

+ (NSString *)getExpireDate {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *val = [ud stringForKey:@"USER_EXPIRE_DATE"];
    if (!val) {
        return @"";
    }
    return val;
}

+ (void)setNotificationSetting:(NSString *)val {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:val forKey:@"USER_NOTIFICATION_SETTING"];
}

+ (NSString *)getNotificationSetting {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *val = [ud stringForKey:@"USER_NOTIFICATION_SETTING"];
    if (!val) {
        return @"";
    }
    return val;
}

+ (void)setPusnaDeviceId:(NSString *)val {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:val forKey:@"QK_CL_PUSNA_DEVICE_ID"];
}

+ (NSString *)getPusnaDeviceId {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *val = [ud stringForKey:@"QK_CL_PUSNA_DEVICE_ID"];
    if (!val) {
        return @"";
    }
    return val;
}

+ (void)setPaymentSetting:(NSString *)val {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:val forKey:@"QK_CL_PAYMENT_SETTING"];
}

+ (NSString *)getPaymentSetting {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *val = [ud stringForKey:@"QK_CL_PAYMENT_SETTING"];
    if (!val) {
        return @"";
    }
    return val;
}

+ (void)setPaymentShowDescription:(NSString *)val {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:val forKey:@"QK_CL_PAYMENT_DESCRIPTION"];
}

+ (NSString *)getPaymentShowDescription {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *val = [ud stringForKey:@"QK_CL_PAYMENT_DESCRIPTION"];
    if (!val) {
        return @"";
    }
    return val;
}

+ (void)setShowAutoMessage:(NSString *)val {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:val forKey:@"QK_CL_SHOW_AUTO_MESSAGE"];
}

+ (NSString *)getShowAutoMessage {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *val = [ud stringForKey:@"QK_CL_SHOW_AUTO_MESSAGE"];
    if (!val) {
        return @"";
    }
    return val;
}

@end
