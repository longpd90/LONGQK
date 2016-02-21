//
//  QKCareerModel.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 7/21/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "chiase-ios-core/NSDictionary+ParseResult.h"

@interface QKCLCareerModel : NSObject

@property (strong, nonatomic) NSString *careerId;
@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *jobTypeLCd;
@property (strong, nonatomic) NSString *jobTypeLName;
@property (strong, nonatomic) NSString *jobTypeMCd;
@property (strong, nonatomic) NSString *jobTypeMName;
@property (strong, nonatomic) NSArray *jobTypeSCd;
@property (strong, nonatomic) NSArray *jobTypeSNm;
@property (strong, nonatomic) NSMutableArray *jobTypeSByCareerList;
@property (strong, nonatomic) NSString *freeText;
@property (strong, nonatomic) NSString *servicePeriod;

- (instancetype)initWithData:(NSDictionary *)data;

@end
