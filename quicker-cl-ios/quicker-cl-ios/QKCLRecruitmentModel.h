//
//  QKRecruitmentModel.h
//  quicker-cl-ios
//
//  Created by Vietnd on 6/14/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QKCLRecruitmentModel : NSObject

@property (strong, nonatomic) NSString *recruitmentId;
@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *shopId;
@property (strong, nonatomic) NSString *personInChargeFirstName;
@property (strong, nonatomic) NSString *personInChargeLastName;
@property (strong, nonatomic) NSURL *personInChargeImageUrl;

@property (strong, nonatomic) NSMutableArray *imageFileList;
@property (strong, nonatomic) NSString *jobTypeLCd;
@property (strong, nonatomic) NSString *jobTypeLName;
@property (strong, nonatomic) NSString *jobTypeMCd;
@property (strong, nonatomic) NSString *jobTypeMName;
@property (strong, nonatomic) NSString *jobTypeSCd;
@property (strong, nonatomic) NSString *jobTypeSName;

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *nameKana;

@property (strong, nonatomic) NSString *phoneNum;
@property (strong, nonatomic) NSString *postcd;
@property (strong, nonatomic) NSString *addressCityJisCd;
@property (strong, nonatomic) NSString *addressCityJisName;
@property (strong, nonatomic) NSString *addressPrfJisCd;
@property (strong, nonatomic) NSString *addressPrfName;
@property (strong, nonatomic) NSString *address1;
@property (strong, nonatomic) NSString *address1Kana;
@property (strong, nonatomic) NSString *address2;
@property (strong, nonatomic) NSString *address2Kana;
@property (strong, nonatomic) NSString *shopDescription;
@property (strong, nonatomic) NSString *accessWay;
@property (strong, nonatomic) NSString *wayside1;
@property (strong, nonatomic) NSString *wayside2;
@property (strong, nonatomic) NSString *wayside3;
@property (strong, nonatomic) NSString *adoptionRecord;
@property (strong, nonatomic) NSString *latLng;

@property (strong, nonatomic) NSMutableArray *preferenceConditionList;
@property (strong, nonatomic) NSString *descriptions;
@property (assign, nonatomic) NSInteger transportationExpenses;
@property (strong, nonatomic) NSString *applicantQualification;
@property (strong, nonatomic) NSString *baggageAndClothes;

@property (strong, nonatomic) NSDate *startDt;
@property (strong, nonatomic) NSDate *endDt;
@property (strong, nonatomic) NSString *recess;
@property (strong, nonatomic) NSDate *closingDt;
@property (strong, nonatomic) NSDate *selectionClosingDt;

@property (strong, nonatomic) NSString *salaryUnit;
@property (nonatomic) NSInteger salaryPerUnit;
@property (nonatomic) NSInteger salaryTotal;

@property (strong, nonatomic) NSString *paymentMethod;

@property (nonatomic) NSInteger timeLimit;
@property (strong, nonatomic) NSString *recruitmentStatus;
@property (strong, nonatomic) NSString *recruitmentStatusName;
@property (strong, nonatomic) NSString *workStatus;
@property (strong, nonatomic) NSString *accountingOfFeesStatus;
@property (assign, nonatomic) NSInteger applicantNum;
@property (strong, nonatomic) NSMutableArray *applicantList;
@property (assign, nonatomic) NSInteger adoptionNum;
@property (strong, nonatomic) NSMutableArray *adoptionList;
@property (strong, nonatomic) NSMutableArray *answeredQaList;
@property (strong, nonatomic) NSMutableArray *historyQaList;
@property (strong, nonatomic) NSMutableArray *unansweredQaList;
@property (strong, nonatomic) NSMutableArray *freeQList;

@property (nonatomic) NSInteger employmentNum;
@property (strong, nonatomic) NSString *question;

- (instancetype)initWithResponse:(NSDictionary *)response;
@end
