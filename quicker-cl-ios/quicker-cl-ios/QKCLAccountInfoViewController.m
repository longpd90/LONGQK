//
//  QKAccountInfoViewController.m
//  quicker-cl-ios
//
//  Created by LongPD-PC on 4/21/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLAccountInfoViewController.h"
#import "QKCLChangePassViewController.h"
#import "QKCLChangeMailViewController.h"
#import "QKCLProfileDetailModel.h"
#import "QKTableViewCell.h"
#import "QKImageView.h"
#import "QKCLEditAccountInfoViewController.h"
@interface QKCLAccountInfoViewController ()<CCAlertViewDelegate>

@property (strong, nonatomic) QKCLProfileDetailModel *profileDetail;
@property (weak, nonatomic) IBOutlet UITableView *accountTableView;
@property (weak, nonatomic) IBOutlet QKImageView *avatarImageView;
@property (strong,nonatomic) CCAlertView *passWordAlertView;
@property (strong,nonatomic) NSString *thisPassWord;
@end

@implementation QKCLAccountInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //custom back button
    [self setAngleLeftBarButton];
    [self setRightBarButtonWithTitle:NSLocalizedString(@"編集", nil) target:@selector(editAccountInfo)];
    //set title for page
    [self setTitle:@"アカウント 情報"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //get account info
    [self getAccountInfo];
}

- (void)getAccountInfo {
    if (self.connected) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [[QKCLRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkUrlProfileDetail] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                self.profileDetail  = [[QKCLProfileDetailModel alloc] initWithResponse:responseObject];
                [self reloadData];
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Get account in fo fail...");
        }];
    }
    else {
        [self showNoInternetViewWithSelector:@selector(getAccountInfo)];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)reloadData {
    [self.avatarImageView setImageWithQKURL:self.profileDetail.imgPath placeholderImage:[UIImage imageNamed:@"account_pic_blankprofile"] withCache:NO];
    [self.accountTableView reloadData];
}

#pragma mark - Table delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return kCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *AccountInfoCellIdentifier = @"QKAccountInfoCell";
    QKTableViewCell *cell =  (QKTableViewCell *)[tableView dequeueReusableCellWithIdentifier:AccountInfoCellIdentifier];
    if (!cell) {
        cell = [[QKTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier :AccountInfoCellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    cell.accessoryView = nil;
    switch (indexPath.row) {
        case kFirstNames: {
            cell.textLabel.text = self.profileDetail.lastName;
            break;
        }
            
        case kLastNames:
            cell.textLabel.text = self.profileDetail.firstName;
            break;
            
        case kFirstNameKanas:
            cell.textLabel.text = self.profileDetail.lastNameKana;
            break;
            
        case kLastNameKanas:
            cell.textLabel.text = self.profileDetail.firstNameKana;
            break;
            
        case kMails:
            cell.textLabel.text = self.profileDetail.email;
            break;
    }
    return cell;
}

- (void)editAccountInfo {
    _passWordAlertView  = [[CCAlertView alloc]initWithTitle:@"パスワードの確認" message:@"アカウントの削除にはパスワードが必要です" delegate:self buttonTitles:@[@"キャンセル",@"OK"] haveTextField:YES];
    [_passWordAlertView showAlert];
    
}
- (void)callApiTocheckPass {
    
    if ([self connected]) {
        
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:[QKCLEncryptUtil encyptBlowfish:_thisPassWord] forKey:@"password"];
        
        [[QKCLRequestManager sharedManager] asyncPOST:[NSString stringFromConst:qkUrlClAccountPasswordReauth] parameters:params showLoading:YES showError:NO success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE
                                ] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
		              
                [self performSegueWithIdentifier:@"QKEditAccountInfoSegue" sender:self];
            }else{
                _passWordAlertView  = [[CCAlertView alloc]initWithTitle:@"パスワードが一致しません" message:@"再度入力をしてください" delegate:self buttonTitles:@[@"キャンセル",@"OK"] haveTextField:YES];
                [_passWordAlertView showAlert];
                
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"fail...%@",error);
        }];
    }else{
        [self showNoInternetViewWithSelector:@selector(callApiTocheckPass)];
    }
}
#pragma mark CCAlertViewDelegate

- (void)alertView:(CCAlertView *)alertView selectedButtonIndex:(NSInteger)index {
    if (alertView  == _passWordAlertView) {
        if (index == 1) {
            _thisPassWord = _passWordAlertView.textField.text;
            [self callApiTocheckPass];
        }
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"QKEditAccountInfoSegue"]) {
        QKCLEditAccountInfoViewController *vc = (QKCLEditAccountInfoViewController*)segue.destinationViewController;
        vc.thisPassWord = _thisPassWord;
    }
}




@end
