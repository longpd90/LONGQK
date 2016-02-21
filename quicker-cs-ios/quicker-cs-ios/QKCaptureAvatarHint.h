//
//  QKCaptureAvatarHint.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 6/5/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKGlobalSecondaryButton.h"

@class QKCaptureAvatarHint;
@protocol QKCaptureAvatarHintDelegate <NSObject>

@optional
- (void)hiddenAvatarGuide:(QKCaptureAvatarHint *)view;

@end
@interface QKCaptureAvatarHint : UIView

@property (assign, nonatomic) id<QKCaptureAvatarHintDelegate> delegate;
@property (weak, nonatomic) IBOutlet QKGlobalSecondaryButton *hiddenButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstrainst;
- (instancetype)initWithXibAndFrame:(CGRect)frame;
- (IBAction)hiddenAvatarHint:(id)sender;
- (IBAction)hiddenButtonClicked:(id)sender;

@end
