//
//  QKApplicantUserModel.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 7/15/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QKCLFreeQAModel.h"

@interface QKCLApplicantUserModel : NSObject

@property (strong, nonatomic) NSString *applicantUserId;
@property (strong, nonatomic) NSString *applicantLastName;
@property (strong, nonatomic) NSString *applicantFirstName;
@property (strong, nonatomic) NSString *applicantUserName;
@property (strong, nonatomic) NSDate *applicantUserBirthday;
@property (strong, nonatomic) NSURL *applicantUserImageUrl;
@property (nonatomic) NSInteger applicantUserAccountSexFlg;
@property (strong, nonatomic) NSString *applicantUserAccountSexFlgName;
@property (strong, nonatomic) NSString *applicantUserAccountStatus;
@property (strong, nonatomic) NSDate *applicantDt;
@property (strong, nonatomic) NSString *adoptedAtSamePeriod;
@property (nonatomic) NSInteger multiApplicantCnt;
@property (strong, nonatomic) NSString *applicantStatus;
@property (strong, nonatomic) NSMutableArray *freeQaList;
@property (nonatomic) BOOL favoriteCustomerF;

- (instancetype)initWithData:(NSDictionary *)data;

@end
