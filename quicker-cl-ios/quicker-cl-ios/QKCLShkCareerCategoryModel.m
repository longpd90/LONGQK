//
//  QKCategoryModel.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 7/21/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLShkCareerCategoryModel.h"

@implementation QKCLShkCareerCategoryModel

- (instancetype)initWithData:(NSDictionary *)data {
    if (self = [super init]) {
        self.jobTypeLCd = [data stringForKey:@"jobTypeLCd"];
        self.jobTypeLNm = [data stringForKey:@"jobTypeLName"];
        self.jobTypeMCd = [data stringForKey:@"jobTypeMCd"];
        self.jobTypeLMNm = [data stringForKey:@"jobTypeMName"];
        self.jobTypeSCd = [data stringForKey:@"jobTypeSCd"];
        self.jobTypeSNm = [data stringForKey:@"jobTypeSName"];
        self.workCount = [data intForKey:@"workCount"];
        self.workNum = [data intForKey:@"workNum"];
    }
    return self;
}

@end
