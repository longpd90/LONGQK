//
//  QKUserGuideViewController.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 6/8/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseViewController.h"

@interface QKCLUserGuideViewController : QKCLBaseViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
