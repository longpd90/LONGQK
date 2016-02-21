//
//  QKRecruitmentModel.m
//  quicker-cl-ios
//
//  Created by Vietnd on 6/14/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLRecruitmentModel.h"
#import "QKCLMasterPreferenceConditionModel.h"
#import "QKCLQaModel.h"
#import "chiase-ios-core/NSDictionary+ParseResult.h"
#import "QKCLImageModel.h"
#import "QKCLApplicantUserModel.h"
#import "QKCLAdoptionUserModel.h"
#import "NSString+QKCLConvertToURL.h"

@implementation QKCLRecruitmentModel

static NSString *dateFormat = @"yyyy-MM-dd HH:mm";

- (instancetype)initWithResponse:(NSDictionary *)response {
    self = [super init];
    if (self) {
        self.employmentNum = [response intForKey:@"employmentNum"];
        self.recruitmentStatusName = [response stringForKey:@"recruitmentStatusName"];
        self.accessWay = [response stringForKey:@"accessWay"];
        self.accountingOfFeesStatus = [response stringForKey:@"accountingOfFeesStatus"];
        self.address1 = [response stringForKey:@"address1"];
        self.address1Kana = [response stringForKey:@"address1Kana"];
        self.address2 = [response stringForKey:@"address2"];
        self.address2Kana = [response stringForKey:@"address2Kana"];
        self.addressCityJisCd = [response stringForKey:@"addressCityJisCd"];
        self.addressCityJisName = [response stringForKey:@"addressCityJisName"];
        self.addressPrfJisCd = [response stringForKey:@"addressPrfJisCd"];
        self.addressPrfName = [response stringForKey:@"addressPrfName"];
        self.paymentMethod = [response stringForKey:@"paymentMethod"];
        self.adoptionList = [[NSMutableArray alloc] init];
        for (NSDictionary *adoptionData in response[@"adoptionList"]) {
            QKCLAdoptionUserModel *adoptionModel = [[QKCLAdoptionUserModel alloc] initWithData:adoptionData];
            [self.adoptionList addObject:adoptionModel];
        }
        
        self.descriptions = [response stringForKey:@"description"];
        self.adoptionNum = [response intForKey:@"adoptionNum"];
        
        // applicantList
        self.applicantList = [[NSMutableArray alloc] init];
        for (NSDictionary *dataApplicant  in response[@"applicantList"]) {
            QKCLApplicantUserModel *applicantModel = [[QKCLApplicantUserModel alloc] initWithData:dataApplicant];
            [self.applicantList addObject:applicantModel];
        }
        self.applicantNum = [response intForKey:@"applicantNum"];
        self.applicantQualification = [response stringForKey:@"applicantQualification"];
        self.baggageAndClothes = [response stringForKey:@"baggageAndClothes"];
        self.closingDt = [response dateForKey:@"closingDt" format:dateFormat];
        
        self.endDt = [response dateForKey:@"endDt" format:dateFormat];
        
        //        self.freeQList;
        //        self.imageFileList;
        self.imageFileList = [[NSMutableArray alloc] init];
        for (NSDictionary *eachImage in[response objectForKey:@"imageFileList"]) {
            QKCLImageModel *model = [[QKCLImageModel alloc] initWithImageData:eachImage];
            [self.imageFileList addObject:model];
        }
        
        self.jobTypeLCd = [response stringForKey:@"jobTypeLCd"];
        self.jobTypeLName = [response stringForKey:@"jobTypeLName"];
        self.jobTypeMCd = [response stringForKey:@"jobTypeMCd"];
        self.jobTypeMName = [response stringForKey:@"jobTypeMName"];
        self.jobTypeSCd = [response stringForKey:@"jobTypeSCd"];
        self.jobTypeSName = [response stringForKey:@"jobTypeSName"];
        self.latLng = [response stringForKey:@"latLng"];
        self.preferenceConditionList = [[NSMutableArray alloc] init];
        //preferenceCondtion
        for (NSDictionary *dic in response[@"preferenceConditionList"]) {
            QKCLMasterPreferenceConditionModel *model = [[QKCLMasterPreferenceConditionModel alloc]initWithResponse:dic];
            [self.preferenceConditionList addObject:model];
        }
        
        //qa
        self.answeredQaList = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in response[@"qaList"][@"qaList"][@"answered"]) {
            QKCLQaModel *model = [[QKCLQaModel alloc]initWithResponse:dic];
            [self.answeredQaList addObject:model];
        }
        self.unansweredQaList = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in response[@"qaList"][@"qaList"][@"unanswered"]) {
            QKCLQaModel *model = [[QKCLQaModel alloc]initWithResponse:dic];
            [self.unansweredQaList addObject:model];
        }
        self.historyQaList = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in response[@"qaList"][@"qaList"][@"history"]) {
            QKCLQaModel *model = [[QKCLQaModel alloc]initWithResponse:dic];
            [self.historyQaList addObject:model];
        }
        self.name = [response stringForKey:@"name"];
        self.nameKana = [response stringForKey:@"nameKana"];
        self.personInChargeFirstName = [response stringForKey:@"personInChargeFirstName"];
        self.phoneNum = [response stringForKey:@"phoneNum"];
        self.postcd = [response stringForKey:@"postcd"];
        self.recess = [response stringForKey:@"recess"];
        self.recruitmentId = [response stringForKey:@"recruitmentId"];
        self.recruitmentStatus = [response stringForKey:@"recruitmentStatus"];
        if ([response intForKey:@"salaryTotal"]) {
            self.salaryTotal = [response intForKey:@"salaryTotal"];
        }
        else if ([response intForKey:@"salary"]) {
            self.salaryTotal = [response intForKey:@"salary"];
        }
        
        self.salaryUnit = [response stringForKey:@"salaryUnit"];
        self.salaryPerUnit = [response intForKey:@"salaryPerUnit"];
        self.shopDescription = [response stringForKey:@"shopDescription"];
        self.shopId = [response stringForKey:@"shopId"];
        self.startDt = [response dateForKey:@"startDt" format:dateFormat];
        self.timeLimit = [response intForKey:@"timeLimit"];
        self.transportationExpenses = [response intForKey:@"transportationExpenses"];
        self.userId = [response stringForKey:@"userId"];
        self.workStatus = [response stringForKey:@"workStatus"];
        
        self.question = [response stringForKey:@"question"];
        self.personInChargeImageUrl = [[response stringForKey:@"personInChargeImagePath"] convertToURL];
        self.personInChargeLastName = [response stringForKey:@"personInChargeLastName"];
    }
    return self;
}

@end
