//
//  QKCLWorkerFavoriteViewController.h
//  quicker-cl-ios
//
//  Created by Quy on 7/31/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseTableViewController.h"

@interface QKCLWorkerFavoriteViewController : QKCLBaseTableViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *thisView;
@property (weak, nonatomic) IBOutlet UITableView *thisTableView;

@end
