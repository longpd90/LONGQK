//
//  QKNewOfferViewController.h
//  quicker-cl-ios
//
//  Created by Nguyen Viet Thang on 5/26/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseTableViewController.h"
#import "QKGlobalTextView.h"
#import "QKGlobalPickerView.h"
#import "QKCLMasterJobTypeModel.h"
#import "QKTableViewCell.h"
#import "QKCLWebViewController.h"
#import "QKCLRecruitmentModel.h"
#import "QKCLTableView.h"

@interface QKCLRecruitmentNewStep1ViewController : QKCLBaseTableViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet QKCLTableView *tableView;
@property (weak, nonatomic) IBOutlet QKGlobalButton *nextButton;
@property (strong, nonatomic) QKCLRecruitmentModel *recuitmentModel;
- (IBAction)nextButtonClick:(id)sender;

@end
