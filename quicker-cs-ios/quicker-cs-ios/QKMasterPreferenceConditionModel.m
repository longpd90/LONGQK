//
//  QKJobModelCondition.m
//  quicker-cs-ios
//
//  Created by Quy on 5/22/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKMasterPreferenceConditionModel.h"
#import "NSString+QKCSConvertToURL.h"

@implementation QKMasterPreferenceConditionModel
- (instancetype)initWithResponse:(NSDictionary *)response {
    self = [super init];
    if (self) {
        [self setPreferenceConditionCd:response[@"preferenceConditionCd"]];
        [self setPreferenceConditionName:response[@"preferenceConditionName"]];
        
        //TODO: Viet
        self.preferenceConditionImagePath = [[response objectForKey:@"imagePath"] convertToURL];
    }
    return self;
}

@end
