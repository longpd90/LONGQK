//
//  QKMasterCityModel.m
//  quicker-cl-ios
//
//  Created by Nguyen Viet Thang on 6/10/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLMasterCityModel.h"
#import "chiase-ios-core/NSDictionary+ParseResult.h"
@implementation QKCLMasterCityModel
- (instancetype)initWithRespone:(NSDictionary *)respone {
    self = [super init];
    if (self) {
        self.prfJisCd = [respone stringForKey:@"prfJisCd"];
        self.cityJisCd = [respone stringForKey:@"cityJisCd"];
        self.cityName = [respone stringForKey:@"cityName"];
    }
    return self;
}

@end
