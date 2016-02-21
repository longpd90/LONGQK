//
//  QKJobModelCondition.m
//  quicker-cs-ios
//
//  Created by Quy on 5/22/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLMasterPreferenceConditionModel.h"

@implementation QKCLMasterPreferenceConditionModel
- (instancetype)initWithResponse:(NSDictionary *)response {
	self = [super init];
	if (self) {
		[self setPreferenceConditionCd:response[@"preferenceConditionCd"]];
		[self setPreferenceConditionName:response[@"preferenceConditionName"]];
	}
	return self;
}

@end
