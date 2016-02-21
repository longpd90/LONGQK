//
//  QKWalkThroughViewController.m
//  quicker-cl-ios
//
//  Created by Viet on 5/8/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLWalkThroughViewController.h"
#import "QKCLWalkThroughContent1ViewController.h"
#import "QKCLWalkThroughContent2ViewController.h"
#import "QKCLWalkThroughContent3ViewController.h"
#import "QKCLWalkThroughContent4ViewController.h"
#import "AppDelegate.h"
#import "QKCLViewController.h"

@interface QKCLWalkThroughViewController ()
@property (strong, nonatomic) NSArray *viewControllers;
@property (strong, nonatomic) QKCLWalkThroughContent1ViewController *page1;
@property (strong, nonatomic) QKCLWalkThroughContent2ViewController *page2;
@property (strong, nonatomic) QKCLWalkThroughContent3ViewController *page3;
@property (strong, nonatomic) QKCLWalkThroughContent4ViewController *page4;
@property (strong, nonatomic) QKCLViewController *signUp;
@property (strong, nonatomic) UIViewController *currentViewController;
@property (nonatomic) int countSwipe;
@end

@implementation QKCLWalkThroughViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.countSwipe = 0;
    // Do any additional setup after loading the view.
    // Create page view controller
    self.pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    
    _page1 = [self.storyboard instantiateViewControllerWithIdentifier:@"QKWalkThroughContent1ViewController"];
    _page2 = [self.storyboard instantiateViewControllerWithIdentifier:@"QKWalkThroughContent2ViewController"];
    _page3 = [self.storyboard instantiateViewControllerWithIdentifier:@"QKWalkThroughContent3ViewController"];
    _page4 = [self.storyboard instantiateViewControllerWithIdentifier:@"QKWalkThroughContent4ViewController"];
    _signUp = [self.storyboard instantiateViewControllerWithIdentifier:@"QKViewController"];
    _signUp.isSignUp = YES;
    _page1.walkThroughDelegate = self;
    _page2.walkThroughDelegate = self;
    _page3.walkThroughDelegate = self;
    _page4.walkThroughDelegate = self;
    
    self.viewControllers = @[_page1, _page2, _page3, _page4, _signUp];
    [self.pageViewController setViewControllers:@[_page1] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.pageViewController.dataSource = self;
    
    // Change the size of page view controller
    self.pageViewController.view.frame = self.view.frame;
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    self.currentViewController = self.page1;
    
    //    UISwipeGestureRecognizer *recognizer =
    //    [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    //    recognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    //    [_page4.view addGestureRecognizer:recognizer];
}

//- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
//    [self nextPage];
//}



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

#pragma mark - WalkthroughDelegate
- (void)skip {
    [self performSegueWithIdentifier:@"QKShowSignUpSegue" sender:self];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    //show nitification tips
    if (![appDelegate checkNotificationSettings]) {
        [appDelegate showNotificationTips];
    }
}

- (void)nextPage {
    self.countSwipe++;
    [self.pageViewController setViewControllers:@[self.viewControllers[self.countSwipe]]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:YES
                                     completion:nil];
}

#pragma mark -View
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

#pragma mark -UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    self.countSwipe = [self.viewControllers indexOfObject:viewController];
    NSUInteger index = [self.viewControllers indexOfObject:viewController];
    if (index == 0) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    self.countSwipe = [self.viewControllers indexOfObject:viewController];
    NSUInteger index = [self.viewControllers indexOfObject:viewController];
    if (index == 4) {
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        //show nitification tips
        if (![appDelegate checkNotificationSettings]) {
            [appDelegate showNotificationTips];
        }
        for (UIScrollView *view in self.pageViewController.view.subviews) {
            if ([view isKindOfClass:[UIScrollView class]]) {
                view.scrollEnabled = NO;
            }
        }
        return nil;
    }
    index++;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index {
    switch (index) {
        case 0:
            return _page1;
            
        case 1:
            return _page2;
            
        case 2:
            return _page3;
            
        case 3:
            return _page4;
            
        case 4:
            return _signUp;
            
        default:
            return nil;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"QKShowSignUpSegue"]) {
        QKCLViewController *vc = (QKCLViewController *)segue.destinationViewController;
        vc.isSignUp = YES;
    }
}

@end
