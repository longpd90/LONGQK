//
//  QKMasterJobType.h
//  quicker-cl-ios
//
//  Created by Viet on 5/5/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum QKJobType : NSInteger {
	QKJobTypeS = 0,
	QKJobTypeL,
	QKJobTypeM
} QKJobType;


@interface QKCLMasterJobTypeModel : NSObject

@property (nonatomic, strong) NSString *jobTypeLCd;
@property (nonatomic, strong) NSString *jobTypeMCd;
@property (nonatomic, strong) NSString *jobTypeSCd;
@property (nonatomic, strong) NSString *jobTypeName;
@property (nonatomic) QKJobType jobType;

- (instancetype)initWithRespone:(NSDictionary *)response type:(QKJobType)jobType;
@end
