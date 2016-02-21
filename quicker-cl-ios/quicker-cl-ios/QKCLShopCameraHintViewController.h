//
//  QKRegisterShopHintViewController.h
//  quicker-cl-ios
//
//  Created by Viet on 7/3/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseViewController.h"

@interface QKCLShopCameraHintViewController : QKCLBaseViewController
@property (weak, nonatomic) IBOutlet QKGlobalButton *cameraButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

- (IBAction)closeButtonClicked:(id)sender;

//param
@property (nonatomic) NSInteger index;
@property (nonatomic) BOOL isHint;
@end
