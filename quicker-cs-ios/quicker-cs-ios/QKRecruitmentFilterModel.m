//
//  QKJobFilterModel.m
//  quicker-cs-ios
//
//  Created by Quy on 5/26/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKRecruitmentFilterModel.h"

@implementation QKRecruitmentFilterModel

- (instancetype)initWithResponse:(NSDictionary *)response {
	self = [super init];
	if (self) {
		self.sortCd = [response objectForKey:@"sortCd"];
		self.startDt = [response objectForKey:@"startDt"];
		self.endDt = [response objectForKey:@"endDt"];
		self.preferenceCdArrays = [[response objectForKey:@"preferenceCdArrays"] mutableCopy];
		if (!self.preferenceCdArrays) {
			self.preferenceCdArrays = [[NSMutableArray alloc]init];
		}
	}
	return self;
}

@end
