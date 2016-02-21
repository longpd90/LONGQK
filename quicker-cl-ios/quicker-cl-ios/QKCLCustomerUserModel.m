//
//  QKCustomerUserModel.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 7/21/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLCustomerUserModel.h"
#import "QKCLCareerModel.h"
#import "QKCLFreeQAModel.h"
#import "QKCLShkCareerSummaryModel.h"
#import "QKCLShkCareerModel.h"
#import "NSString+QKCLConvertToURL.h"

@implementation QKCLCustomerUserModel

- (instancetype)initWithData:(NSDictionary *)data {
    if (self = [super init]) {
        self.customerUserId = [data stringForKey:@"userId"];
        self.customeFirstName = [data stringForKey:@"firstName"];
        self.customeFirstNameKana = [data stringForKey:@"firstNameKana"];
        self.customeLastName = [data stringForKey:@"lastName"];
        self.customeLastNameKana = [data stringForKey:@"lastNameKana"];
        self.birthday = [data dateForKey:@"birthday" format:@"yyyy-MM-dd"];
        self.sexFlg = [data stringForKey:@"sexFlg"];
        [self setImageUrl:[[data stringForKey:@"imagePath"] convertToURL]];
        self.selfPromotion = [data stringForKey:@"selfPromotion"];
        self.education = [data stringForKey:@"education"];
        self.applicantStatus = [data stringForKey:@"applicantStatus"];
        self.selfPromotionInApplication = [data stringForKey:@"selfPromotionInApplication"];
        self.latLng = [data stringForKey:@"latLng"];
        self.actualStartDate = [data dateForKey:@"actualStartDate" format:@"yyyy-MM-dd"];
        self.actualEndDate = [data dateForKey:@"actualEndDate" format:@"yyyy-MM-dd"];
        self.actualRecess = [data dateForKey:@"actualRecess" format:@"yyyy-MM-dd"];
        self.actualSalaryUnit = [data stringForKey:@"actualSalaryUnit"];
        self.actualSalaryPerUnit = [data intForKey:@"actualSalaryPerUnit"];
        self.totalAmountPaid = [data intForKey:@"totalAmountPaid"];
        self.margin = [data intForKey:@"margin"];
        self.actualUpdateDt = [data dateForKey:@"actualUpdateDt" format:@"yyyy-MM-dd"];
        self.transferDt = [data dateForKey:@"transferDt" format:@"yyyy-MM-dd"];
        self.transferStatus = [data stringForKey:@"transferStatus"];
        
        self.freeQuestionList = [[NSMutableArray alloc] init];
        
        for (NSDictionary *freeQData in data[@"freeQuestionList"]) {
            QKCLFreeQAModel *freeQAModel = [[QKCLFreeQAModel alloc] initWithData:freeQData];
            [self.freeQuestionList addObject:freeQAModel];
        }
        
        self.careerList = [[NSMutableArray alloc] init];
        
        for (NSDictionary *careerData in data[@"carrierList"][@"careerList"]) {
            QKCLCareerModel *careerModel = [[QKCLCareerModel alloc] initWithData:careerData];
            [self.careerList addObject:careerModel];
        }
        
        self.shkCareerSummary = [[QKCLShkCareerSummaryModel alloc] initWithData:data[@"shkCareerSummary"]];
        
        self.shkCareerList = [[NSMutableArray alloc] init];
        
        for (NSDictionary *career in data[@"shkCareerList"]) {
            QKCLShkCareerModel *model = [[QKCLShkCareerModel alloc] initWithData:career];
            [self.shkCareerList addObject:model];
        }
        
        self.multiApplicationCount = [data intForKey:@"multiApplicationCount"];
        self.adoptedAtSamePeriod = [data intForKey:@"adoptedAtSamePeriod"];
        self.sameJobExperienceByCareer = [data intForKey:@"sameJobExperienceByCareer"];
        self.sameJobExperienceByShkCareer = [data intForKey:@"sameJobExperienceByShkCareer"];
        self.notReadMessageCount = [data intForKey:@"notReadMessageCount"];
        self.favoriteCustomerF = [data boolForKey:@"favoriteCustomerF"];
        self.favoriteShopCount = [data intForKey:@"favoriteShopCount"];
    }
    return self;
}

@end
