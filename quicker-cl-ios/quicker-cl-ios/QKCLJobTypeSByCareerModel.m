//
//  QKJobTypeSByCareerModel.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 7/21/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLJobTypeSByCareerModel.h"

@implementation QKCLJobTypeSByCareerModel

- (instancetype)initWithData:(NSDictionary *)data {
    if (self = [super init]) {
        self.careerId = [data stringForKey:@"careerId"];
        self.jobTypeS = [data stringForKey:@"jobTypeS"];
        self.jobTypeSNm = [data stringForKey:@"jobTypeSNm"];
    }
    return self;
}

@end
