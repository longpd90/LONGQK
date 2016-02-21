//
//  QkF60Label.m
//  quicker-cs-ios
//
//  Created by Viet on 6/23/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QkF60Label.h"

@implementation QkF60Label


- (void)awakeFromNib {
	[super awakeFromNib];
	self.textColor = [UIColor colorWithHexString:@"#4F5868"];
	self.font = [UIFont boldSystemFontOfSize:10.0];
}

@end
