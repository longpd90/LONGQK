//
//  QKTextView.h
//  quicker-cs-ios
//
//  Created by LongPD-PC on 6/25/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKGlobalDefines.h"
#import "QKGlobalTextView.h"
#import "QKF40Label.h"
#import "chiase-ios-core/UIView+Extra.h"
#import "QKViewWithBorder.h"
@protocol QKTextViewDelegate <NSObject>
- (void)editingChanged:(UITextView *)textView;
@end

@interface QKTextView : QKViewWithBorder<UITextViewDelegate> {
    long remain_lenght;
}

@property id <QKTextViewDelegate> delegate;
@property (strong, nonatomic)  QKGlobalTextView *textView;
@property (strong, nonatomic)  QKF40Label *lengthText;
@property (assign, nonatomic) NSInteger max;
@property InputMode inputMode;

- (NSString *)getText;
- (void)setText:(NSString *)text;
- (void)setMaxLength:(NSInteger)max;
@end
