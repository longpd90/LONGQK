//
//  QKF33Label.m
//  quicker-cs-ios
//
//  Created by Viet on 6/23/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKF33Label.h"

@implementation QKF33Label

- (void)awakeFromNib {
	[super awakeFromNib];
	self.textColor = [UIColor colorWithHexString:@"#444"];
	self.font = [UIFont systemFontOfSize:14.0];
}

@end
