//
//  QKRecruitmentPerDay.h
//  quicker-cs-ios
//
//  Created by LongPD-PC on 8/14/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QKRecruitmentPerDay : NSObject

@property (assign, nonatomic) NSInteger recruitmentCondition;
@property (assign, nonatomic) NSInteger recruitmentOpen;
@property (nonatomic, strong) NSDate *targetDate;
- (instancetype)initWithResponse:(NSDictionary *)response ;
@end
