//
//  QKSelectJobTypeViewController.h
//  quicker-cl-ios
//
//  Created by Vietnd on 6/13/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//


#import "QKCLBaseTableViewController.h"
#import "QKCLMasterJobTypeModel.h"
#import "QKCLConst.h"

@protocol QKCLSelectJobTypeDelegate <NSObject>
- (void)jobTypeSelected:(QKCLMasterJobTypeModel *)selectedJobType;
@end

@interface QKCLSelectJobTypeViewController : QKCLBaseTableViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) QKJobType jobType;
@property (strong, nonatomic) QKCLMasterJobTypeModel *currentJobType;

@property (strong, nonatomic) id <QKCLSelectJobTypeDelegate> delegate;

@end
