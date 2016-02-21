//
//  QKShopInfoModel.h
//  quicker-cl-ios
//
//  Created by Quy on 5/15/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QKCLImageModel.h"
#import "QKCLRelShopUserModel.h"

@interface QKCLShopInfoModel : NSObject
@property (strong, nonatomic) NSString *shopId;
@property (strong, nonatomic) NSString *abbreviatedTitle;
@property (strong, nonatomic) NSString *abbreviatedTitleKana;
@property (assign, nonatomic) NSInteger adoptionRecord;
@property (assign, nonatomic) NSInteger availableAmount;
@property (strong, nonatomic) NSString *classificationCd;
@property (strong, nonatomic) NSString *companyAddress1;
@property (strong, nonatomic) NSString *companyAddress2;
@property (strong, nonatomic) NSString *companyAddressCityJisCd;
@property (strong, nonatomic) NSString *companyAddressCityName;
@property (strong, nonatomic) NSString *companyAddressPrfJisCd;
@property (strong, nonatomic) NSString *companyAddressPrfName;
@property (strong, nonatomic) NSString *companyNameKana;
@property (strong, nonatomic) NSString *companyPostcd;
@property (assign, nonatomic) NSInteger favoriteNum;
@property (strong, nonatomic) NSString *companyName;
@property (strong, nonatomic) NSString *shopStatus;
@property (strong, nonatomic) NSString *descriptions;
@property (strong, nonatomic) NSString *shopDescription;
@property (strong, nonatomic) NSString *accessWay;
@property (strong, nonatomic) NSString *phoneNum;
@property (strong, nonatomic) NSString *postcd;
@property (strong, nonatomic) NSString *business;
@property (strong, nonatomic) NSString *jobTypeLCd;
@property (strong, nonatomic) NSString *jobTypeLName;
@property (strong, nonatomic) NSString *jobTypeMCd;
@property (strong, nonatomic) NSString *jobTypeMName;
@property (strong, nonatomic) NSString *addressPrfJisCd;
@property (strong, nonatomic) NSString *addressPrfName;
@property (strong, nonatomic) NSString *addressCityJisCd;
@property (strong, nonatomic) NSString *addressCityName;
@property (strong, nonatomic) NSString *address1;
@property (strong, nonatomic) NSString *address2;
@property (strong, nonatomic) NSMutableArray *imageFileList;
@property (strong, nonatomic) NSString *latLng;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *nameKana;
@property (strong, nonatomic) NSString *paymentSystemType;
@property (strong, nonatomic) NSString *paymentSystemTypeName;
@property (strong, nonatomic) NSString *personInCharge;
@property (strong, nonatomic) NSString *pushStatus;
@property (strong, nonatomic) NSString *statusCd;
@property (strong, nonatomic) NSString *tradeNameCd;
@property (strong, nonatomic) NSString *tradeNamePosition;
@property (nonatomic) NSInteger unreadNoticeNum;
@property (strong, nonatomic) NSString *wayside1;
@property (strong, nonatomic) NSString *wayside2;
@property (strong, nonatomic) NSString *wayside3;
@property (strong, nonatomic) NSMutableArray *relShopUserList;
@property (strong, nonatomic) NSMutableArray *freeItemList;

- (instancetype)initWithResponse:(NSDictionary *)response;
- (NSString *)getFullAddressString;
@end
