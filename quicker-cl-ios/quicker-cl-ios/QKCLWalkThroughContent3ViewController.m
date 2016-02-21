//
//  QKWalkThroughContent3ViewController.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 5/28/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLWalkThroughContent3ViewController.h"
#import "AppDelegate.h"

@implementation QKCLWalkThroughContent3ViewController
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
