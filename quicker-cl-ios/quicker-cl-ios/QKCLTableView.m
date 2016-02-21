//
//  QKCLTableView.m
//  quicker-cl-ios
//
//  Created by VietND on 7/28/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLTableView.h"

@implementation QKCLTableView
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [[self nextResponder] touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    [[self nextResponder] touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [[self nextResponder] touchesEnded:touches withEvent:event];
}

@end
