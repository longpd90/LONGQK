//
//  QKDescriptionPaymentMethodViewController.m
//  quicker-cl-ios
//
//  Created by Quy on 5/28/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLDescriptionPaymentMethodViewController.h"
#import "QKCLChoosePaymentMethodViewController.h"

@interface QKCLDescriptionPaymentMethodViewController ()

@end

@implementation QKCLDescriptionPaymentMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"振込代行について";
    [self setAngleLeftBarButton];
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    //// Do any additional setup after loading the view.
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"QKShowPaymentSettingSegue"]) {
        QKCLChoosePaymentMethodViewController *choosePaymentViewController = (QKCLChoosePaymentMethodViewController *)segue.destinationViewController;
        [choosePaymentViewController setMode:_mode];
        [choosePaymentViewController setShopId:_shopId];
    }
}

@end
