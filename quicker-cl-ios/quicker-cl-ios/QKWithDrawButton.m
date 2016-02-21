//
//  QKWithDrawButton.m
//  quicker-cl-ios
//
//  Created by Quy on 6/19/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKWithDrawButton.h"
#import "QKCLConst.h"
#import <UIKit/UIKit.h>
@implementation QKWithDrawButton

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
    //[self setTintColor:[UIColor colorWithRed:255.0 / 255.0 green:255.0 / 255.0 blue:255.0 / 255.0 alpha:1]];
    
    [self setTitleColor:[UIColor colorWithRed:201.0 / 255.0 green:65.0 / 255.0 blue:82.0 / 255.0 alpha:1]  forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont boldSystemFontOfSize:11]];
}

- (void)setHighlighted:(BOOL)highlighted {
    // [super setHighlighted:highlighted];
    if (highlighted) {
        self.alpha = 0.5f;
        self.backgroundColor = kQKColorHighlighted;
    }
    else {
        self.alpha = 1.0f;
        self.backgroundColor = [UIColor clearColor];
    }
}

@end
