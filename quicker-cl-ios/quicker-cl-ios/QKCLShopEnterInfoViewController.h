//
//  QKEnterStoreInfoViewController.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 4/15/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseTableViewController.h"
#import "QKCLShopInfoModel.h"
#import "QKTextViewTableViewCell.h"
@interface QKCLShopEnterInfoViewController : QKCLBaseTableViewController <QKTextViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet QKGlobalButton *saveButton;
- (IBAction)saveButtonClicked:(id)sender;

//param
@property (strong, nonatomic) QKCLShopInfoModel *shopInfo;
@end
