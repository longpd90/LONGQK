//
//  QKMainMenuViewController.m
//  quicker-cl-ios
//
//  Created by LongPD-PC on 4/16/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLMainMenuViewController.h"

@interface QKCLMainMenuViewController ()

@end

@implementation QKCLMainMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    UITabBar *tabBar = self.tabBar;
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor colorWithRed:136.0 / 255.0 green:136.0 / 255.0 blue:136.0 / 255.0 alpha:1] }
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{                    NSForegroundColorAttributeName : [UIColor colorWithRed:110.0 / 255.0 green:189.0 / 255.0 blue:193.0 / 255.0 alpha:1] }
                                             forState:UIControlStateSelected];
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];
    
    
    [tabBarItem1 setSelectedImage:[[UIImage imageNamed:@"tab_btn_recruit_active"]
                                   imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItem2 setSelectedImage:[[UIImage imageNamed:@"tab_btn_work_active"]
                                   imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItem3 setSelectedImage:[[UIImage imageNamed:@"tab_btn_notice_active"]
                                   imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItem4 setSelectedImage:[[UIImage imageNamed:@"tab_btn_account_active"]
                                   imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
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
