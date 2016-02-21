//
//  QKJobHistoryViewController.h
//  quicker-cs-ios
//
//  Created by LongPD-PC on 5/7/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSBaseViewController.h"
#import "QKTextView.h"
#import "QKRecruitmentModel.h"
#import "QKCSImageView.h"

typedef enum QKCVmode : NSInteger {
    QKCVmodeNormal = 0,
    QKCVmodeModeEdit,
    QKCVModeRecruitment
} QKCVmode;

@interface QKJobHistoryViewController : QKCSBaseViewController
@property (nonatomic) NSInteger sectionSelecting;
@property (strong, nonatomic) NSArray *titles;
@property (strong, nonatomic) NSMutableArray *jobHistorys;
@property ( nonatomic) QKCVmode mode;
@property (assign, nonatomic) float lat;
@property (assign, nonatomic) float lng;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *historyContraintToTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *historyViewContraintHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewConstraintToTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewcontraintToBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarViewcontraintToTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *finishButtonConstraintToTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarToTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentContraintHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarLabelContraintToTop;

@property (weak, nonatomic) IBOutlet UIView *applyView;
@property (weak, nonatomic) IBOutlet QKCSImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UITableView *jobHistoryTableView;
@property (weak, nonatomic) IBOutlet QKTextView *educationTextView;
@property (weak, nonatomic) IBOutlet QKTextView *selfPromotionTextView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleTextView1;
@property (weak, nonatomic) IBOutlet UILabel *titleTextView2;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet QKGlobalSecondaryButton *finishButton;
@property (weak, nonatomic) IBOutlet UILabel *tipInputLabel;
@property (weak, nonatomic) IBOutlet UIView *templateView;
@property (weak, nonatomic) IBOutlet UIView *recruitmentFooterView;
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UIView *statusView;
@property (weak, nonatomic) IBOutlet UILabel *avatarTopLabel;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *historyView;
@property (weak, nonatomic) IBOutlet QKTextView *jobTextView;
@property (weak, nonatomic) IBOutlet UIButton *addJobhistoryButton;
@property (weak, nonatomic) IBOutlet UILabel *avatarLabel;
@property (weak, nonatomic) IBOutlet QKTextView *questionTextView;

@property (strong, nonatomic) QKRecruitmentModel *recruitmentModel;

- (IBAction)termOfUseClicked:(id)sender;
- (IBAction)addMoreHistory:(id)sender;
- (IBAction)saveJobHistoryClicked:(id)sender;
- (IBAction)changeAvatar:(id)sender;
- (IBAction)policyClicked:(id)sender;

@end
