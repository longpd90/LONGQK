//
//  QKJobModelCondition.h
//  quicker-cs-ios
//
//  Created by Quy on 5/22/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QKCLMasterPreferenceConditionModel : NSObject
@property (strong, nonatomic) NSString *preferenceConditionCd;
@property (strong, nonatomic) NSString *preferenceConditionName;

- (instancetype)initWithResponse:(NSDictionary *)response;
@end
