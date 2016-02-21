//
//  QKDaySalaryModel.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 8/25/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLDaySalaryModel.h"

@implementation QKCLDaySalaryModel

- (instancetype)initWithResponse:(NSDictionary *)response {
    self = [super init];
    if (self) {
        self.day = [response stringForKey:@"day"];
        self.totalSalaryPerDay = [response intForKey:@"totalSalaryPerDay"];
        self.totalMarginPerDay = [response intForKey:@"totalMarginPerDay"];
        self.recruitmentList = [[NSMutableArray alloc] init];
        for (NSDictionary *recruitment in [response objectForKey:@"recruitmentList"]) {
            QKCLSalaryModel *recruitmetSalary = [[QKCLSalaryModel alloc] initWithResponse:recruitment];
            [self.recruitmentList addObject:recruitmetSalary];
        }
    }
    return self;
}

@end
