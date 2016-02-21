//
//  QKRecruitmentPassListViewController.m
//  quicker-cl-ios
//
//  Created by Quy on 7/14/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLRecruitmentPassListViewController.h"
#import "QKF20Label.h"
#import "QKRecruitmentPassListTableViewCell.h"
#import "QKCLRecruitmentModel.h"
#import "QKCLRecruitmentNewStep1ViewController.h"
#import "QKCLMasterPreferenceConditionModel.h"
@interface QKCLRecruitmentPassListViewController ()
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;
@end

@implementation QKCLRecruitmentPassListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"新規募集"];
    [self setLeftBarButtonWithTitle:@"キャンセル" target:@selector(goBack:)];
    
    // Do any additional setup after loading the view.
}

#pragma mark UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 2;
            
        case 1:
            return [_recruitmentArrays count];
            
        default: return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    cell = [tableView dequeueReusableCellWithIdentifier:@"HeaderCell"];
                    break;
                    
                case 1:
                    cell = [tableView dequeueReusableCellWithIdentifier:@"SecondCell"];
                    break;
                    
                default:
                    break;
            }
            
            break;
            
        case 1: {
            QKRecruitmentPassListTableViewCell *cells = (QKRecruitmentPassListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"JobRercuitmentCell"];
            if (cells == nil) {
                cells = (QKRecruitmentPassListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"JobRercuitmentCell"];
            }
            QKCLRecruitmentModel *model = [_recruitmentArrays objectAtIndex:indexPath.row];
            cells.jobttypeSName.text = model.jobTypeSName;
            cells.jobDescription.text = model.descriptions;
            NSDate *date = model.endDt;
            
            cells.endDate.text = [date longDateString];
            NSLog(@"%@", date);
            cell = cells;
            
            break;
        }
            
        default:
            break;
    }
    if (cell == nil) {
        cell = [UITableViewCell new];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 0.01f;
            
        case 1:
            return 44.0f;
            
        default: return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    return 121.0f;
                    
                case 1:
                    return 44.0f;
                    
                default: return 0;
            }
            
        case 1: {
            QKRecruitmentPassListTableViewCell *cells = (QKRecruitmentPassListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"JobRercuitmentCell"];
            if (cells == nil) {
                cells = (QKRecruitmentPassListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"JobRercuitmentCell"];
            }
            QKCLRecruitmentModel *model = [_recruitmentArrays objectAtIndex:indexPath.row];
            cells.jobttypeSName.text = model.jobTypeSName;
            cells.jobDescription.text = model.descriptions;
            NSDate *date = model.endDt;
            
            cells.endDate.text = [date longDateString];
            return [self calculateHeightForConfiguredSizingCell:cells inTableView:tableView];
        }
            
            
        default: return 0;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return nil;
            
        case 1:
            return NSLocalizedString(@"過去の募集から複製", nil);
            
        default: return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedIndexPath = indexPath;
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            [self performSegueWithIdentifier:@"QKNewRecruitmentSegue" sender:self];
        }
        else {
            return;
        }
    }
    else if (indexPath.section == 1) {
        [self performSegueWithIdentifier:@"QKNewRecruitmentSegue" sender:self];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"QKNewRecruitmentSegue"]) {
        switch (_selectedIndexPath.section) {
            case 0:
                //nothing
                break;
                
            case 1:
            {
                QKCLRecruitmentNewStep1ViewController *vc = (QKCLRecruitmentNewStep1ViewController *)segue.destinationViewController;
                
                QKCLRecruitmentModel *model = [_recruitmentArrays objectAtIndex:_selectedIndexPath.row];
                
                vc.recuitmentModel = [[QKCLRecruitmentModel alloc]init];
                
                vc.recuitmentModel.jobTypeSCd = model.jobTypeSCd;
                vc.recuitmentModel.jobTypeSName = model.jobTypeSName;
                
                vc.recuitmentModel.transportationExpenses =  model.transportationExpenses;
                vc.recuitmentModel.applicantQualification = model.applicantQualification;
                vc.recuitmentModel.descriptions = model.descriptions;
                vc.recuitmentModel.baggageAndClothes = model.baggageAndClothes;
                
                vc.recuitmentModel.preferenceConditionList = model.preferenceConditionList;
                vc.recuitmentModel.recess = model.recess;
                vc.recuitmentModel.question = model.question;
                
                
                break;
            }
                
            default:
                break;
        }
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

@end
