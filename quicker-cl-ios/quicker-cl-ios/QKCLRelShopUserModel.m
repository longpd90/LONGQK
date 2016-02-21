//
//  QKRelShopUser.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 6/11/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLRelShopUserModel.h"
#import "chiase-ios-core/NSDictionary+ParseResult.h"

@implementation QKCLRelShopUserModel

- (instancetype)initWithResponse:(NSDictionary *)response {
    self = [super init];
    if (self) {
        self.shopUserRole = [response stringForKey:@"shopUserRole"];
        self.imageUrl = [response urlForKey:@"imageUrl"];
        self.userId = [response stringForKey:@"userId"];
        self.firstName = [response stringForKey:@"firstName"];
        self.lastName = [response stringForKey:@"lastName"];
    }
    return self;
}

@end
