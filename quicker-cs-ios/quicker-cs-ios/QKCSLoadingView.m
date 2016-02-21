//
//  QKCSLoadingView.m
//  quicker-cs-ios
//
//  Created by VietND on 8/4/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSLoadingView.h"
#import "chiase-ios-core/UIColor+Extra.h"

@interface QKCSLoadingView ()
@property (strong,nonatomic) UIImageView *indicatorImageView;
@property (strong,nonatomic) UIView *bgView;
@end
@implementation QKCSLoadingView

-(id)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        if (!_indicatorImageView) {
            _bgView = [[UIView alloc]initWithFrame:CGRectZero];
            _bgView.backgroundColor = [UIColor colorWithHexString:@"#F5FAFA"];
            _indicatorImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
            [self createIndicatorImage];
            
            [self setTranslatesAutoresizingMaskIntoConstraints:NO];
            [_bgView setTranslatesAutoresizingMaskIntoConstraints:NO];
            [_indicatorImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
            [self addSubview:_bgView];
            [_bgView addSubview:_indicatorImageView];
            NSDictionary *views = @{@"bgView":_bgView,@"indicator":_indicatorImageView};
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[bgView]|" options:0 metrics:nil views:views]];
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[bgView]|" options:0 metrics:nil views:views]];
            [_bgView addConstraint:[NSLayoutConstraint constraintWithItem:_indicatorImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_bgView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
            [_bgView addConstraint:[NSLayoutConstraint constraintWithItem:_indicatorImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_bgView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
            [_indicatorImageView addConstraint:[NSLayoutConstraint constraintWithItem:_indicatorImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20]];
            [_indicatorImageView addConstraint:[NSLayoutConstraint constraintWithItem:_indicatorImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20]];
            [self clipsToBounds];
            [self setTranslatesAutoresizingMaskIntoConstraints:YES];
            self.backgroundColor = [UIColor whiteColor];
            [self layoutIfNeeded];
        }
    }
    return self;
}


- (void)createIndicatorImage {
    NSMutableArray* imageArray = [[NSMutableArray alloc] init];
    for (int i = 1; i < 33; i++) {
        NSString *imageName = [NSString stringWithFormat:@"common_loader_small_000%d", i];
        if (i > 9) {
            imageName = [NSString stringWithFormat:@"common_loader_small_00%d", i];
        }
        [imageArray addObject:[UIImage imageNamed:imageName]];
    }
    
    _indicatorImageView.animationImages = imageArray;
    _indicatorImageView.animationDuration = 1;
    [_indicatorImageView startAnimating];
}
- (void)containingScrollViewDidEndDragging:(UIScrollView *)containingScrollView
{
    CGFloat minOffsetToTriggerRefresh = 50.0f;
    if (containingScrollView.contentOffset.y <= -minOffsetToTriggerRefresh) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

@end
