//
//  QKClWorkerPaymentCalculateSalaryViewController.h
//  quicker-cl-ios
//
//  Created by Quy on 8/10/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseTableViewController.h"
#import "QKCLRecruitmentModel.h"
#import "QKCLAdoptionUserModel.h"
#import "QKCLWorkerTimeTableViewCell.h"
#import "QKCLCustomerSalaryModel.h"
#import "QKCLTableView.h"

@interface QKClWorkerPaymentCalculateSalaryViewController : QKCLBaseTableViewController
@property (nonatomic, strong) QKCLRecruitmentModel *recruitmentModel;
@property (nonatomic, strong) QKCLCustomerSalaryModel *adoptSalaryModel;
@property (weak, nonatomic) IBOutlet QKCLTableView *thisTableView;




@end
