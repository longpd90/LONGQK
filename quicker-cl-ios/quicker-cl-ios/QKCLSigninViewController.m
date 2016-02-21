//
//  QKSigninViewController.m
//  quicker-cl-ios
//
//  Created by Viet on 6/4/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLSigninViewController.h"
#import "AppDelegate.h"

@interface QKCLSigninViewController () <UITextFieldDelegate>

@end

@implementation QKCLSigninViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _errorLabel.hidden = YES;
    [_signinButton setEnabled:NO];
    
    //set keyboard
    [_emailTextField setInputMode:InputModeEnglish];
    [_passwordTextField setInputMode:InputModeEnglish];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

- (IBAction)signinClicked:(id)sender {
    //success
    if ([self connected]) {
        NSLog(@"Sign in...");
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKey];
        [params setValue:_emailTextField.text forKey:@"email"];
        [params setValue:[QKCLEncryptUtil encyptBlowfish:_passwordTextField.text] forKey:@"password"];
        
        [[QKCLRequestManager sharedManager] asyncPOST:[NSString stringFromConst:qkUrlAccountLogin] parameters:params showLoading:YES showError:NO success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                NSLog(@"Sign in successful...");
                
                [self setDefaults:responseObject];
                
                UIViewController *mainMenuNavigationViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
                [[UIApplication sharedApplication] keyWindow].rootViewController = mainMenuNavigationViewController;
                
                //check shop status
                [self checkShopStatus:responseObject[@"shopStatusList"]];
            }
            else {
                //check status code and return screen
                NSArray *statusCodeArrays = @[QK_STT_CODE_NEW_VERSION,
                                              QK_STT_CODE_ACCOUNT_STOP,
                                              QK_STT_CODE_ACCOUNT_CLOSE,
                                              QK_STT_CODE_SHOP_STOP,
                                              QK_STT_CODE_SHOP_CLOSE];
                if ([statusCodeArrays containsObject:responseObject[QK_API_STATUS_CODE]]) {
                    //set defaults
                    [self setDefaults:responseObject];
                    
                    //move to screen
                    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                    [appDelegate moveToScreen:responseObject[QK_API_STATUS_CODE] shopStatus:[NSString stringFromConst:QK_SHOP_STATUS_PUBLIC] shopId:@"1"];
                }
                else {
                    NSLog(@"Sign in fail...");
                    _errorLabel.hidden = NO;
                    _errorLabel.text = responseObject[@"msg"];
                }
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error:%@", error);
        }];
    }
    else {
        [self showNoInternetViewWithSelector:nil];
    }
}

- (void)checkShopStatus:(NSArray *)shopStatusList {
    NSInteger shopCount = [shopStatusList count];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if (shopCount > 0) {
        //move to main menu
        UIViewController *mainMenuNavigationViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
        [[UIApplication sharedApplication] keyWindow].rootViewController = mainMenuNavigationViewController;
        [[[UIApplication sharedApplication] keyWindow] makeKeyWindow];
        
        NSDictionary *activeShop = [shopStatusList objectAtIndex:0];
        [appDelegate moveToScreen:[NSString stringFromConst:QK_STT_CODE_SUCCESS] shopStatus:activeShop[@"shopStatus"] shopId:activeShop[@"shopId"]];
    }
    else {
        //add shop
        [appDelegate moveToScreen:[NSString stringFromConst:QK_STT_CODE_SUCCESS] shopStatus:[NSString stringFromConst:QK_SHOP_STATUS_PUBLIC] shopId:nil];
    }
}

- (IBAction)valueChanged:(id)sender {
    if (![_emailTextField.text isEqualToString:@""] && ![_passwordTextField.text isEqualToString:@""]) {
        [_signinButton setEnabled:YES];
    }
    else {
        [_signinButton setEnabled:NO];
    }
}

- (IBAction)forgetPassButtonClicked:(id)sender {
    [self.parentViewController performSegueWithIdentifier:@"QKForgetPasswordSeque" sender:self.parentViewController];
}

#pragma mark -Actions
- (void)setDefaults:(NSDictionary *)response {
    [QKCLAccessUserDefaults setUserId:[response valueForKey:@"userId"]];
    [QKCLAccessUserDefaults setMail:_emailTextField.text];
    [QKCLAccessUserDefaults setToken:[response valueForKey:@"accessToken"]];
    [QKCLAccessUserDefaults setExpireDate:[response valueForKey:@"expireDt"]];
    [QKCLAccessUserDefaults setPusnaDeviceId:[response valueForKey:@"pusnaDeviceId"]];
}

#pragma mark -UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _emailTextField) {
        [_passwordTextField becomeFirstResponder];
    }
    else if (textField == _passwordTextField) {
        [_passwordTextField resignFirstResponder];
    }
    return YES;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
