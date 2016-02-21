//
//  QKAccountDetailViewController.h
//  quicker-cs-ios
//
//  Created by Nguyen Huu Anh on 5/19/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSBaseViewController.h"

@interface QKAccountDetailViewController : QKCSBaseViewController <CCAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *thisTableView;

@end
