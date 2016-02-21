//
//  QKRecruitmentModel.m
//  quicker-cs-ios
//
//  Created by LongPD-PC on 6/11/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKRecruitmentModel.h"
#import "chiase-ios-core/NSDictionary+ParseResult.h"
#import "QKMasterPreferenceConditionModel.h"
#import "QKQaModel.h"
#import "QKCSFreeQaModel.h"
#import "NSString+QKCSConvertToURL.h"

@implementation QKRecruitmentModel

- (instancetype)initWithResponse:(NSDictionary *)response {
    self = [super init];
    if (self) {
        self.recruitmentId = [response stringForKey:@"recruitmentId"];
        self.userId = [response stringForKey:@"userId"];
        self.freeQId = [response stringForKey:@"freeQId"];
        self.personInChargeFirstName = [response stringForKey:@"personInChargeFirstName"];
        self.adoptionRecord = [response stringForKey:@"adoptionRecord"];
        self.des = [response stringForKey:@"description"];
        self.personInChargeImageUrl =[[response stringForKey:@"personInChargeImagePath"] convertToURL];
        self.jobTypeSCd = [response stringForKey:@"jobTypeSCd"];
        self.jobTypeSName = [response stringForKey:@"jobTypeSName"];
        self.jobTypeLCd = [response stringForKey:@"jobTypeLCd"];
        self.jobTypeLName = [response stringForKey:@"jobTypeLName"];
        self.jobTypeMCd = [response stringForKey:@"jobTypeMCd"];
        self.jobTypeMName = [response stringForKey:@"jobTypeMName"];
        self.startDt = [response stringForKey:@"startDt"];
        self.startDate = [response dateForKey:@"startDt" format:@"yyyy-MM-dd HH:mm"];
        self.endDt = [response stringForKey:@"endDt"];
        self.recess = [response stringForKey:@"recess"];
        self.salaryUnit = [response stringForKey:@"salaryUnit"];
        self.salaryPerUnit = [response stringForKey:@"salaryPerUnit"];
        self.salaryTotal = [response stringForKey:@"salaryTotal"];
        self.employmentNum = [response stringForKey:@"employmentNum"];
        self.closingDt = [response dateForKey:@"closingDt" format:@"yyyy-MM-dd HH:mm"];
        self.timeLimit = [response intForKey:@"timeLimit"];
        self.preCrtDt = [response stringForKey:@"preCrtDt"];
        self.selectionClosingDt = [response stringForKey:@"selectionClosingDt"];
        self.recruitmentStatus = [response stringForKey:@"recruitmentStatus"];
        self.recruitmentStatusName = [response stringForKey:@"recruitmentStatusName"];
        self.workStatus = [response stringForKey:@"workStatus"];
        self.accountingOfFeesStatus = [response stringForKey:@"accountingOfFeesStatus"];
        self.isKept = [response boolForKey:@"isKept"];
        self.recruitmentDescription = [response stringForKey:@"description"];
        self.applicantqualification = [response stringForKey:@"applicantQualification"];
        self.baggageAndClothes = [response stringForKey:@"baggageAndClothes"];
        self.transporationExpenses = [response stringForKey:@"transportationExpenses"];
        self.unreadMessageCount = [response intForKey:@"notReadMessageCount"];
        
        self.accessWay = [response stringForKey:@"accessWay"];
        self.address1 = [response stringForKey:@"address1"];
        self.address1Kana = [response stringForKey:@"address1Kana"];
        self.address2 = [response stringForKey:@"address2"];
        self.addressCityJisCd = [response stringForKey:@"addressCityJisCd"];
        self.addressCityName = [response stringForKey:@"addressCityName"];
        self.addressPrfJisCd = [response stringForKey:@"addressPrfJisCd"];
        self.addressPrfName = [response stringForKey:@"addressPrfName"];
        self.latLng = [response stringForKey:@"latLng"];
        if (self.latLng.length <= 1) {
            self.latLng = @"0,0";
        }
        //shop info
        self.shopInfo = [[QKShopInfoModel alloc]initWithResponse:response];
        self.shopInfo.shopDescription = [response stringForKey:@"shopDescription"];
        //preferenceCondtion
        self.preferenceConditionList = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in response[@"preferenceConditionList"]) {
            QKMasterPreferenceConditionModel *model = [[QKMasterPreferenceConditionModel alloc]initWithResponse:dic];
            [self.preferenceConditionList addObject:model];
        }
        
        //qa
        self.answeredQaList = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in response[@"qaList"][@"qaList"][@"answered"]) {
            QKQaModel *model = [[QKQaModel alloc]initWithResponse:dic];
            [self.answeredQaList addObject:model];
        }
        self.unansweredQaList = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in response[@"qaList"][@"qaList"][@"unanswered"]) {
            QKQaModel *model = [[QKQaModel alloc]initWithResponse:dic];
            [self.unansweredQaList addObject:model];
        }
        self.historyQaList = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in response[@"qaList"][@"qaList"][@"history"]) {
            QKQaModel *model = [[QKQaModel alloc]initWithResponse:dic];
            [self.historyQaList addObject:model];
        }
        
        //image list
        self.imageList = [[NSMutableArray alloc] init];
        for (NSDictionary *eachImage in[response objectForKey:@"imageFileList"]) {
            QKImageModel *model = [[QKImageModel alloc] initWithImageData:eachImage];
            [self.imageList addObject:model];
        }
        self.isKept = [response boolForKey:@"isKeptF"];
        self.applicantStatus = [response stringForKey:@"applicantStatus"];
        self.transferStatusName = [response stringForKey:@"transferStatusName"];
        self.transferStatus = [response stringForKey:@"transferStatus"];
        self.workActualStatus = [response stringForKey:@"workActualStatus"];
        self.workActualStatusName = [response stringForKey:@"workActualStatusName"];
        self.employmentStatus = [response stringForKey:@"employmentStatus"];
        self.employmentStatusName = [response stringForKey:@"employmentStatusName"];
        
        self.freeQaList = [[NSMutableArray alloc] init];
        for (NSDictionary *freeQa in [response objectForKey:@"freeQaList"]) {
            QKCSFreeQaModel *freeQaModel = [[QKCSFreeQaModel alloc] initWithResponse:freeQa];
            [self.freeQaList addObject:freeQaModel];
        }
        
    }
    return self;
}

@end
