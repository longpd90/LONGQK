//
//  QKCLShopFreeItemModel.h
//  quicker-cl-ios
//
//  Created by VietND on 8/21/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QKCLShopFreeItemModel : NSObject

@property (strong, nonatomic) NSString *freeItemJobTypeLCd;
@property (strong, nonatomic) NSString *freeItemJobTypeLNo;
@property (strong, nonatomic) NSString *freeItemJobTypeLName;
@property (strong, nonatomic) NSString *freeItemJobTypeLValue;

- (instancetype)initWithResponse:(NSDictionary *)response;

@end
