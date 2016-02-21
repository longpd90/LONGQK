//
//  QKJobQuestionViewController.h
//  quicker-cs-ios
//
//  Created by LongPD-PC on 6/9/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSBaseViewController.h"

@interface QKRecruitmentQuestionNewViewController : QKCSBaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *thisTableView;
- (IBAction)termOfUseClicked:(id)sender;
- (IBAction)policyClicked:(id)sender;
@property (strong ,nonatomic)NSString *recruimentId;
- (IBAction)updateQuestionButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet QKGlobalSecondaryButton *updateButtonOutlet;
@property (weak, nonatomic) IBOutlet UIView *thisView;


@end
