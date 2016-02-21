//
//  QKJobEntity.h
//  quicker-cs-ios
//
//  Created by LongPD-PC on 6/11/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "QKShopInfoModel.h"

@interface QKRecruitmentModel : NSObject

@property (nonatomic, strong) NSString *recruitmentId;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *personInChargeFirstName;
@property (nonatomic, strong) NSURL *personInChargeImageUrl;
@property (nonatomic, strong) UIImage *personInChargeImage;
@property (nonatomic, strong) NSMutableArray *imageList;
@property (nonatomic, strong) QKShopInfoModel *shopInfo;
@property (nonatomic, strong) NSMutableArray *preferenceConditionList;
@property (nonatomic, strong) NSString *adoptionRecord;

@property (nonatomic, strong) NSString *accessWay;
@property (nonatomic, strong) NSString *address1;
@property (nonatomic, strong) NSString *address1Kana;
@property (nonatomic, strong) NSString *address2;
@property (nonatomic, strong) NSString *addressCityJisCd;
@property (nonatomic, strong) NSString *addressCityName;
@property (nonatomic, strong) NSString *addressPrfJisCd;
@property (nonatomic, strong) NSString *addressPrfName;
@property (nonatomic, strong) NSString *des;

@property (nonatomic, strong) NSString *jobTypeSCd;
@property (nonatomic, strong) NSString *jobTypeSName;
@property (nonatomic, strong) NSString *jobTypeMCd;
@property (nonatomic, strong) NSString *jobTypeMName;
@property (nonatomic, strong) NSString *jobTypeLCd;
@property (nonatomic, strong) NSString *jobTypeLName;
@property (nonatomic, strong) NSString *recruitmentDescription;
@property (nonatomic, strong) NSString *transporationExpenses;
@property (nonatomic, strong) NSString *applicantqualification;
@property (nonatomic, strong) NSString *baggageAndClothes;
@property (nonatomic, strong) NSString *latLng;

@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSString *startDt;
@property (nonatomic, strong) NSString *endDt;
@property (nonatomic, strong) NSString *recess;
@property (nonatomic, strong) NSString *salaryUnit;
@property (nonatomic, strong) NSString *salaryPerUnit;
@property (nonatomic, strong) NSString *salaryTotal;
@property (nonatomic, strong) NSString *employmentNum;
@property (nonatomic, strong) NSDate *closingDt;
@property (nonatomic, assign) NSInteger timeLimit;
@property (nonatomic, strong) NSString *preCrtDt;
@property (nonatomic, strong) NSString *selectionClosingDt;
@property (nonatomic, strong) NSString *recruitmentStatus;
@property (nonatomic, strong) NSString *recruitmentStatusName;
@property (nonatomic, strong) NSString *workStatus;
@property (nonatomic, strong) NSString *accountingOfFeesStatus;
@property (nonatomic, assign) BOOL isKept;
@property (strong, nonatomic) NSMutableArray *answeredQaList;
@property (strong, nonatomic) NSMutableArray *historyQaList;
@property (strong, nonatomic) NSMutableArray *unansweredQaList;
@property (nonatomic, strong) NSString *freeQId;
@property (assign, nonatomic) NSInteger unreadMessageCount;

@property (strong, nonatomic) NSString *workActualStatus;
@property (strong, nonatomic) NSString *workActualStatusName;
@property (strong, nonatomic) NSString *employmentStatus;
@property (strong, nonatomic) NSString *employmentStatusName;

@property (nonatomic, strong) NSString *applicantStatus;
@property (nonatomic, strong) NSString *applicantStatusName;
@property (nonatomic, strong) NSString *transferStatus;
@property (nonatomic, strong) NSString *transferStatusName;

@property (nonatomic, strong) NSMutableArray *freeQaList;

- (instancetype)initWithResponse:(NSDictionary *)response;

@end
