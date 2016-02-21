//
//  QKAccessUserDefaults.m
//  quicker-cl-ios
//
//  Created by Viet on 5/6/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKAccessUserDefaults.h"
#import "QKEncryptUtil.h"

@implementation QKAccessUserDefaults
+ (void)clear {
    [self setUserId:@""];
    [self setMail:@""];
    [self setToken:@""];
    [self setExpireDate:@""];
    [self setAuthTime:@""];
    [self setRecruitmentFilter:nil];
    [self setShowAutoMessage:@""];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setUserId:(NSString *)val {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:val forKey:@"QK_CS_USER_DEFAULT_ID"];
}

+ (NSString *)getUserId {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *val = [ud stringForKey:@"QK_CS_USER_DEFAULT_ID"];
    if (!val) {
        return @"";
    }
    
    //Customer server
    return [QKEncryptUtil encyptBlowfish:val];
}

+ (void)setPassword:(NSString *)val {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:val forKey:@"password"];
}

+ (NSString *)getPassword {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *val = [ud stringForKey:@"password"];
    if (!val) {
        return @"";
    }
    return [QKEncryptUtil encyptBlowfish:val];
}


+ (void)setFBAccessToken:(NSString *)val {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:val forKey:@"QK_CS_USER_FACEBOOK_ACCESS_TOKEN"];
}

+ (NSString *)getFBAccessToken {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *val = [ud stringForKey:@"QK_CS_USER_FACEBOOK_ACCESS_TOKEN"];
    if (!val) {
        return @"";
    }
    
    return val;
}

+ (void)setAuthTime:(NSString *)val {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:val forKey:@"QK_CS_USER_FACEBOOK_AUTH_TIME"];
}

+ (NSString *)getAuthTime {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *val = [ud stringForKey:@"QK_CS_USER_FACEBOOK_AUTH_TIME"];
    if (!val) {
        return @"";
    }
    
    return val;
}

+ (void)setNotificationSetting:(NSString *)val {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:val forKey:@"QK_CS_NOTIFICATION_SETTING"];
}

+ (NSString *)getNotificationSetting {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *val = [ud stringForKey:@"QK_CS_NOTIFICATION_SETTING"];
    if (!val) {
        return @"";
    }
    
    return val;
}

+ (void)setRecruitmentFilter:(NSObject *)val {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:val forKey:@"QK_CS_RECRUITMENT_FILTER"];
}

+ (NSObject *)getRecruitmentFilter {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSObject *val = [ud objectForKey:@"QK_CS_RECRUITMENT_FILTER"];
    if (!val) {
        return nil;
    }
    
    return val;
}

+ (void)setAutoLogin:(NSString *)val {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:val forKey:@"USER_AUTO_LOGIN"];
}

+ (NSString *)getAutoLogin {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *val = [ud stringForKey:@"USER_AUTO_LOGIN"];
    if (!val) {
        return @"";
    }
    return val;
}

+ (void)setShowAutoMessage:(NSString *)val {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:val forKey:@"QK_CS_SHOW_AUTO_MESSAGE"];
}

+ (NSString *)getShowAutoMessage {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *val = [ud stringForKey:@"QK_CS_SHOW_AUTO_MESSAGE"];
    if (!val) {
        return @"";
    }
    return val;
}
@end
