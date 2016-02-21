//
//  QKJobHistoryModel.m
//  quicker-cs-ios
//
//  Created by LongPD-PC on 5/27/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKJobHistoryModel.h"
#import "chiase-ios-core/NSDictionary+ParseResult.h"

@implementation QKJobHistoryModel

- (instancetype)initWithResponse:(NSDictionary *)response {
    self = [super init];
    if (self) {
        self.jobtypeL = [[QKJobTileModel alloc]initWithResponseJobTileL:response];
        self.jobtypeM = [[QKJobTileModel alloc]initWithResponseJobTileM:response];
        self.jobtypeS = [[QKJobTileModel alloc]initWithArrayJobTileS:response];
        self.jobContent = [response stringForKey:@"freeText"];
        self.jobPeriod =[response stringForKey:@"servicePeriod"];
        self.jobID = [response stringForKey:@"careerId"];
    }
    return self;
}
@end
