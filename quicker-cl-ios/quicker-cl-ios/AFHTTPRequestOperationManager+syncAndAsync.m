//
//  AFHTTPRequestOperationManager+syncAndAsync.m
//  quicker-cl-ios
//
//  Created by Viet on 5/6/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "AFHTTPRequestOperationManager+syncAndAsync.h"
#import "chiase-ios-core/NSString+Extra.h"
#import "QKCLConst.h"
#import "AppDelegate.h"
#import "QKCLBigLoadingView.h"
#import "QKCLAccessUserDefaults.h"
#import "QKCLLocalNotificationManager.h"

@implementation AFHTTPRequestOperationManager (sync)
- (id)synchronouslyPerformMethod:(NSString *)method
                       URLString:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                       operation:(AFHTTPRequestOperation *__autoreleasing *)operationPtr
                           error:(NSError *__autoreleasing *)outError {
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
    
    
    AFHTTPRequestOperation *op = [self HTTPRequestOperationWithRequest:request
                                                               success:nil
                                                               failure:nil];
    
    
    [op start];
    [op waitUntilFinished];
    
    if (operationPtr != nil) *operationPtr = op;
    
    // Must call responseObject before checking the error
    id responseObject = [op responseObject];
    if (outError != nil) *outError = [op error];
    
    return responseObject;
}

- (BOOL)syncGET:(NSString *)URLString
     parameters:(NSDictionary *)parameters
       response:(NSDictionary **)responseData
          error:(NSError *__autoreleasing *)outError showLoading:(BOOL)isLoading showError:(BOOL)isError {
    QKCLBigLoadingView *indicator;
    if (isLoading) {
        indicator = [[QKCLBigLoadingView alloc] initHUDView];
        [indicator showIndicator];
    }
    AFHTTPRequestOperation *operationPtr;
    NSDictionary *data = (NSDictionary *)[self synchronouslyPerformMethod:@"GET" URLString:URLString parameters:parameters operation:&operationPtr error:outError];
    *responseData = nil;
    *responseData = data;
    if (isLoading) {
        [indicator hideIndicator];
    }
    if (![data[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
        [self checkVersion:data[QK_API_STATUS_CODE]];
        [self checkInvalidAccount:data];
        if (isError) {
            [self showError:data];
        }
        return NO;
    }
    return YES;
}

//- (AFHTTPRequestOperation *)asyncGET:(NSString *)URLString parameters:(id)parameters showLoading:(BOOL)isLoading showError:(BOOL)isError success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure

- (AFHTTPRequestOperation *)asyncGET:(NSString *)URLString parameters:(id)parameters showLoading:(BOOL)isLoading showError:(BOOL)isError success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    QKCLBigLoadingView *indicator;
    if (isLoading) {
        indicator = [[QKCLBigLoadingView alloc] initHUDView];
        [indicator showIndicator];
    }
    return [self GET:URLString parameters:parameters success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation, responseObject);
        if (isLoading) {
            [indicator hideIndicator];
        }
        if (![responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
            [self checkVersion:responseObject[QK_API_STATUS_CODE]];
            [self checkInvalidAccount:responseObject];
            if (isError) {
                [self showError:responseObject];
            }
        }
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation, error);
        if (isLoading) {
            [indicator hideIndicator];
        }
    }];
}

- (BOOL)syncPOST:(NSString *)URLString
      parameters:(NSDictionary *)parameters
        response:(NSDictionary **)responseData
           error:(NSError *__autoreleasing *)outError showLoading:(BOOL)isLoading showError:(BOOL)isError {
    QKCLBigLoadingView *indicator;
    if (isLoading) {
        indicator = [[QKCLBigLoadingView alloc] initHUDView];
        [indicator showIndicator];
    }
    AFHTTPRequestOperation *operationPtr;
    NSDictionary *data = (NSDictionary *)[self synchronouslyPerformMethod:@"POST" URLString:URLString parameters:parameters operation:&operationPtr error:outError];
    *responseData = nil;
    *responseData = data;
    if (isLoading) {
        [indicator hideIndicator];
    }
    
    if (![data[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
        [self checkVersion:data[QK_API_STATUS_CODE]];
        [self checkInvalidAccount:data];
        if (isError) {
            [self showError:data];
        }
        return NO;
    }
    return YES;
}

- (AFHTTPRequestOperation *)asyncPOST:(NSString *)URLString parameters:(id)parameters showLoading:(BOOL)isLoading showError:(BOOL)isError success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure  {
    QKCLBigLoadingView *indicator;
    if (isLoading) {
        indicator = [[QKCLBigLoadingView alloc] initHUDView];
        [indicator showIndicator];
    }
    return [self POST:URLString parameters:parameters success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation, responseObject);
        if (isLoading) {
            [indicator hideIndicator];
        }
        
        if (![responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
            [self checkVersion:responseObject[QK_API_STATUS_CODE]];
            [self checkInvalidAccount:responseObject];
            if (isError) {
                [self showError:responseObject];
            }
        }
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation, error);
        if (isLoading) {
            [indicator hideIndicator];
        }
    }];
}

- (AFHTTPRequestOperation *)asyncPOST:(NSString *)URLString parameters:(id)parameters showLoading:(BOOL)isLoading showError:(BOOL)isError constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> fromdata))block success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure  {
    QKCLBigLoadingView *indicator;
    if (isLoading) {
        indicator = [[QKCLBigLoadingView alloc] initHUDView];
        [indicator showIndicator];
    }
    return [self POST:URLString parameters:parameters constructingBodyWithBlock: ^(id < AFMultipartFormData > formData) {
        block(formData);
    } success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation, responseObject);
        if (isLoading) {
            [indicator hideIndicator];
        }
        
        if (![responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
            [self checkVersion:responseObject[QK_API_STATUS_CODE]];
            [self checkInvalidAccount:responseObject];
            if (isError) {
                [self showError:responseObject];
            }
        }
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation, error);
        if (isLoading) {
            [indicator hideIndicator];
        }
    }];
}

#pragma mark - Check version
- (void)checkVersion:(NSString *)statusCd {
    if ([[NSString stringFromConst:QK_STT_CODE_NEW_VERSION] isEqualToString:statusCd]) {
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate moveToUpgradeVersionScreen];
    }
}

#pragma mark -Check accessToken
- (void)checkInvalidAccount:(NSDictionary *)responseObject {
    NSArray *statusArrays = @[QK_STT_CODE_ACCESSTOKEN_INVALID,
                              QK_STT_CODE_ACCESSTOKEN_EXPIRED,
                              QK_STT_CODE_ACCOUNT_INVALID,
                              QK_STT_CODE_SHOP_STOP,
                              QK_STT_CODE_SHOP_CLOSE
                              ];
    if ([statusArrays containsObject:responseObject[QK_API_STATUS_CODE]]) {
        CCAlertView *alertView = [[CCAlertView alloc]initWithTitle:responseObject[@"title"] message:responseObject[@"msg"] delegate:self buttonTitles:[NSArray arrayWithObjects:@"OK", nil]];
        [alertView showAlert];
    }
}

#pragma mark - CCAlertViewDelegate
- (void)alertView:(CCAlertView *)alertView selectedButtonIndex:(NSInteger)index {
    if (index == 0) {
        [QKCLAccessUserDefaults clear];
        [QKCLLocalNotificationManager cancelAllLocalNotification];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        UIViewController *mainMenuNavigationViewController = [storyboard instantiateViewControllerWithIdentifier:@"QKNavigationSigninViewController"];
        window.rootViewController = mainMenuNavigationViewController;
        [window makeKeyAndVisible];
    }
}

#pragma mark-Error
- (void)showError:(NSDictionary *)responseObject {
    NSString *title = responseObject[@"title"];
    NSString *msg =responseObject[@"msg"];
    NSArray *errors = responseObject[@"errors"];
    for (NSDictionary *error in errors) {
        msg = [NSString stringWithFormat:@"%@\n%@",msg, error[@"message"]];
    }
    UIAlertView *errorAlertView = [[UIAlertView alloc]initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlertView show];
}

@end
