//
//  QKRecruitmentInformationViewController.m
//  quicker-cl-ios
//
//  Created by Quy on 7/3/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLRecruitmentInformationViewController.h"
#import "QKCLRecruitmentQuestionListViewController.h"
#import "QKCLRecruitmentDetailViewController.h"
#import "QKCLRecruitmentStatusViewController.h"

@interface QKCLRecruitmentInformationViewController ()
@property (nonatomic) BOOL isEditing;
@property (nonatomic) BOOL isfirst;
@end

@implementation QKCLRecruitmentInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"募集詳細"];
    
    [self setAngleLeftBarButton];
    
    self.recruitmentId = self.recruitmentModel.recruitmentId;
    // [self showRightContainer];
    self.topView1.hidden = [self.recruitmentModel.recruitmentStatus isEqualToString:[NSString stringFromConst:QK_REC_STATUS_DONE_WORKING]];
    if (self.topView1.hidden) {
        [self showleftContainer];
        
    } else {
        [self showMainContainer];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"QKRecruitmentQuestionListSegue"]) {
        QKCLRecruitmentQuestionListViewController *recruitmentListQuestion = (QKCLRecruitmentQuestionListViewController *)segue.destinationViewController;
        recruitmentListQuestion.recruitmentId = self.recruitmentModel.recruitmentId;
    }
    if ([[segue identifier] isEqualToString:@"QKShowRecruitmentStatusViewController"]) {
        QKCLRecruitmentStatusViewController *recruitmentStatusVC = (QKCLRecruitmentStatusViewController *)segue.destinationViewController;
        recruitmentStatusVC.recruitmentId = self.recruitmentModel.recruitmentId;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)leftButtonClicked:(id)sender {
    [self showleftContainer];
}

- (IBAction)mainButtonClicked:(id)sender {
    [self showMainContainer];
}

- (IBAction)rightButtonClicked:(id)sender {
    [self showRightContainer];
}

- (void)showleftContainer {
    [self.leftButton setSelected:YES];
    [self.mainButton setSelected:NO];
    [self.rightButton setSelected:NO];
    
    [self.mainStatusView setHidden:YES];
    [self.rightStatusView setHidden:YES];
    [self.leftStatusView setHidden:NO];
    
    
    [self.mainContaiter setHidden:YES];
    [self.rightContainer setHidden:YES];
    [self.leftContainer setHidden:NO];
    [self.navigationItem setRightBarButtonItem:nil];
}

- (void)showMainContainer {
    [self.mainButton setSelected:YES];
    [self.mainButton1 setSelected:YES];
    [self.rightButton setSelected:NO];
    [self.rightButton1 setSelected:NO];
    [self.leftButton setSelected:NO];
    
    [self.rightStatusView setHidden:YES];
    [self.leftStatusView setHidden:YES];
    [self.mainStatusView setHidden:NO];
    [self.mainStatusView1 setHidden:NO];
    [self.rightStatusView1 setHidden:YES];
    
    [self.mainContaiter setHidden:NO];
    [self.rightContainer setHidden:YES];
    [self.leftContainer setHidden:YES];
    [self.navigationItem setRightBarButtonItem:nil];
    //reload
    for (UIViewController *vc in self.childViewControllers) {
        if ([vc isKindOfClass:[QKCLRecruitmentDetailViewController class]]) {
            QKCLRecruitmentDetailViewController *recDetailVC = (QKCLRecruitmentDetailViewController *)vc;
            recDetailVC.isDetailViewController = YES;
            recDetailVC.recruitmentModel.recruitmentId =_recruitmentId;
            [recDetailVC loadRecruimentDetail];
        }
    }
}

- (void)showRightContainer {
    
    [self.rightButton setSelected:YES];
    [self.rightButton1 setSelected:YES];
    [self.leftButton setSelected:NO];
    [self.mainButton setSelected:NO];
    [self.mainButton1 setSelected:NO];
    
    [self.mainStatusView setHidden:YES];
    [self.mainStatusView1 setHidden:YES];
    [self.leftStatusView setHidden:YES];
    [self.rightStatusView setHidden:NO];
    [self.rightStatusView1 setHidden:NO];
    
    [self.mainContaiter setHidden:YES];
    [self.rightContainer setHidden:NO];
    [self.leftContainer setHidden:YES];
    
    //reload
    for (UIViewController *vc in self.childViewControllers) {
        if ([vc isKindOfClass:[QKCLRecruitmentQuestionListViewController class]]) {
            [self setRightBarButtonWithTitle:@"編集" target:@selector(editQuestionList)];
            QKCLRecruitmentQuestionListViewController *questionListViewController = (QKCLRecruitmentQuestionListViewController *)vc;
            questionListViewController.recruitmentId = _recruitmentModel.recruitmentId;
            [questionListViewController instalization];
        
        }
    }
    
    
    
    //Set rightBarButtonItem
    
}

#pragma mark -Actions
- (void)editQuestionList {
    self.isEditing = !self.isEditing;
    if (self.isEditing) {
        [self.navigationItem.rightBarButtonItem setTitle:@"キャンセル"];
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.hidesBackButton = YES;
    }
    else {
        [self.navigationItem.rightBarButtonItem setTitle:@"編集"];
        [self setAngleLeftBarButton];
    }
    
    for (UIViewController *vc in self.childViewControllers) {
        if ([vc isKindOfClass:[QKCLRecruitmentQuestionListViewController class]]) {
            QKCLRecruitmentQuestionListViewController *questionListViewController = (QKCLRecruitmentQuestionListViewController *)vc;
            [questionListViewController.thisTableView setEditing:self.isEditing];
        }
    }
}

@end
