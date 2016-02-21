//
//  QKViewController.m
//  quicker-cs-ios
//
//  Created by LongPD-PC on 4/14/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSBaseViewController.h"

@interface QKCSBaseViewController () <UIScrollViewDelegate>

@end

@implementation QKCSBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.translatesAutoresizingMaskIntoConstraints = YES;
    [self setNavigationBarColor:kQKGlobalBlueColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName: [UIColor whiteColor],
                                                           NSFontAttributeName: [UIFont boldSystemFontOfSize:20.0]
                                                           }];
    //set background
    [self.view setBackgroundColor:kQKColorBG];
}

- (void)setNavigationBarColor:(UIColor *)color {
    [self.navigationController.navigationBar setBarTintColor:color];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setRightBarButtonWithTitle:(NSString *)buttonTitle target:(SEL)action {
    UIBarButtonItem *rightBarItem =
    [[UIBarButtonItem alloc] initWithTitle:buttonTitle
                                     style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:action];
    [rightBarItem setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14.0f], NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil]
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

- (void)setRightBarButtonWithImage:(UIImage *)image target:(SEL)action {
    UIBarButtonItem *customBarItem;
    //set image if exist
    if (image != nil) {
        //create the button
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setBackgroundImage:image
                          forState:UIControlStateNormal];
        
        //create a UIBarButtonItem with the button as a custom view
        [button    addTarget:self action:action
            forControlEvents:UIControlEventTouchUpInside];
        [button sizeToFit];
        
        [button setUserInteractionEnabled:YES];
        button.frame = CGRectMake(15, 0.0, image.size.width, image.size.height);
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        [view addSubview:button];
        customBarItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    }
    [self.navigationItem setRightBarButtonItem:customBarItem];
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

- (void)goBack:(id)sender {
    if (self.presentingViewController
        && [[self.navigationController.viewControllers firstObject] isEqual:self]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)dissmissView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

# pragma mark - keyboard
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];// this will do the trick
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

- (void)setNavigationBarWithTitle:(NSString *)title andSubTitle:(NSString *)subTitle {
    CGFloat width = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    UIView *navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 44.0)];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:9.0f];
    titleLabel.adjustsFontSizeToFitWidth = NO;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = kQKColorWhite;
    titleLabel.text = title;
    [titleLabel sizeToFit];
    UILabel *subTitleLabel = [[UILabel alloc] init];
    subTitleLabel.backgroundColor = [UIColor clearColor];
    subTitleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    subTitleLabel.adjustsFontSizeToFitWidth = NO;
    subTitleLabel.textAlignment = NSTextAlignmentCenter;
    subTitleLabel.textColor = kQKColorWhite;
    subTitleLabel.text = subTitle;
    [subTitleLabel sizeToFit];
    [navigationView addSubview:titleLabel];
    [navigationView addSubview:subTitleLabel];
    
    
    
    [titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [subTitleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [navigationView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(titleLabel, subTitleLabel, navigationView);
    [navigationView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[titleLabel]-(5)-[subTitleLabel]-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
    
    //[navigationView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[titleLabel]-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
    [navigationView addConstraint:[NSLayoutConstraint constraintWithItem:titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:navigationView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [navigationView setTranslatesAutoresizingMaskIntoConstraints:YES];
    
    // [self.navigationController.navigationBar addSubview:navigationView];
    self.navigationItem.titleView = navigationView;
}

- (BOOL)connected {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

- (void)showNoInternetViewWithSelector:(SEL)selector {
    QKCSNoInternetView *noInternetView = [[QKCSNoInternetView alloc] initWithTarget:self selector:selector];
    [noInternetView show];
}

#pragma mark - CaculateCellHeightFunction
- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell inTableView:(UITableView *)tableView {
    sizingCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.frame), CGRectGetHeight(sizingCell.bounds));
    
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1.0f; // Add 1.0f for the cell separator height
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

@end
