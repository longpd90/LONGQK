//
//  QKCSTableViewController.h
//  quicker-cs-ios
//
//  Created by LongPD-PC on 5/22/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QKGlobalDefines.h"

#import "chiase-ios-core/UIView+Extra.h"
#import "chiase-ios-core/CCDateUtil.h"
#import "QKAccessUserDefaults.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "QKConst.h"
#import "QKAPI.h"
#import "AFHTTPRequestOperationManager+syncAndAsync.h"
#import "QKRequestManager.h"
#import "NSMutableDictionary+initWithApiKey.h"
#import "NSDate+Extra.h"

#import "QKGlobalButton.h"
#import "QKGlobalTextField.h"
#import "CCAlertView.h"
#import "QKF1Label.h"
#import "QKF2Label.h"
#import "QKF3Label.h"
#import "QKF4Label.h"
#import "QKF5Label.h"
#import "QKF6Label.h"
#import "QKF7Label.h"
#import "QKF8Label.h"
#import "QKF9Label.h"
#import "QKF10Label.h"
#import "QKF20Label.h"
#import "QKF21Label.h"
#import "QKF30Label.h"
#import "QKF31Label.h"
#import "QKF32Label.h"
#import "QKF33Label.h"
#import "QKF34Label.h"
#import "QKF35Label.h"
#import "QKF36Label.h"
#import "QKF37Label.h"
#import "QKF38Label.h"
#import "QKF39Label.h"
#import "QKF41Label.h"
#import "QKF42Label.h"
#import "QKF43Label.h"
#import "QKF44Label.h"
#import "QKF45Label.h"
#import "QKF51Label.h"
#import "QKF52Label.h"
#import "QKF53Label.h"
#import "QKF54Label.h"
#import "QKF55Label.h"
#import "QKF56Label.h"
#import "QKF57Label.h"
#import "QKF58Label.h"
#import "QKF59Label.h"
#import "QKF60Label.h"
#import "QKF70Label.h"
#import "QKF71Label.h"
#import "QKF72Label.h"
#import "QKF81Label.h"
#import "QKF82Label.h"
#import "QKF90Label.h"
#import "QKF91Label.h"
#import "QKGlobalTextButton.h"
#import "QKCSImageView.h"
#import "UIView+customView.h"
#import "QKCSNoInternetView.h"
#import "QKGlobalErrorLabel.h"
#import "NSString+QKCSConvertToURL.h"

@interface QKCSTableViewController : UITableViewController

- (void)goBack:(id)sender;
- (void)setWhiteTitle:(NSString *)title;

- (void)setAngleLeftBarButton;
- (void)setRightBarButtonWithTitle:(NSString *)buttonTitle target:(SEL)action;
- (void)setLeftBarButtonWithTitle:(NSString *)buttonTitle target:(SEL)action;
- (void)setLeftBarButtonWithImage:(UIImage *)image1
                       hightlight:(UIImage *)image2
                            title:(NSString *)title
                           target:(SEL)action;
//check internet
- (BOOL)connected;
- (void)showNoInternetViewWithSelector:(SEL)selector;

//call center
- (void)callCenter;

//caculate height of cell
- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell inTableView:(UITableView *)tableView;
@end
