//
//  QKViewController.h
//  quicker-cl-ios
//
//  Created by LongPD-PC on 4/14/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKCLGlobalDefines.h"
#import "QKGlobalButton.h"
#import "QKGlobalTextField.h"
#import "chiase-ios-core/UIView+Extra.h"
#import "CCAlertView.h"
#import "chiase-ios-core/CCStringUtil.h"
#import "chiase-ios-core/NSDictionary+ParseResult.h"
#import "chiase-ios-core/NSString+Extra.h"
#import "chiase-ios-core/UIColor+Extra.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "QKCLConst.h"
#import "QKCLAPI.h"
#import "AFHTTPRequestOperationManager+syncAndAsync.h"
#import "NSMutableDictionary+initWithApiKey.h"
#import "QKCLAccessUserDefaults.h"
#import "QKCLRequestManager.h"
#import "SWRevealViewController.h"
#import "QKCSNoInternetView.h"
#import "QKF5Label.h"
#import "QKF1Label.h"
#import "QKF2Label.h"
#import "QKF3Label.h"
#import "QKF4Label.h"
#import "QKF10Label.h"
#import "QKF20Label.h"
#import "QKF30Label.h"
#import "QKF40Label.h"
#import "QKF20Label.h"
#import "QKF21Label.h"
#import "QKF22Label.h"
#import "QKF30Label.h"
#import "QKF40Label.h"
#import "QKF41Label.h"
#import "QKF42Label.h"
#import "QKF43Label.h"
#import "QKF50Label.h"
#import "QKF51Label.h"
#import "QKF52Label.h"
#import "QKCLEncryptUtil.h"
#import "UIView+customView.h"
#import "QKGlobalTextButton.h"
#import "QKGlobalTextView.h"
#import "NSDate+Extra.h"
#import "NSString+QKCLConvertToURL.h"
#import "QKCLTableView.h"
#import "NSNumber+QKCLConvertToCurrency.h"

@interface QKCLBaseViewController : UIViewController


//Navigation bar: set bar button and bar title
- (void)setLeftBarButtonWithTitle:(NSString *)buttonTitle target:(SEL)action;
- (void)setLeftBarButtonWithImage:(UIImage *)image1 hightlight:(UIImage *)image2 target:(id)target action:(SEL)action;
- (void)setLeftBarButtonWithButton:(NSString *)buttonTitle target:(SEL)action;
- (void)setRightBarButtonWithButton:(NSString *)buttonTitle target:(SEL)action;
- (void)setRightBarButtonWithTitle:(NSString *)buttonTitle target:(SEL)action;

- (void)setLeftBarButtonWithImage:(UIImage *)image1
                       hightlight:(UIImage *)image2
                            title:(NSString *)title
                           target:(id)target
                           action:(SEL)action;

- (void)setAngleLeftBarButton;

- (void)setNavigationBarWithTitle:(NSString *)title andSubTitle:(NSString *)subTitle;

//Action
- (void)goBack:(id)sender;

//check internet
- (BOOL)connected;
- (void)showNoInternetViewWithSelector:(SEL)selector;

//call center
- (void)callCenter;
@end
