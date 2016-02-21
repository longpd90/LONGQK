//
//  QKRegisterShopInfoConfirmViewController.h
//  quicker-cl-ios
//
//  Created by Nguyen Viet Thang on 6/3/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseTableViewController.h"
#import "QKCLShopInfoModel.h"

@interface QKCLConfirmShopInfoViewController : QKCLBaseTableViewController <UITableViewDataSource, UITableViewDelegate, CCAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) QKCLShopInfoModel *shopInfoModel;
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (nonatomic) BOOL isPresented;

- (IBAction)confirmShopClicked:(id)sender;

@end
