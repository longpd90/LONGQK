//
//  QKMessageModel.m
//  quicker-cl-ios
//
//  Created by Viet on 7/7/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLMessageModel.h"
#import "chiase-ios-core/NSDictionary+ParseResult.h"
#import "QKCLEncryptUtil.h"
#import "NSString+QKCLConvertToURL.h"

@implementation QKCLMessageModel
- (instancetype)initWithResponse:(NSDictionary *)response {
    self = [super init];
    if (self) {
        self.messageId = [response stringForKey:@"messageId"];
        self.message = [response stringForKey:@"message"];
        self.messageType = [response stringForKey:@"messageType"];
        self.preLDelF = [response stringForKey:@"preLDelF"];
        self.fromUserId = [QKCLEncryptUtil encyptBlowfish:[response stringForKey:@"fromUserId"]];
        self.fromUserName = [response stringForKey:@"fromUserName"];
        self.fromUserImagePath = [[response stringForKey:@"fromUserImagePath"] convertToURL];
        self.createDt = [response dateForKey:@"createDt" format:@"yyyy-MM-dd HH:mm:ss"];
        self.readF = [response boolForKey:@"readF"];
    }
    return self;
}

@end