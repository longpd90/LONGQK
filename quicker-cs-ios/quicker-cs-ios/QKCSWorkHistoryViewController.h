//
//  QKCSWorkHistoryViewController.h
//  quicker-cs-ios
//
//  Created by C Anh on 8/13/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSBaseViewController.h"
#import "QKGlobalDatePickerView.h"
#import "QKGlobalPickerView.h"
#import "QKSelectPreferenceConditionTableViewController.h"

@interface QKCSWorkHistoryViewController : QKCSBaseViewController <UITableViewDataSource, UITableViewDelegate , QKGlobalPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *nothingView;

@end
