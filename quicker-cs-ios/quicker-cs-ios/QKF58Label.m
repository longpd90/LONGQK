//
//  QKF58Label.m
//  quicker-cs-ios
//
//  Created by Viet on 6/23/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKF58Label.h"

@implementation QKF58Label

- (void)awakeFromNib {
	[super awakeFromNib];
	self.textColor = [UIColor colorWithHexString:@"#7F7F7F"];
	self.font = [UIFont systemFontOfSize:10.0];
}

@end
