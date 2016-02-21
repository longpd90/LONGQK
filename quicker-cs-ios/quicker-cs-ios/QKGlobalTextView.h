//
//  QKGlobalTextView.h
//  quicker-cl-ios
//
//  Created by VietND on 6/9/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKGlobalDefines.h"


@interface QKGlobalTextView : UITextView

@property InputMode inputMode;
@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderTextColor;

@end
