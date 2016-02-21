//
//  QKProfileDetail.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 5/13/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLProfileDetailModel.h"
#import "chiase-ios-core/NSDictionary+ParseResult.h"
#import "QKCLAPI.h"
#import "NSString+QKCLConvertToURL.h"

@implementation QKCLProfileDetailModel
//
- (instancetype)initWithResponse:(NSDictionary *)response {
    self = [super init];
    if (self) {
        self.email = response[@"email"];
        self.expireDt = [response dateForKey:@"expireDt" format:@"yyyy/MM/dd HH:mm:ss"];
        [self setImgPath:[[response stringForKey:@"imagePath"] convertToURL]];
        self.activeShopId = [response stringForKey:@"shopId"];
        self.lastName = [response stringForKey:@"lastName"];
        self.firstName = [response stringForKey:@"firstName"];
        self.firstNameKana = [response stringForKey:@"firstNameKana"];
        self.lastNameKana = [response stringForKey:@"lastNameKana"];
        self.passwordEnterRequired = [response stringForKey:@"passwordEnterRequired"];
        self.pusnaDeviceId = [response stringForKey:@"pusnaDeviceId"];
        self.status = [response stringForKey:@"status"];
    }
    return self;
}

@end
