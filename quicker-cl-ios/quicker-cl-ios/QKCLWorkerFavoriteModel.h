//
//  QKCLWorkerFavoriteModel.h
//  quicker-cl-ios
//
//  Created by Quy on 8/3/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "chiase-ios-core/NSDictionary+ParseResult.h"
@interface QKCLWorkerFavoriteModel : NSObject
@property (nonatomic , strong) NSString *userId;
@property (nonatomic , strong) NSString *lastName;
@property (nonatomic , strong) NSString *firstName;
@property (nonatomic , strong) NSString *lastNameKana;
@property (nonatomic , strong) NSString *firstNameKana;
@property (nonatomic , strong) NSURL    *imagePath;
@property (nonatomic , strong) NSDate   *birthday;
@property (nonatomic , strong) NSString *sexFlg;
@property (nonatomic , strong) NSString *sexFlgName;
@property (nonatomic , strong) NSString *status;

- (instancetype)initWithResponse:(NSDictionary*)response;
@end
