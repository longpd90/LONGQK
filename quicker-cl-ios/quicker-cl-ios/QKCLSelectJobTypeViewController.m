//
//  QKSelectJobTypeViewController.m
//  quicker-cl-ios
//
//  Created by Vietnd on 6/13/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLSelectJobTypeViewController.h"
#import "QKTableViewCell.h"
#import "QKCLConst.h"
#import "QKCLShopInfoModel.h"

@interface QKCLSelectJobTypeViewController ()
@property (nonatomic)   NSInteger selectedCurveIndex;
@property (strong, nonatomic) NSMutableArray *jobTypeArrays;
@end

@implementation QKCLSelectJobTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //custom back on navigation
    [self setAngleLeftBarButton];
    
    //get data for job type
    _jobTypeArrays = [[NSMutableArray alloc]init];
    [self getJobTypeMasterS];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma Get JobType Data From Server
- (void)getJobTypeMasterS {
    if (!([self checkJobTypeL] || [self checkJobTypeM])) {
        [self getJobTypeMasterLM];
    }
    if ([self connected]) {
        NSDictionary *response;
        NSError *error;
        NSString *url = @"";
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKey];
        
        switch (_jobType) {
            case QKJobTypeL:
                url = [NSString stringFromConst:qkUrlMasterJobTypeL];
                break;
                
            case QKJobTypeM:
                
                [params setObject:[QKCLAccessUserDefaults getJobTypeLCd] forKey:@"jobTypeLCd"];
                url = [NSString stringFromConst:qkUrlMasterJobTypeM];
                break;
                
            case QKJobTypeS:
                
                [params setObject:[QKCLAccessUserDefaults getJobTypeLCd] forKey:@"jobTypeLCd"];
                [params setObject:[QKCLAccessUserDefaults getJobTypeMCd] forKey:@"jobTypeMCd"];
                
                url = [NSString stringFromConst:qkUrlMasterJobTypeS];
                
                break;
                
            default:
                break;
        }
        if (![url isEqualToString:@""]) {
            BOOL result =  [[QKCLRequestManager sharedManager] syncGET:url parameters:params response:&response error:&error showLoading:YES showError:YES];
            
            if (result) {
                switch (_jobType) {
                    case QKJobTypeL: {
                        for (NSDictionary *data in response[@"jobTypeLMaster"]) {
                            QKCLMasterJobTypeModel *model = [[QKCLMasterJobTypeModel alloc]initWithRespone:data type:QKJobTypeL];
                            [_jobTypeArrays addObject:model];
                        }
                        break;
                    }
                        
                    case QKJobTypeM: {
                        for (NSDictionary *data in response[@"jobTypeMMaster"]) {
                            QKCLMasterJobTypeModel *model = [[QKCLMasterJobTypeModel alloc]initWithRespone:data type:QKJobTypeM];
                            [_jobTypeArrays addObject:model];
                        }
                        break;
                    }
                        
                    case QKJobTypeS: {
                        for (NSDictionary *data in response[@"jobTypeSMaster"]) {
                            QKCLMasterJobTypeModel *model = [[QKCLMasterJobTypeModel alloc]initWithRespone:data type:QKJobTypeS];
                            [_jobTypeArrays addObject:model];
                        }
                        break;
                    }
                        
                    default:
                        break;
                }
                [self.tableView reloadData];
            }
        }
    }
    else {
        [self showNoInternetViewWithSelector:@selector(getJobTypeMasterS)];
    }
}

- (void)getJobTypeMasterLM {
    if (!([self checkJobTypeL] || [self checkJobTypeM])) {
        if ([self connected]) {
            NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
            [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
            [params setObject:[QKCLAccessUserDefaults getActiveShopId] forKey:@"shopId"];
            NSDictionary *response;
            NSError *error;
            BOOL result = [[QKCLRequestManager sharedManager] syncGET:[NSString stringFromConst:qkUrlShopDetail] parameters:params response:&response error:&error showLoading:YES showError:YES];
            if (result) {
                QKCLShopInfoModel *shopInfo = [[QKCLShopInfoModel alloc] initWithResponse:response];
                [QKCLAccessUserDefaults setJobTypeLCd:shopInfo.jobTypeLCd];
                [QKCLAccessUserDefaults setJobTypeMCd:shopInfo.jobTypeMCd];
            }
        }
        else {
            [self showNoInternetViewWithSelector:@selector(getJobTypeMasterLM)];
        }
    }
}

- (BOOL)checkJobTypeM {
    if ([[QKCLAccessUserDefaults getJobTypeMCd] isEqualToString:@""]) {
        return NO;
    }
    return YES;
}

- (BOOL)checkJobTypeL {
    if ([[QKCLAccessUserDefaults getJobTypeLCd] isEqualToString:@""]) {
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_jobTypeArrays count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QKTableViewCell *cell = (QKTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CellRow"];
    if (cell == nil) {
        cell = [[QKTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellRow"];
    }
    QKCLMasterJobTypeModel *model = [_jobTypeArrays objectAtIndex:indexPath.row];
    cell.textLabel.text = model.jobTypeName;
    
    //check current selected jobtype
    switch (_jobType) {
        case QKJobTypeL:
            if ([_currentJobType.jobTypeLCd isEqualToString:model.jobTypeLCd]) {
                cell.accessoryView = [UIView QKTableViewCellAccessoryCheckmark];
                _selectedCurveIndex = indexPath.row;
            }
            break;
            
        case QKJobTypeM:
            if ([_currentJobType.jobTypeMCd isEqualToString:model.jobTypeMCd]) {
                cell.accessoryView = [UIView QKTableViewCellAccessoryCheckmark];
                _selectedCurveIndex = indexPath.row;
            }
            break;
            
        case QKJobTypeS:
            if ([_currentJobType.jobTypeSCd isEqualToString:model.jobTypeSCd]) {
                cell.accessoryView = [UIView QKTableViewCellAccessoryCheckmark];
                _selectedCurveIndex = indexPath.row;
            }
            else {
                cell.accessoryView = nil;
            }
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryView = [UIView QKTableViewCellAccessoryCheckmark];
        self.currentJobType = [_jobTypeArrays objectAtIndex:indexPath.row];
        
        if (_selectedCurveIndex != indexPath.row) {
            NSIndexPath *oldPath = [NSIndexPath indexPathForRow:_selectedCurveIndex inSection:indexPath.section];
            cell = [_tableView cellForRowAtIndexPath:oldPath];
            cell.accessoryView = nil;
            _selectedCurveIndex = indexPath.row;
        }
    }
    [self performSelector:@selector(goBack:) withObject:nil afterDelay:0.5];
}

- (void)goBack:(id)sender {
    [super goBack:sender];
    if ([self.delegate respondsToSelector:@selector(jobTypeSelected:)]) {
        [self.delegate jobTypeSelected:self.currentJobType];
    }
}

@end
