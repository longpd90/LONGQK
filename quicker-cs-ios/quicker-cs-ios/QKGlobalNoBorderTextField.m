//
//  QKNoBorderTextField.m
//  quicker-cl-ios
//
//  Created by Viet on 6/17/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKGlobalNoBorderTextField.h"

@implementation QKGlobalNoBorderTextField

- (void)awakeFromNib {
	[super awakeFromNib];
	[self setupGlobalNoBorderTextField];
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self setupGlobalNoBorderTextField];
	}
	return self;
}

- (void)setupGlobalNoBorderTextField {
	self.layer.cornerRadius = 0.0f;
	self.layer.borderWidth = 0.0f;
	self.layer.borderColor = [UIColor clearColor].CGColor;
    [self setFont:[UIFont systemFontOfSize:14.0f]];
}

@end
