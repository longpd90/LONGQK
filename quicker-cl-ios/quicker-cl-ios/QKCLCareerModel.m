//
//  QKCareerModel.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 7/21/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLCareerModel.h"
#import "QKCLJobTypeSByCareerModel.h"

@implementation QKCLCareerModel

- (instancetype)initWithData:(NSDictionary *)data {
    if (self = [super init]) {
        self.careerId = [data stringForKey:@"careerId"];
        self.userId = [data stringForKey:@"userId"];
        self.jobTypeLCd = [data stringForKey:@"jobTypeLCd"];
        self.jobTypeLName = [data stringForKey:@"jobTypeLName"];
        self.jobTypeMCd = [data stringForKey:@"jobTypeMCd"];
        self.jobTypeMName = [data stringForKey:@"jobTypeMName"];
        self.jobTypeSCd = [data objectForKey:@"jobTypeSCd"];
        self.jobTypeSNm = [data objectForKey:@"jobTypeSName"];
        self.jobTypeSByCareerList = [[NSMutableArray alloc] init];
        for (NSDictionary *jobTypeSByCareer in data[@"jobTypeSByCareerList"]) {
            QKCLJobTypeSByCareerModel *model = [[QKCLJobTypeSByCareerModel alloc] initWithData:jobTypeSByCareer];
            [self.jobTypeSByCareerList addObject:model];
        }
        self.freeText = [data stringForKey:@"freeText"];
        self.servicePeriod = [data stringForKey:@"servicePeriod"];
    }
    return self;
}

@end
