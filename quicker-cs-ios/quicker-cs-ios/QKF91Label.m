//
//  QKF91Label.m
//  quicker-cs-ios
//
//  Created by Viet on 6/23/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKF91Label.h"

@implementation QKF91Label

- (void)awakeFromNib {
	[super awakeFromNib];
	self.textColor = [UIColor colorWithHexString:@"#fff"];
	self.font = [UIFont systemFontOfSize:9.0];
}

@end
