//
//  QKCropImageViewController.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 5/14/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseViewController.h"



@protocol QKCropImageViewControllerDelegate <NSObject>

- (void)croppedImage:(UIImage *)image imageId:(NSString *)imageId;
@end

@interface QKCLCropImageViewController : QKCLBaseViewController <UIScrollViewDelegate>

@property (weak, nonatomic) id <QKCropImageViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic)  UIImageView *imageView;

@property (nonatomic) CGFloat rectangleRadius;
@property (nonatomic) CGPoint rectangleCenter;
@property (nonatomic, weak) CAShapeLayer *maskLayer;
@property (nonatomic, weak) CAShapeLayer *rectangleLayer;
@property (nonatomic) CGRect frame;
@property (nonatomic) CGFloat lastZoomScale;

@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) UIView *rightView;
@property (strong, nonatomic) UIView *bottomView;
@property (strong, nonatomic) UIView *leftView;
@property (strong, nonatomic) UIView *cropView;
@property (assign, nonatomic) float rate;


//param
@property (nonatomic) QKUploadMode mode;
@property (strong, nonatomic) NSString *sourceImageType;
@property (strong, nonatomic) UIImage *sourceImage;
@property (strong, nonatomic) UIImage *croppedImage;
@property (assign, nonatomic) QKCropImageType cropImageType;
@end
