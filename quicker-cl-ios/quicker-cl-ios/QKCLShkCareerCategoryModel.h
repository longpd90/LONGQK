//
//  QKCategoryModel.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 7/21/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "chiase-ios-core/NSDictionary+ParseResult.h"

@interface QKCLShkCareerCategoryModel : NSObject

@property (strong, nonatomic) NSString *jobTypeLCd;
@property (strong, nonatomic) NSString *jobTypeLNm;
@property (strong, nonatomic) NSString *jobTypeMCd;
@property (strong, nonatomic) NSString *jobTypeLMNm;
@property (strong, nonatomic) NSString *jobTypeSCd;
@property (strong, nonatomic) NSString *jobTypeSNm;
@property (assign, nonatomic) NSInteger workCount;
@property (assign, nonatomic) NSInteger workNum;

- (instancetype)initWithData:(NSDictionary *)data;

@end
