//
//  QKRequestManager.m
//  quicker-cl-ios
//
//  Created by Viet on 5/14/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLRequestManager.h"
#import "QKCLConst.h"

@implementation QKCLRequestManager
+ (QKCLRequestManager *)sharedManager {
    static dispatch_once_t pred;
    static QKCLRequestManager *_sharedManager = nil;
    
    dispatch_once(&pred, ^{
        _sharedManager = [self manager];
        [_sharedManager.requestSerializer clearAuthorizationHeader];
        [_sharedManager.requestSerializer setAuthorizationHeaderFieldWithUsername:kQKBasicAuthUserName password:kQKBasicAuthPassword];
        _sharedManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _sharedManager.responseSerializer =  [AFJSONResponseSerializer serializer];
        _sharedManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"application/json", @"application/x-www-form-urlencoded", nil];
        [_sharedManager.requestSerializer setTimeoutInterval:300];
    });
    return _sharedManager;
}

@end
