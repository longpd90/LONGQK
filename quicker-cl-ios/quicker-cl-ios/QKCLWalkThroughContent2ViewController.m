//
//  QKWalkThroughContent2ViewController.m
//  quicker-cl-ios
//
//  Created by Viet on 5/8/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLWalkThroughContent2ViewController.h"
#import "AppDelegate.h"

@interface QKCLWalkThroughContent2ViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLayout;

@end

@implementation QKCLWalkThroughContent2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)skip:(id)sender {
    if (self.walkThroughDelegate && [self.walkThroughDelegate respondsToSelector:@selector(skip)]) {
        [self.walkThroughDelegate skip];
    }
}

#pragma mark -View

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (IBAction)nextPage:(id)sender {
    if (self.walkThroughDelegate && [self.walkThroughDelegate respondsToSelector:@selector(nextPage)]) {
        [self.walkThroughDelegate nextPage];
    }
}

@end
