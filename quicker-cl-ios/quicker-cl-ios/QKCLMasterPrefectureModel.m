//
//  QKMasterPrefectureModel.m
//  quicker-cl-ios
//
//  Created by Nguyen Viet Thang on 6/10/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLMasterPrefectureModel.h"
#import "chiase-ios-core/NSDictionary+ParseResult.h"

@implementation QKCLMasterPrefectureModel

- (instancetype)initWithRespone:(NSDictionary *)respone {
    self = [super init];
    if (self) {
        self.prfJisCd = [respone stringForKey:@"prfJisCd"];
        self.prfName = [respone stringForKey:@"prfName"];
    }
    return self;
}

@end
