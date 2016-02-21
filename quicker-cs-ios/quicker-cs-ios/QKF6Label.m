//
//  QKF6Label.m
//  quicker-cs-ios
//
//  Created by Viet on 6/23/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKF6Label.h"

@implementation QKF6Label
- (void)awakeFromNib {
	[super awakeFromNib];
	self.textColor = [UIColor colorWithHexString:@"#777"];
	self.font = [UIFont systemFontOfSize:17.0];
}

@end
