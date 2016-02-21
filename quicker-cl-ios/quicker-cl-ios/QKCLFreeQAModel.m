//
//  QKFreeQAModel.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 7/15/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLFreeQAModel.h"

@implementation QKCLFreeQAModel

- (instancetype)initWithData:(NSDictionary *)data {
    if (self = [super init]) {
        self.freeQId = [data stringForKey:@"freeQId"];
        self.question = [data stringForKey:@"question"];
        self.answer = [data stringForKey:@"answer"];
        self.qUserId = [data stringForKey:@"qUserId"];
        self.aUserId = [data stringForKey:@"aUserId"];
    }
    return self;
}

@end
