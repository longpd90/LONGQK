//
//  QKF39Label.m
//  quicker-cs-ios
//
//  Created by Viet on 6/23/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKF39Label.h"

@implementation QKF39Label

- (void)awakeFromNib {
	[super awakeFromNib];
	self.textColor = [UIColor colorWithHexString:@"#4F5868"];
	self.font = [UIFont boldSystemFontOfSize:14.0];
}

@end
