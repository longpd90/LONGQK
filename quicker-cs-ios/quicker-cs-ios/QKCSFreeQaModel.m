//
//  QKCSFreeQaModel.m
//  quicker-cs-ios
//
//  Created by Nguyen Huu Anh on 8/25/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSFreeQaModel.h"
#import "chiase-ios-core/NSDictionary+ParseResult.h"

@implementation QKCSFreeQaModel

- (instancetype)initWithResponse:(NSDictionary *)response {
    self = [super init];
    if (self) {
        self.freeQId = [response stringForKey:@"freeQId"];
        self.question = [response stringForKey:@"question"];
    }
    return self;
}

@end
