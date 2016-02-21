//
//  QKCLShopFreeItemModel.m
//  quicker-cl-ios
//
//  Created by VietND on 8/21/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLShopFreeItemModel.h"

@implementation QKCLShopFreeItemModel
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
