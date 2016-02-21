//
//  UIView+customView.m
//  quicker-cl-ios
//
//  Created by Viet on 6/15/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "UIView+customView.h"

@implementation UIView (customView)
+ (UIImageView *)QKTableViewCellAccessoryCheckmark {
    UIImageView *imgCheckMark = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"list_ic_checked"]];
    return imgCheckMark;
}

+ (UIImageView *)QKTableViewCellAccessoryDisclosureIndicator {
    UIImageView *imgCheckMark = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"common_ic_arrow_min"]];
    return imgCheckMark;
}

+ (UISwitch *)QKSwitch {
    UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
    [switchView setOnTintColor:[UIColor colorWithRed:110.0 / 255.0 green:189.0 / 255.0 blue:193.0 / 255.0 alpha:1.0]];
    return switchView;
}

@end
