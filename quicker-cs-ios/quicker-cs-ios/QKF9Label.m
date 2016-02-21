//
//  QKF9Label.m
//  quicker-cs-ios
//
//  Created by Viet on 6/23/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKF9Label.h"

@implementation QKF9Label

- (void)awakeFromNib {
	[super awakeFromNib];
	self.textColor = [UIColor colorWithHexString:@"#ccc"];
	self.font = [UIFont boldSystemFontOfSize:12.0];
}

@end
