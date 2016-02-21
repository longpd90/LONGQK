//
//  QKCLWorkerDayModel.h
//  quicker-cl-ios
//
//  Created by Quy on 7/31/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "chiase-ios-core/NSDictionary+ParseResult.h"
@interface QKCLWorkerDayModel : NSObject
@property (strong, nonatomic) NSString *totalSalaryPerDay;
@property (strong, nonatomic) NSString *day;
@property (strong, nonatomic) NSMutableArray *adoptionList;
- (instancetype)initWithResponse:(NSDictionary *)response;

@end
