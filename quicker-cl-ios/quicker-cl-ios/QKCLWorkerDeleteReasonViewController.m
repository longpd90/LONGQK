//
//  QKCLWorkerDeleteReason.m
//  quicker-cl-ios
//
//  Created by Quy on 8/7/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLWorkerDeleteReasonViewController.h"
#import "QKClWorkerReasonTableViewCell.h"
#import "QKClWorkerRecommenTableviewCell.h"
#import "QKCLApplicantTableViewCell.h"
#import "QKTextViewTableViewCell.h"

@interface QKCLWorkerDeleteReasonViewController () <CCAlertViewDelegate, QKTextViewCellDelegate>
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSMutableArray *reasonArray;
@property (strong, nonatomic) CCAlertView *cancelServiceAlertView;
@property (strong, nonatomic) CCAlertView *successAlertView;
@property (strong, nonatomic) NSString *commentTextView;

@property (nonatomic) NSInteger selectedRow;
@end
static NSString *recommenCell = @"QKClWorkerRecommenTableviewCell";

static NSString *workerCell = @"QKCLApplicantTableViewCell";
static NSString *reasonCell = @"QKClWorkerReasonTableViewCell";
static NSString *textViewCell = @"QKTextViewTableViewCell";
@implementation QKCLWorkerDeleteReasonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectedRow =-1;
    
    [self setAngleLeftBarButton];
    [self setTitle:@"勤務の取り消し"];
    [self.thisTableView registerNib:[UINib nibWithNibName:workerCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:workerCell];
    [self.thisTableView registerNib:[UINib nibWithNibName:textViewCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:textViewCell];
    [self.thisTableView registerNib:[UINib nibWithNibName:recommenCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:recommenCell];
    [self.thisTableView registerNib:[UINib nibWithNibName:reasonCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reasonCell];
    _reasonArray = [[NSMutableArray alloc]initWithObjects:@"店舗側の都合", @"勤務者が来なかった", @"その他の理由で取り消す", nil];
   
   
    
    
  
    [self checkEnableButton];
    [self.thisTableView setBackgroundColor:[UIColor clearColor]];
    
    // Do any additional setup after loading the view.
}

#pragma mark - CheckEnableButton

- (void)checkEnableButton {
    if (![_status isEqualToString:@""] && _status != nil && ![_commentTextView isEqualToString:@""] && _commentTextView != nil) {
        [self.cancelServiceOutlet setEnabled:YES];
    }
    else {
        [self.cancelServiceOutlet setEnabled:NO];
    }
}

#pragma mark - UITextViewDelegate
- (void)editingChanged:(id)sender {
    UITextView *textView = (UITextView *)sender;
    _commentTextView = textView.text;
    [self checkEnableButton];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 2;
            
        case 1:
            return 3;
            
        case 2:
            return 1;
            
        default: return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 90.0f;
            
        case 1:
            return 44.0f;
            
        case 2:
            return 209.0f;
            
            
        default:
            return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0: {
                    QKCLApplicantTableViewCell *cells = (QKCLApplicantTableViewCell *)[tableView dequeueReusableCellWithIdentifier:workerCell];
                    cells.workerName.text = _userPassModel.adoptionUserName;
                    if (_userPassModel.adoptionUserImagePath != nil) {
                        [cells.avartarImageView setImageWithQKURL:_userPassModel.adoptionUserImagePath withCache:YES];
                    }
                    
                    cells.workerAge.text  = [NSString stringWithFormat:@"(%@歳・女性)", [_userPassModel.adoptionUserBirthday convertToAge]];
                    
                    cell = cells;
                    break;
                }
                    
                case 1: {
                    QKClWorkerRecommenTableviewCell *cells = (QKClWorkerRecommenTableviewCell *)[tableView dequeueReusableCellWithIdentifier:recommenCell];
                    cells.firstLabel.font = [UIFont boldSystemFontOfSize:17.0f];
                    cells.secondLabel.font = [UIFont boldSystemFontOfSize:17.0f];
                    cell = cells;
                    break;
                }
                    
                default:
                    break;
            }
            break;
            
        case 1: {
            QKClWorkerReasonTableViewCell *cells = (QKClWorkerReasonTableViewCell *)[tableView dequeueReusableCellWithIdentifier:reasonCell];
            if (cells == nil) {
                cells = [[QKClWorkerReasonTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reasonCell];
            }
            if ( indexPath.row == _selectedRow) {
                [cells.iconImageView setImage:[UIImage imageNamed:@"list_pic_active"]];
            }else{
                [cells.iconImageView setImage:[UIImage imageNamed:@"list_pic_inactive"]];
            }

            cells.reasonLabel.text = [_reasonArray objectAtIndex:indexPath.row];
            cell = cells;
            break;
        }
            
        case 2: {
            QKTextViewTableViewCell *cells = (QKTextViewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:textViewCell];
            if (cells == nil) {
                cells = [[QKTextViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:textViewCell];
            }
            cells.max = 200;
            cells.delegate = self;
            [cells.textView setText:self.commentTextView];
            
            cell = cells;
            break;
        }
            
        default:
            break;
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QKClWorkerReasonTableViewCell *cell = (QKClWorkerReasonTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 1) {
        [self checkEnableButton];
        
      
        [cell.iconImageView setImage:[UIImage imageNamed:@"list_pic_active"]];
        self.selectedRow  = indexPath.row;
        switch (indexPath.row) {
            case 0: {
                _status = [NSString stringFromConst:QKCL_APP_DEL_REASON_NOT_WORK];
                break;
            }
                
            case 1: {
                _status = [NSString stringFromConst:QKCL_APP_DEL_REASON_SHOP];
                break;
            }
                
            case 2: {
                _status = [NSString stringFromConst:QKCL_APP_DEL_REASON_ORTHER];
                break;
            }
                
            default:
                break;
        }
        [self.thisTableView reloadSections: [NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        
    }
}

#pragma mark - CCAlertViewDelegate

- (void)alertView:(CCAlertView *)alertView selectedButtonIndex:(NSInteger)index {
    if (alertView == _cancelServiceAlertView) {
        if (index == 1) {
            [self callApiToCancelService];
        }
    }
    if (alertView == _successAlertView) {
        if (index == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)callApiToCancelService {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [params setValue:self.recruitmentId forKey:@"recruitmentId"];
        [params setObject:[QKCLEncryptUtil encyptBlowfish:self.userPassModel.adoptionUserId] forKey:@"customerUserId"];
        
        [params setObject:_status forKey:@"employmentStatus"];
        [params setObject:_commentTextView forKey:@"workCanceledReason"];
        [[QKCLRequestManager sharedManager] asyncPOST:[NSString stringFromConst:qkClUrlWorkerPaymentCancel] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                _successAlertView = [[CCAlertView alloc]initWithImage:[UIImage imageNamed:@"dialog_pic_delete"] title:nil message:@"勤務を取り消しました" delegate:self buttonTitles:@[@"OK"]];
                [_successAlertView showAlert];
            }
        } failure:
         ^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"fail...%@", error);
         }];
    }
    else {
        [self showNoInternetViewWithSelector:nil];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            [cell setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
            [cell setPreservesSuperviewLayoutMargins:NO];
        }
        
        // Explictly set your cell's layout margins
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:UIEdgeInsetsZero];
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


- (IBAction)cancelServiceButtonClicked:(id)sender {
    _cancelServiceAlertView = [[CCAlertView alloc]initWithTitle:@"勤務を取り消しますか？" message:[NSString stringWithFormat:@"%@\n%@", @"勤務を取り消すと給与の支払いいや", @"勤務者と連絡が出来なくなります"] delegate:self buttonTitles:@[@"キャンセル", @"取り消す"]];
    [_cancelServiceAlertView showAlert];
}

@end
