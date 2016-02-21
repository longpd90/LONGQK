//
//  QKCSFreeItemShopModel.m
//  quicker-cs-ios
//
//  Created by C Anh on 8/26/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSFreeItemShopModel.h"

@implementation QKCSFreeItemShopModel
- (instancetype)initWithResponse:(NSDictionary *)response {
    self = [super init];
    if (self) {
        self.freeItemJobTypeLCd = response[@"freeItemJobTypeLCd"];
        self.freeItemJobTypeLName = response[@"freeItemJobTypeLName"];
        self.freeItemJobTypeLValue = response[@"freeItemJobTypeLValue"];
    }
    return self;
}
@end
