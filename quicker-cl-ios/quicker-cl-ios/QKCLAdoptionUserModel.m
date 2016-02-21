//
//  QKAdoptionUserModel.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 7/15/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLAdoptionUserModel.h"
#import "NSString+QKCLConvertToURL.h"

@implementation QKCLAdoptionUserModel

- (instancetype)initWithData:(NSDictionary *)data {
    if (self = [super init]) {
        self.adoptionUserId = [data stringForKey:@"adoptionUserId"];
        self.adoptionUserFirstName = [data stringForKey:@"adoptionUserFirstName"];
        self.adoptionUserLastName = [data stringForKey:@"adoptionUserLastName"];
        self.adoptionUserName = [NSString stringWithFormat:@"%@ %@",self.adoptionUserLastName,self.adoptionUserFirstName];
        self.adoptionUserBirthday = [data dateForKey:@"adoptionUserBirthday" format:@"yyyy-MM-dd"];
        self.adoptionUserImagePath = [[data stringForKey:@"adoptionUserImagePath"] convertToURL];
        self.adoptionUserAccountSexFlg = [data stringForKey:@"adoptionUserSexFlg"];
        self.adoptionUserAccountSexFlgName = [data stringForKey:@"adoptionUserSexFlgName"];
        self.adoptionUserAccountStatus = [data stringForKey:@"adoptionUserAccountStatus"];
        self.adoptionDt = [data dateForKey:@"adoptionDt" format:@"yyyy-MM-dd HH:mm"];
        self.employmentStatus = [data stringForKey:@"employmentStatus"];
        self.workActualStatus = [data stringForKey:@"workActualStatus"];
        
        NSString *favoriteCustomerF = [data stringForKey:@"favoriteCustomerF"];//true or false
        if (favoriteCustomerF && [favoriteCustomerF isEqualToString:@"true"]) {
            self.favoriteCustomerF = YES;
        }
        else {
            self.favoriteCustomerF = NO;
        }
    }
    return self;
}

@end
