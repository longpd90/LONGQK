//
//  QKCameraViewController.h
//  quicker-cl-ios
//
//  Created by Nguyen Viet Thang on 5/15/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>


typedef enum FlashMode : int {
    flash_on = 0,
    flash_off
} FlashMode;

@class QKCLCameraViewController;
@protocol QKCameraViewControllerDelegate <NSObject>
- (void)QKCameraViewGetImageFinish:(UIImage *)img;
@end


@interface QKCLCameraViewController : QKCLBaseViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btnSwichCamera;

@property (nonatomic, unsafe_unretained) id <QKCameraViewControllerDelegate> delegate;

@property (strong, nonatomic) AVCaptureSession *captureSession;
@property (strong, nonatomic) AVCaptureDeviceInput *videoInput;
@property (strong, nonatomic) AVCaptureStillImageOutput *stillImageOutput;
@property (weak, nonatomic) IBOutlet UIButton *cameraHintButton;
@property (weak, nonatomic) IBOutlet UIButton *btnCapture;
@property (weak, nonatomic) IBOutlet UIView *preview;
@property (weak, nonatomic) IBOutlet UIImageView *camera_frame;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *footerView;

//param
@property (strong, nonatomic) UIViewController *presentingVC;
@property (nonatomic) QKUploadMode mode;
@property (strong, nonatomic) NSString *sourceImageType;
@property (strong, nonatomic) UIImage *sourceImage;
@property (assign, nonatomic) QKCropImageType cropImageType;
@property (nonatomic) BOOL noEditFlag;
@property (assign, nonatomic) BOOL isCaptureForAvatar;
@property (strong, nonatomic) NSString *hintSegue;

- (IBAction)btnCaptureClick:(id)sender;
- (IBAction)btnShowHintClick:(id)sender;
- (IBAction)btnCloseClick:(id)sender;
- (IBAction)SwichCameraClick:(id)sender;
- (IBAction)flashClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnFlash;
- (IBAction)btnCameraRollClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *lastestImageButton;

@end
