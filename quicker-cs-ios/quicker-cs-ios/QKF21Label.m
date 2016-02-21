//
//  QKF21Label.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 6/5/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKF21Label.h"

@implementation QKF21Label

- (void)awakeFromNib {
	[super awakeFromNib];
	self.textColor = [UIColor colorWithHexString:@"#333"];
	self.font = [UIFont boldSystemFontOfSize:15.0];
}

@end
