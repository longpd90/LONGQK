//
//  QKListModel.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 7/21/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLShkCareerModel.h"

@implementation QKCLShkCareerModel

- (instancetype)initWithData:(NSDictionary *)data {
    if (self = [super init]) {
        self.jobTypeLCd = [data stringForKey:@"jobTypeLCd"];
        self.jobTypeLMNm = [data stringForKey:@"jobTypeMNm"];
        self.jobTypeMCd = [data stringForKey:@"jobTypeMCd"];
        self.jobTypeLNm = [data stringForKey:@"jobTypeLNm"];
        self.jobTypeSCd = [data stringForKey:@"jobTypeSCd"];
        self.jobTypeSNm = [data stringForKey:@"jobTypeSNm"];
        self.shopNm = [data stringForKey:@"shopNm"];
        self.workDate = [data dateForKey:@"workDate" format:@"yyyy-MM-dd"];
    }
    return self;
}

@end
