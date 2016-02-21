//
//  QKCustomerInforSalaryModel.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 8/13/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "chiase-ios-core/NSDictionary+ParseResult.h"
#import "QKCLOptionalItemModel.h"
#import "QKCLAdoptionUserModel.h"
#import "QKCLRecruitmentModel.h"
#import "QKCLAdoptionUserModel.h"

@interface QKCLCustomerSalaryModel : NSObject

//@property (strong, nonatomic) NSString *adoptionUserId;
//@property (strong, nonatomic) NSString *adoptionUserName;
////>>>
//@property (strong, nonatomic) NSString *adoptionUserFirstName;
//@property (strong, nonatomic) NSString *adoptionUserLastName;
//@property (strong, nonatomic) NSURL *adoptionUserImagePath;
//@property (strong, nonatomic) NSString *adoptionUserAccountSexFlg;
//@property (strong, nonatomic) NSString *adoptionUserAccountSexFlgName;
//@property (strong, nonatomic) NSString *adoptionUserAccountStatus;
//@property (strong, nonatomic) NSDate *adoptionDt;
//
//@property (strong, nonatomic) NSDate *adoptionUserBirthday;
//@property (strong, nonatomic) NSString *workActualStatus;
//@property (strong, nonatomic) NSString *employmentStatus;
//@property (assign, nonatomic) BOOL favoriteCustomerF;
@property (strong, nonatomic) QKCLAdoptionUserModel* adoptUserInfo;
@property (assign, nonatomic) NSInteger actualSalaryPerUnit;
@property (assign, nonatomic) NSInteger basicSalary;
@property (assign, nonatomic) NSInteger actualSalary;
@property (strong, nonatomic) NSDate *actualStartDt;
@property (strong, nonatomic) NSDate *actualEndDt;
@property (assign, nonatomic) NSInteger actualRecess;
@property (assign, nonatomic) NSInteger actualTransportationExpenses;
@property (assign, nonatomic) NSInteger actualNighttimeAllowance;
@property (assign, nonatomic) NSInteger actualOvertimeAllowance;
@property (assign, nonatomic) NSInteger actualWithholding;

@property (strong, nonatomic) NSMutableArray *optionalItemList;

@property (assign, nonatomic) NSInteger totalAmountPaid;
@property (assign, nonatomic) NSInteger margin;
@property (strong, nonatomic) NSDate *actualUpdtDt;

- (instancetype)initWithResponse:(NSDictionary *)response;

@end
