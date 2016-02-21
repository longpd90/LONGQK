//
//  QKEditShopInfoViewController.h
//  quicker-cl-ios
//
//  Created by Quy on 5/11/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseTableViewController.h"
#import "QKCLShopInfoModel.h"
#import "QKTextViewTableViewCell.h"
@interface QKCLShopEditInfoViewController : QKCLBaseTableViewController <CCAlertViewDelegate, QKTextViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *editShopTableView;
- (IBAction)deleteShopButtonClicked:(id)sender;
- (IBAction)callCenterButtonClicked:(id)sender;
@end
