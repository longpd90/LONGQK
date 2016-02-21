//
//  QKAdoptionUserModel.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 7/15/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "chiase-ios-core/NSDictionary+ParseResult.h"

@interface QKCLAdoptionUserModel : NSObject

@property (strong, nonatomic) NSString *adoptionUserId;
@property (strong, nonatomic) NSString *adoptionUserFirstName;
@property (strong, nonatomic) NSString *adoptionUserLastName;
@property (strong, nonatomic) NSString *adoptionUserName;
@property (strong, nonatomic) NSDate *adoptionUserBirthday;
@property (strong, nonatomic) NSURL *adoptionUserImagePath;
@property (assign, nonatomic) NSString *adoptionUserAccountSexFlg;
@property (strong, nonatomic) NSString *adoptionUserAccountSexFlgName;
@property (strong, nonatomic) NSString *adoptionUserAccountStatus;
@property (strong, nonatomic) NSDate *adoptionDt;
@property (assign, nonatomic) NSInteger messageNum;
@property (strong,nonatomic) NSString *adoptionUserAge;

@property (strong,nonatomic) NSString *workActualStatus;
@property (strong,nonatomic) NSString *employmentStatus;
@property (nonatomic) BOOL favoriteCustomerF;

- (instancetype)initWithData:(NSDictionary *)data;

@end
