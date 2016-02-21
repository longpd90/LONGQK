//
//  QKSnaphitCameraViewController.h
//  quicker-cl-ios
//
//  Created by LongPD-PC on 4/22/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKCLBaseViewController.h"
#import "QKCLCameraViewController.h"
#import "QKCLCropImageViewController.h"

@interface QKCLAccountCameraHintViewController : QKCLBaseViewController <QKCropImageViewControllerDelegate>
@property (weak, nonatomic) IBOutlet QKGlobalButton *cameraButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLayout;

- (IBAction)cameraButtonClicked:(id)sender;
- (IBAction)closeButtonClicked:(id)sender;

//param
@property (nonatomic) BOOL isHint;
@end
