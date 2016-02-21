//
//  QKOptionalItemModel.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 8/13/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "chiase-ios-core/NSDictionary+ParseResult.h"

@interface QKCLOptionalItemModel : NSObject

@property (strong, nonatomic) NSString *itemsName;
@property (strong, nonatomic) NSString *payStatementStatus;
@property (assign, nonatomic) NSInteger amount;

- (instancetype)initWithResponse:(NSDictionary *)response;

@end
