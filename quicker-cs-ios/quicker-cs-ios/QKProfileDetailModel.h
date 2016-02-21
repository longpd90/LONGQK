//
//  QKProfileDetail.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 5/13/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface QKProfileDetailModel : NSObject

@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *firstNameKana;
@property (strong, nonatomic) NSString *lastNameKana;
@property (strong, nonatomic) NSString *phoneNumber;
@property (strong, nonatomic) NSDate *birthDay;
@property (strong, nonatomic) NSString *occupation;
@property (assign, nonatomic) NSInteger gender;
@property (strong,nonatomic) NSString *registCompleteDt;
@property (strong,nonatomic) NSString *phoneNumAuthenticated;
@property (strong,nonatomic) NSString *education;
@property (strong,nonatomic) NSString *selfPromotion;
@property (strong,nonatomic) NSURL *avatarURL;

- (instancetype)initWithResponse:(NSDictionary *)response;

@end
