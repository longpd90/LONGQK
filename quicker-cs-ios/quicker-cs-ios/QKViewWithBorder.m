//
//  QKViewWithBorder.m
//  quicker-cs-ios
//
//  Created by LongPD-PC on 7/6/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKViewWithBorder.h"

@implementation QKViewWithBorder

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupBorder];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBorder];
    }
    return self;
}

- (void)setupBorder {
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [UIColor colorWithRed:204.0 / 255.0 green:204.0 / 255.0 blue:204.0 / 255.0 alpha:1].CGColor;
}

@end
