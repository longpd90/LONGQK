//
//  QKCSGlobalImageAndTitleButton.m
//  quicker-cs-ios
//
//  Created by C Anh on 8/24/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSGlobalImageAndTitleButton.h"

@implementation QKCSGlobalImageAndTitleButton

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
    
    self.decriptionTitleLabel = [[QKF1Label alloc] initWithFrame:CGRectMake(0, self.height - 10, self.width, self.height/3.0)];
    [self.decriptionTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.decriptionTitleLabel setFont:[UIFont systemFontOfSize:14]];
    [self addSubview:self.decriptionTitleLabel];
    self.imageViewButton = [[UIImageView alloc] initWithFrame:CGRectMake(self.width/2 - 10, 10, self.height/2, self.height/2)];
    
    self.imageViewButton.contentMode = UIViewContentModeCenter;
    self.imageViewButton.backgroundColor = [UIColor blackColor];
    [self addSubview:self.imageViewButton];

}
- (void)setTitle:(NSString *)title {
    [self.decriptionTitleLabel setText:title];
}

- (void)setImage:(UIImage *)image {
    [self.imageViewButton setImage:image];
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    if (enabled) {
        self.backgroundColor = kQKColorBtnSecondary;
    }
    else {
        self.backgroundColor = kQKColorDisabled;
    }
}


@end
