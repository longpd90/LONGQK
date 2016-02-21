//
//  QKNavigationItem.m
//  quicker-cl-ios
//
//  Created by Viet on 4/24/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKNavigationItem.h"

@implementation QKNavigationItem

- (void)awakeFromNib {
	self.title = NSLocalizedString(self.title, nil);
}

@end
