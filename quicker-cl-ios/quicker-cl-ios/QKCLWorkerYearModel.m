//
//  QKCLWorkerYearModel.m
//  quicker-cl-ios
//
//  Created by Quy on 7/30/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLWorkerYearModel.h"

@implementation QKCLWorkerYearModel
- (id)init {
    self = [super init];
    if (self) {
        self.monthList = [[NSMutableArray alloc]init];
    }
    return self;
}

- (instancetype)initWithResonponse:(NSDictionary *)response {
    self = [super init];
    if (self) {
        self.year = [response stringForKey:@"year"];
        self.monthList = [[NSMutableArray alloc]init];
        for (NSDictionary *dic in response[@"monthList"]) {
            QKCLWorkerMonthModel *model = [[QKCLWorkerMonthModel alloc]initWithResponse:dic];
            [self.monthList addObject:model];
        }
    }
    return self;
}

@end
