//
//  QKBankTransferMethodViewController.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 5/5/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLPaymentMethodViewController.h"
#import "QKTableViewCell.h"
#import "QKTextViewTableViewCell.h"

@interface QKCLPaymentMethodViewController ()

@end

static NSString *QKTableViewCellidentifier = @"QKTableViewCell";
static NSString *QKTextViewCellidentifier = @"QKTextViewTableViewCell";
@implementation QKCLPaymentMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAngleLeftBarButton];
    self.noteView.textContainerInset = UIEdgeInsetsMake(10.0, 15.0, 10.0, 15.0);
    [self.noteView setFont:[UIFont systemFontOfSize:10.0]];
    [self.noteView setTextColor:[UIColor colorWithHexString:@"#888"]];
    [self.noteView setAlpha:0.9];
    self.noteView.layer.borderColor = [UIColor colorWithHexString:@"#D9DBDA"].CGColor;
    self.noteView.layer.borderWidth = 1.0;
    [self.noteView setClipsToBounds:YES];
    self.noteView.layer.cornerRadius = 3.0f;
    
    [self.tableView registerNib:[UINib nibWithNibName:QKTextViewCellidentifier bundle:nil] forCellReuseIdentifier:QKTextViewCellidentifier];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // [self getPaymentMethodInfo];
}

- (void)getPaymentMethodInfo {
    if (self.connected) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:[QKCLAccessUserDefaults getActiveShopId] forKey:@"shopId"];
        
        NSDictionary *response;
        NSError *error;
        BOOL result = [[QKCLRequestManager sharedManager] syncPOST:[NSString stringFromConst:qkUrlPaymentRegist] parameters:params response:&response error:&error showLoading:YES showError:YES];
        if (result) {
        }
    }
    else {
        [self showNoInternetViewWithSelector:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)inquireChangeMethod:(id)sender {
    CCAlertView *contactWithTelAlv = [[CCAlertView alloc] initWithTitle:@"コールセンターへ 電話をかけます"
                                                                message:kQKCenterPhoneNum
                                                               delegate:self
                                                           buttonTitles:@[@"キャンセル", @"発信"]];
    [contactWithTelAlv showAlert];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([_paymentSystemTypeCd isEqualToString:[NSString stringFromConst:PAYMENT_SYSTEM_TYPE_CD_CARD]]) {
        return 1;
    }
    else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    switch (indexPath.row) {
        case 0: {
            QKTableViewCell *cell1 =  (QKTableViewCell *)[tableView dequeueReusableCellWithIdentifier:QKTableViewCellidentifier];
            if (!cell1) {
                cell1 = [[QKTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                              reuseIdentifier :QKTableViewCellidentifier];
            }
            
            cell1.textLabel.text = NSLocalizedString(@"支払い方法", nil);
            cell1.detailTextLabel.text = _paymentSystemTypeName;
            cell = cell1;
            break;
        }
            
        case 1: {
            QKTextViewTableViewCell *cell2 =  (QKTextViewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:QKTextViewCellidentifier];
            if (!cell2) {
                cell2 = [[QKTextViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                      reuseIdentifier :QKTextViewCellidentifier];
            }
            NSString *address;
            if (_paymentAddress) {
                address =  [NSString stringWithFormat:@"%@\n%@", NSLocalizedString(@"請求書送り先住所", nil), _paymentAddress];
            }
            else {
                address = NSLocalizedString(@"請求書送り先住所", nil);
            }
            
            
            [cell2 setText:address];
            [cell2 setEditable:NO];
            cell = cell2;
            break;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //cell.accessoryView = nil;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            return 44;
            
        case 1: {
            QKTextViewTableViewCell *cell =  (QKTextViewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:QKTextViewCellidentifier];
            if (!cell) {
                cell = [[QKTextViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                     reuseIdentifier :QKTextViewCellidentifier];
            }
            
            
            NSString *address;
            if (_paymentAddress) {
                address =  [NSString stringWithFormat:@"%@\n%@", NSLocalizedString(@"請求書送り先住所", nil), _paymentAddress];
            }
            else {
                address = NSLocalizedString(@"請求書送り先住所", nil);
            }
            [cell setText:address];
            [cell setEditable:NO];
            return [cell getCellHeight];
        }
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0f;
}

@end
