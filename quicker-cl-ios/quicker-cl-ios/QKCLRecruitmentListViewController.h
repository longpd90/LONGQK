//
//  OfferControlViewController.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 4/20/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseTableViewController.h"

typedef enum QKRecruitmentState : NSInteger {
    QKRecruitmentStateNoRecruitment = 0,
    QKRecruitmentStateHaveRecruitment,
    QKRecruitmentStateNoPayment
} QKRecruitmentState;

@interface QKCLRecruitmentListViewController : QKCLBaseTableViewController <UITableViewDataSource, UITableViewDelegate>

@property (assign, nonatomic) QKRecruitmentState recruitmentState;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *noRecruitmentView;
@property (weak, nonatomic) IBOutlet QKF10Label *noRecMessageLabel;
- (IBAction)addNewRecruitmentButtonClicked:(id)sender;


@property (weak, nonatomic) IBOutlet UIView *noPaymentView;
@property (weak, nonatomic) IBOutlet UIImageView *noPaymentImageView;
@property (weak, nonatomic) IBOutlet QKF10Label *noPaymentMessageLabel;
- (IBAction)noPaymentButtonClicked:(id)sender;


@end
