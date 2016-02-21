//
//  QKEditRecruitmentQuestionDetailAnsweredViewController.h
//  quicker-cl-ios
//
//  Created by Quy on 7/22/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseTableViewController.h"

@interface QKCLRecruitmentQuestionAnsweredEditViewController : QKCLBaseTableViewController
@property (weak, nonatomic) IBOutlet UITableView *thisTableView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
- (IBAction)deleteQuestion:(id)sender;
@property (strong,nonatomic) NSString *qaId;
@end
