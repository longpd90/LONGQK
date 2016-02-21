//
//  QKCLWorkerMonthModel.h
//  quicker-cl-ios
//
//  Created by Quy on 7/30/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "chiase-ios-core/NSDictionary+ParseResult.h"
@interface QKCLWorkerMonthModel : NSObject

@property (strong,nonatomic) NSString *month;
@property (nonatomic) NSString *totalSalaryPerMonth;
@property (nonatomic) NSString *totalMarginPerMonth;
@property (strong,nonatomic) NSString *usageCount;
@property (strong,nonatomic) NSString *workersCount;
- (instancetype)initWithResponse:(NSDictionary*)response;
@end
