//
//  QKCLWorkerDayModel.m
//  quicker-cl-ios
//
//  Created by Quy on 7/31/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLWorkerDayModel.h"

#import "QKCLAdoptionUserModel.h"

@implementation QKCLWorkerDayModel
- (id)init {
    self = [super init];
    if (self) {
        self.adoptionList = [[NSMutableArray alloc]init];
    }
    return self;
}

- (instancetype)initWithResponse:(NSDictionary *)response {
    self = [super init];
    if (self) {
        self.totalSalaryPerDay = [response stringForKey:@"totalSalaryPerDay"];
        self.day = [response stringForKey:@"day"];
        self.adoptionList = [[NSMutableArray alloc]init];
        for (NSDictionary *dic in response[@"recruitmentList"]) {
            for (NSDictionary *adopt in dic[@"adoptionList"]) {
                QKCLAdoptionUserModel *model = [[QKCLAdoptionUserModel alloc]initWithData:adopt];
                [self.adoptionList addObject:model];
            }
        }
    }
    return self;
}

@end
