//
//  QKGlobalLabel.m
//  quicker-cl-ios
//
//  Created by Vietnd on 5/23/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKGlobalLabel.h"

@implementation QKGlobalLabel

- (void)awakeFromNib {
	[super awakeFromNib];
	[self setupGlobal];
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self awakeFromNib];
	}
	return self;
}

- (void)setupGlobal {
	[self setUserInteractionEnabled:YES];
}

#pragma mark -Override
- (void)setHighlighted:(BOOL)highlighted {
	if (highlighted) {
		self.alpha = 0.5f;
	}
	else {
		self.alpha = 1.0f;
	}
}

@end
