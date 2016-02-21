//
//  CCButtonForAlertView.m
//  chiase-ios-core
//
//  Created by Nguyen Huu Anh on 6/12/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "CCButtonForAlertView.h"

@implementation CCButtonForAlertView

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if (highlighted) {
        self.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
    } else {
        self.backgroundColor = [UIColor whiteColor];
    }
}

@end
