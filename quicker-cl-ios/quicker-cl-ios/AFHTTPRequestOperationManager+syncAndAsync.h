//
//  AFHTTPRequestOperationManager+syncAndAsync.h
//  quicker-cl-ios
//
//  Created by Viet on 5/6/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
#import "CCAlertView.h"

@interface AFHTTPRequestOperationManager (sync) <CCAlertViewDelegate>
- (BOOL)syncGET:(NSString *)URLString parameters:(NSDictionary *)parameters response:(NSDictionary **)responseData error:(NSError *__autoreleasing *)outError showLoading:(BOOL)isLoading showError:(BOOL)isError;

- (AFHTTPRequestOperation *)asyncGET:(NSString *)URLString parameters:(id)parameters showLoading:(BOOL)isLoading showError:(BOOL)isError success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (BOOL)syncPOST:(NSString *)URLString parameters:(NSDictionary *)parameters response:(NSDictionary **)responseData error:(NSError *__autoreleasing *)outError showLoading:(BOOL)isLoading showError:(BOOL)isError;

- (AFHTTPRequestOperation *)asyncPOST:(NSString *)URLString parameters:(id)parameters showLoading:(BOOL)isLoading showError:(BOOL)isError success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (AFHTTPRequestOperation *)asyncPOST:(NSString *)URLString parameters:(id)parameters showLoading:(BOOL)isLoading showError:(BOOL)isError constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> ))block success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


@end
