//
//  QKSubcriedTableViewCell.h
//  quicker-cs-ios
//
//  Created by LongPD-PC on 6/9/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKF41Label.h"
#import "QKClockCountDownView.h"
#import "QKF42Label.h"
#import "QKRecruitmentModel.h"
#import "QKF58Label.h"

@protocol QKSubcriedTableViewCellDelegate <NSObject>

- (void)gotoMapWithRecruitment:(QKRecruitmentModel *)recruitment;
- (void)gotoCallWithRecruitment:(QKRecruitmentModel *)recruitment;
- (void)gotoMessengerWithRecruitment:(QKRecruitmentModel *)recruitment;

@end
@interface QKSubcriedTableViewCell : UITableViewCell
@property (assign, nonatomic) id<QKSubcriedTableViewCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIView *callView;
@property (weak, nonatomic) IBOutlet UIView *expandView;
@property (weak, nonatomic) IBOutlet UIView *mapView;
@property (weak, nonatomic) IBOutlet QKF58Label *appliCantStatusLabel;
@property (nonatomic,assign) BOOL isShowExpand;
@property (weak, nonatomic) IBOutlet UIButton *phoneButton;
@property (weak, nonatomic) IBOutlet UIButton *messegeButton;
@property (weak, nonatomic) IBOutlet UIButton *mapButton;
@property (weak, nonatomic) IBOutlet QKF42Label *nameLabel;
@property (weak, nonatomic) IBOutlet QKF42Label *typeLabel;
@property (weak, nonatomic) IBOutlet QKClockCountDownView *clockView;

@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;
@property (weak, nonatomic) IBOutlet QKF41Label *countDownLabel;
@property (weak, nonatomic) IBOutlet UIView *coutDownView;

@property (strong, nonatomic) QKRecruitmentModel *recruitmentAppiled;

- (IBAction)phoneNumberClicked:(id)sender;
- (IBAction)messegeButtonClicked:(id)sender;
- (IBAction)mapButtonClicked:(id)sender;
@end
