//
//  QKSignUpModel.h
//  quicker-cl-ios
//
//  Created by Viet on 6/9/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QKCLSignUpModel : NSObject
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *firstNameKana;
@property (strong, nonatomic) NSString *lastNameKana;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *password;
@end
