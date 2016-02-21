//
//  QKQKWalkThroughContent4ViewController.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 5/28/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLWalkThroughContent4ViewController.h"
#import "AppDelegate.h"

@implementation QKCLWalkThroughContent4ViewController




- (IBAction)closeWalkThrough:(id)sender {
    if (self.walkThroughDelegate && [self.walkThroughDelegate respondsToSelector:@selector(skip)]) {
        [self.walkThroughDelegate skip];
    }
}

@end
