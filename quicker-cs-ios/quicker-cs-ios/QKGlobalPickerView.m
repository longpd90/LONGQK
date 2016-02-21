//
//  QKPickerView.m
//  quicker-cl-ios
//
//  Created by Nguyen Viet Thang on 6/4/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKGlobalPickerView.h"
#import "QKConst.h"
#import "QKGlobalTextButton.h"

@interface QKGlobalPickerView ()
@property (strong, nonatomic) UIWindow *keyWindow;
@end
@implementation QKGlobalPickerView

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
    [self addPickerView];
    [self addToolbar];
}

- (void)addToolbar {
    _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height - self.pickerView.frame.size.height - 44, self.frame.size.width, 44)];
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

- (void)addPickerView {
    self.pickerView = [[UIPickerView alloc]init];
    self.pickerView.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height - self.pickerView.frame.size.height, self.frame.size.width, self.pickerView.frame.size.height);
    
    self.pickerView.delegate = self;
    self.pickerView.backgroundColor = [UIColor colorWithRed:244.0 / 255.0 green:250.0 / 255.0 blue:250.0 / 255.0 alpha:1.0];
    
    [self addSubview:self.pickerView];
}

- (void)show {
    [self.pickerView selectRow:_selectedIndex inComponent:0 animated:NO];
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
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelPickerView:)]) {
        [self.delegate cancelPickerView:self];
    }
    [self hide];
}

- (void)done:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(donePickerView:selectedIndex:)]) {
        [self.delegate donePickerView:self selectedIndex:[self.pickerView selectedRowInComponent:0]];
    }
    [self hide];
}

#pragma mark - Handle Action In View

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!([[touches anyObject] view] == _toolBar)) {
        [self hide];
    }
}

#pragma mark PickerView DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// The number of columns of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _pickerData[row];
}

- (void) reloadPicker {
    [self.pickerView reloadAllComponents];
}
@end
