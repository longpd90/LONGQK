//
//  QKGlobalTextButton.m
//  quicker-cs-ios
//
//  Created by Viet on 6/24/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKGlobalTextButton.h"

@implementation QKGlobalTextButton
- (void)awakeFromNib {
	[super awakeFromNib];
	[self setupGlobal];
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self setupGlobal];
	}
	return self;
}

- (void)setupGlobal {
}

- (void)setHighlighted:(BOOL)highlighted {
	if (highlighted) {
		self.alpha = 0.5f;
	}
	else {
		self.alpha = 1.0f;
	}
}

@end
