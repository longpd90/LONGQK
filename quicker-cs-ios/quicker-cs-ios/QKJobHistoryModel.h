//
//  QKJobHistoryModel.h
//  quicker-cs-ios
//
//  Created by LongPD-PC on 5/27/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QKJobTileModel.h"
@interface QKJobHistoryModel : NSObject

@property(strong, nonatomic) QKJobTileModel *jobtypeL;
@property(strong, nonatomic) QKJobTileModel *jobtypeM;
@property(strong, nonatomic) QKJobTileModel *jobtypeS;
@property(strong, nonatomic) NSString *jobContent;
@property(strong, nonatomic) NSString *jobPeriod;
@property(strong, nonatomic) NSString *jobID;

- (instancetype)initWithResponse:(NSDictionary *)response ;

@end
