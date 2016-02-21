//
//  QKF34Label.m
//  quicker-cs-ios
//
//  Created by Viet on 6/23/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKF34Label.h"

@implementation QKF34Label

- (void)awakeFromNib {
	[super awakeFromNib];
	self.textColor = [UIColor colorWithHexString:@"#666"];
	self.font = [UIFont boldSystemFontOfSize:14.0];
}

@end
