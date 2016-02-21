//
//  QKSalaryModel.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 8/13/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLSalaryModel.h"
#import "NSString+QKCLConvertToURL.h"

@implementation QKCLSalaryModel
-(id)init{
    self = [super init];
    if (self) {
        self.adoptionList  = [[NSMutableArray alloc]init];
    }
    return self;
}
- (instancetype)initWithResponse:(NSDictionary *)response {
    self = [super init];
    if (self) {
        self.recruitmentId = [response stringForKey:@"recruitmentId"];
        self.userId = [response stringForKey:@"userId"];
        self.shopId = [response stringForKey:@"shopId"];
        self.personInChargeFirstName = [response stringForKey:@"personInChargeFirstName"];
        self.personInChargeLastName = [response stringForKey:@"personInChargeLastName"];
        self.personInChargeImagePath = [[response stringForKey:@"personInChargeImagePath"] convertToURL];
        self.jobTypeLCd = [response stringForKey:@"jobTypeLCd"];
        self.jobTypeLName = [response stringForKey:@"jobTypeLName"];
        self.jobTypeMCd = [response stringForKey:@"jobTypeMCd"];
        self.jobTypeMName = [response stringForKey:@"jobTypeMName"];
        self.jobTypeSCd = [response stringForKey:@"jobTypeSCd"];
        self.jobTypeSName = [response stringForKey:@"jobTypeSName"];
        self.transportationExpenses = [response intForKey:@"transportationExpenses"];
        self.startDt = [response dateForKey:@"startDt" format:@"yyyy-MM-dd HH:mm"];
        self.endDt = [response dateForKey:@"endDt" format:@"yyyy-MM-dd HH:mm"];
        self.recess = [response intForKey:@"recess"];
        self.salaryUnit = [response stringForKey:@"salaryUnit"];
        self.salaryPerUnit = [response intForKey:@"salaryPerUnit"];
        self.employmentNum = [response intForKey:@"employmentNum"];
        self.paymentMethod = [response stringForKey:@"paymentMethod"];
        self.paymentMethodName = [response stringForKey:@"paymentMethodName"];
        self.recruitmentStatus = [response stringForKey:@"recruitmentStatus"];
        self.accountingOfFeesStatus = [response stringForKey:@"accountingOfFeesStatus"];
        self.totalSalary = [response intForKey:@"totalSalary"];
        self.totalMargin = [response intForKey:@"totalMargin"];
        self.adoptionNum = [response intForKey:@"adoptionNum"];
        
        self.adoptionList = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in response[@"adoptionList"]) {
            QKCLCustomerSalaryModel *model = [[QKCLCustomerSalaryModel alloc]initWithResponse:dic];
            [self.adoptionList addObject:model];
        }
    }
    return self;
}

@end
