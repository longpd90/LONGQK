//
//  QKViewController.m
//  quicker-cl-ios
//
//  Created by LongPD-PC on 4/14/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseViewController.h"

@interface QKCLBaseViewController () <UIScrollViewDelegate>

@end

@implementation QKCLBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:110.0 / 255.0 green:189.0 / 255.0 blue:193.0 / 255.0 alpha:1.0]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSForegroundColorAttributeName: [UIColor whiteColor],
                                                           NSFontAttributeName: [UIFont boldSystemFontOfSize:20.0]
                                                           }];
    self.view.translatesAutoresizingMaskIntoConstraints = YES;
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    //set background
    [self.view setBackgroundColor:kQKColorBG];
    
    //custom headerview for tableview
    [[UILabel appearanceWhenContainedIn:[UITableViewHeaderFooterView class], nil] setTextColor:[UIColor colorWithHexString:@"#444"]];
    [[UILabel appearanceWhenContainedIn:[UITableViewHeaderFooterView class], nil] setFont:[UIFont systemFontOfSize:12.0f]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setRightBarButtonWithTitle:(NSString *)buttonTitle target:(SEL)action {
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:buttonTitle style:UIBarButtonItemStyleBordered target:self action:action];
    [rightBarItem setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica-Bold" size:17.0], NSFontAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil]
                                forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

- (void)setLeftBarButtonWithTitle:(NSString *)buttonTitle target:(SEL)action {
    UIBarButtonItem *rightBarItem =
    [[UIBarButtonItem alloc] initWithTitle:buttonTitle
                                     style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:action];
    
    [rightBarItem setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica-Bold" size:17.0], NSFontAttributeName, [UIColor colorWithWhite:1.0f
                                                                                                                                          alpha:1.0f], NSForegroundColorAttributeName, nil]
                                forState:UIControlStateNormal];
    [rightBarItem setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica-Bold" size:17.0], NSFontAttributeName, [UIColor colorWithWhite:1.0f alpha:0.5f], NSForegroundColorAttributeName, nil]
                                forState:UIControlStateHighlighted];
    
    self.navigationItem.leftBarButtonItem = rightBarItem;
}

- (void)setLeftBarButtonWithImage:(UIImage *)image1
                       hightlight:(UIImage *)image2
                            title:(NSString *)title
                           target:(id)target
                           action:(SEL)action {
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
        [button    addTarget:target action:action
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

- (void)setLeftBarButtonWithButton:(NSString *)buttonTitle target:(SEL)action {
    UIBarButtonItem *customBarItem;
    if (buttonTitle != nil && ![buttonTitle isEqualToString:@""]) {
        QKGlobalButton *button = [[QKGlobalButton alloc]init];
        [button setTitle:buttonTitle forState:UIControlStateNormal];
        //create a UIBarButtonItem with the button as a custom view
        [button    addTarget:self action:action
            forControlEvents:UIControlEventTouchUpInside];
        [button sizeToFit];
        [button setUserInteractionEnabled:YES];
        customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    
    self.navigationItem.leftBarButtonItem = customBarItem;
}

- (void)setRightBarButtonWithButton:(NSString *)buttonTitle target:(SEL)action {
    UIBarButtonItem *customBarItem;
    if (buttonTitle != nil && ![buttonTitle isEqualToString:@""]) {
        QKGlobalButton *button = [[QKGlobalButton alloc]initWithFrame:CGRectMake(0, 0, 75, 30)];
        [button setTitle:buttonTitle forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        //create a UIBarButtonItem with the button as a custom view
        [button    addTarget:self action:action
            forControlEvents:UIControlEventTouchUpInside];
        //[button sizeToFit];
        [button setUserInteractionEnabled:YES];
        customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    
    [self.navigationItem setRightBarButtonItem:customBarItem];
}

- (void)setLeftBarButtonWithImage:(UIImage *)image1 hightlight:(UIImage *)image2 target:(id)target action:(SEL)action {
    UIBarButtonItem *customBarItem;
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
        if (target) {
            [button    addTarget:target action:action
                forControlEvents:UIControlEventTouchUpInside];
        }
        else {
            [button    addTarget:button action:action
                forControlEvents:UIControlEventTouchUpInside];
        }
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

- (void)setAngleLeftBarButton {
    UIImage *buttonImage = [UIImage imageNamed:@"nav_btn_back"];
    
    //set title
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:buttonImage
                      forState:UIControlStateNormal];
    [button    addTarget:self action:@selector(goBack:)
        forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    [button setUserInteractionEnabled:YES];
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
    [navigationView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[titleLabel]-(5)-[subTitleLabel]|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
    
    //[navigationView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[titleLabel]|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:views]];
    [navigationView addConstraint:[NSLayoutConstraint constraintWithItem:titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:navigationView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [navigationView setTranslatesAutoresizingMaskIntoConstraints:YES];
    
    self.navigationItem.titleView = navigationView;
}

- (BOOL)checkPassword:(NSString *)password {
    return YES;
}

- (BOOL)connected {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

- (void)showNoInternetViewWithSelector:(SEL)selector {
    QKCSNoInternetView *noInternetView = [[QKCSNoInternetView alloc] initWithTarget:self selector:selector];
    [noInternetView show];
}

# pragma mark - keyboard
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];// this will do the trick
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
