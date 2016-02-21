//
//  QKCLSelectMasterCityTableViewController.h
//  quicker-cl-ios
//
//  Created by VietND on 7/31/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseTableViewController.h"
#import "QKCLMasterCityModel.h"
#import "QKCLConst.h"

@protocol QKCLSelectMasterCityDelegate <NSObject>
- (void)citySelected:(QKCLMasterCityModel *)selectedCity;
@end
@interface QKCLSelectMasterCityTableViewController : QKCLBaseTableViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) QKCLMasterCityModel *currentCityModel;

@property (strong, nonatomic) id <QKCLSelectMasterCityDelegate> delegate;
@end
