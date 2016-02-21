//
//  QKApplicantViewController.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 7/22/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseTableViewController.h"
#import "QKCLAdoptionUserModel.h"
#import "QKCLRecruitmentModel.h"
typedef enum QKApplicantDetailMode : NSInteger {
    QKApplicantDetailModeFullInfo = 0,//J-1-1,J-1-2
    QKApplicantDetailModeReview, //K-6-1,K-6-2
    QKApplicantDetailModeBeforeWorking, //K-1-1
    QKApplicantDetailModeWorkActualStatusInputBefore, //K-1-2
    QKApplicantDetailModeWorkActualStatusInputAlready, //K-1-3
    QKApplicantDetailModeWorkActualStatusPending, //K-1-4
    QKApplicantDetailModeWorkActualStatusApproval, //K-1-5
    QKApplicantDetailModeNonEmployment, //K-1-6
} QKApplicantDetailMode;


@interface QKCLApplicantDetailViewController : QKCLBaseTableViewController

@property (strong, nonatomic) NSString *customerUserId;
@property (strong, nonatomic) QKCLRecruitmentModel *recruitmentModel;
@property (strong, nonatomic) QKCLAdoptionUserModel *userInfoModel;

@property (strong, nonatomic) NSArray *freeQAList;
@property (nonatomic) QKApplicantDetailMode mode;//check mode to display screen

@end
