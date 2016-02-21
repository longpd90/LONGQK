//
//  QKCSTableViewController.m
//  quicker-cs-ios
//
//  Created by LongPD-PC on 5/22/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSTableViewController.h"

@interface QKCSTableViewController ()

@end

@implementation QKCSTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarColor:kQKGlobalBlueColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName: [UIColor whiteColor],
                                                           NSFontAttributeName: [UIFont boldSystemFontOfSize:20.0]
                                                           }];
    
    //set background
    [self.view setBackgroundColor:kQKColorBG];
    
    //custom headerview for tableview
    [[UILabel appearanceWhenContainedIn:[UITableViewHeaderFooterView class], nil] setTextColor:[UIColor colorWithHexString:@"#444"]];
    [[UILabel appearanceWhenContainedIn:[UITableViewHeaderFooterView class], nil] setFont:[UIFont systemFontOfSize:12.0f]];
}

- (void)setNavigationBarColor:(UIColor *)color {
    [self.navigationController.navigationBar setBarTintColor:color];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goBack:(id)sender {
    if (self.presentingViewController
        && [[self.navigationController.viewControllers firstObject] isEqual:self]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)setAngleLeftBarButton {
    UIImage *buttonImage = [UIImage imageNamed:@"nav_btn_back"];
    
    //create the button and assign the image
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    
    //set the frame of the button to the size of the image (see note below)
    button.frame = CGRectMake(0, 0, 13.0, 22.0);
    [button addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    //create a UIBarButtonItem with the button as a custom view
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = customBarItem;
}

- (void)setWhiteTitle:(NSString *)title {
    [super setTitle:title];
    UILabel *titleView = (UILabel *)self.navigationItem.titleView;
    if (!titleView) {
        titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        titleView.backgroundColor = [UIColor clearColor];
        titleView.font = [UIFont boldSystemFontOfSize:20.0];
        titleView.textColor = [UIColor whiteColor]; // Change to desired color
    }
    titleView.text = title;
    [titleView sizeToFit];
    self.navigationItem.titleView = titleView;
}

- (void)setRightBarButtonWithTitle:(NSString *)buttonTitle target:(SEL)action {
    UIBarButtonItem *rightBarItem =
    [[UIBarButtonItem alloc] initWithTitle:buttonTitle
                                     style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:action];
    [rightBarItem setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica-Bold" size:14.0], NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil]
                                forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

- (void)setLeftBarButtonWithTitle:(NSString *)buttonTitle target:(SEL)action {
    UIBarButtonItem *leftBarItem =
    [[UIBarButtonItem alloc] initWithTitle:buttonTitle
                                     style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:action];
    [leftBarItem setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica-Bold" size:14.0], NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil]
                               forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = leftBarItem;
}

- (void)setLeftBarButtonWithImage:(UIImage *)image1
                       hightlight:(UIImage *)image2
                            title:(NSString *)title
                           target:(SEL)action {
    UIBarButtonItem *customBarItem;
    //set image if exist
    if (image1 != nil) {
        //create the button
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:image1
                          forState:UIControlStateNormal];
        if (image2 != nil) {
            [button setBackgroundImage:image2
                              forState:UIControlStateHighlighted];
        }
        //create a UIBarButtonItem with the button as a custom view
        [button    addTarget:self action:action
            forControlEvents:UIControlEventTouchUpInside];
        [button sizeToFit];
        [button setUserInteractionEnabled:YES];
        customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    
    //set title
    if (title != nil && ![title isEqualToString:@""]) {
        QKGlobalButton *button = [[QKGlobalButton alloc]init];
        [button setTitle:title forState:UIControlStateNormal];
        //create a UIBarButtonItem with the button as a custom view
        [button    addTarget:self action:action
            forControlEvents:UIControlEventTouchUpInside];
        [button sizeToFit];
        [button setUserInteractionEnabled:YES];
        customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    
    self.navigationItem.leftBarButtonItem = customBarItem;
}

#pragma mark - keyboard
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.tableView endEditing:YES];// this will do the trick
}

//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
//    return 0;
//}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (BOOL)connected {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

- (void)showNoInternetViewWithSelector:(SEL)selector {
    QKCSNoInternetView *noInternetView = [[QKCSNoInternetView alloc] initWithTarget:self selector:selector];
    [noInternetView show];
}

#pragma mark -Call center
- (void)callCenter {
    NSString *number = [@"telprompt://" stringByAppendingString:kQKCenterPhoneNum];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:number]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:number]];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Device doesn't support phone call." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark - CaculateCellHeightFunction
- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell inTableView:(UITableView *)tableView {
    sizingCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.frame), CGRectGetHeight(sizingCell.bounds));
    
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1.0f; // Add 1.0f for the cell separator height
}

@end
