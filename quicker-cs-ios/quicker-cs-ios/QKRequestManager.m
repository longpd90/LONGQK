//
//  QKRequestManager.m
//  quicker-cl-ios
//
//  Created by Viet on 5/14/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKRequestManager.h"
#import "QKConst.h"

@implementation QKRequestManager
+ (QKRequestManager *)sharedManager {
	static dispatch_once_t pred;
	static QKRequestManager *_sharedManager = nil;

	dispatch_once(&pred, ^{
		_sharedManager = [self manager];
		[_sharedManager.requestSerializer clearAuthorizationHeader];
		[_sharedManager.requestSerializer setAuthorizationHeaderFieldWithUsername:kQKBasicAuthUserName password:kQKBasicAuthPassword];
		_sharedManager.requestSerializer = [AFHTTPRequestSerializer serializer];
		_sharedManager.responseSerializer =  [AFJSONResponseSerializer serializer];
		_sharedManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"application/json", @"application/x-www-form-urlencoded", nil];
	});
	return _sharedManager;
}

@end
