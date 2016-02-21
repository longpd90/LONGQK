//
//  QKConfirmKeyViewController.h
//  quicker-cs-ios
//
//  Created by LongPD-PC on 5/7/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSBaseViewController.h"
typedef enum QKConfirmKeyMode : NSInteger {
    QKConfirmKeyModeNormal = 0,
    QKConfirmKeyModeEdit,
    QKConfirmKeyModeRecruitment
} QKConfirmKeyMode;

@interface QKConfirmKeyViewController : QKCSBaseViewController
@property (weak, nonatomic) IBOutlet UIView *confirmView;
@property (strong, nonatomic) NSString *timeLimitString;
@property (weak, nonatomic) IBOutlet QKGlobalLabel *timeLimitLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backgroundViewContraintToBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *satusViewContraintToTop;
@property (weak, nonatomic) IBOutlet UIButton *resendKeyButton;
- (IBAction)resendConfirmKey:(id)sender;
@property (weak, nonatomic) IBOutlet QKGlobalButton *confirmButton;
- (IBAction)confirmButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *phoneNumerContraintToTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *resendButtonContraintToBottom;

@property (weak, nonatomic) IBOutlet UITextField *confirmKeyTextField;
@property (weak, nonatomic) IBOutlet UILabel *wrongConfirmKeyLabel;
@property (nonatomic)QKConfirmKeyMode mode ;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet QKF43Label *smsLabel;
@property (weak, nonatomic) IBOutlet QKF43Label *expiredLabel;


@end
