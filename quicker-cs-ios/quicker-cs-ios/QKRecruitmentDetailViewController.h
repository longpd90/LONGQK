//
//  QKRecruitmentDetailViewController.h
//  quicker-cs-ios
//
//  Created by LongPD-PC on 5/12/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSBaseViewController.h"
#import "QKRecruitmentModel.h"
#import "QKScrollImageCell.h"
#import "QKAboutJobTableViewCell.h"
#import "QKJobDescriptionTableViewCell.h"
#import "QKListQACell.h"
#import "QKjobOptionRecordTableViewCell.h"
#import "QKShopDescriptionTableViewCell.h"
#import "QKJobLocationTableViewCell.h"
#import "QKConfirmApplyRecAlertView.h"
#import "QKNotificationItem.h"
#import "NSDate+Extra.h"
#import "QKLocalNotificationManager.h"

typedef enum {
    QKRecruitmentStateActiveNoOffer = 0,
    QKRecruitmentStateDoneNoOffer,
    QKRecruitmentStateActiveOfferDone,
    QKRecruitmentStateDoneOfferDone,
    QKRecruitmentStateOfferDoneNG,
    QKRecruitmentStateOfferDoneOKBefore,
    QKRecruitmentStateOfferDoneOKSalary,
    QKRecruitmentStateOfferDoneOKAfter
} QKRecruitmentState;

typedef  enum qkcsWebViewType:NSInteger {
    qkcsWebViewTypeTermOfService = 0,
    qkcsWebViewTypePolicy
}(qkcsWebViewType);

@interface QKRecruitmentDetailViewController : QKCSBaseViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *applyView;
@property (nonatomic) QKRecruitmentState recruitmentState;
//param
@property (strong, nonatomic) QKRecruitmentModel *recruitment;

@property (nonatomic) BOOL isWorkHistorycontroller;

- (IBAction)recruitmentSelected:(id)sender;

@end
