//
//  QKJobFilterModel.h
//  quicker-cs-ios
//
//  Created by Quy on 5/26/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QKRecruitmentFilterModel : NSObject
@property (strong, nonatomic) NSString *sortCd;
@property (strong, nonatomic) NSString *startDt;
@property (strong, nonatomic) NSString *endDt;
@property (strong, nonatomic) NSString *jobTypeLCd;
@property (strong, nonatomic) NSString *workAreaCd;
@property (strong, nonatomic) NSMutableArray *preferenceCdArrays;


-(instancetype)initWithResponse:(NSDictionary*)response;
@end
