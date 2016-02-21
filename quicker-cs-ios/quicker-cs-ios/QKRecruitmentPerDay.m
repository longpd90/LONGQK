//
//  QKRecruitmentPerDay.m
//  quicker-cs-ios
//
//  Created by LongPD-PC on 8/14/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKRecruitmentPerDay.h"
#import "chiase-ios-core/NSDictionary+ParseResult.h"

@implementation QKRecruitmentPerDay

- (instancetype)initWithResponse:(NSDictionary *)response {
    self = [super init];
    if (self) {
        self.recruitmentCondition = [response intForKey:@"recCountByCondition"];
        self.recruitmentOpen = [response intForKey:@"recCountByOpen"];
        self.targetDate = [response dateForKey:@"targetDt" format:@"yyyy/MM/dd"];
        
    }
    return self;
}
@end
