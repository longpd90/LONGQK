//
//  QKCLSelectMasterPreferenceViewController.h
//  quicker-cl-ios
//
//  Created by VietND on 7/31/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseTableViewController.h"
#import "QKCLMasterPrefectureModel.h"
#import "QKCLConst.h"

@protocol QKCLSelectMasterPrefectureDelegate <NSObject>
- (void)prefectureSelected:(QKCLMasterPrefectureModel *)selectedPrefecture;
@end
@interface QKCLSelectMasterPrefectureTableViewController : QKCLBaseTableViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) QKCLMasterPrefectureModel *currentPrefectureModel;

@property (strong, nonatomic) id <QKCLSelectMasterPrefectureDelegate> delegate;
@end
