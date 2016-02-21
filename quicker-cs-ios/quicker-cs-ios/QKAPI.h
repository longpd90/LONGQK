//
//  QKAPI.h
//  quicker-cl-ios
//
//  Created by Viet on 5/5/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface QKAPI : NSObject

#pragma mark - Account
extern NSString const *qkCSUrlAccountRegist;
extern NSString const *qkCSUrlAccountRegistComplete;
extern NSString const *qkCSUrlAccountRegistWithdraw;
extern NSString const *qkCSUrlAccountLogin;
extern NSString const *qkCSUrlAccountLogout;
extern NSString const *qkCSUrlAccountPasswordUpdate;
extern NSString const *qkCSUrlAccountPasswordReissue;
extern NSString const *qkCSUrlAccountDelete;
extern NSString const *qkCsUrlAccountEmailUpdate;

extern NSString const *qkCSUrlAccountFacebookLogin;
extern NSString const *qkCSUrlAccountFacebookRegist;

#pragma mark - Profile
extern NSString const *qkCSUrlProfileRegist;
extern NSString const *qkCSUrlProfileDetail;
extern NSString const *qkCSUrlProfileCareer;
extern NSString const *qkCSUrlProfileList;

#pragma mark - SMS auth
extern NSString const *qkCSUrlSMSAuth;
extern NSString const *qkCSUrlSMSAuthSend;

#pragma mark - Application
extern NSString const *qkCSUrlApplicationRegist;
extern NSString const *qkCSUrlAppliAble;
extern NSString const *qkCSUrlAppliCancel;
extern NSString const *qkCSUrlApplicationInfoRegiest;

#pragma mark - Message
extern NSString const *qkCSUrlMessageRegist;
extern NSString const *qkCSUrlMessageList;
extern NSString const *qkCSUrlMessageDelete;

#pragma mark - Notice
extern NSString const *qkCSUrlNoticeList;

#pragma mark - Recruitment
extern NSString const *qkCSUrlRecruitmentList;
extern NSString const *qkCSUrlRecruitmentDetail;
extern NSString const *qkCSUrlRecruitmentAppliedList;
extern NSString const *qkCSUrlRecruitmentPreviewList;
extern NSString const *qkCSUrlRecruitmentQuestion;
extern NSString const *qkCSUrlKeepRegist;
extern NSString const *qkCSUrlKeepDelete;
extern NSString const *qkCSUrlKeepList;

#pragma mark - Shop
extern NSString const *qkCSUrlShopDetail;

#pragma mark - Master
//jobtype
extern NSString const *qkUrlMasterJobTypeL;
extern NSString const *qkUrlMasterJobTypeM;
extern NSString const *qkUrlMasterJobTypeS;

//prefecture
extern NSString const *qkUrlMasterPrefecture;
extern NSString const *qkUrlMasterCity;

//preference condition
extern NSString const *qkUrlMasterPreferenceCondition;

//rating
extern NSString const *qkUrlMasterRatingItem;

//address
extern NSString const *qkUrlMasterAddress;

#pragma mark - WebView
extern NSString const *qkCSUrlWebAccountPasswordReissue;
extern NSString const *qkCSUrlWebAccountPasswordReissueComlete;

extern NSString const *qkCSUrlWebAgreement;
extern NSString const *qkCSUrlWebCopyright;
extern NSString const *qkCSUrlWebContact;

#pragma mark - Favorite Store
extern NSString const *qkCSUrlFavoriteList;
extern NSString const *qkCSUrlDeleteFromFavoriteList;
extern NSString const *qkCSUrlFavoriteRegist;

#pragma mark - Work History
extern NSString const *qkCSUrlWorkHistoryPerformance;
extern NSString const *qkCSUrlAppliedRecruitmentList;

@end
