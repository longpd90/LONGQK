//
//  QKCustomerUserModel.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 7/21/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "chiase-ios-core/NSDictionary+ParseResult.h"
#import "QKCLShkCareerSummaryModel.h"

@interface QKCLCustomerUserModel : NSObject

@property (strong, nonatomic) NSString *customerUserId;
@property (strong, nonatomic) NSString *customeLastName;
@property (strong, nonatomic) NSString *customeFirstName;
@property (strong, nonatomic) NSString *customeLastNameKana;
@property (strong, nonatomic) NSString *customeFirstNameKana;
@property (strong, nonatomic) NSDate *birthday;
@property (strong, nonatomic) NSString *sexFlg;
@property (strong, nonatomic) NSURL *imageUrl;
@property (strong, nonatomic) NSString *occupation;
@property (strong, nonatomic) NSString *selfPromotion;
@property (strong, nonatomic) NSString *education;
@property (strong, nonatomic) NSString *applicantStatus;
@property (strong, nonatomic) NSString *selfPromotionInApplication;
@property (strong, nonatomic) NSString *latLng;
@property (strong, nonatomic) NSDate *actualStartDate;
@property (strong, nonatomic) NSDate *actualEndDate;
@property (strong, nonatomic) NSDate *actualRecess;
@property (strong, nonatomic) NSString *actualSalaryUnit;
@property (assign, nonatomic) NSInteger actualSalaryPerUnit;
@property (assign, nonatomic) NSInteger totalAmountPaid;
@property (assign, nonatomic) NSInteger margin;
@property (strong, nonatomic) NSDate *actualUpdateDt;
@property (strong, nonatomic) NSDate *transferDt;
@property (strong, nonatomic) NSString *transferStatus;
@property (strong, nonatomic) NSMutableArray *freeQuestionList;
@property (strong, nonatomic) NSMutableArray *careerList;
@property (strong, nonatomic) QKCLShkCareerSummaryModel *shkCareerSummary;
@property (strong, nonatomic) NSMutableArray *shkCareerList;
@property (assign, nonatomic) NSInteger multiApplicationCount;
@property (assign, nonatomic) NSInteger adoptedAtSamePeriod;
@property (assign, nonatomic) NSInteger sameJobExperienceByCareer;
@property (assign, nonatomic) NSInteger sameJobExperienceByShkCareer;
@property (assign, nonatomic) NSInteger notReadMessageCount;
@property (assign, nonatomic) BOOL favoriteCustomerF;
@property (assign, nonatomic) NSInteger favoriteShopCount;

- (instancetype)initWithData:(NSDictionary *)data;

@end
