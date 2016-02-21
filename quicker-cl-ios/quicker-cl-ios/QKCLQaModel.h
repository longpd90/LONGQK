//
//  QKQaModel.h
//  quicker-cl-ios
//
//  Created by Viet on 6/29/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "chiase-ios-core/NSDictionary+ParseResult.h"
@interface QKCLQaModel : NSObject
@property (nonatomic, strong) NSString *qaId;
@property (nonatomic, strong) NSString *qaOpenStatus;
@property (nonatomic, strong) NSString *question;
@property (nonatomic, strong) NSString *answer;

- (instancetype)initWithResponse:(NSDictionary *)response;
@end
