//
//  QKCreatProfileViewController.h
//  quicker-cs-ios
//
//  Created by LongPD-PC on 5/7/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSBaseViewController.h"
#import "QKProfileDetailModel.h"
#import "QKGlobalPrimaryButton.h"
#import "QKGlobalSecondaryButton.h"

typedef enum QKProfileMode : NSInteger {
	QKProfileModeNormal = 0,
	QKProfileModeEdit,
    QKProfileModeRecruitment
} QKProfileMode;

enum QKAlertViewMode : NSInteger {
    QKAlertViewModeConfirmPass = 0,
    QKAlertViewModeWrongPass,
} ;

typedef enum QKProfileField : NSInteger {
    QKProfileFieldFistName = 0,
    QKProfileFieldLastName,
    QKProfileFieldFistNameKana,
    QKProfileFieldLastNameKana,
    QKProfileFieldPhone,
    QKProfileFieldBirtday,
    QKProfileFieldGender,
    QKProfileFieldOccupation,
} QKProfileField;

@interface QKCreatProfileViewController : QKCSBaseViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *profileLabel;
@property (assign, nonatomic) QKProfileField currentField;
@property (weak, nonatomic) IBOutlet UIView *headerTableView;
@property (strong, nonatomic) QKProfileDetailModel *profileDetail;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//param
@property (weak, nonatomic) IBOutlet UIView *templateView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *finishToTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewContraintToTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewContraintToBottom;

@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UIView *statusView;
@property (nonatomic)QKProfileMode mode ;
@property (weak, nonatomic) IBOutlet QKF3Label *topLabel;
@property (weak, nonatomic) IBOutlet QKF43Label *centerLabel;
@property (weak, nonatomic) IBOutlet QKF43Label *footerLabel;
@property (weak, nonatomic) IBOutlet UIView *notificationView;
@property (weak, nonatomic) IBOutlet QKGlobalPrimaryButton *finishButton;
@property (weak, nonatomic) IBOutlet QKGlobalSecondaryButton *nextButton;
@property (weak, nonatomic) IBOutlet QKGlobalLabel *timeLeftLabel;
@property (assign, nonatomic) BOOL showPhoneNumAuthenCell;
@property (assign, nonatomic) NSDate *closingDate;

- (IBAction)policyClicked:(id)sender;
- (IBAction)termOfUseClicked:(id)sender;
- (IBAction)creatProfileFinish:(id)sender;

@end
