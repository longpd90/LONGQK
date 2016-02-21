//
//  QKWalkThroughViewController.m
//  quicker-cs-ios
//
//  Created by LongPD-PC on 5/14/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSWalkThroughViewController.h"

@interface QKCSWalkThroughViewController ()

@end

@implementation QKCSWalkThroughViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //swipe to sign up
    UISwipeGestureRecognizer *leftSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftGesture:)];
    leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipeGesture];
    
   
    
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



#pragma mark - Gesture Recognizer
- (void)swipeLeftGesture:(id)sender {
    [self performSegueWithIdentifier:@"QKShowSignupSegue" sender:self];
}


@end
