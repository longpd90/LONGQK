//
//  QKRelShopUser.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 6/11/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QKCLRelShopUserModel : NSObject
@property (strong, nonatomic) NSURL *imageUrl;
@property (strong, nonatomic) NSString *shopUserRole;
@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;

- (instancetype)initWithResponse:(NSDictionary *)response;

@end
