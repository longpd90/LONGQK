//
//  QKConfirmApplyRecAlertView.h
//  quicker-cs-ios
//
//  Created by Nguyen Huu Anh on 7/10/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "CCAlertView.h"
#import "QKGlobalPrimaryButton.h"
#import "QKGlobalSecondaryButton.h"

@interface QKConfirmApplyRecAlertView : CCAlertView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIButton *termsOfServiceButton;
@property (weak, nonatomic) IBOutlet UIButton *privacyPolicyButton;
@property (weak, nonatomic) IBOutlet QKGlobalPrimaryButton *applicantsAcceptButton;
@property (weak, nonatomic) IBOutlet QKGlobalSecondaryButton *quitButton;

@property (strong, nonatomic) NSDate *closingDate;

- (instancetype)initConfirmApplyRecAlertView;

@end
