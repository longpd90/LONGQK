//
//  QKMasterJobType.m
//  quicker-cl-ios
//
//  Created by Viet on 5/5/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLMasterJobTypeModel.h"

@implementation QKCLMasterJobTypeModel


- (instancetype)initWithRespone:(NSDictionary *)response type:(QKJobType)jobType {
    self = [super init];
    if (self) {
        switch (jobType) {
            case QKJobTypeL: {
                self.jobTypeLCd = response[@"jobTypeLCd"];
                self.jobTypeName = response[@"jobTypeLName"];
                break;
            }
                
            case QKJobTypeM: {
                self.jobTypeLCd = response[@"jobTypeLCd"];
                self.jobTypeMCd = response[@"jobTypeMCd"];
                self.jobTypeName = response[@"jobTypeMName"];
                break;
            }
                
            case QKJobTypeS: {
                self.jobTypeLCd = response[@"jobTypeLCd"];
                self.jobTypeMCd = response[@"jobTypeMCd"];
                self.jobTypeSCd = response[@"jobTypeSCd"];
                self.jobTypeName = response[@"jobTypeSName"];
                break;
            }
                
            default:
                break;
        }
    }
    return self;
}

@end
