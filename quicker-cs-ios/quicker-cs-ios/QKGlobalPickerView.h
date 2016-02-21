//
//  QKPickerView.h
//  quicker-cl-ios
//
//  Created by Nguyen Viet Thang on 6/4/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QKGlobalPickerViewDelegate;

@interface QKGlobalPickerView : UIView <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) id <QKGlobalPickerViewDelegate> delegate;
@property (nonatomic) NSInteger selectedIndex;
@property (strong, nonatomic) NSArray *pickerData;
@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) UIToolbar *toolBar;

- (void)show;

- (void) reloadPicker;
@end


@protocol QKGlobalPickerViewDelegate <NSObject>

- (void)donePickerView:(QKGlobalPickerView *)pickerView selectedIndex:(NSInteger)selectedIndex;

@optional
-(void)cancelPickerView:(QKGlobalPickerView*)pickerView;
@end
