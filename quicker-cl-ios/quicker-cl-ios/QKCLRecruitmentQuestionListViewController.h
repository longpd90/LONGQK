//
//  QKRecruitmentListQuestionViewController.h
//  quicker-cl-ios
//
//  Created by Quy on 7/6/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseViewController.h"
#import "QKRecruitmentQuestionTableViewCell.h"
@interface QKCLRecruitmentQuestionListViewController : QKCLBaseViewController
@property (weak, nonatomic) IBOutlet UITableView *thisTableView;
@property (weak, nonatomic) IBOutlet UIView *noQuestionView;
@property (strong, nonatomic) NSString *recruitmentId;

- (void)instalization;
@end
