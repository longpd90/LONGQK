//
//  QKCLWorkerYearModel.h
//  quicker-cl-ios
//
//  Created by Quy on 7/30/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QKCLWorkerMonthModel.h"
#import "chiase-ios-core/NSDictionary+ParseResult.h"
@interface QKCLWorkerYearModel : NSObject

@property (strong,nonatomic) NSString *year;

@property (strong,nonatomic) NSMutableArray *monthList;

-(instancetype)initWithResonponse:(NSDictionary*)response;
@end
