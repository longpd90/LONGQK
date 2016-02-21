//
//  QKCLWorkerYearListViewController.h
//  quicker-cl-ios
//
//  Created by Quy on 7/29/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseTableViewController.h"

@interface QKCLWorkerYearListViewController : QKCLBaseTableViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *thisTableView;
@property (weak, nonatomic) IBOutlet UIView *thisView;

@end
