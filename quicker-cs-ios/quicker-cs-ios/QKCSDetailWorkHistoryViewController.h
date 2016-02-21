//
//  QKCSDetailWorkHistoryViewController.h
//  quicker-cs-ios
//
//  Created by C Anh on 8/17/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSBaseViewController.h"
#import "QKRecruitmentModel.h"

@interface QKCSDetailWorkHistoryViewController : QKCSBaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) BOOL isFavoriteJob;
@property (strong, nonatomic) QKRecruitmentModel *recruitmentModel;
@end
