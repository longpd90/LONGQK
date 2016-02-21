//
//  QKGlobal2TileButton.m
//  quicker-cs-ios
//
//  Created by LongPD-PC on 6/19/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKGlobal2TileButton.h"



@implementation QKGlobal2TileButton

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

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect rect = _bigTitleLabel.frame;
    rect.size.width = self.frame.size.width;
    _bigTitleLabel.frame = rect;
    rect = _smallTitleLabel.frame;
    rect.size.width = self.frame.size.width;
    _smallTitleLabel.frame = rect;
}

- (void)setupGlobal {
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    self.backgroundColor = kQKColorBtnSecondary;
    [self setTitle:@"" forState:UIControlStateNormal];
    _bigTitleLabel = [[QKF2Label alloc] initWithFrame:CGRectMake(0, 5, self.width, self.height/2.0)];
    _bigTitleLabel.textColor = [UIColor whiteColor];
    [_bigTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_bigTitleLabel];
    
    _smallTitleLabel = [[QKF20Label alloc] initWithFrame:CGRectMake(0, self.height/2.0, self.width, self.height/2.0)];
    _smallTitleLabel.textColor = [UIColor whiteColor];
    [_smallTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_smallTitleLabel];
    
}

- (void)setBigTile:(NSString *)bigTile {
    [_bigTitleLabel setText:bigTile];
}

- (void)setSmallTile:(NSString *)smallTile {
    [_smallTitleLabel setText:smallTile];
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
