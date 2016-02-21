//
//  QKGlobalDatePickerView.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 6/26/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKGlobalDatePickerView.h"
#import "QKGlobalTextButton.h"
#import "QKConst.h"

@interface QKGlobalDatePickerView ()

@property (strong, nonatomic) UIWindow *keyWindow;

@end

@implementation QKGlobalDatePickerView
- (id)init {
    self = [super init];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)initialization {
    self.keyWindow = [[UIApplication sharedApplication] keyWindow];
    self.frame = self.keyWindow.frame;
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    [self addDatePicker];
    [self addToolbar];
}

- (void)addToolbar {
    _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height - self.datePicker.frame.size.height - 44, self.frame.size.width, 44)];
    _toolBar.barStyle = UIBarStyleDefault;
    _toolBar.backgroundColor = kQKColorWhite;
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *leftFixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    leftFixedSpace.width = 15;
    UIBarButtonItem *rightFixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    rightFixedSpace.width = 15;
    
    QKGlobalTextButton *cancelButton = [[QKGlobalTextButton alloc]init];
    [cancelButton setTitle:NSLocalizedString(@"キャンセル", nil) forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor colorWithRed:79.0 / 255.0 green:88.0 / 255.0 blue:104.0 / 255.0 alpha:1]  forState:UIControlStateNormal];
    [cancelButton sizeToFit];
    [cancelButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *cancelBarButton = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
    QKGlobalTextButton *doneButton = [[QKGlobalTextButton alloc]init];
    [doneButton setTitle:NSLocalizedString(@"決定", nil) forState:UIControlStateNormal];
    [doneButton setTitleColor:kQKColorBtnPrimary forState:UIControlStateNormal];
    [doneButton sizeToFit];
    [doneButton addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithCustomView:doneButton];
    
    [_toolBar setItems:[NSArray arrayWithObjects:leftFixedSpace, cancelBarButton, flexibleSpace, doneBarButton, rightFixedSpace, nil]];
    [self addSubview:_toolBar];
}

- (void)addDatePicker {
    self.datePicker = [[UIDatePicker alloc]init];
    self.datePicker.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height - self.datePicker.frame.size.height, self.frame.size.width, self.datePicker.frame.size.height);
    [self.datePicker setDatePickerMode:UIDatePickerModeTime];
    self.datePicker.backgroundColor = [UIColor colorWithRed:244.0 / 255.0 green:250.0 / 255.0 blue:250.0 / 255.0 alpha:1.0];
    [self addSubview:self.datePicker];
}

- (void)show {
    if (_date != nil) {
        [self.datePicker setDate:_date];
    }
    [_keyWindow addSubview:self];
    self.alpha = 0;
    [UIView animateWithDuration:.2 animations: ^{
        self.alpha = 1;
    }];
}

- (void)hide {
    [self removeFromSuperview];
}

- (void)cancel:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelDatePicker:)]) {
        [self.delegate cancelDatePicker:self];
    }
    [self hide];
}

- (void)done:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickedDatePicker:withDate:)]) {
        [self.delegate pickedDatePicker:self withDate:self.datePicker.date];
    }
    [self hide];
}

#pragma mark - Handle Action In View

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!([[touches anyObject] view] == _toolBar)) {
        [self hide];
    }
}

@end
