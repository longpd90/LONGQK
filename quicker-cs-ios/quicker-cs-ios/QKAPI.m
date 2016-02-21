//
//  QKAPI.m
//  quicker-cl-ios
//
//  Created by Viet on 5/5/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKAPI.h"

//test server
//#define BASE_URL @"http://192.168.1.123:9000"

//dev server
#define BASE_URL @"http://dev01cstm.shk.x.recruit.co.jp"
#define BASE_URL_BASIC_AUTH @"http://shk:258456@dev01clnt.shk.x.recruit.co.jp"

@implementation QKAPI

#pragma mark - Account
NSString const *qkCSUrlAccountRegist = BASE_URL "/api/account/regist/";
NSString const *qkCSUrlAccountRegistComplete = BASE_URL "/api/account/regist/complete/";
NSString const *qkCSUrlAccountLogin = BASE_URL "/api/account/login/";
NSString const *qkCSUrlAccountLogout = BASE_URL "/api/account/logout/";
NSString const *qkCSUrlAccountPasswordUpdate = BASE_URL "/api/account/password/update/";

NSString const *qkCSUrlAccountDelete = BASE_URL "/api/account/password/reauth/";
NSString const *qkCSUrlAccountPasswordReissue = BASE_URL "/api/account/password/reissue/send/";
NSString const *qkCsUrlAccountEmailUpdate = BASE_URL "/api/account/email/update/";
NSString const *qkCSUrlAccountRegistWithdraw = BASE_URL "/api/account/withdraw/";

NSString const *qkCSUrlAccountFacebookLogin = BASE_URL "/api/account/login/fb/";
NSString const *qkCSUrlAccountFacebookRegist = BASE_URL "/api/account/regist/fb/";

#pragma mark - Profile
NSString const *qkCSUrlProfileRegist = BASE_URL "/api/profile/regist/";
NSString const *qkCSUrlProfileDetail = BASE_URL "/api/profile/detail/";
NSString const *qkCSUrlProfileCareer = BASE_URL "/api/profile/career/regist/";
NSString const *qkCSUrlProfileList = BASE_URL "/api/profile/career/list/";

#pragma mark - SMS auth
NSString const *qkCSUrlSMSAuth = BASE_URL "/api/smsauth/";
NSString const *qkCSUrlSMSAuthSend = BASE_URL "/api/smsauth/send/";


#pragma mark - Message
NSString const *qkCSUrlMessageRegist = BASE_URL "/api/message/regist/";
NSString const *qkCSUrlMessageList = BASE_URL "/api/message/list/";
NSString const *qkCSUrlMessageDelete = BASE_URL "/api/message/delete/";

#pragma mark - Notice
NSString const *qkCSUrlNoticeList = BASE_URL "/api/notice/list/";

#pragma mark - Recruitment
NSString const *qkCSUrlRecruitmentList = BASE_URL "/api/recruitment/list/";
NSString const *qkCSUrlRecruitmentDetail = BASE_URL "/api/recruitment/detail/";
NSString const *qkCSUrlRecruitmentAppliedList = BASE_URL "/api/recruitment/applied/list/";
NSString const *qkCSUrlRecruitmentPreviewList = BASE_URL "/api/recruitment/preview/list/";
NSString const *qkCSUrlRecruitmentQuestion = BASE_URL "/api/qa/question/";
NSString const *qkCSUrlKeepRegist = BASE_URL "/api/keep/regist/";
NSString const *qkCSUrlKeepDelete = BASE_URL "/api/keep/delete/";
NSString const *qkCSUrlKeepList = BASE_URL "/api/keep/list/";

#pragma mark - Shop
NSString const *qkCSUrlShopDetail = BASE_URL "/api/shop/detail/";

#pragma mark - Application
NSString const *qkCSUrlApplicationRegist = BASE_URL "/api/application/regist/";
NSString const *qkCSUrlAppliAble = BASE_URL "/api/application/applicable/";
NSString const *qkCSUrlAppliCancel = BASE_URL "/api/application/cancel/";
NSString const *qkCSUrlApplicationInfoRegiest = BASE_URL "/api/application/additionalinfo/regist/";

#pragma mark - Master
//Jobtype
NSString const *qkUrlMasterJobTypeL = BASE_URL "/api/master/jobtypel/";
NSString const *qkUrlMasterJobTypeM = BASE_URL "/api/master/jobtypem/";
NSString const *qkUrlMasterJobTypeS = BASE_URL "/api/master/jobtypes/";

//prefecture
NSString const *qkUrlMasterPrefecture = BASE_URL "/api/master/prefecture/";
NSString const *qkUrlMasterCity = BASE_URL "/api/master/city/";

NSString const *qkUrlMasterPreferenceCondition = BASE_URL "/api/master/preferencecondition/";

//rating
NSString const *qkUrlMasterRatingItem = BASE_URL "/api/master/ratingitem/";

//address
NSString const *qkUrlMasterAddress = BASE_URL "/api/master/address/";

#pragma mark - WebView
NSString const *qkCSUrlWebAccountPasswordReissue= BASE_URL "/account/password/reissue/";
NSString const *qkCSUrlWebAccountPasswordReissueComlete= BASE_URL "/account/password/reissue/compelete/";

NSString const *qkCSUrlWebAgreement= BASE_URL "/agreement/";
NSString const *qkCSUrlWebCopyright= BASE_URL "/copyright/";
NSString const *qkCSUrlWebContact= BASE_URL "/contact/";

#pragma mark - Favorite Store
NSString const *qkCSUrlFavoriteList = BASE_URL "/api/favorite/list/";
NSString const *qkCSUrlDeleteFromFavoriteList = BASE_URL "/api/favorite/delete/";
NSString const *qkCSUrlFavoriteRegist = BASE_URL @"/api/favorite/regist/";

#pragma mark - Work History
NSString const *qkCSUrlWorkHistoryPerformance = BASE_URL "/api/history/performance/approval/";
NSString const *qkCSUrlAppliedRecruitmentList = BASE_URL "/api/recruitment/applied/list/";

@end
