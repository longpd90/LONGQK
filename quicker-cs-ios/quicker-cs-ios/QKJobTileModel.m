//
//  QKJobTileModel.m
//  quicker-cs-ios
//
//  Created by LongPD-PC on 6/30/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKJobTileModel.h"
#import "chiase-ios-core/NSDictionary+ParseResult.h"

@implementation QKJobTileModel

- (instancetype)initWithResponseJobTileL:(NSDictionary *)response {
    self = [super init];
    if (self) {
        self.jobTile = [response stringForKey:@"jobTypeLCd"];
        self.jobName = [response stringForKey:@"jobTypeLName"];
    }
    return self;
}

- (instancetype)initWithResponseJobTileM:(NSDictionary *)response {
    self = [super init];
    if (self) {
        self.jobTile = [response stringForKey:@"jobTypeMCd"];
        self.jobName = [response stringForKey:@"jobTypeMName"];
    }
    return self;
}

- (instancetype)initWithArrayJobTileS:(NSDictionary *)response {
    self = [super init];
    if (self) {
        NSArray*array = response[@"jobTypeSCd"];
        if (array!=nil && array.count >0) {
            self.jobTile = array[0];
        }
        NSArray*array1 = response[@"jobTypeSName"];
        if (array1!=nil && array1.count >0) {
            self.jobName = array1[0];
        }
    }
    return self;
}

- (instancetype)initWithResponseJobTileS:(NSDictionary *)response {
    self = [super init];
    if (self) {
        self.jobTile = [response stringForKey:@"jobTypeSCd"];
        self.jobName = [response stringForKey:@"jobTypeSName"];
    }
    return self;
}

@end
