//
//  QKCLWorkerMonthListViewController.h
//  quicker-cl-ios
//
//  Created by Quy on 7/30/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseTableViewController.h"

@interface QKCLWorkerMonthListViewController : QKCLBaseTableViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)NSString *year;
@property (nonatomic, strong)NSString *month;
@property (weak, nonatomic) IBOutlet UITableView *thisTableView;

@end
