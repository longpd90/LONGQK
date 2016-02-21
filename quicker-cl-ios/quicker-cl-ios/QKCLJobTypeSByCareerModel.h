//
//  QKJobTypeSByCareerModel.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 7/21/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "chiase-ios-core/NSDictionary+ParseResult.h"

@interface QKCLJobTypeSByCareerModel : NSObject

@property (strong, nonatomic) NSString *careerId;
@property (strong, nonatomic) NSString *jobTypeS;
@property (strong, nonatomic) NSString *jobTypeSNm;

- (instancetype)initWithData:(NSDictionary *)data;

@end
