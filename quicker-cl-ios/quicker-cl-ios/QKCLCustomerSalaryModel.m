//
//  QKCustomerInforSalaryModel.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 8/13/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLCustomerSalaryModel.h"
#import "NSString+QKCLConvertToURL.h"
@implementation QKCLCustomerSalaryModel

- (instancetype)initWithResponse:(NSDictionary *)response {
    self = [super init];
    if (self) {
        
        self.adoptUserInfo = [[QKCLAdoptionUserModel alloc]initWithData:response];
        self.actualSalaryPerUnit = [response intForKey:@"actualSalaryPerUnit"];
        self.basicSalary = [response intForKey:@"actualSalary"];
        self.actualSalary = [response intForKey:@"actualSalary"];
        self.actualStartDt = [response dateForKey:@"actualStartDt" format:@"yyyy-MM-dd HH:mm"];
        self.actualEndDt = [response dateForKey:@"actualEndDt" format:@"yyyy-MM-dd HH:mm"];
        self.actualRecess = [response intForKey:@"actualRecess"];
        self.actualTransportationExpenses = [response intForKey:@"actualTransportationExpenses"];
        self.actualNighttimeAllowance = [response intForKey:@"actualNighttimeAllowance"];
        self.actualOvertimeAllowance = [response intForKey:@"actualOvertimeAllowance"];
        self.actualWithholding = [response intForKey:@"actualWithholding"];
        
        self.optionalItemList = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in response[@"optionalItemList"]) {
            QKCLOptionalItemModel *model = [[QKCLOptionalItemModel alloc]initWithResponse:dic];
            [self.optionalItemList addObject:model];
        }
        self.totalAmountPaid = [response intForKey:@"totalAmountPaid"];
        self.margin = [response intForKey:@"margin"];
        self.actualUpdtDt = [response dateForKey:@"actualUpdtDt" format:@"yyyy-MM-dd HH:mm"];
    }
    return self;
}

@end
