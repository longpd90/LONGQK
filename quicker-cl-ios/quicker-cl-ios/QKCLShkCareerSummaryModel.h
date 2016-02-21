//
//  QKShkCareerModel.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 7/21/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "chiase-ios-core/NSDictionary+ParseResult.h"

@interface QKCLShkCareerSummaryModel : NSObject

@property (assign, nonatomic) NSInteger workCountTotal;
@property (assign, nonatomic) NSInteger workTimeTotal;
@property (strong, nonatomic) NSMutableArray *ctgry;

- (instancetype)initWithData:(NSDictionary *)data;

@end
