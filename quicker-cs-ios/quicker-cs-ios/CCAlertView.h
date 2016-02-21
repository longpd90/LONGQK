//
//  CCAlertView.h
//  chiase-ios-core
//
//  Created by Nguyen Huu Anh on 4/15/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "chiase-ios-core/UIView+Extra.h"

typedef enum {
    QKAlertViewStyleWhite = 0,
    QKAlertViewStyleBlack
} QKAlertViewStyle;

@protocol CCAlertViewDelegate;

@interface CCAlertView : UIView
@property (nonatomic, weak) id <CCAlertViewDelegate> delegate;
@property (assign, nonatomic) BOOL autoHidden;
@property (strong, nonatomic) UITextField *textField;
@property (assign, nonatomic) UIImage *image;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) UILabel *messageLabel;
@property (strong, nonatomic) NSArray *buttonTitles;
@property (copy, nonatomic) UIWindow *keyWindow;
@property (nonatomic) BOOL isDelete;

- (id)initWithImage:(UIImage *)image
              title:(NSString *)title
         andMessage:(NSString *)message
              style:(QKAlertViewStyle)alertViewStyle;

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
           delegate:(id)delegate
       buttonTitles:(NSArray *)buttonTitles;

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
           delegate:(id)delegate
       buttonTitles:(NSArray *)buttonTitles
           isDelete:(BOOL)isDelete;

- (id)initWithImage:(UIImage *)image
              title:(NSString *)title
            message:(NSString *)message
           delegate:(id)delegate
       buttonTitles:(NSArray *)buttonTitles;

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
           delegate:(id)delegate
       buttonTitles:(NSArray *)buttonTitles
      haveTextField:(BOOL)haveTextField;

- (void)showAlert;
- (void)hideAlert;

@end
@protocol CCAlertViewDelegate <NSObject>
@optional
- (void)clickOnAlertView:(CCAlertView *)alertView;
- (void)alertView:(CCAlertView *)alertView selectedButtonIndex:(NSInteger)index;
@end
