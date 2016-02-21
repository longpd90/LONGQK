//
//  QKImageView.m
//  quicker-cl-ios
//
//  Created by Quy on 6/23/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKImageView.h"
#import "UIImageView+AFNetworking.h"
@implementation QKImageView
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setImageWithQKURL:(NSURL *)url withCache:(BOOL)isCache {
    [self setImageWithQKURL:url placeholderImage:nil withCache:isCache];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!_views) {
        [self createIndicatorView];
    }
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    _views.frame = self.frame;
    self.indicatorImageView.center = _views.center;
}

- (void)createIndicatorView {
    _views = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    
    _indicatorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    
    [_indicatorImageView setUserInteractionEnabled:NO];
    NSMutableArray *imageArray = [[NSMutableArray alloc] init];
    
    for (int i = 1; i < 33; i++ ) {
        NSString *imageName = [NSString stringWithFormat:@"common_loader_small_000%d",i];
        if (i > 9 ) {
            imageName = [NSString stringWithFormat:@"common_loader_small_00%d",i];
        }
        [imageArray addObject:[UIImage imageNamed:imageName]];
    }
    self.indicatorImageView.animationImages = imageArray;
    self.indicatorImageView.animationDuration = 1.0;
    
    [self.indicatorImageView startAnimating];
    self.indicatorImageView.center = self.views.center;
    [_views setBackgroundColor:[UIColor clearColor]];
    [_views addSubview:_indicatorImageView];
    
    
}

- (void)setImageWithQKURL:(NSURL *)url
         placeholderImage:(UIImage *)placeholderImage withCache:(BOOL)isCache {
    //show loading
    
    [self addSubview:_views];
    
    [self bringSubviewToFront:_views];
    
    NSMutableURLRequest *imageRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    if (!isCache) {
        imageRequest.cachePolicy=NSURLRequestReloadIgnoringCacheData;
    }
    [imageRequest addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    //get image from url
    __weak typeof(self) weakSelf = self;
    
    [self setImageWithURLRequest:imageRequest placeholderImage:placeholderImage success: ^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        //hide loading
        [weakSelf.indicatorImageView stopAnimating];
        [weakSelf.views removeFromSuperview];
        [weakSelf setContentMode:UIViewContentModeScaleToFill];
        [weakSelf setImage:image];
        [weakSelf setNeedsLayout];
        
    } failure: ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        //hide loading
        //[weakSelf.indicatorImageView setHidden:YES];
        [weakSelf.indicatorImageView stopAnimating];
        [weakSelf.views removeFromSuperview];
    }];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
