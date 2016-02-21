//
//  QKButtonGlobal.m
//  quicker-cl-ios
//
//  Created by LongPD-PC on 4/14/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKGlobalButton.h"
#import "QKCLConst.h"
#import <UIKit/UIKit.h>
#import "QKCLBigLoadingView.h"
@interface QKGlobalButton ()
@property (strong, nonatomic) UIImageView *indicatorImageView;

@end
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

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!_indicatorImageView) {
        [self createIndicatorView];
    }
}

- (void)createIndicatorView {
    float _widthIs =
    [self.titleLabel.text
     boundingRectWithSize:self.titleLabel.frame.size
     options:NSStringDrawingUsesLineFragmentOrigin
     attributes:@{ NSFontAttributeName:self.titleLabel.font }
     context:nil]
    .size.width;
    
    _indicatorImageView = [[UIImageView alloc] initWithFrame:
                           CGRectMake(_widthIs * 0.5  + self.frame.size.width * 0.5 + 10, self.frame.size.height * 0.5 - 6, 12, 12)];
    [_indicatorImageView setUserInteractionEnabled:NO];
    NSMutableArray *imageArray = [[NSMutableArray alloc] init];
    
    for (int i = 1; i < 33; i++) {
        NSString *imageName = [NSString stringWithFormat:@"common_loader_inbtn_000%d", i];
        if (i > 9) {
            imageName = [NSString stringWithFormat:@"common_loader_inbtn_00%d", i];
        }
        [imageArray addObject:[UIImage imageNamed:imageName]];
    }
    
    self.indicatorImageView.animationImages = imageArray;
    self.indicatorImageView.animationDuration = 1.0;
    [self.indicatorImageView startAnimating];
}

- (void)setupGlobal {
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    //[self setTintColor:[UIColor colorWithRed:255.0 / 255.0 green:255.0 / 255.0 blue:255.0 / 255.0 alpha:1]];
    [self setTitleColor:[UIColor colorWithRed:255.0 / 255.0 green:255.0 / 255.0 blue:255.0 / 255.0 alpha:1]  forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    
    self.backgroundColor = kQKColorBtnSecondary;
    
    //[self createIndicatorView];
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

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if (highlighted) {
        self.alpha = 0.5f;
        [self showIndicator];
    }
    
    else {
        self.alpha = 1.0f;
        [self hideIndicator];
    }
}

- (void)showIndicator {
    [self addSubview:_indicatorImageView];
}

- (void)hideIndicator {
    [_indicatorImageView removeFromSuperview];
    _indicatorImageView = nil;
}

@end
