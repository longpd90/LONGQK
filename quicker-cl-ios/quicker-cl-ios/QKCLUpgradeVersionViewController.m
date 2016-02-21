//
//  QKUpgradeVersionViewController.m
//  quicker-cl-ios
//
//  Created by Viet on 5/18/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLUpgradeVersionViewController.h"

@interface QKCLUpgradeVersionViewController ()

@end

@implementation QKCLUpgradeVersionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
#pragma mark -IBActions
- (IBAction)goToAppStoreButtonClicked:(id)sender {
    if (![kQKNewVersionAppName isEqualToString:@""]) {
        NSURL *appStoreURL = [NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/%@", [kQKNewVersionAppName stringByReplacingOccurrencesOfString:@" " withString:@""]]];
        if ([[UIApplication sharedApplication] canOpenURL:appStoreURL]) {
            [[UIApplication sharedApplication] openURL:appStoreURL];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"Can not open app store" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Warning" message:@"Don't have new version" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

@end
