//
//  QKDescriptionPaymentMethodViewController.h
//  quicker-cl-ios
//
//  Created by Quy on 5/28/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseViewController.h"

@interface QKCLDescriptionPaymentMethodViewController : QKCLBaseViewController
@property (weak, nonatomic) IBOutlet UIScrollView *thisScrollView;

//param
@property (nonatomic) QKPaymentSettingMode mode;
@property (strong,nonatomic) NSString* shopId;
@end
