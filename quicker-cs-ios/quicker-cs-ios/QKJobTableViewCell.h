//
//  QKJobTableViewCell.h
//  quicker-cs-ios
//
//  Created by LongPD-PC on 5/11/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKRecruitmentModel.h"
#import "UIImageView+AFNetworking.h"
#import "QKCSImageView.h"
#import "QKF41Label.h"
#import "QKF1Label.h"
#import "QKF55Label.h"
#import "QKF21Label.h"
#import "QKF45Label.h"
#import "QKClockCountDownView.h"

@interface QKJobTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *backgroundCellView;
@property (weak, nonatomic) IBOutlet UIView *dimView;
@property (weak, nonatomic) IBOutlet QKCSImageView *shopImageView;
@property (weak, nonatomic) IBOutlet UIView *coutDownView;
@property (weak, nonatomic) IBOutlet QKF41Label *countDownLabel;
@property (weak, nonatomic) IBOutlet QKF41Label *recNameLabel;
@property (weak, nonatomic) IBOutlet QKF1Label *recCategoryNameLabel;
@property (weak, nonatomic) IBOutlet QKF55Label *workStartDtLabel;
@property (weak, nonatomic) IBOutlet QKF21Label *workTimeLabel;
@property (weak, nonatomic) IBOutlet QKF55Label *salaryUnitLabel;
@property (weak, nonatomic) IBOutlet QKF21Label *salaryPerUnitLabel;
@property (weak, nonatomic) IBOutlet QKCSImageView *personInChargeImageView;
@property (weak, nonatomic) IBOutlet QKF45Label *accessWayLabel;
@property (weak, nonatomic) IBOutlet UIView *preConditionsView;
@property (weak, nonatomic) IBOutlet QKClockCountDownView *clockView;
@property (weak, nonatomic) IBOutlet UIImageView *condition1ImageView;

@property (weak, nonatomic) IBOutlet UIImageView *condition2ImageView;
//param
@property (strong, nonatomic) QKRecruitmentModel *recruitmentEntity;

@end
