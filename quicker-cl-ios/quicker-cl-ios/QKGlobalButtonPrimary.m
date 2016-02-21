//
//  QKGlobalButtonPrimary.m
//  quicker-cl-ios
//
//  Created by Quy on 8/7/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKGlobalButtonPrimary.h"
#import "QKCLConst.h"
@implementation QKGlobalButtonPrimary

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    if (enabled) {
        self.backgroundColor = kQKColorBtnPrimary;
    }
    else {
        self.backgroundColor = kQKColorDisabled;
    }
}

- (void)setupGlobal {
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    //[self setTintColor:[UIColor colorWithRed:255.0 / 255.0 green:255.0 / 255.0 blue:255.0 / 255.0 alpha:1]];
    [self setTitleColor:[UIColor colorWithRed:255.0 / 255.0 green:255.0 / 255.0 blue:255.0 / 255.0 alpha:1]  forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    
    self.backgroundColor = kQKColorBtnPrimary;
    
    //[self createIndicatorView];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
