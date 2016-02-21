//
//  QKAddShopExaminationViewController.h
//  quicker-cl-ios
//
//  Created by Viet on 5/6/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseViewController.h"

@interface QKCLShopExaminatingViewController : QKCLBaseViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet QKGlobalTextButton *tab1Button;
@property (weak, nonatomic) IBOutlet QKGlobalTextButton *tab2Button;
@property (weak, nonatomic) IBOutlet UIView *footerView1;
@property (weak, nonatomic) IBOutlet UIView *footerView2;
- (IBAction)tab1Clicked:(id)sender;
- (IBAction)tab2Clicked:(id)sender;

@end
