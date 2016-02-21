//
//  QKChoosePaymentMethodViewController.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 4/21/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLChoosePaymentMethodViewController.h"
#import "QKCLPaymentMethodViewController.h"

@interface QKCLChoosePaymentMethodViewController () <CCAlertViewDelegate>
@property (strong, nonatomic) NSString *paymentSystemTypeCd;
@property (strong, nonatomic) NSString *paymentSystemTypeName;
@property (strong, nonatomic) NSString *paymentAddress;
@end

@implementation QKCLChoosePaymentMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAngleLeftBarButton];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action
- (void)addPaymentMethod {
    if (self.connected) {
        if (_shopId == nil || [_shopId isEqualToString:@""]) {
            _shopId = [QKCLAccessUserDefaults getActiveShopId];
        }
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:_shopId forKey:@"shopId"];
        [params setObject:self.paymentSystemTypeCd forKey:@"paymentSystemTypeCd"];
        
        NSDictionary *response;
        NSError *error;
        BOOL result = [[QKCLRequestManager sharedManager] syncPOST:[NSString stringFromConst:qkUrlPaymentRegist] parameters:params response:&response error:&error showLoading:YES showError:YES];
        if (result) {
            NSLog(@"Set payment successful...");
            _paymentSystemTypeName = response[@"paymentSystemTypeName"];
            _paymentAddress = response[@"billingAddress"];
            
            if (_mode == QKPaymentSettingModeOther) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            else {
                [self performSegueWithIdentifier:@"QKPaymentMethodSegue" sender:self];
            }
        }
    }
    else {
        [self showNoInternetViewWithSelector:nil];
    }
}

#pragma mark -Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"QKPaymentMethodSegue"]) {
        QKCLPaymentMethodViewController *vc = (QKCLPaymentMethodViewController *)segue.destinationViewController;
        vc.paymentAddress = _paymentAddress;
        vc.paymentSystemTypeCd = _paymentSystemTypeCd;
        vc.paymentSystemTypeName = _paymentSystemTypeName;
    }
}

- (IBAction)paymentCardClicked:(id)sender {
    //[NSString stringWithFormat:@"%@,\n%@", mystring1,mystring2];
    
    CCAlertView *alert = [[CCAlertView alloc]initWithTitle:@"店舗を削除しますか？" message:[NSString stringWithFormat:@"%@\n%@\n%@", @"削除すると、店舗情報、勤務履歴、", @"請求情報、登録クレジットカード情報などの", @"全ての情報が削除されます"] delegate:self buttonTitles:@[@"しない", @"削除する"]];
    alert.tag = 1;
    [alert showAlert];
}

- (IBAction)paymentBankClicked:(id)sender {
    CCAlertView *alert = [[CCAlertView alloc]initWithTitle:@"店舗を削除しますか？" message:[NSString stringWithFormat:@"%@\n%@\n%@", @"削除すると、店舗情報、勤務履歴、", @"請求情報、登録クレジットカード情報などの", @"全ての情報が削除されます"]  delegate:self buttonTitles:@[@"しない", @"する"]];
    alert.tag = 2;
    [alert showAlert];
}

- (void)alertView:(CCAlertView *)alertView selectedButtonIndex:(NSInteger)index {
    if (index == 1) {
        switch (alertView.tag) {
            case 1:
                self.paymentSystemTypeCd = [NSString stringFromConst:PAYMENT_SYSTEM_TYPE_CD_CARD];
                [self addPaymentMethod];
                break;
                
            case 2:
                self.paymentSystemTypeCd = [NSString stringFromConst:PAYMENT_SYSTEM_TYPE_CD_BANK];
                [self addPaymentMethod];
                break;
        }
    }
}

@end
