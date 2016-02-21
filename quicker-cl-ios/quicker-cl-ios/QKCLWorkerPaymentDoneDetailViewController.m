//
//  QKCLWorkerPaymentDoneDetailViewController.m
//  quicker-cl-ios
//
//  Created by Quy on 8/17/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLWorkerPaymentDoneDetailViewController.h"
#import "QKClWorkerRecommenTableviewCell.h"
#import "QKCLApplicantTableViewCell.h"
#import "QKClWorkerReasonTableViewCell.h"
#import "QKCLApplicantDetailViewController.h"
@interface QKCLWorkerPaymentDoneDetailViewController () <UITableViewDataSource, UITableViewDataSource, CCAlertViewDelegate>
@property (nonatomic, strong) NSMutableArray *reasonArray;
@property (nonatomic, strong) NSString *status;


@property (nonatomic) NSInteger selectedRow;
@property (nonatomic) BOOL isCommment;
@property (nonatomic, strong) NSString *commentReason;
@property (nonatomic, strong) CCAlertView *ratingAlertView;
@property (nonatomic, strong) CCAlertView *confirmRatingAlertView;
@property (nonatomic, strong) CCAlertView *successAlertView;
@end
static NSString *recommenCell = @"QKClWorkerRecommenTableviewCell";

static NSString *workerCell = @"QKCLApplicantTableViewCell";
static NSString *reasonCell = @"QKClWorkerReasonTableViewCell";
@implementation QKCLWorkerPaymentDoneDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"給与支払い"];
    [self.thisTableView registerNib:[UINib nibWithNibName:workerCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:workerCell];
    
    [self.thisTableView registerNib:[UINib nibWithNibName:recommenCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:recommenCell];
    [self.thisTableView registerNib:[UINib nibWithNibName:reasonCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reasonCell];
    self.reasonArray = [[NSMutableArray alloc]initWithObjects:@"良かった", @"特に問題がなかった", @"問題があった", nil];
    
    self.navigationItem.hidesBackButton=YES;
    _selectedRow =-1;
    [self.thisTableView setBackgroundColor:[UIColor clearColor]];
    
    [self.accepteRatingOutlet setEnabled:NO];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 2;
            
        case 1:
            return 3;
            
        default: return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 90.0f;
    }else{
        if(indexPath.row == 2){
            CGFloat height = self.isCommment ? 68.0f : 44.0f;
            return height;
        }
        return 44.0f;
    }
   
    
        
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    switch (indexPath.section) {
        case 0: {
            switch (indexPath.row) {
                case 0: {
                    QKCLApplicantTableViewCell *cells = (QKCLApplicantTableViewCell *)[tableView dequeueReusableCellWithIdentifier:workerCell];
                    cells.workerName.text = _userPassModel.adoptUserInfo.adoptionUserName;
                    if (_userPassModel.adoptUserInfo.adoptionUserImagePath != nil) {
                        [cells.avartarImageView setImageWithQKURL:_userPassModel.adoptUserInfo.adoptionUserImagePath withCache:YES];
                    }
                    
                    cells.workerAge.text  = [NSString stringWithFormat:@"(%@歳・女性)", [_userPassModel.adoptUserInfo.adoptionUserBirthday convertToAge]];
                    
                    cell = cells;
                    break;
                }
                    
                case 1: {
                    QKClWorkerRecommenTableviewCell *cells = (QKClWorkerRecommenTableviewCell *)[tableView dequeueReusableCellWithIdentifier:recommenCell];
                    cells.firstLabel.text = @"今回の勤務を評価してください";
                    cells.secondLabel.text = @"(評価によって支給額が変動することはありません)";
                    [cells.secondLabel setFont:[UIFont systemFontOfSize:12.0f]];
                    [cells.secondLabel sizeToFit];
                    cell = cells;
                    break;
                }
                    
                default:
                    break;
            }
            break;
        }
            
        case 1: {
            QKClWorkerReasonTableViewCell *cells = (QKClWorkerReasonTableViewCell *)[tableView dequeueReusableCellWithIdentifier:reasonCell];
            if (cells == nil) {
                cells = [[QKClWorkerReasonTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reasonCell];
            }
            
            if (indexPath.row == self.selectedRow) {
                [cells.iconImageView setImage:[UIImage imageNamed:@"list_pic_active"]];
                
                              if (self.selectedRow == 2) {
                    
                    [cells.reasonTextField setHidden:NO];
                    [cells.reasonTextField addTarget:self action:@selector(editCommentChange:) forControlEvents:UIControlEventEditingChanged];
                    cells.reasonTextField.text = _commentReason;
                }else{
                   
                    [cells.reasonTextField setHidden:YES];
                    _commentReason = @"";
                    
                }
                
                
            }else{
                [cells.iconImageView setImage:[UIImage imageNamed:@"list_pic_inactive"]];
                
            }
            cells.reasonLabel.text = [_reasonArray objectAtIndex:indexPath.row];
            cell = cells;
            break;
        }
            
        default:
            break;
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

#pragma mark textField change
- (void)editCommentChange:(id)sender {
    UITextField *textField = (UITextField *)sender;
    _commentReason = textField.text;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
            [cell setPreservesSuperviewLayoutMargins:NO];
        }
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QKClWorkerReasonTableViewCell *cell = (QKClWorkerReasonTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 1) {
        [cell.iconImageView setImage:[UIImage imageNamed:@"list_pic_active"]];
        [self.accepteRatingOutlet setEnabled:YES];
        self.selectedRow  = indexPath.row;
       
        
        switch (indexPath.row) {
            case 0: {
                _status = [NSString stringFromConst:QK_CL_RATING_WORKER_STATUS_GOOD];
                _isCommment = NO;
            
                break;
            }
                
            case 1: {
                _status = [NSString stringFromConst:QK_CL_RATING_WORKER_STATUS_NORMAL];
                _isCommment = NO;
                break;
            }
                
            case 2: {
                
                
                _status = [NSString stringFromConst:QK_CL_RATING_WORKER_STATUS_BAD];
                _isCommment = YES;
                
                break;
            }
                
            default:
                break;
        }
        [self.thisTableView reloadSections: [NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        
    }
}

#pragma mark  - confirm Rating
- (void)callApiToConFirmRating {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getActiveShopId] forKey:@"shopId"];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:[QKCLEncryptUtil encyptBlowfish:_userPassModel.adoptUserInfo.adoptionUserId] forKey:@"customerUserId"];
        
        [[QKCLRequestManager sharedManager] asyncPOST:[NSString stringFromConst:qkCLUrlConFirmRatingWorker] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                _confirmRatingAlertView = [[CCAlertView alloc] initWithImage:[UIImage imageNamed:@"list_ic_rightfav"] title:@"お気に入りに追加しました" andMessage:@"お気に入りに追加した勤務者は\n「マイページ」から確認できます" style:QKAlertViewStyleWhite];
                [_confirmRatingAlertView showAlert];
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"fail...%@", error);
        }];
    }
    else {
        [self showNoInternetViewWithSelector:nil];
    }
}

#pragma  mark - Action call rec-00012 back to QKCLWorkerViewcontroller
- (void)moveToWorker {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - CCAlertViewDelegate
- (void)alertView:(CCAlertView *)alertView selectedButtonIndex:(NSInteger)index {
    if (alertView == _ratingAlertView) {
        if (index == 1) {
            [self callApiToConFirmRating];
        }
    }
    if (alertView == _successAlertView) {
        if (index == 0) {
            [self moveToWorker];
        }
    }
}

- (void)clickOnAlertView:(CCAlertView *)alertView {
    if (alertView == _confirmRatingAlertView) {
        _successAlertView = [[CCAlertView alloc]initWithImage:[UIImage imageNamed:@"dialog_pic_done"] title:@"給与の支払いが完了しました" message:@"給与は勤務者の確認のあと\n異議申し立てが無ければ\n自動的に振り込まれます" delegate:self buttonTitles:@[@"OK"]];
        [_successAlertView showAlert];
        
    }
}

- (IBAction)ratingButtonClicked:(id)sender {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:_recruitmentId forKey:@"recruitmentId"];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:[QKCLEncryptUtil encyptBlowfish:_userPassModel.adoptUserInfo.adoptionUserId] forKey:@"customerUserId"];
        [params setObject:_status forKey:@"ratingItemCd"];
        if (![_commentReason isEqualToString:@""] && _commentReason != nil) {
            [params setObject:_commentReason forKey:@"ratingComment"];
        }
        
        [[QKCLRequestManager sharedManager] asyncPOST:[NSString stringFromConst:qkCLUrlRatingWorker] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                if ([_status isEqualToString:[NSString stringFromConst:QK_CL_RATING_WORKER_STATUS_GOOD]]) {
                    _ratingAlertView = [[CCAlertView alloc]initWithImage:[UIImage imageNamed:@"list_ic_rightfav"] title:nil message:@"この勤務者を\nお気に入りに追加しますか？" delegate:self buttonTitles:@[@"しない", @"追加する"]];
                    [_ratingAlertView showAlert];
                }
                else {
                    [self moveToWorker];
                }
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"fail...%@", error);
        }];
    }
    else {
        [self showNoInternetViewWithSelector:nil];
    }
}



@end
