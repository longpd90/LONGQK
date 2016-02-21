//
//  QKRecruitmentStatusViewController.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 7/14/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseTableViewController.h"
#import "QKCLRecruitmentModel.h"

@interface QKCLRecruitmentStatusViewController : QKCLBaseTableViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet QKF2Label *timeUntilAdoptEndLabel;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet QKF40Label *messageLabel;
@property (strong, nonatomic) QKCLRecruitmentModel *recruitmentModel;
@property (strong, nonatomic) NSString *recruitmentId;

@end
