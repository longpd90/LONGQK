//
//  QKButtonGlobal.m
//  quicker-cl-ios
//
//  Created by LongPD-PC on 4/14/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKGlobalButton.h"
#import "QKConst.h"
#import <UIKit/UIKit.h>
@implementation QKGlobalButton

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
	self.layer.cornerRadius = 3;
	self.layer.masksToBounds = YES;
	[self setTitleColor:[UIColor colorWithRed:255.0 / 255.0 green:255.0 / 255.0 blue:255.0 / 255.0 alpha:1]  forState:UIControlStateNormal];
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
