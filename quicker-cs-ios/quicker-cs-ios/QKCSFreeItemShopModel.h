//
//  QKCSFreeItemShopModel.h
//  quicker-cs-ios
//
//  Created by C Anh on 8/26/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QKCSFreeItemShopModel : NSObject
@property (strong, nonatomic) NSString *freeItemJobTypeLCd;
@property (strong, nonatomic) NSString *freeItemJobTypeLNo;
@property (strong, nonatomic) NSString *freeItemJobTypeLName;
@property (strong, nonatomic) NSString *freeItemJobTypeLValue;

- (instancetype)initWithResponse:(NSDictionary *)response;
@end
