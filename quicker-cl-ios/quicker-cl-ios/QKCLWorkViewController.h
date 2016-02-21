
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 4/20/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseTableViewController.h"

@interface QKCLWorkViewController : QKCLBaseTableViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *thisTableview;
@property (weak, nonatomic) IBOutlet UIView *thisView;

@end
