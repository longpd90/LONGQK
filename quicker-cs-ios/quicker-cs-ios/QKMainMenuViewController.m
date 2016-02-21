//
//  QKMainMenuViewController.m
//  quicker-cs-ios
//
//  Created by LongPD-PC on 5/5/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKMainMenuViewController.h"

@interface QKMainMenuViewController ()

@end

@implementation QKMainMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITabBar *tabBar = self.tabBar;
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : kQKColorDisabled }
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : kQKColorBtnPrimary }
                                             forState:UIControlStateSelected];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName: [UIColor whiteColor],
                                                           NSFontAttributeName: [UIFont boldSystemFontOfSize:20.0]
                                                           }];
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];
    
    [tabBarItem1 setSelectedImage:[[UIImage imageNamed:@"tab_btn_recruit_active"]
                                   imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItem2 setSelectedImage:[[UIImage imageNamed:@"tab_btn_already_active"]
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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}


@end
