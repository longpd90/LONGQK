//
//  QKSlideMenuViewController.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 5/21/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseViewController.h"
#import "QKCLShopInfoModel.h"
@interface QKCLSlideMenuViewController : QKCLBaseViewController <UITableViewDelegate>
@property (strong, nonatomic) QKCLShopInfoModel *deleteShopModel;
@property (weak, nonatomic) IBOutlet UITableView *menuTableView;
@property (strong, nonatomic) NSMutableArray *listShops;
@property (strong, nonatomic) NSObject *shop;
- (void)reloadDatas;
@end
