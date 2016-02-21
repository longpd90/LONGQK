//
//  QKF90Label.m
//  quicker-cs-ios
//
//  Created by Viet on 6/23/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKF90Label.h"

@implementation QKF90Label


- (void)awakeFromNib {
	[super awakeFromNib];
	self.textColor = [UIColor colorWithHexString:@"#030303"];
	self.font = [UIFont boldSystemFontOfSize:9.0];
}

@end
