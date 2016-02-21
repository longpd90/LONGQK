//
//  QKCLWorkerMonthModel.m
//  quicker-cl-ios
//
//  Created by Quy on 7/30/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLWorkerMonthModel.h"

@implementation QKCLWorkerMonthModel

-(instancetype)initWithResponse:(NSDictionary *)response {
    self = [super init];
    if (self) {
        self.month = [response stringForKey:@"month"];
        self.totalSalaryPerMonth = [response stringForKey:@"totalSalaryPerMonth"];
        self.totalMarginPerMonth = [response stringForKey:@"totalMarginPerMonth"];
        self.usageCount = [response stringForKey:@"usageCount"];
        self.workersCount = [response stringForKey:@"workersCount"];
    }
    return self;
}
@end
