//
//  QKF45Label.m
//  quicker-cs-ios
//
//  Created by Viet on 6/23/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKF45Label.h"

@implementation QKF45Label

- (void)awakeFromNib {
	[super awakeFromNib];
	self.textColor = [UIColor colorWithHexString:@"#333"];
	self.font = [UIFont boldSystemFontOfSize:12.0];
}

@end
