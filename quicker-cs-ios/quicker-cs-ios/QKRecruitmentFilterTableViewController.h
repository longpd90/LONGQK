//
//  QKRecruitmentFilterTableViewController.h
//  quicker-cs-ios
//
//  Created by Quy on 5/21/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import "QKCSTableViewController.h"
#import "QKRecruitmentFilterModel.h"

@interface QKRecruitmentFilterTableViewController : QKCSTableViewController
@property (weak, nonatomic) IBOutlet QkF59Label *errorLabel;

@property (nonatomic) QKRecruitmentFilterModel *filter;


- (IBAction)updateFilterButtonClicked:(id)sender;

@end
