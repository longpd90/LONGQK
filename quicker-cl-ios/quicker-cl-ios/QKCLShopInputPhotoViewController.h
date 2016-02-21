//
//  QKRegisterStoreInfoViewController.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 4/16/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseViewController.h"
#import "QKCLCameraViewController.h"

@interface QKCLShopInputPhotoViewController : QKCLBaseViewController <UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet QKGlobalButton *completeRegisterShopButton;


- (IBAction)completeRegisterShopClicked:(id)sender;

//param
@property (strong, nonatomic) NSString *json;
@property (strong, nonatomic) NSString *accessWay;

@end
