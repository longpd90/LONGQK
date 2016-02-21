//
//  QKCSPastRecuitmentViewController.h
//  quicker-cs-ios
//
//  Created by C Anh on 8/19/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSBaseViewController.h"
#import "QKShopInfoModel.h"
#import "QKRecruitmentModel.h"
@interface QKCSPastRecuitmentViewController : QKCSBaseViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) QKShopInfoModel *shopModel;

@property (strong, nonatomic) QKRecruitmentModel *recruitmentModel;
@end
