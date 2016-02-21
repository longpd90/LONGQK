//
//  QKRecruitmentQuestionDetailAnsweredViewController.h
//  quicker-cl-ios
//
//  Created by Quy on 7/22/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseTableViewController.h"

@interface QKCLRecruitmentQuestionAnsweredShowViewController : QKCLBaseTableViewController
@property (weak, nonatomic) IBOutlet UITableView *thisTableView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (strong ,nonatomic) NSString *qaId;
@end
