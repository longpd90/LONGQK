//
//  QKCLWorkerFavoriteModel.m
//  quicker-cl-ios
//
//  Created by Quy on 8/3/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLWorkerFavoriteModel.h"
#import "NSString+QKCLConvertToURL.h"

@implementation QKCLWorkerFavoriteModel

- (instancetype)initWithResponse:(NSDictionary *)response {
    self = [super init];
    if (self) {
        self.userId = [response stringForKey:@"userId"];
        
        self.lastName = [response stringForKey:@"lastName"];
        self.firstName = [response stringForKey:@"firstName"];
        self.lastNameKana = [response stringForKey:@"lastNameKana"];
        self.firstNameKana = [response stringForKey:@"firstNameKana"];
        self.imagePath = [[response stringForKey:@"adoptionUserImagePath"] convertToURL];
        self.birthday = [response dateForKey:@"birthday" format:@"yyy-MM-dd"];
        self.sexFlg = [response stringForKey:@"sexFlg"];
        self.sexFlgName = [response stringForKey:@"sexFlgName"];
        self.status = [response stringForKey:@"status"];
    }
    return self;
}

@end
