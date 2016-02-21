//
//  QKFreeQAModel.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 7/15/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "chiase-ios-core/NSDictionary+ParseResult.h"

@interface QKCLFreeQAModel : NSObject

@property (strong, nonatomic) NSString *freeQId;
@property (strong, nonatomic) NSString *question;
@property (strong, nonatomic) NSString *answer;
@property (strong, nonatomic) NSString *qUserId;
@property (strong, nonatomic) NSString *aUserId;

- (instancetype)initWithData:(NSDictionary *)data;

@end
