//
//  QKViewController.h
//  quicker-cl-ios
//
//  Created by Viet on 6/4/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseViewController.h"
#import "QKCLSignUpModel.h"

@interface QKCLViewController : QKCLBaseViewController
@property (weak, nonatomic) IBOutlet UIButton *signupButton;
@property (weak, nonatomic) IBOutlet UIImageView *signupArrow;
@property (weak, nonatomic) IBOutlet UIButton *signinButton;
@property (weak, nonatomic) IBOutlet UIImageView *signinArrow;
@property (weak, nonatomic) IBOutlet UIView *signinContainer;
@property (weak, nonatomic) IBOutlet UIView *signupContainer;
- (IBAction)signupButtonSelected:(id)sender;
- (IBAction)signinButtonSelected:(id)sender;

//param
@property (strong, nonatomic) QKCLSignUpModel *signupModel;
@property (nonatomic) BOOL isSignUp;
@end
