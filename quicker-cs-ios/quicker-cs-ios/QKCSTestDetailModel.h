//
//  QKCSTestDetailModel.h
//  quicker-cs-ios
//
//  Created by C Anh on 8/24/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QKCSTestDetailModel : NSObject

@property (strong, nonatomic) NSString *recruitmentId;
@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *shopId;
@property (strong, nonatomic) NSString *personInChargeFirstName;
@property (strong, nonatomic) NSString *personInChargeLastName;
@property (strong, nonatomic) NSURL *personInChargeImagePath;

@property (strong, nonatomic) NSString *jobTypeLCd;
@property (strong, nonatomic) NSString *jobTypeLName;
@property (strong, nonatomic) NSString *jobTypeMCd;
@property (strong, nonatomic) NSString *jobTypeMName;
@property (strong, nonatomic) NSString *jobTypeSCd;
@property (strong, nonatomic) NSString *jobTypeSName;
@property (assign, nonatomic) NSInteger transportationExpenses;
@property (strong, nonatomic) NSDate *startDt;
@property (strong, nonatomic) NSDate *endDt;
@property (assign, nonatomic) NSInteger salaryTotal;
@property (assign, nonatomic) NSInteger employmentNum;
@property (strong, nonatomic) NSString *paymentMethod;
@property (strong, nonatomic) NSString *paymentMethodName;
@property (strong, nonatomic) NSString *recruitmentStatus;
@property (strong, nonatomic) NSString *recruitmentStatusName;
@property (strong, nonatomic) NSString *accountingOfFeesStatus;
@property (assign, nonatomic) NSInteger totalSalary;
@property (assign, nonatomic) NSInteger totalMargin;
@property (assign, nonatomic) NSInteger adoptionNum;

@property (strong, nonatomic) NSString *salaryUnit;
@property (assign, nonatomic) NSInteger salaryPerUnit;
@property (strong, nonatomic) NSDate *actualStartDt;
@property (strong, nonatomic) NSDate *actualEndDt;
@property (strong, nonatomic) NSString *worktime;
@property (assign, nonatomic) NSInteger recess;
@property (strong, nonatomic) NSString *totalAmount;

@property (strong, nonatomic) NSMutableArray *adoptionList;

- (instancetype)initWithResponse:(NSDictionary *)response;


@end
