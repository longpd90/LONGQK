//
//  QKGlobalErrorLabel.m
//  quicker-cl-ios
//
//  Created by Viet on 5/13/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKGlobalErrorLabel.h"

@implementation QKGlobalErrorLabel

- (void)awakeFromNib {
	[super awakeFromNib];
	[self setFont:[UIFont boldSystemFontOfSize:11.0f]];
	[self setTextColor:[UIColor colorWithRed:160.0 / 255.0 green:39.0 / 255.0 blue:39.0 / 255.0 alpha:1]];
}

@end
