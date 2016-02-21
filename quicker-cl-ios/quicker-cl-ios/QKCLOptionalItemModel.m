//
//  QKOptionalItemModel.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 8/13/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLOptionalItemModel.h"
#import "QKCLConst.h"
#import "chiase-ios-core/NSString+Extra.h"

@implementation QKCLOptionalItemModel
-(id)init {
    self = [super init];
    if (self) {
        self.payStatementStatus = [NSString stringFromConst:QK_PAYMENT_STATUS_PAY];
    }
    return self;
}
- (instancetype)initWithResponse:(NSDictionary *)response {
    self = [super init];
    if (self) {
        self.itemsName = [response stringForKey:@"itemsName"];
        self.payStatementStatus = [response stringForKey:@"payStatementStatus"];
        self.amount = [response intForKey:@"amount"];
    }
    return self;
}

@end
