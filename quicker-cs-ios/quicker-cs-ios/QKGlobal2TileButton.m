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

- (void)setupGlobal {
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    [self setTitleColor:[UIColor colorWithRed:255.0 / 255.0 green:255.0 / 255.0 blue:255.0 / 255.0 alpha:1]  forState:UIControlStateNormal];
    self.backgroundColor = kQKColorBtnPrimary;
    
    _bigTitleLabel = [[QKF1Label alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height/2.0)];
    [_bigTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [_bigTitleLabel setFont:[UIFont systemFontOfSize:14]];
    [self addSubview:_bigTitleLabel];
    
    _smallTitleLabel = [[QKF51Label alloc] initWithFrame:CGRectMake(0, self.height/2.0, self.width, self.height/2.0)];
    [_smallTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [_smallTitleLabel setFont:[UIFont systemFontOfSize:14]];
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
        self.backgroundColor = kQKColorBtnPrimary;
    }
    else {
        self.backgroundColor = kQKColorDisabled;
    }
}

@end
