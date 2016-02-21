//
//  QKGlobalRedButton.m
//  quicker-cl-ios
//
//  Created by Viet on 5/13/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKGlobalRedButton.h"
#import "QKCLConst.h"

#define kQKColorRedButton [UIColor colorWithRed:201.0 / 255.0 green:65.0 / 255.0 blue:82.0 / 255.0 alpha:1]

@implementation QKGlobalRedButton

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
    [self setTitleColor:kQKColorWhite forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
    self.backgroundColor = kQKColorRedButton;
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    if (enabled) {
        self.backgroundColor = kQKColorRedButton;
    }
    else {
        self.backgroundColor = kQKColorDisabled;
    }
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if (highlighted) {
        self.alpha = 0.5f;
    }
    else {
        self.alpha = 1.0f;
    }
}

@end
