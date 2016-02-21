//
//  QKRecruitmentQuestionDetailViewController.h
//  quicker-cl-ios
//
//  Created by Quy on 7/21/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseTableViewController.h"

@interface QKCLRecruitmentQuestionUnansweredViewController : QKCLBaseTableViewController
@property (weak, nonatomic) IBOutlet UITableView *thisTableView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) NSString *qaId;
- (IBAction)answerButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet QKGlobalButton *answeredButtonOutlet;

@end
