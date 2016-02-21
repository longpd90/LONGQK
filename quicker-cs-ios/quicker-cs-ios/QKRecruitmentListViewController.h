//
//  QKSearchJobViewController.h
//  quicker-cs-ios
//
//  Created by LongPD-PC on 5/7/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSBaseViewController.h"
#import "QKRecruitmentFilterTableViewController.h"
#import "QKCalendarHorizontalView.h"
#import "QKRecruitmentFilterModel.h"

@interface QKRecruitmentListViewController : QKCSBaseViewController <QKCalendarHorizontalViewDelegate>
@property (weak, nonatomic) IBOutlet QKF3Label *dateLabel;
@property (strong, nonatomic) IBOutlet UIView *tableHeaderView;
@property (weak, nonatomic) IBOutlet UITableView *jobsTableView;
@property (weak, nonatomic) IBOutlet QKCalendarHorizontalView *calendarView;
@property (strong, nonatomic) NSMutableArray *recruitmentList;



//param
@property (strong, nonatomic) NSString *dateString;
@property (strong, nonatomic) QKRecruitmentFilterModel *filter;

@end
