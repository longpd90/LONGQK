//
//  QKCameraViewController.m
//  quicker-cs-ios
//
//  Created by Nguyen Viet Thang on 5/15/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCameraViewController.h"
#import "QKCaptureAvatarHint.h"
#import "QKCropImageViewController.h"
static CGFloat DegreesToRadians(CGFloat degrees) {
    return degrees * M_PI / 180;
};

@interface QKCameraViewController ()<QKCaptureAvatarHintDelegate>
{
    UIDevice *device;
    
}
@property (nonatomic)   NSInteger flash_mode;
@property (strong, nonatomic) UIImage *image;
@property (nonatomic) AVCaptureDevicePosition currentPosition;
@end

@implementation QKCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getLastestImage];
    // Do any additional setup after loading the view.
    self.captureSession = [[AVCaptureSession alloc] init];
    //self.captureSession.sessionPreset = AVCaptureSessionPresetMedium;
    
    AVCaptureDevice *thisdevice =
    [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    NSError *error = nil;
    self.videoInput = [AVCaptureDeviceInput deviceInputWithDevice:thisdevice error:&error];
    if (self.videoInput) {
        [self.captureSession addInput:self.videoInput];
    }
    else {
        NSLog(@"Input Error: %@", error);
    }
    
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *stillImageOutputSettings =
    [[NSDictionary alloc] initWithObjectsAndKeys:
     AVVideoCodecJPEG, AVVideoCodecKey, nil];
    [self.stillImageOutput setOutputSettings:stillImageOutputSettings];
    [self.captureSession addOutput:self.stillImageOutput];
    
    [self.headerView setBackgroundColor:kQKColorBtnSecondary];
    [self.headerView setAlpha:0.8f];
    [self.footerView setBackgroundColor:kQKColorBtnSecondary];
    AVCaptureVideoPreviewLayer *previewLayer =
    [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    [previewLayer setBackgroundColor:[[UIColor blackColor] CGColor]];
    [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspect];
    CALayer *rootLayer = [self.preview layer];
    [rootLayer setMasksToBounds:YES];
    CGRect frame = [[UIApplication sharedApplication] keyWindow].frame;
    [previewLayer setFrame:frame];
    [rootLayer addSublayer:previewLayer];
    [self setFlashModeForState:AVCaptureFlashModeAuto];
    _flash_mode = flash_off;
    self.currentPosition = AVCaptureDevicePositionBack;
    if (_isCaptureForAvatar) {
        [self.camera_frame setHidden:NO];
        [self swapFrontAndBackCameras];
    }
    
    NSString *showTipJob = [QKAccessUserDefaults get:kQKNeedShowAvatarHintKey];
    if (![kQKNeedShowAvatarHint isEqualToString:showTipJob]) {
        [QKAccessUserDefaults put:kQKNeedShowAvatarHintKey withValue:kQKNeedShowAvatarHint];
        [self showAvatarHint];
    }
    // add observer to detect divece rotate
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChanged:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(status == AVAuthorizationStatusAuthorized) {
        // authorized
        [_btnCapture setEnabled:YES];
    } else if(status == AVAuthorizationStatusDenied) {
        // denied
        CCAlertView *alertView = [[CCAlertView alloc]initWithTitle:@"Camera is denied!" message:@"Please change access permission in Setting." delegate:nil buttonTitles:[NSArray arrayWithObjects:@"OK", nil]];
        [alertView showAlert];
        [_btnCapture setEnabled:NO];
    } else if(status == AVAuthorizationStatusRestricted) {
        // restricted
        CCAlertView *alertView = [[CCAlertView alloc]initWithTitle:@"Camera is restricted!" message:@"" delegate:nil buttonTitles:[NSArray arrayWithObjects:@"OK", nil]];
        [alertView showAlert];
        [_btnCapture setEnabled:NO];
    } else if(status == AVAuthorizationStatusNotDetermined) {
        // not determined
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if(granted) {
                NSLog(@"Granted access");
                [_btnCapture setEnabled:YES];
            } else {
                CCAlertView *alertView = [[CCAlertView alloc]initWithTitle:@"Camera is denied!" message:@"Please change access permission in Setting." delegate:nil buttonTitles:[NSArray arrayWithObjects:@"OK", nil]];
                [alertView showAlert];
                [_btnCapture setEnabled:NO];
            }
        }];
    }
    
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self.captureSession startRunning];
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    device = [UIDevice currentDevice];
    //hidden status bar
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
}
//get the lastes photo from library
- (void)getLastestImage {
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    
    
    
    [library enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock: ^(ALAssetsGroup *group, BOOL *stop) {
        // Within the group enumeration block, filter to enumerate just photos.
        
        [group setAssetsFilter:[ALAssetsFilter allPhotos]];
        
        
        
        // Chooses the photo at the last index
        
        [group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock: ^(ALAsset *alAsset, NSUInteger index, BOOL *innerStop) {
            // The end of the enumeration is signaled by asset == nil.
            
            if (alAsset) {
                ALAssetRepresentation *representation = [alAsset defaultRepresentation];
                
                UIImage *latestPhoto = [UIImage imageWithCGImage:[representation fullScreenImage]];
                
                
                
                [self.lastestImageButton setBackgroundImage:latestPhoto forState:UIControlStateNormal];
                
                // Stop the enumerations
                
                *stop = YES;
                
                *innerStop = YES;
            }
        }];
    } failureBlock: ^(NSError *error) {
        // Typically you should handle an error more gracefully than this.
        
        NSLog(@"No groups");
    }];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.captureSession stopRunning];
    [self setFlashModeForState:AVCaptureFlashModeAuto];
    
    //show status bar
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)btnCaptureClick:(id)sender {
    AVCaptureConnection *stillImageConnection =
    [self.stillImageOutput.connections objectAtIndex:0];
    if ([stillImageConnection isVideoOrientationSupported])
        [stillImageConnection setVideoOrientation:AVCaptureVideoOrientationPortrait];
    
    [self.stillImageOutput
     captureStillImageAsynchronouslyFromConnection:stillImageConnection
     completionHandler: ^(CMSampleBufferRef imageDataSampleBuffer, NSError *error)
     {
         if (imageDataSampleBuffer != NULL) {
             NSData *imageData = [AVCaptureStillImageOutput
                                  jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
             _image = [[UIImage alloc] initWithData:imageData];
             _image = [self getTrueImage:_image];
             ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
             // Request to save the image to camera roll
             [library writeImageToSavedPhotosAlbum:[_image CGImage] orientation:(ALAssetOrientation)[_image imageOrientation] completionBlock: ^(NSURL *assetURL, NSError *error) {
                 if (error) {
                     //NOT SAVED
                     //DISPLAY ERROR THE PICTURE CAN'T BE SAVED
                 }
                 else {
                     //SAVED
                 }
             }];
             NSLog(@"image size: %@", NSStringFromCGSize(_image.size));
             //            UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
             //            [self.view addSubview: imageView];
             //            imageView.contentMode = UIViewContentModeScaleAspectFit;
             //            imageView.image = _image;
             //close popup
             if (_noEditFlag) {
                 [self dismissViewControllerAnimated:YES completion: ^{
                     //get image
                     if ([self.delegate respondsToSelector:@selector(QKCameraViewGetImageFinish:)]) {
                         [self.delegate QKCameraViewGetImageFinish:_image];
                     }
                 }];
             }
             else {
                 [self performSegueWithIdentifier:@"QKShowCropImageSegue" sender:self];
             }
         }
         else {
             NSLog(@"Error capturing still image: %@", error);
         }
     }
     ];
}

- (IBAction)btnShowHintClick:(id)sender {
    //	if ([_hintSegue isEqualToString:@"QKCaptureAvatarHint"]) {
    QKCaptureAvatarHint *captureAvatar = [[QKCaptureAvatarHint alloc] initWithXibAndFrame:self.view.frame];
    captureAvatar.hiddenButton.hidden = YES;
    captureAvatar.bottomConstrainst.constant =30;
    captureAvatar.delegate = self;
    [self presentView:captureAvatar];
    //	}
    //	else if (_hintSegue != nil && ![_hintSegue isEqualToString:@""]) {
    //		[self performSegueWithIdentifier:_hintSegue sender:self];
    //	}
}

- (void)showAvatarHint {
    QKCaptureAvatarHint *captureAvatar = [[QKCaptureAvatarHint alloc] initWithXibAndFrame:self.view.frame];
    captureAvatar.delegate = self;
    [self presentView:captureAvatar];
}

- (void)presentView:(UIView *)view {
    CGRect frame = view.frame;
    frame.origin.y = CGRectGetHeight(self.view.frame);
    view.frame = frame;
    [self.view addSubview:view];
    [UIView animateWithDuration:0.3 animations: ^{
        view.y = 0.0;
    }];
}

- (void)hiddenView:(UIView *)view {
    [UIView animateWithDuration:0.3 animations:^{
        view.y = self.view.height;
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
    }];
}

- (void)hiddenAvatarGuide:(QKCaptureAvatarHint *)view {
    [self hiddenView:view];
}
- (IBAction)btnCloseClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)SwichCameraClick:(id)sender {
    [self swapFrontAndBackCameras];
}

- (IBAction)flashClick:(id)sender {
    if (_flash_mode == flash_on) {
        [self setFlashModeForState:AVCaptureFlashModeOff];
        _flash_mode = flash_off;
        [self rotateButtonInCamera];
    }
    else {
        [self setFlashModeForState:AVCaptureFlashModeOn];
        _flash_mode = flash_on;
        [self rotateButtonInCamera];
    }
}
#pragma mark - detect device rotation to rotate flash image

- (void)orientationChanged:(NSNotification *)note {
    device = note.object;
    [self rotateButtonInCamera];
    
}

- (void)rotateButtonInCamera {
    if (device.orientation == UIDeviceOrientationPortrait) {
        if (_flash_mode == flash_off) {
            //rotate image splash
            [self.btnFlash setImage:[UIImage imageNamed:@"camera_btn_flash_inactive"] forState:UIControlStateNormal];
        }
        else {
            //rotate image splash
            [self.btnFlash setImage:[UIImage imageNamed:@"camera_btn_flash_active"] forState:UIControlStateNormal];
        }
        
        //rotate image hit
        [self.cameraHintButton setImage:[UIImage imageNamed:@"camera_btn_hint"] forState:UIControlStateNormal];
        
        //rotate image switch camera
        [self.btnSwichCamera setImage:[UIImage imageNamed:@"camera_btn_change"] forState:UIControlStateNormal];
        
        [self getLastestImage];
    }
    else if (device.orientation == UIDeviceOrientationLandscapeLeft) {
        //rotate image splash
        UIImage *returnImage;
        
        if (_flash_mode == flash_off) {
            returnImage = [self imageRotatedByDegrees:[UIImage imageNamed:@"camera_btn_flash_inactive"]  deg:90];
        }
        else {
            returnImage = [self imageRotatedByDegrees:[UIImage imageNamed:@"camera_btn_flash_active"]  deg:90];
        }
        
        [self.btnFlash setImage:returnImage forState:UIControlStateNormal];
        
        //rotate image hit
        returnImage = [self imageRotatedByDegrees:[UIImage imageNamed:@"camera_btn_hint"] deg:90];
        [self.cameraHintButton setImage:returnImage forState:UIControlStateNormal];
        
        //rotate image switch camera
        returnImage = [self imageRotatedByDegrees:[UIImage imageNamed:@"camera_btn_change"] deg:90];
        [self.btnSwichCamera setImage:returnImage forState:UIControlStateNormal];
        
        UIImage *image = [self.lastestImageButton backgroundImageForState:UIControlStateNormal];
        returnImage = [self imageRotatedByDegrees:image deg:90];
        [self.lastestImageButton setBackgroundImage:returnImage forState:UIControlStateNormal];
    }
    else if (device.orientation == UIDeviceOrientationLandscapeRight) {
        //rotate image splash
        UIImage *returnImage;
        
        if (_flash_mode == flash_off) {
            returnImage = [self imageRotatedByDegrees:[UIImage imageNamed:@"camera_btn_flash_inactive"]  deg:-90];
        }
        else {
            returnImage = [self imageRotatedByDegrees:[UIImage imageNamed:@"camera_btn_flash_active"]  deg:-90];
        }
        
        [self.btnFlash setImage:returnImage forState:UIControlStateNormal];
        
        //rotate image hit
        returnImage = [self imageRotatedByDegrees:[UIImage imageNamed:@"camera_btn_hint"] deg:-90];
        [self.cameraHintButton setImage:returnImage forState:UIControlStateNormal];
        
        //rotate image switch camera
        returnImage = [self imageRotatedByDegrees:[UIImage imageNamed:@"camera_btn_change"] deg:-90];
        [self.btnSwichCamera setImage:returnImage forState:UIControlStateNormal];
        
        UIImage *image = [self.lastestImageButton backgroundImageForState:UIControlStateNormal];
        returnImage = [self imageRotatedByDegrees:image deg:-90];
        [self.lastestImageButton setBackgroundImage:returnImage forState:UIControlStateNormal];
    }
    else if (device.orientation == UIDeviceOrientationPortraitUpsideDown) {
        //rotate image splash
        UIImage *returnImage;
        
        if (_flash_mode == flash_off) {
            returnImage = [self imageRotatedByDegrees:[UIImage imageNamed:@"camera_btn_flash_inactive"]  deg:180];
        }
        else {
            returnImage = [self imageRotatedByDegrees:[UIImage imageNamed:@"camera_btn_flash_active"]  deg:180];
        }
        
        [self.btnFlash setImage:returnImage forState:UIControlStateNormal];
        
        //rotate image hit
        returnImage = [self imageRotatedByDegrees:[UIImage imageNamed:@"camera_btn_hint"] deg:180];
        [self.cameraHintButton setImage:returnImage forState:UIControlStateNormal];
        
        //rotate image switch camera
        returnImage = [self imageRotatedByDegrees:[UIImage imageNamed:@"camera_btn_change"] deg:180];
        [self.btnSwichCamera setImage:returnImage forState:UIControlStateNormal];
        
        UIImage *image = [self.lastestImageButton backgroundImageForState:UIControlStateNormal];
        returnImage = [self imageRotatedByDegrees:image deg:90];
        [self.lastestImageButton setBackgroundImage:returnImage forState:UIControlStateNormal];
    }
}

- (UIImage *)imageRotatedByDegrees:(UIImage *)oldImage deg:(CGFloat)degrees {
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0, 0, oldImage.size.width, oldImage.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(degrees * M_PI / 180);
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width / 2, rotatedSize.height / 2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, (degrees * M_PI / 180));
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-oldImage.size.width / 2, -oldImage.size.height / 2, oldImage.size.width, oldImage.size.height), [oldImage CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - Camera Properties

//switch camera front and back
- (void)swapFrontAndBackCameras {
    // Assume the session is already running
    
    NSArray *inputs = self.captureSession.inputs;
    for (AVCaptureDeviceInput *input in inputs) {
        AVCaptureDevice *thisdevice = input.device;
        if ([thisdevice hasMediaType:AVMediaTypeVideo]) {
            AVCaptureDevicePosition position = thisdevice.position;
            AVCaptureDevice *newCamera = nil;
            AVCaptureDeviceInput *newInput = nil;
            
            if (position == AVCaptureDevicePositionFront) {
                newCamera = [self cameraWithPosition:AVCaptureDevicePositionBack];
                self.currentPosition = AVCaptureDevicePositionBack;
                self.btnFlash.hidden = NO;
            }
            else {
                newCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];
                self.currentPosition = AVCaptureDevicePositionFront;
                self.btnFlash.hidden = YES;
            }
            newInput = [AVCaptureDeviceInput deviceInputWithDevice:newCamera error:nil];
            
            // beginConfiguration ensures that pending changes are not applied immediately
            [self.captureSession beginConfiguration];
            
            [self.captureSession removeInput:input];
            [self.captureSession addInput:newInput];
            
            // Changes take effect once the outermost commitConfiguration is invoked.
            [self.captureSession commitConfiguration];
            break;
        }
    }
}

- (BOOL)isHasFlash {
    return [[self backFacingCamera] hasFlash];
}

- (UIImage *)getTrueImage:(UIImage *)image {
    if (device.orientation == UIDeviceOrientationPortrait) {
        return image;
    }
    else if (device.orientation == UIDeviceOrientationLandscapeLeft) {
        if (self.currentPosition == AVCaptureDevicePositionFront) {
            return [self imageRotatedImage:image byDegrees:90];
        } else
            return [self imageRotatedImage:image byDegrees:-90];
    }
    else if (device.orientation == UIDeviceOrientationLandscapeRight) {
        if (self.currentPosition == AVCaptureDevicePositionFront) {
            return [self imageRotatedImage:image byDegrees:-90];
        } else
            return [self imageRotatedImage:image byDegrees:90];
    }
    else if (device.orientation == UIDeviceOrientationPortraitUpsideDown) {
        return [self imageRotatedImage:image byDegrees:180];
    }
    return image;
    
}

- (UIImage *)imageRotatedImage:(UIImage *)image byDegrees:(CGFloat)degrees
{
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,image.size.width, image.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(DegreesToRadians(degrees));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, DegreesToRadians(degrees + 90));
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-rotatedSize.width / 2, -rotatedSize.height / 2, rotatedSize.width, rotatedSize.height), [image CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
}

- (void)setFlashModeForState:(AVCaptureFlashMode)flashMode {
    NSError *error;
    if ([self isHasFlash]) {
        if ([[self backFacingCamera] lockForConfiguration:&error]) {
            if ([[self backFacingCamera] isFlashModeSupported:flashMode]) {
                [[self backFacingCamera] setFlashMode:flashMode];
            }
            [[self backFacingCamera] unlockForConfiguration];
        }
    }
}

//set camera back
- (AVCaptureDevice *)backFacingCamera {
    return [self cameraWithPosition:AVCaptureDevicePositionBack];
}

// Find a camera with the specificed AVCaptureDevicePosition, returning nil if one is not found
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    AVCaptureDevice *captureDevice = nil;
    
    for (AVCaptureDevice *thisdevice in devices) {
        if (thisdevice.position == position) {
            captureDevice = thisdevice;
            break;
        }
    }
    
    //  couldn't find one on the front, so just get the default video device.
    if (!captureDevice) {
        captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return captureDevice;
}

//choose image from camera roll
- (IBAction)btnCameraRollClick:(id)sender {
    
    BOOL canAccessCameraRoll = YES;
    //check permission to library
    ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
    switch (status) {
        case ALAuthorizationStatusNotDetermined: {
            // not determined
            CCAlertView *alertView = [[CCAlertView alloc]initWithTitle:@"CameraRoll is determined!" message:@"" delegate:nil buttonTitles:[NSArray arrayWithObjects:@"OK", nil]];
            [alertView showAlert];
            canAccessCameraRoll =NO;
            break;
        }
        case ALAuthorizationStatusRestricted: {
            // restricted
            CCAlertView *alertView = [[CCAlertView alloc]initWithTitle:@"CameraRoll is restricted!" message:@"" delegate:nil buttonTitles:[NSArray arrayWithObjects:@"OK", nil]];
            [alertView showAlert];
            canAccessCameraRoll =NO;
            break;
        }
        case ALAuthorizationStatusDenied: {
            // denied
            CCAlertView *alertView = [[CCAlertView alloc]initWithTitle:@"CameraRoll is denied!" message:@"Please change access permission in Setting." delegate:nil buttonTitles:[NSArray arrayWithObjects:@"OK", nil]];
            [alertView showAlert];
            canAccessCameraRoll =NO;
            break;
        }
        case ALAuthorizationStatusAuthorized: {
            // authorized
            break;
        }
        default: {
            break;
        }
    }
    if (canAccessCameraRoll) {
        UIImagePickerController *imagePickerView = [[UIImagePickerController alloc] init];
        imagePickerView.delegate = self;
        imagePickerView.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerView animated:NO completion:nil];
    }
}

# pragma mark - image picker view delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:NO completion: ^{
        _image = [info objectForKey:UIImagePickerControllerOriginalImage];
        if (_noEditFlag) {
            [self dismissViewControllerAnimated:YES completion: ^{
                //get image
                if ([self.delegate respondsToSelector:@selector(QKCameraViewGetImageFinish:)]) {
                    [self.delegate QKCameraViewGetImageFinish:_image];
                }
            }];
        }
        else {
            [self performSegueWithIdentifier:@"QKShowCropImageSegue" sender:self];
        }
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:NO completion:NULL];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"QKShowCropImageSegue"]) {
        QKCropImageViewController *vc = (QKCropImageViewController *)segue.destinationViewController;
        
        vc.delegate = self.presentingVC;
        [vc setSourceImage:_image];
        [vc setSourceImageType:_sourceImageType];
        [vc setCropImageType:_cropImageType];
    }
}

@end
