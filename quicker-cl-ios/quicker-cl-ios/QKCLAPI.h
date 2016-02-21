//
//  QKAPI.h
//  quicker-cl-ios
//
//  Created by Viet on 5/5/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QKCLAPI : NSObject


#pragma mark - Version
extern NSString const *qkUrlJudgeVersion;

#pragma mark - Account
extern NSString const *qkUrlAccountRegist;
extern NSString const *qkUrlAccountRegistComplete;
extern NSString const *qkUrlAccountLogin;
extern NSString const *qkUrlAccountLogout;
extern NSString const *qkUrlAccountPasswordUpdate;
extern NSString const *qkUrlAccountPasswordReissue;
extern NSString const *qkUrlAccountEmailUpdate;
extern NSString const *qkUrlAccountWithDraw;
extern NSString const *qkUrlClAccountPasswordReauth;

#pragma mark - Workers Past
extern NSString const *qkClUrlWorkersPastYearList;
extern NSString const *qkClUrlWorkersPastMonthList;
#pragma mark - Worker Payment
extern NSString const *qkClUrlWorkerPaymentCancel;
extern NSString const *qkClUrlWorkerPayment;
#pragma mark -Worker salary calculate
extern NSString const *qkClUrlWorkerSalaryCalculate;
#pragma mark - Workers Favorite List

extern NSString const *qkClUrlWorkerFavoriteList;
#pragma mark - Profile
extern NSString const *qkUrlProfileUpdate;
extern NSString const *qkUrlProfileDetail;
extern NSString const *qkUrlProfileNameUpdate;

#pragma mark  - Confirm Rating Worker
extern NSString const *qkCLUrlConFirmRatingWorker;
#pragma mark - Rating Worker
extern NSString const *qkCLUrlRatingWorker;
#pragma mark - Shop
extern NSString const *qkUrlShopRegist;
extern NSString const *qkUrlShopUpdate;
extern NSString const *qkUrlShopUpdateComplete;
extern NSString const *qkUrlShopDelete;
extern NSString const *qkUrlShopDetail;
extern NSString const *qkUrlShopList;
extern NSString const *qkUrlShopImageUpload;
extern NSString const *qkUrlShopImageDelete;

#pragma mark - Recruitment
extern NSString const *qkUrlRecruitmentRegist;
extern NSString const *qkUrlRecruitmentTerminate;
extern NSString const *qkClUrlRecruitmentList;
extern NSString const *qkUrlRecruitmentDetail;
extern NSString const *qkUrlRecruitmentRegistComplete;
extern NSString const *qkClUrlRecruitmentQuestionList;
extern NSString const *qkClUrlRecruitmentQuestionDetail;
extern NSString const *qkClUrlRecruitmentQuestionAnswer;
extern NSString const *qkClUrlRecruitmentQuestionDelete;
extern NSString const *qkUrlRecruitMentPastList;
extern NSString const *qkUrlRecruitmentAttendanceList;
extern NSString const *qkCLUrlRecruitmentUpdate;
#pragma mark - Applicant
extern NSString const *qkUrlApplicantDetail;
extern NSString const *qkUrlApplicantAdoptionStatusUpdate;

#pragma mark - Notice
extern NSString const *qkUrlNoticeList;

#pragma mark - Payment
extern NSString const *qkUrlPaymentRegist;
extern NSString const *qkUrlPaymentCreditComplete;

#pragma mark - Salary
extern NSString const *qkUrlSalaryDetail;
extern NSString const *qkUrlSalaryFixedMonth;

#pragma mark -Message
extern NSString const *qkUrlMessageList;
extern NSString const *qkUrlMessageRegist;
extern NSString const *qkUrlMessageDelete;

#pragma mark - Master
//jobtype
extern NSString const *qkUrlMasterJobTypeL;
extern NSString const *qkUrlMasterItemJobTypeL;
extern NSString const *qkUrlMasterJobTypeM;
extern NSString const *qkUrlMasterJobTypeS;
//merritmask
extern NSString const *qkUrlMasterPreferenceCondition;
//prefecture
extern NSString const *qkUrlMasterPrefecture;
//city
extern NSString const *qkUrlMasterCity;
//searchAddress
extern NSString const *qkUrlMasterAddress;

#pragma mark - Notice
extern NSString const *qkUrlNotice;

#pragma mark - WebView
extern NSString const *qkCLUrlWebReviewSteps;
extern NSString const *qkCLUrlWebReviewFaq;

extern NSString const *qkCLUrlWebAccountPasswordReissue;
extern NSString const *qkCLUrlWebAccountPasswordReissueComplete;

extern NSString const *qkCLUrlWebMypageWorkingConditionns;
extern NSString const *qkCLUrlWebGuidelineWriting;
extern NSString const *qkCLUrlWebGuidelineEntry;
extern NSString const *qkCLUrlWebGuidelinePrecautionImage;
extern NSString const *qkCLUrlWebPrivacyPolicy;
extern NSString const *qkCLUrlWebAgreement;
extern NSString const *qkCLUrlWebCopyright;
extern NSString const *qkCLUrlWebContact;

@end
