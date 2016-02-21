//
//  QKAPI.m
//  quicker-cl-ios
//
//  Created by Viet on 5/5/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLAPI.h"

//test server
//#define BASE_URL @"http://192.168.1.123:9000"

//dev server
#define BASE_URL @"http://dev01clnt.shk.x.recruit.co.jp"
#define BASE_URL_BASIC_AUTH @"http://shk:258456@dev01clnt.shk.x.recruit.co.jp"

@implementation QKCLAPI

#pragma mark - Version
NSString const *qkUrlJudgeVersion = BASE_URL "/api/system/version/";

#pragma mark - Account
NSString const *qkUrlAccountRegist = BASE_URL "/api/account/regist/";
NSString const *qkUrlAccountRegistComplete = BASE_URL "/api/account/regist/complete/";
NSString const *qkUrlAccountLogin = BASE_URL "/api/account/login/";
NSString const *qkUrlAccountLogout = BASE_URL "/api/account/logout/";
NSString const *qkUrlAccountPasswordUpdate = BASE_URL "/api/account/password/update/";
NSString const *qkUrlAccountPasswordReissue = BASE_URL "/api/account/password/reissue/send/";
NSString const *qkUrlAccountEmailUpdate = BASE_URL "/api/account/email/update/";
NSString const *qkUrlAccountWithDraw = BASE_URL "/api/account/regist/withdraw/";
NSString const *qkUrlClAccountPasswordReauth = BASE_URL "/api/account/password/reauth/";

#pragma mark - Workers Past
NSString const *qkClUrlWorkersPastYearList = BASE_URL "/api/salary/fixed/year/";
NSString const *qkClUrlWorkersPastMonthList = BASE_URL "/api/salary/fixed/month/";

#pragma mark - Worker payment
NSString const *qkClUrlWorkerPaymentCancel = BASE_URL "/api/applicant/worktime/cancel/";
NSString const *qkClUrlWorkerPayment = BASE_URL "/api/applicant/worktime/regist/";
#pragma mark -Worker salary calculate
NSString const *qkClUrlWorkerSalaryCalculate = BASE_URL "/api/salary/calculation/base/";

#pragma mark -Workers Favorite Worker
NSString const *qkClUrlWorkerFavoriteList = BASE_URL "/api/favorite/list/";
#pragma mark - Profile
NSString const *qkUrlProfileUpdate = BASE_URL "/api/profile/update/";
NSString const *qkUrlProfileDetail = BASE_URL "/api/profile/detail/";
NSString const *qkUrlProfileNameUpdate = BASE_URL "/api/profile/name/update/";

#pragma mark - Rating Worker
NSString const *qkCLUrlRatingWorker = BASE_URL @"/api/rating/regist/";
#pragma mark - ConFirm Rating Worker
NSString const *qkCLUrlConFirmRatingWorker = BASE_URL @"/api/favorite/regist/";
#pragma mark - Shop
NSString const *qkUrlShopRegist = BASE_URL "/api/shop/regist/";
NSString const *qkUrlShopUpdate = BASE_URL "/api/shop/update/";
NSString const *qkUrlShopUpdateComplete = BASE_URL "/api/shop/update/complete/";
NSString const *qkUrlShopDelete = BASE_URL "/api/shop/delete/";
NSString const *qkUrlShopDetail = BASE_URL "/api/shop/detail/";
NSString const *qkUrlShopList = BASE_URL "/api/shop/list/";
NSString const *qkUrlShopImageUpload = BASE_URL "/api/shop/image/regist/";
NSString const *qkUrlShopImageDelete = BASE_URL "/api/shop/image/delete/";

#pragma mark - Recruitment
NSString const *qkUrlRecruitmentRegist = BASE_URL "/api/recruitment/regist/";
NSString const *qkUrlRecruitmentTerminate = BASE_URL "/api/recruitment/terminate/";
NSString const *qkClUrlRecruitmentList = BASE_URL "/api/recruitment/list/";
NSString const *qkUrlRecruitmentDetail = BASE_URL "/api/recruitment/detail/";
NSString const *qkUrlRecruitmentRegistComplete = BASE_URL "/api/recruitment/regist/complete/";
NSString const *qkUrlRecruitmentAttendanceList = BASE_URL "/api/recruitment/attendance/list/";

NSString const *qkUrlRecruitMentPastList = BASE_URL "/api/recruitment/past/list/";
NSString const *qkClUrlRecruitmentQuestionList = BASE_URL "/api/qa/list/";
NSString const *qkClUrlRecruitmentQuestionDetail = BASE_URL "/api/qa/detail/";
NSString const *qkClUrlRecruitmentQuestionAnswer = BASE_URL "/api/qa/answer/";
NSString const *qkClUrlRecruitmentQuestionDelete = BASE_URL "/api/qa/delete/";
NSString const *qkCLUrlRecruitmentUpdate = BASE_URL "/api/recruitment/update/";
#pragma mark - Applicant
NSString const *qkUrlApplicantDetail = BASE_URL "/api/applicant/detail/";
NSString const *qkUrlApplicantAdoptionStatusUpdate = BASE_URL "/api/applicant/adoption/status/update/";

#pragma mark - Notice
NSString const *qkUrlNoticeList = BASE_URL "/api/notice/list/";

#pragma mark - Payment
NSString const *qkUrlPaymentRegist = BASE_URL "/api/payment/regist/";
NSString const *qkUrlPaymentCreditComplete = BASE_URL "/api/payment/credit/complete/";

#pragma mark - Salary
NSString const *qkUrlSalaryDetail = BASE_URL "/api/salary/detail/";
NSString const *qkUrlSalaryFixedMonth = BASE_URL "/api/salary/fixed/month/";

#pragma mark -Message
NSString const *qkUrlMessageList = BASE_URL "/api/message/list/";
NSString const *qkUrlMessageRegist = BASE_URL "/api/message/regist/";
NSString const *qkUrlMessageDelete = BASE_URL "/api/message/delete/";

#pragma mark - Master
//Jobtype
NSString const *qkUrlMasterJobTypeL = BASE_URL "/api/master/jobtypel/";
NSString const *qkUrlMasterItemJobTypeL = BASE_URL "/api/master/itemjobtypel/";
NSString const *qkUrlMasterJobTypeM = BASE_URL "/api/master/jobtypem/";
NSString const *qkUrlMasterJobTypeS = BASE_URL "/api/master/jobtypes/";

//merritmask
NSString const *qkUrlMasterPreferenceCondition = BASE_URL "/api/master/preferencecondition/";

//prefecture
NSString const *qkUrlMasterPrefecture = BASE_URL "/api/master/prefecture/";

//city
NSString const *qkUrlMasterCity = BASE_URL "/api/master/city/";

//searchAddress
NSString const *qkUrlMasterAddress = BASE_URL "/api/master/address/";

#pragma mark - Notice
NSString const *qkUrlNotice = BASE_URL "/api/notice/list/";

#pragma mark - WebView
NSString const *qkCLUrlWebReviewSteps = BASE_URL_BASIC_AUTH "/review/steps/";
NSString const *qkCLUrlWebReviewFaq = BASE_URL_BASIC_AUTH "/review/faq/";

NSString const *qkCLUrlWebAccountPasswordReissue = BASE_URL_BASIC_AUTH "/account/password/reissue/";
NSString const *qkCLUrlWebAccountPasswordReissueComplete = BASE_URL_BASIC_AUTH "/account/password/reissue/complete/";

NSString const *qkCLUrlWebMypageWorkingConditionns = BASE_URL_BASIC_AUTH "/mypage/workingconditions/";
NSString const *qkCLUrlWebGuidelineWriting = BASE_URL_BASIC_AUTH "/guideline/writing/";
NSString const *qkCLUrlWebGuidelineEntry = BASE_URL_BASIC_AUTH "/guideline/entry/";
NSString const *qkCLUrlWebGuidelinePrecautionImage = BASE_URL_BASIC_AUTH "/guideline/precaution/image/";
NSString const *qkCLUrlWebPrivacyPolicy = BASE_URL_BASIC_AUTH "/privacypolicy/";
NSString const *qkCLUrlWebAgreement = BASE_URL_BASIC_AUTH "/agreement/";
NSString const *qkCLUrlWebCopyright = BASE_URL_BASIC_AUTH "/copyright/";
NSString const *qkCLUrlWebContact = BASE_URL_BASIC_AUTH "/contact/";
@end
