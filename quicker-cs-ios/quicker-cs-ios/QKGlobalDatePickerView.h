//
//  QKGlobalDatePickerView.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 6/26/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QKGlobalDatePickerViewDelegate;

@interface QKGlobalDatePickerView : UIView
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) UIToolbar *toolBar;
@property (weak, nonatomic) id <QKGlobalDatePickerViewDelegate> delegate;

- (void)show;
@end

@protocol QKGlobalDatePickerViewDelegate <NSObject>
- (void)pickedDatePicker:(QKGlobalDatePickerView *)datePicker withDate:(NSDate *)date;
@optional
- (void)cancelDatePicker:(QKGlobalDatePickerView *)datePicker;
@end
