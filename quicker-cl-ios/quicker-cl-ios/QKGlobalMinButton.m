//
//  QKGlobalMinButton.m
//  quicker-cl-ios
//
//  Created by Vietnd on 6/5/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKGlobalMinButton.h"
#import "QKCLConst.h"
@interface QKGlobalMinButton ()
@property (strong, nonatomic) UIImageView *indicatorImageView;

@end
@implementation QKGlobalMinButton

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
    self.backgroundColor = kQKColorBtnSecondary;
    [self.titleLabel setFont:[UIFont boldSystemFontOfSize:14]];
}

- (void)setHighlighted:(BOOL)highlighted {
    // [super setHighlighted:highlighted];
    if (highlighted) {
        self.alpha = 0.5f;
    }
    
    else {
        self.alpha = 1.0f;
    }
}

@end
