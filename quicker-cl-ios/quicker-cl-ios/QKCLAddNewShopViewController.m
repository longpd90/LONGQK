//
//  QKRegisterAccAddShopViewController.m
//  quicker-cl-ios
//
//  Created by Viet on 5/6/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLAddNewShopViewController.h"
#import "QKCLRegisterShopInfoViewController.h"

@interface QKCLAddNewShopViewController ()
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@end

@implementation QKCLAddNewShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self checkShowCloseButton];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)checkShowCloseButton {
    if (_isPresented) {
        self.closeButton.hidden = NO;
        //		[QKAccessUserDefaults put:@"QKAddShopFromSlideMenu" withValue:@"1"];
    }
    else {
        self.closeButton.hidden = YES;
    }
}

- (IBAction)dismissViewController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    QKCLRegisterShopInfoViewController *registVC = (QKCLRegisterShopInfoViewController *)[segue destinationViewController];
    registVC.isPresented = _isPresented;
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
