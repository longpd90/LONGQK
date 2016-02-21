//
//  QKShkCareerModel.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 7/21/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLShkCareerSummaryModel.h"
#import "QKCLShkCareerCategoryModel.h"

@implementation QKCLShkCareerSummaryModel

- (instancetype)initWithData:(NSDictionary *)data {
    if (self = [super init]) {
        self.workCountTotal = [data intForKey:@"workCountTotal"];
        self.workTimeTotal = [data intForKey:@"workTimeTotal"];
        self.ctgry = [[NSMutableArray alloc] init];
        for (NSDictionary *dataDic in data[@"ctgry"]) {
            QKCLShkCareerCategoryModel *model = [[QKCLShkCareerCategoryModel alloc] initWithData:dataDic];
            [self.ctgry addObject:model];
        }
    }
    return self;
}

@end
