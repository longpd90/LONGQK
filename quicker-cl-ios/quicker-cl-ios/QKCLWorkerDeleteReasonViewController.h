//
//  QKCLWorkerDeleteReason.h
//  quicker-cl-ios
//
//  Created by Quy on 8/7/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseTableViewController.h"
#import "QKImageView.h"
#import "QKCLAdoptionUserModel.h"
#import "QKCLRecruitmentModel.h"

@interface QKCLWorkerDeleteReasonViewController : QKCLBaseTableViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic) QKCLAdoptionUserModel *userPassModel;
@property (nonatomic, strong) NSString *recruitmentId;

@property (weak, nonatomic) IBOutlet UITableView *thisTableView;

- (IBAction)cancelServiceButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet QKGlobalButton *cancelServiceOutlet;

@end
