//
//  QKSubcribedViewController.h
//  quicker-cs-ios
//
//  Created by LongPD-PC on 5/7/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSBaseViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface QKSubcribedViewController : QKCSBaseViewController
@property (weak, nonatomic) IBOutlet UITableView *subcribedTableView;
@property (weak, nonatomic) IBOutlet UIView *headerTableView;
@property (weak, nonatomic) IBOutlet QKGlobalSecondaryButton *findJobButton;
- (IBAction)findJobButtonClicked:(id)sender;

@property (nonatomic, readonly) NSDate *startDate, *endDate;
@property (nonatomic, strong) NSDate *selectedDate;
@property (nonatomic, strong) UIImage *selectedDateBackgroundImage;
@property (nonatomic, strong) NSMutableArray *dayHaveRecruitments;
@property (nonatomic, assign) BOOL selectedDateBackgroundExtendsToTop;
@property (nonatomic, strong) NSMutableArray *appliedRecruitments;
@property (nonatomic, strong) NSMutableDictionary *dictionaryStartDate;
- (IBAction)gotoJobhistory:(id)sender;

@end
