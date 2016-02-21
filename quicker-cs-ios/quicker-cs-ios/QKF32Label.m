//
//  QKF32Label.m
//  quicker-cs-ios
//
//  Created by Viet on 6/23/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKF32Label.h"

@implementation QKF32Label

- (void)awakeFromNib {
	[super awakeFromNib];
	self.textColor = [UIColor colorWithHexString:@"#444"];
	self.font = [UIFont boldSystemFontOfSize:14.0];
}

@end
