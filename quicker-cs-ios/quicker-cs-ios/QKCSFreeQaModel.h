//
//  QKCSFreeQaModel.h
//  quicker-cs-ios
//
//  Created by Nguyen Huu Anh on 8/25/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QKCSFreeQaModel : NSObject

@property (strong, nonatomic) NSString *freeQId;
@property (strong, nonatomic) NSString *question;

- (instancetype)initWithResponse:(NSDictionary *)response;

@end
