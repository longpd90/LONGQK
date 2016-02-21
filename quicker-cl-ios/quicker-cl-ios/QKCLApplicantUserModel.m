//
//  QKApplicantUserModel.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 7/15/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLApplicantUserModel.h"
#import "NSString+QKCLConvertToURL.h"

@implementation QKCLApplicantUserModel

- (instancetype)initWithData:(NSDictionary *)data {
    if (self = [super init]) {
        self.applicantUserId = [data stringForKey:@"applicantUserId"];
        self.applicantLastName = [data stringForKey:@"applicantUserLastName"];
        self.applicantFirstName = [data stringForKey:@"applicantUserFirstName"];
        self.applicantUserName = [NSString stringWithFormat:@"%@ %@",self.applicantLastName,self.applicantFirstName];
        self.applicantUserBirthday = [data dateForKey:@"applicantUserBirthday" format:@"yyyy-MM-dd"];
        self.applicantUserImageUrl = [[data stringForKey:@"applicantUserImagePath"] convertToURL];
        
        self.applicantUserAccountSexFlg = [data intForKey:@"applicantUserSexFlg"];
        
        self.applicantUserAccountSexFlgName = [data stringForKey:@"applicantUserSexFlgName"];
        self.applicantUserAccountStatus = [data stringForKey:@"applicantUserAccountStatus"];
        self.applicantDt = [data dateForKey:@"applicantDt" format:@"yyyy-MM-dd HH:mm:ss"];
        self.adoptedAtSamePeriod = [data stringForKey:@"adoptedAtSamePeriod"];
        self.multiApplicantCnt = [data intForKey:@"multiApplicantCnt"];
        self.applicantStatus = [data stringForKey:@"applicantStatus"];
        
        self.freeQaList = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in data[@"freeQaList"]) {
            QKCLFreeQAModel *freeQaModel = [[QKCLFreeQAModel alloc] initWithData:dic];
            [self.freeQaList addObject:freeQaModel];
        }
        NSString*favoriteCustomerF = [data stringForKey:@"favoriteCustomerF"];
        if (favoriteCustomerF && [favoriteCustomerF isEqualToString:@"true"]) {
            self.favoriteCustomerF = YES;
        }else{
            self.favoriteCustomerF = NO;
        }
    }
    return self;
}

@end
