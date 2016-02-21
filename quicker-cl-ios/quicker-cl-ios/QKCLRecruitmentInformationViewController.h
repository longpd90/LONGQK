//
//  QKRecruitmentInformationViewController.h
//  quicker-cl-ios
//
//  Created by Quy on 7/3/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseViewController.h"
#import "QKCLRecruitmentModel.h"

@interface QKCLRecruitmentInformationViewController : QKCLBaseViewController
@property (weak, nonatomic) IBOutlet UIView *leftStatusView;
@property (weak, nonatomic) IBOutlet UIView *mainStatusView;
@property (weak, nonatomic) IBOutlet UIView *rightStatusView;
@property (weak, nonatomic) IBOutlet UIView *mainStatusView1;
@property (weak, nonatomic) IBOutlet UIView *rightStatusView1;
@property (weak, nonatomic) IBOutlet UIView *topView1;
- (IBAction)leftButtonClicked:(id)sender;
- (IBAction)mainButtonClicked:(id)sender;
- (IBAction)rightButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *rightContainer;
@property (weak, nonatomic) IBOutlet UIView *mainContaiter;

@property (weak, nonatomic) IBOutlet UIView *leftContainer;
@property (strong, nonatomic) NSString *recruitmentId;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *mainButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UIButton *mainButton1;
@property (weak, nonatomic) IBOutlet UIButton *rightButton1;

@property (strong, nonatomic) QKCLRecruitmentModel *recruitmentModel;
- (void)showRightContainer;
@end
