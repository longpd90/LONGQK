//
//  QKShopInfoModel.m
//  quicker-cl-ios
//
//  Created by Quy on 5/15/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKShopInfoModel.h"
#import "chiase-ios-core/NSDictionary+ParseResult.h"
#import "QKConst.h"
#import "QKAPI.h"
#import "QKCSFreeItemShopModel.h"
@implementation QKShopInfoModel

- (instancetype)initWithResponse:(NSDictionary *)response {
    self = [super init];
    if (self) {
        self.abbreviatedTitle = [response stringForKey:@"abbreviatedTitle"];
        self.abbreviatedTitleKana = [response stringForKey:@"abbreviatedTitleKana"];
        
        self.shopId = [response stringForKey:@"shopId"];
        self.name = [response stringForKey:@"name"];
        self.nameKana = [response stringForKey:@"nameKana"];
        self.companyName = [response stringForKey:@"companyName"];
        self.phoneNum = [response stringForKey:@"phoneNum"];
        self.shopDescription = [response stringForKey:@"description"];
        self.accessWay = [response stringForKey:@"accessWay"];
        self.jobTypeLCd = [response stringForKey:@"jobTypeLCd"];
        self.jobTypeLName = [response stringForKey:@"jobTypeLName"];
        self.jobTypeMCd = [response stringForKey:@"jobTypeMCd"];
        self.jobTypeMName = [response stringForKey:@"jobTypeMName"];
        self.addressPrfJisCd = [response stringForKey:@"addressPrfJisCd"];
        self.addressPrfName = [response stringForKey:@"addressPrfName"];
        self.addressCityJisCd = [response stringForKey:@"addressCityJisCd"];
        self.addressCityName = [response stringForKey:@"addressCityName"];
        self.address1 = [response stringForKey:@"address1"];
        self.address2 = [response stringForKey:@"address2"];
        self.adoptionRecord = [response intForKey:@"adoptionRecord"];
        self.availableAmount = [response intForKey:@"availableAmount"];
        self.classificationCd = [response stringForKey:@"classificationCd"];
        self.companyAddress1 = [response stringForKey:@"companyAddress1"];
        self.companyAddress2 = [response stringForKey:@"companyAddress2"];
        self.companyAddressCityJisCd = [response stringForKey:@"companyAddressCityJisCd"];
        self.companyAddressCityName = [response stringForKey:@"companyAddressCityName"];
        self.companyAddressPrfJisCd = [response stringForKey:@"companyAddressPrfJisCd"];
        self.companyAddressPrfName = [response stringForKey:@"companyAddressPrfName"];
        self.companyNameKana = [response stringForKey:@"companyNameKana"];
        self.companyPostcd = [response stringForKey:@"companyPostcd"];
        self.favoriteNum = [response intForKey:@"favoriteNum"];
        self.latLng = [response stringForKey:@"latLng"];
        if (self.latLng.length <= 1) {
            self.latLng = @"0,0";
        }
        self.paymentSystemType = [response stringForKey:@"paymentSystemType"];
        self.personInCharge = [response stringForKey:@"personInCharge"];
        self.postcd = [response stringForKey:@"postcd"];
        self.pushStatus = [response stringForKey:@"pushStatus"];
        self.statusCd = [response stringForKey:@"statusCd"];
        self.tradeNameCd = [response stringForKey:@"tradeNameCd"];
        self.tradeNamePosition = [response stringForKey:@"tradeNamePosition"];
        self.unreadNoticeNum = [response intForKey:@"unreadNoticeNum"];
        self.imageFileList = [[NSMutableArray alloc] init];
        for (NSDictionary *eachImage in[response objectForKey:@"imageFileList"]) {
            QKImageModel *model = [[QKImageModel alloc] initWithImageData:eachImage];
            
            [self.imageFileList addObject:model];
        }
        self.shopStatus = [response stringForKey:@"shopStatus"];
        self.wayside1 = [response stringForKey:@"wayside1"];
        self.wayside2 = [response stringForKey:@"wayside2"];
        self.wayside3 = [response stringForKey:@"wayside3"];
        
        self.freeItemList = [[NSMutableArray alloc] init];
        for (NSDictionary *freeItem in[response objectForKey:@"freeItemList"]) {
            QKCSFreeItemShopModel *model = [[QKCSFreeItemShopModel alloc] initWithResponse:freeItem];
            [self.freeItemList addObject:model];
        }
    }
    return self;
}

- (NSString *)getFullAddressString {
    NSString *result = [NSString stringWithFormat:@"%@ %@ %@ %@", self.addressPrfName, self.addressCityName, self.address1, self.address2];
    return result;
}

@end
