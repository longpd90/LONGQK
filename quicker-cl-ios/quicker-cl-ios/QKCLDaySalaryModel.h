//
//  QKDaySalaryModel.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 8/25/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QKCLSalaryModel.h"

@interface QKCLDaySalaryModel : NSObject

@property (strong, nonatomic) NSString *day;
@property (assign, nonatomic) NSInteger totalSalaryPerDay;
@property (assign, nonatomic) NSInteger totalMarginPerDay;
@property (strong, nonatomic) NSMutableArray *recruitmentList;

- (instancetype)initWithResponse:(NSDictionary *)response;

@end
