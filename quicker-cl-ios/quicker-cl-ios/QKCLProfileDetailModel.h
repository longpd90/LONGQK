//
//  QKProfileDetail.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 5/13/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface QKCLProfileDetailModel : NSObject
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSDate *expireDt;
@property (strong, nonatomic) NSURL *imgPath;
@property (assign, nonatomic) NSString *activeShopId;
@property (assign, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *firstNameKana;
@property (strong, nonatomic) NSString *lastNameKana;
@property (strong, nonatomic) NSString *passwordEnterRequired;
@property (strong, nonatomic) NSString *pusnaDeviceId;
@property (strong, nonatomic) NSString *status;

- (instancetype)initWithResponse:(NSDictionary *)response;

@end
