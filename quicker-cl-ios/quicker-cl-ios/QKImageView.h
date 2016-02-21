//
//  QKImageView.h
//  quicker-cl-ios
//
//  Created by Quy on 6/23/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QKImageView : UIImageView

@property (retain, nonatomic) UIImageView *indicatorImageView;
@property (strong, nonatomic) UIView *views;
- (void)setImageWithQKURL:(NSURL *)url withCache:(BOOL)isCache;
- (void)setImageWithQKURL:(NSURL *)url
         placeholderImage:(UIImage *)placeholderImage withCache:(BOOL)isCache;

@end
