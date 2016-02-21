//
//  QKJobModelCondition.h
//  quicker-cs-ios
//
//  Created by Quy on 5/22/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QKMasterPreferenceConditionModel : NSObject
@property (strong, nonatomic) NSString *preferenceConditionCd;
@property (strong, nonatomic) NSString *preferenceConditionName;
@property (strong, nonatomic) NSURL *preferenceConditionImagePath;

- (instancetype)initWithResponse:(NSDictionary *)response;
@end
