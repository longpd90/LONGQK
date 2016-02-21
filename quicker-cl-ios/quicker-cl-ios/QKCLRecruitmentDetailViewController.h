//
//  QKConfirmationNewRecruitmentViewController.h
//  quicker-cl-ios
//
//  Created by Nguyen Viet Thang on 5/20/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseTableViewController.h"
#import <MapKit/MapKit.h>
#import "QKF11Label.h"
#import "QKCLRecruitmentModel.h"
#import "QKGlobal2TileButton.h"
#import "QKCLLocalNotificationManager.h"

@interface QKCLRecruitmentDetailViewController : QKCLBaseTableViewController <UIScrollViewDelegate, UITableViewDelegate,
UITableViewDataSource, UIActionSheetDelegate, CCAlertViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topContraint;
@property (weak, nonatomic) IBOutlet UIView *doneWorkerTopView;
@property (weak, nonatomic) IBOutlet UIView *doneRecruimentView;
@property (assign, nonatomic) BOOL isDetailViewController;
@property (strong, nonatomic) NSMutableArray *preConditionArrays;
@property (strong, nonatomic) NSString *applicationQualification;
@property (strong, nonatomic) NSString *baggageAndClothes;
@property (strong, nonatomic) NSString *transportationExpenses;
@property (strong, nonatomic) NSString *des;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (weak, nonatomic) IBOutlet QKF20Label *shopNameLabel;
@property (weak, nonatomic) IBOutlet QKF11Label *jobCategoryNameLabel;
@property (weak, nonatomic) IBOutlet QKF21Label *workStartDateLabel;
@property (weak, nonatomic) IBOutlet QKF11Label *workHourLabel;
@property (weak, nonatomic) IBOutlet QKF40Label *restTimeLabel;
@property (weak, nonatomic) IBOutlet QKF11Label *salaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *transporationExpenses;
@property (weak, nonatomic) IBOutlet UILabel *salaryPerUnitLabel;

@property (weak, nonatomic) IBOutlet UIView *preferenceConditionsView;

@property (weak, nonatomic) IBOutlet QKF20Label *employmentNumLabel;
@property (weak, nonatomic) IBOutlet QKF20Label *baggageAndClothesLabel;

@property (weak, nonatomic) IBOutlet UIImageView *mapsImageView;
@property (weak, nonatomic) IBOutlet QKF10Label *shopAddress;
@property (weak, nonatomic) IBOutlet QKF10Label *waySide1Label;
@property (weak, nonatomic) IBOutlet QKF10Label *waySide2Label;
@property (weak, nonatomic) IBOutlet QKF10Label *waySide3Label;
@property (weak, nonatomic) IBOutlet UILabel *accessWay;
@property (strong, nonatomic) QKCLRecruitmentModel *recruitmentModel;

- (IBAction)startJobOfferButtonClick:(id)sender;
- (IBAction)viewMapButtonClick:(id)sender;
@property (weak, nonatomic) IBOutlet QKGlobalButton *startJobButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


- (void)loadRecruimentDetail;
@end
