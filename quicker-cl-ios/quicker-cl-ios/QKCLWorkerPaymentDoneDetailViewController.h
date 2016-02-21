//
//  QKCLWorkerPaymentDoneDetailViewController.h
//  quicker-cl-ios
//
//  Created by Quy on 8/17/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseTableViewController.h"
#import "QKCLAdoptionUserModel.h"
#import "QKCLCustomerSalaryModel.h"
@interface QKCLWorkerPaymentDoneDetailViewController : QKCLBaseTableViewController
@property (weak, nonatomic) IBOutlet UITableView *thisTableView;
@property (nonatomic)QKCLCustomerSalaryModel *userPassModel;
- (IBAction)ratingButtonClicked:(id)sender;
@property (nonatomic)NSString *recruitmentId;
@property (weak, nonatomic) IBOutlet QKGlobalButton *accepteRatingOutlet;


@end
