//
//  QKProfileDetail.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 5/13/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKProfileDetailModel.h"
#import "chiase-ios-core/NSDictionary+ParseResult.h"
#import "NSString+QKCSConvertToURL.h"

@implementation QKProfileDetailModel

- (instancetype)initWithResponse:(NSDictionary *)response {
    self = [super init];
    if (self) {
        self.lastName = [response stringForKey:@"lastName"];
        self.firstName = [response stringForKey:@"firstName"];
        self.firstNameKana = [response stringForKey:@"firstNameKana"];
        self.lastNameKana = [response stringForKey:@"lastNameKana"];
        self.userName = [response stringForKey:@"userName"];
        self.phoneNumber = [response stringForKey:@"phoneNum"];
        NSDateFormatter *sdateFormatter = [[NSDateFormatter alloc] init];
        sdateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [sdateFormatter setDateFormat:@"yyyy/dd/mm hh:mm "];
        
        self.gender = [response intForKey:@"sexFlg"];
        self.birthDay =  [sdateFormatter dateFromString:response[@"birthday"]];
        self.registCompleteDt = [response stringForKey:@"registCompleteDt" ];
        self.occupation = [response stringForKey:@"occupation"];
        self.education = [response stringForKey:@"education"];
        self.selfPromotion = [response stringForKey:@"selfPromotion"];
        self.phoneNumAuthenticated = [response stringForKey:@"phoneNumAuthenticated"];
        self.avatarURL = [[response stringForKey:@"imagePath"] convertToURL];
    }
    return self;
}

@end
