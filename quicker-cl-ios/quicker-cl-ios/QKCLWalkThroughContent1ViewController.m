//
//  QKWalkThroughContent1ViewController.m
//  quicker-cl-ios
//
//  Created by Viet on 5/8/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLWalkThroughContent1ViewController.h"
#import "AppDelegate.h"

@interface QKCLWalkThroughContent1ViewController ()

@end

@implementation QKCLWalkThroughContent1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)skip:(id)sender {
    if (self.walkThroughDelegate && [self.walkThroughDelegate respondsToSelector:@selector(skip)]) {
        [self.walkThroughDelegate skip];
    }
}

- (IBAction)nextPage:(id)sender {
    if (self.walkThroughDelegate && [self.walkThroughDelegate respondsToSelector:@selector(nextPage)]) {
        [self.walkThroughDelegate nextPage];
    }
}

@end
