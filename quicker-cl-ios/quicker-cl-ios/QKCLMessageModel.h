//
//  QKMessageModel.h
//  quicker-cl-ios
//
//  Created by Viet on 7/7/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QKCLMessageModel : NSObject

@property (strong, nonatomic) NSString *messageId;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSString *messageType;
@property (strong, nonatomic) NSString *preLDelF;
@property (strong, nonatomic) NSString *fromUserId;
@property (strong, nonatomic) NSString *fromUserName;
@property (strong, nonatomic) NSURL *fromUserImagePath;
@property (strong, nonatomic) NSDate *createDt;
@property (nonatomic) BOOL readF;
@property (nonatomic) BOOL isDate;

- (instancetype)initWithResponse:(NSDictionary *)response;
@end
