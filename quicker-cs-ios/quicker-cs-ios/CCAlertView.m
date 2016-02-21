//
//  CCAlertView.m
//  chiase-ios-core
//
//  Created by Nguyen Huu Anh on 4/15/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "CCAlertView.h"
#import "CCButtonForAlertView.h"

#define kQKCSAutoCloseAlertValue 2.5

@interface CCAlertView ()

@property (strong, nonatomic) UIView *messageDialog;
@property (strong, nonatomic) UIImageView *iconImageView;
@property (strong, nonatomic) UILabel *titleLabel;

@property (nonatomic) CGFloat yBottom;
@property (nonatomic) CGRect frameKeyboard;
@property (strong,nonatomic) NSTimer* timer;
@end

@implementation CCAlertView

#pragma mark - Initialize

- (id)initWithImage:(UIImage *)image
              title:(NSString *)title
         andMessage:(NSString *)message
              style:(QKAlertViewStyle)alertViewStyle {
    self = [super initWithFrame:self.keyWindow.frame];
    
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        _image = image;
        self.title = title;
        self.message = message;
        self.autoHidden = YES;
        [self createMessageDialog:alertViewStyle];
        if (!_timer) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:kQKCSAutoCloseAlertValue target:self selector:@selector(timerFired:) userInfo:nil repeats:NO
                      ];
        }
    }
    
    return self;
}
-(void)timerFired:(id)sender {
    [self hideAlert];
    if ([self.delegate respondsToSelector:@selector(clickOnAlertView:)]) {
        [self.delegate clickOnAlertView:self];
    }
    [self stopTimer:sender];
}
- (void)stopTimer:(id)sender {
    if ([_timer isValid]) {
        [_timer invalidate];
    }
    _timer = nil;
}

- (UIWindow *)keyWindow {
    return [[UIApplication sharedApplication] keyWindow];
}

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
           delegate:(id)delegate
       buttonTitles:(NSArray *)buttonTitles {
    self = [super initWithFrame:self.keyWindow.frame];
    
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.autoHidden = NO;
        self.title = title;
        self.message = message;
        self.buttonTitles = buttonTitles;
        self.delegate = delegate;
        [self createAlertViewHaveTextField:NO];
    }
    
    return self;
}

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
           delegate:(id)delegate
       buttonTitles:(NSArray *)buttonTitles
           isDelete:(BOOL)isDelete {
    self = [super initWithFrame:self.keyWindow.frame];
    
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.autoHidden = NO;
        self.title = title;
        self.message = message;
        self.buttonTitles = buttonTitles;
        self.delegate = delegate;
        self.isDelete = isDelete;
        [self createAlertViewHaveTextField:NO];
    }
    
    return self;
}

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
           delegate:(id)delegate
       buttonTitles:(NSArray *)buttonTitles
      haveTextField:(BOOL)haveTextField {
    self = [super initWithFrame:self.keyWindow.frame];
    
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.autoHidden = NO;
        self.title = title;
        self.message = message;
        self.buttonTitles = buttonTitles;
        self.delegate = delegate;
        [self createAlertViewHaveTextField:haveTextField];
    }
    
    return self;
}

- (id)initWithImage:(UIImage *)image
              title:(NSString *)title
            message:(NSString *)message
           delegate:(id)delegate
       buttonTitles:(NSArray *)buttonTitles {
    self = [super initWithFrame:self.keyWindow.frame];
    
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        _image = image;
        self.autoHidden = NO;
        self.title = title;
        self.message = message;
        self.buttonTitles = buttonTitles;
        self.delegate = delegate;
        [self createAlertViewHaveTextField:NO];
    }
    
    return self;
}

#pragma mark - create interface for MessageDialog

- (void)createMessageDialog:(QKAlertViewStyle)styleAlertView {
    CGFloat width = 270.0;
    
    _messageDialog = [[UIView alloc] initWithFrame:CGRectMake((self.keyWindow.frame.size.width - width) / 2, 0.0, width, 0)];
    _messageDialog.layer.cornerRadius = 6.0;
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(width / 2.0 - 22.5, 30.0, 45.0, 45.0)];
    _iconImageView.image = _image;
    
    [_messageDialog addSubview:_iconImageView];
    float y = CGRectGetMaxY(_iconImageView.frame) + 20.0;
    width = CGRectGetWidth(_messageDialog.frame) - 20;
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, y, width, 0)];
    _titleLabel.text = self.title;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.numberOfLines = 0;
    
    [_titleLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
    [_titleLabel sizeToFit];
    CGRect labelFrame = _titleLabel.frame;
    labelFrame.size.width =  width;
    _titleLabel.frame = labelFrame;
    [_messageDialog addSubview:_titleLabel];
    
    y = CGRectGetMaxY(_titleLabel.frame) + 10.0;
    _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, y, width, 0)];
    _messageLabel.text = self.message;
    _messageLabel.numberOfLines = 0;
    [_messageLabel setTextAlignment:NSTextAlignmentCenter];
    [_messageLabel setFont:[UIFont systemFontOfSize:12.0]];
    [_messageLabel sizeToFit];
    CGRect messageFrame = _messageLabel.frame;
    messageFrame.size.width =  width;
    _messageLabel.frame = messageFrame;
    
    [_messageDialog addSubview:_messageLabel];
    
    if (!_messageLabel || [_message isEqualToString:@""]) {
        y = CGRectGetMaxY(_titleLabel.frame) + 20.0;
    }
    else  y = CGRectGetMaxY(_messageLabel.frame) + 30.0;
    
    CGRect frame = _messageDialog.frame;
    frame.size.height = y;
    _messageDialog.frame = frame;
    _messageDialog.center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    
    if (styleAlertView == QKAlertViewStyleWhite) {
        [_messageDialog setBackgroundColor:[UIColor whiteColor]];
        [_titleLabel setTextColor:[UIColor darkGrayColor]];
        [_messageLabel setTextColor:[UIColor grayColor]];
    }
    else {
        [_messageDialog setBackgroundColor:[UIColor darkGrayColor]];
        [_titleLabel setTextColor:[UIColor whiteColor]];
        [_messageLabel setTextColor:[UIColor whiteColor]];
    }
    
    [self addSubview:_messageDialog];
}

#pragma mark - create interface for AlertView

- (void)createAlertViewHaveTextField:(BOOL)haveTextField {
    CGFloat width = 270.0;
    
    //init dialog
    _messageDialog = [[UIView alloc] initWithFrame:CGRectMake((self.keyWindow.frame.size.width - width) / 2, 0.0, width, 0)];
    [_messageDialog setBackgroundColor:[UIColor whiteColor]];
    _messageDialog.layer.cornerRadius = 6.0;
    
    //add image
    if (self.image) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(width / 2.0 - 22.5, 30.0, 45.0, 45.0)];
        _iconImageView.image = _image;
        
        [_messageDialog addSubview:_iconImageView];
        _yBottom = CGRectGetMaxY(_iconImageView.frame) + 20.0;
    }
    else {
        _yBottom = 30.0;
    }
    
    //title
    width = CGRectGetWidth(_messageDialog.frame) - 20;
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0,  _yBottom, width, 0)];
    _titleLabel.text = self.title;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.numberOfLines = 0;
    
    [_titleLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
    [_titleLabel sizeToFit];
    CGRect labelFrame = _titleLabel.frame;
    labelFrame.size.width =  width;
    _titleLabel.frame = labelFrame;
    [_messageDialog addSubview:_titleLabel];
    
    //add text
    _yBottom = CGRectGetMaxY(_titleLabel.frame) + 10.0;
    _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, _yBottom, width, 0)];
    _messageLabel.text = self.message;
    _messageLabel.numberOfLines = 0;
    [_messageLabel setFont:[UIFont systemFontOfSize:10.0]];
    [_messageLabel sizeToFit];
    CGRect messageFrame = _messageLabel.frame;
    messageFrame.size.width =  width;
    _messageLabel.frame = messageFrame;
    [_messageLabel setTextAlignment:NSTextAlignmentCenter];
    [_messageDialog addSubview:_messageLabel];
    if (_message == nil || [_message isEqualToString:@""]) {
        _yBottom  = CGRectGetMaxY(_messageLabel.frame) + 10.0;
        if (_image == nil) {
            _yBottom  = CGRectGetMaxY(_messageLabel.frame) + 10.0;
        }
    }
    else  _yBottom = CGRectGetMaxY(_messageLabel.frame) + 20.0;
    
    if (haveTextField) {
        _yBottom -= 5.0;
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(10, _yBottom, width, 30.0)];
        self.textField.layer.borderWidth = 1;
        self.textField.layer.borderColor = [[UIColor grayColor] CGColor];
        self.textField.layer.cornerRadius = 3.0;
        self.textField.secureTextEntry = YES;
        [_messageDialog addSubview:_textField];
        [self initializationNotification];
        _yBottom += 30.0 + 20.0;
    }
    
    [self addButtons];
    
    CGRect frame = _messageDialog.frame;
    frame.size.height = _yBottom;
    _messageDialog.frame = frame;
    _messageDialog.center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    
    [self addSubview:_messageDialog];
}

- (void)addButtons {
    UIColor *grayColor = [UIColor colorWithRed:204.0 / 255.0 green:204.0 / 255.0 blue:204.0 / 255.0 alpha:1.0];
    UIColor *greenColor = [UIColor colorWithRed:110.0 / 255.0 green:189.0 / 255.0 blue:193.0 / 255.0 alpha:1.0];
    if (self.buttonTitles.count == 0) {
        _yBottom += 20;
        return;
    }
    
    CGFloat width = CGRectGetWidth(_messageDialog.frame);
    if (self.buttonTitles.count == 1) {
        UIView *grayLine = [[UIView alloc] initWithFrame:CGRectMake(0, _yBottom, width, 1.0)];
        [grayLine setBackgroundColor:grayColor];
        [_messageDialog addSubview:grayLine];
        [self createButtonWithIndex:0];
        return;
    }
    
    if (self.buttonTitles.count == 2) {
        UIView *grayLine = [[UIView alloc] initWithFrame:CGRectMake(0, _yBottom, width, 1.0)];
        [grayLine setBackgroundColor:grayColor];
        [_messageDialog addSubview:grayLine];
        
        UIView *verticalLine = [[UIView alloc] initWithFrame:CGRectMake(width / 2, _yBottom, 1, 40.0)];
        [verticalLine setBackgroundColor:grayColor];
        [_messageDialog addSubview:verticalLine];
        
        CGFloat startX = 0;
        
        for (int i = 0; i < _buttonTitles.count; i++) {
            CGRect frameForButton = CGRectMake(startX, _yBottom, width / 2, 40.0);
            CCButtonForAlertView *button = [[CCButtonForAlertView alloc] initWithFrame:frameForButton];
            [button setTitleColor:greenColor forState:UIControlStateNormal];
            [button setTitle:self.buttonTitles[i] forState:UIControlStateNormal];
            if (i == 1) {
                if (self.isDelete == YES) {
                    [button setTitleColor:[UIColor colorWithHexString:@"#C9273B"] forState:UIControlStateNormal];
                }
            }
            if (i == 0) {
                button.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
            }
            else
                button.titleLabel.font = [UIFont systemFontOfSize:17.0];
            button.tag = i;
            [button    addTarget:self
                          action:@selector(clicked:)
                forControlEvents:UIControlEventTouchUpInside];
            
            [_messageDialog addSubview:button];
            
            startX += width / 2;
        }
        _yBottom += 40.0;
        return;
    }
    
    UIView *grayLine = [[UIView alloc] initWithFrame:CGRectMake(0, _yBottom, width, 1.0)];
    [grayLine setBackgroundColor:[UIColor grayColor]];
    [_messageDialog addSubview:grayLine];
    
    for (int i = 0; i < _buttonTitles.count; i++) {
        UIView *grayLine = [[UIView alloc] initWithFrame:CGRectMake(0, _yBottom, width, 1.0)];
        [grayLine setBackgroundColor:[UIColor grayColor]];
        [_messageDialog addSubview:grayLine];
        [self createButtonWithIndex:i];
    }
}

- (void)createButtonWithIndex:(int)i {
    CGFloat width = CGRectGetWidth(_messageDialog.frame);
    CCButtonForAlertView *button = [[CCButtonForAlertView alloc] initWithFrame:CGRectMake(0, _yBottom, width, 40.0)];
    [button setTitleColor:[UIColor colorWithRed:110.0 / 255.0 green:189.0 / 255.0 blue:193.0 / 255.0 alpha:1.0]
                 forState:UIControlStateNormal];
    if (i == 0) {
        button.titleLabel.font = [UIFont boldSystemFontOfSize:17.0];
    }
    else
        button.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [button setTitle:self.buttonTitles[i]
            forState:UIControlStateNormal];
    button.tag = i;
    [button    addTarget:self
                  action:@selector(clicked:)
        forControlEvents:UIControlEventTouchUpInside];
    [_messageDialog addSubview:button];
    _yBottom += CGRectGetHeight(button.frame);
}

#pragma mark - Hide and Show alert

- (void)showAlert {
    [self.keyWindow addSubview:self];
    self.transform = CGAffineTransformMakeScale(1.1, 1.1);
    self.alpha = 0;
    [UIView animateWithDuration:.2 animations: ^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)hideAlert {
    [UIView animateWithDuration:.2 animations: ^{
        self.transform = CGAffineTransformMakeScale(1.1, 1.1);
        self.alpha = 0.0;
    } completion: ^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

#pragma mark - Handle Action In View

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.autoHidden) {
        [self hideAlert];
        
        id <CCAlertViewDelegate> strongDelegate = self.delegate;
        
        if ([strongDelegate respondsToSelector:@selector(clickOnAlertView:)]) {
            [strongDelegate clickOnAlertView:self];
        }
    }
}

- (IBAction)clicked:(id)sender {
    UIButton *selectedButton = (UIButton *)sender;
    id <CCAlertViewDelegate> strongDelegate = self.delegate;
    
    if ([strongDelegate respondsToSelector:@selector(alertView:selectedButtonIndex:)]) {
        if ([self.textField isFirstResponder]) {
            [self.textField resignFirstResponder];
        }
        [strongDelegate alertView:self selectedButtonIndex:selectedButton.tag];
    }
    
    [self hideAlert];
}

#pragma mark - Handle Keyboard

- (void)initializationNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    [UIView animateWithDuration:0.3 animations: ^{
        CGRect frame = _messageDialog.frame;
        frame.origin.y = frame.origin.y - 100.0;
        _messageDialog.frame = frame;
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    [UIView animateWithDuration:0.3 animations: ^{
        CGRect frame = _messageDialog.frame;
        frame.origin.y = frame.origin.y + 100.0;
        _messageDialog.frame = frame;
    }];
}

@end
