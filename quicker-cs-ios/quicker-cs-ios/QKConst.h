//
//  QKConst.h
//  quicker-cl-ios
//
//  Created by Viet on 5/5/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kQKAPIKeyValue          @"23z37jp77fjxk45hnkyt8ud84g6tzugj"
#define kQKBlowfishKey          @"8bddb8d4d181f7e9"
#define kQKBasicAuthUserName    @"shk"
#define kQKBasicAuthPassword    @"258456"
#define kQKBasicAuthString      @"shk:258456@"
#define kQKCenterPhoneNum       @"03-1234-5678"
#define kQKVersion              @"0.1"
#define kQKNewVersionAppName    @""

#define kQKAPIKey                                    @"apiKey"
#define kQKEmailKey                                  @"email"
#define kQKUserIDKey                                 @"userId"
#define kQKPassWordKey                               @"password"
#define kQKOSKey                                     @"os"
#define kQKOSKeyValue                                @"0"
#define kQKUserNameKey                               @"userName"
#define kQKUserNameKanaKey                           @"userNameKana"
#define kQKPhoneNumberKey                            @"phoneNo"
#define kQKBirthDayKey                               @"birthday"
#define kQKGenderKey                                 @"sexFlg"
#define kQKAddressKey                                @"address1"
#define kQKImagePathKey                              @"imgPath"
#define kQKQualificationKey                          @"qualification"
#define kQKSelfPromotionKey                          @"selfPromotion"
#define kQKOOCupationKey                             @"oocupation"
#define kQKSelfPromotionInApplicationKey             @"selfPromotionInApplication"
#define kQKCoordidateKey                             @"latLng"
#define kQKAccessTokenKey                            @"accessToken"
#define kQKConfirmCdKey                              @"confirmCd"
#define kQKFbAccessTokenKey                           @"fbAccessToken"

#define kQKNeedShowTipListJobKey                      @"kQKNeedShowTipListJobKey"
#define kQKNeedShowTipListJob                         @"kQKNeedShowTipListJob"
#define kQKNeedShowAvatarHintKey                      @"kQKNeedShowAvatarHintKey"
#define kQKNeedShowAvatarHint                      @"kQKNeedShowAvatarHint"

#define kQKNeedShowLoginAlertKey                      @"kQKNeedShowLoginAlertKey"
#define kQKNeedShowLoginAlert                      @"kQKNeedShowLoginAlert"
#define kQKShowWithdrawAlertKey                     @"kQKShowWithdrawAlertKey"
#define kQKNeedShowLogoutAlertKey                      @"kQKNeedShowLogoutAlertKey"
#define kQKNeedShowLogoutAlert                      @"kQKNeedShowLogoutAlert"



//color
#define kQKColorBase            [UIColor colorWithRed:110.0 / 255.0 green:189.0 / 255.0 blue:193.0 / 255.0 alpha:1]
#define kQKColorKey            [UIColor colorWithRed:242.0 / 255.0 green:142.0 / 255.0 blue:65.0 / 255.0 alpha:1]
#define kQKColorBG             [UIColor colorWithRed:244.0 / 255.0 green:250.0 / 255.0 blue:250.0 / 255.0 alpha:1]
#define kQKColorBtnPrimary      [UIColor colorWithRed:88.0 / 255.0 green:151.0 / 255.0 blue:154.0 / 255.0 alpha:1]
#define kQKColorBtnSecondary     [UIColor colorWithRed:92.0 / 255.0 green:103 / 255.0 blue:122 / 255.0 alpha:1]
#define kQKColorDisabled          [UIColor colorWithRed:204.0 / 255.0 green:204.0 / 255.0 blue:204.0 / 255.0 alpha:1]
#define kQKColorSuccess           [UIColor colorWithRed:103.0 / 255.0 green:191.0 / 255.0 blue:147.0 / 255.0 alpha:1]
#define kQKColorError           [UIColor colorWithRed:201.0 / 255.0 green:40.0 / 255.0 blue:59.0 / 255.0 alpha:1]
#define kQKColorWhite           [UIColor colorWithRed:255.0 / 255.0 green:255.0 / 255.0 blue:255.0 / 255.0 alpha:1]
#define kQKColorHighlighted     [UIColor colorWithRed:247.0 / 255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1]

#define kQKGlobalBackgroundGrayColor            [UIColor colorWithRed:237 / 255.0 green:237 / 255.0 blue:237 / 255.0 alpha:1]
#define kQKGlobalBackgroundButtonGrayColor      [UIColor colorWithRed:92.0 / 255.0 green:103.0 / 255.0 blue:121.0 / 255.0 alpha:1]
#define kQKGlobalTextLabelGrayColor             [UIColor colorWithRed:68.0 / 255.0 green:68.0 / 255.0 blue:68.0 / 255.0 alpha:1]
#define kQKGlobalBackgroundGrayBlueColor        [UIColor colorWithRed:245 / 255.0 green:250 / 255.0 blue:250 / 255.0 alpha:1]
#define kQKGlobalBlueColor                      [UIColor colorWithRed:110.0 / 255.0 green:189.0 / 255.0 blue:193.0 / 255.0 alpha:1]


typedef enum QKCropImageType : NSInteger {
    QKCropImageTypeRectangle = 0,
    QKCropImageTypeSquare
} QKCropImageType;

typedef enum QKType : NSInteger {
    QKTypeAccountStop = 0,
    QKTypeAccountClose
} QKType;


@interface QKConst : NSObject
/**
 *  Const
 */
//Params for API
extern NSString const *QK_API_KEY;
extern NSString const *QK_API_KEY_ACCESS_TOKEN;
extern NSString const *QK_API_KEY_OS;
extern NSString const *QK_API_STATUS_CODE;
extern NSString const *QK_API_KEY_VERSION;

#pragma mark  - Common const for CL and CS

//Shop status
extern NSString const *QK_SHOP_STATUS_EXAMINATING;
extern NSString const *QK_SHOP_STATUS_EXAM_NG;
extern NSString const *QK_SHOP_STATUS_PUBLIC;
extern NSString const *QK_SHOP_STATUS_DISABLED;
extern NSString const *QK_SHOP_STATUS_DELETED;
extern NSString const *QK_SHOP_STATUS_CLOSED;


//Sex
extern NSString const *SEX_FLG_MALE;     // Men
extern NSString const *SEX_FLG_FEMALE; // Women

//Occupation
extern NSString const *OCCUPATION_01; // 01：学生
extern NSString const *OCCUPATION_02; // 02：主婦・主夫
extern NSString const *OCCUPATION_03; // 03：アルバイト・パート
extern NSString const *OCCUPATION_04; // 04：派遣
extern NSString const *OCCUPATION_05; // 05：家事手伝い
extern NSString const *OCCUPATION_06; // 06：正社員
extern NSString const *OCCUPATION_07; // 07：引退/退職
extern NSString const *OCCUPATION_08; // 08：契約社員
extern NSString const *OCCUPATION_09; // 09：失業/休職中
extern NSString const *OCCUPATION_10; // 10：自営/独立
extern NSString const *OCCUPATION_11; // 11：その他


//Salary unit
extern NSString const *QK_SALARY_UNIT_HOUR;
extern NSString const *QK_SALARY_UNIT_DAY;
extern NSString const *QK_SALARY_UNIT_MONTH;

//Transfer status
extern NSString const *QK_TRANSFER_STATUS_BEFORE_WORK;
extern NSString const *QK_TRANSFER_STATUS_AFTER_WORK;
extern NSString const *QK_TRANSFER_STATUS_ALERT_WORKING;
extern NSString const *QK_TRANSFER_STATUS_APPROVE_WORK;
extern NSString const *QK_TRANSFER_STATUS_PROCEED_DONE;
extern NSString const *QK_TRANSFER_STATUS_PAY_DONE;
extern NSString const *QK_TRANSFER_STATUS_PAY_FAILURE;
extern NSString const *QK_TRANSFER_STATUS_NO_WORK_BY_USER;
extern NSString const *QK_TRANSFER_STATUS_NO_WORK_BY_SHOP;

//Service period
extern NSString const *QK_SERVICE_PERIOD_SINGLE;
extern NSString const *QK_SERVICE_PERIOD_1_WEEK;
extern NSString const *QK_SERVICE_PERIOD_1_MONTH;
extern NSString const *QK_SERVICE_PERIOD_HALF_YEAR;
extern NSString const *QK_SERVICE_PERIOD_OVER_1_YEAR;

//Message type
extern NSString const *QK_MESSAGE_TYPE_NORMAL;
extern NSString const *QK_MESSAGE_TYPE_ALERT;
extern NSString const *QK_MESSAGE_TYPE_AUTO;

//Delete flag
extern NSString const *QK_DEL_FLG_NO;
extern NSString const *QK_DEL_FLG_DONE;

//Read flag
extern NSString const *QK_READ_FLG_NO;
extern NSString const *QK_READ_FLG_DONE;

//Open status
extern NSString const *QK_OPEN_STATUS_PUBLIC;
extern NSString const *QK_OPEN_STATUS_NO_PUBLIC;

// payment way
extern NSString const *PAYMENT_SYSTEM_TYPE_CD_CARD;    // payment card
extern NSString const *PAYMENT_SYSTEM_TYPE_CD_BANK;    // payment bank

// Judge status
extern NSString const *QK_JUDGE_STATUS_REVIEWING;
extern NSString const *QK_JUDGE_STATUS_CHECKING;
extern NSString const *QK_JUDGE_STATUS_NG;
extern NSString const *QK_JUDGE_STATUS_OK;

// Image type
extern NSString const *QK_IMAGE_TYPE_MAIN;
extern NSString const *QK_IMAGE_TYPE_OTHER;
extern NSString const *QK_IMAGE_TYPE_EXAM;

//RECRUITMENT STATUS
extern NSString const *QK_REC_STATUS_WORKING;
extern NSString const *QK_REC_STATUS_DONE_PERIOD;
extern NSString const *QK_REC_STATUS_STOP;
extern NSString const *QK_REC_STATUS_CHOOSING;
extern NSString const *QK_REC_STATUS_CHOOSE_DONE;
extern NSString const *QK_REC_STATUS_DONE_OFFER1;
extern NSString const *QK_REC_STATUS_DONE_OFFER2;

//APPLI CANT STATUS
extern NSString const *QK_APPLI_CANT_STATUS_NOW;
extern NSString const *QK_APPLI_CANT_STATUS_OK;
extern NSString const *QK_APPLI_CANT_STATUS_NG;
extern NSString const *QK_APPLI_CANT_STATUS_CANCEL1;
extern NSString const *QK_APPLI_CANT_STATUS_CANCEL2;
extern NSString const *QK_APPLI_CANT_STATUS_DUPLICATE;

//WORK ACTUAL STATUS
extern NSString const *QK_WORK_ACTUAL_STATUS_00 ;
extern NSString const *QK_WORK_ACTUAL_STATUS_10 ;
extern NSString const *QK_WORK_ACTUAL_STATUS_20 ;
extern NSString const *QK_WORK_ACTUAL_STATUS_25 ;
//WORK STATUS
extern NSString const *QK_WORK_STATUS_WORK_BEFORE;
extern NSString const *QK_WORK_STATUS_WORK;
extern NSString const *QK_WORK_STATUS_WORK_AFTER;

//FEE STATUS
extern NSString const *QK_FEE_STATUS_INVOICE_BEFORE;
extern NSString const *QK_FEE_STATUS_INVOICE_DONE;
extern NSString const *QK_FEE_STATUS_PAYMENT_BEFORE;
extern NSString const *QK_FEE_STATUS_PAYMENT_NOT;

//TRADE NAME POSITION
extern NSString const *QK_TRADE_NAME_POSITION_BEFORE;
extern NSString const *QK_TRADE_NAME_POSITION_AFTER;

//PUSH STATUS
extern NSString const *QK_PUSH_NOTIF_ON;
extern NSString const *QK_PUSH_NOTIF_OFF;

#pragma mark -Const for CS
//SORT TYPE
extern NSString const *QK_SORT_TYPE_NEAR_LIMMIT;
extern NSString const *QK_SORT_TYPE_START_TIME;
extern NSString const *QK_SORT_TYPE_HIGH_SALARY;

//RATING STATUS
extern NSString const *QK_RATING_STATUS_NO;
extern NSString const *QK_RATING_STATUS_YES;

//NOTICETYPE
extern NSString const *QK_NOTICE_TYPE_MESSAGE;

#pragma mark - Map

+ (NSDictionary *)SEX_FLG_MAP;
+ (NSDictionary *)OCCUPATION_MAP;
+ (NSDictionary *)WORK_STATUS_MAP;
//+ (NSDictionary *)WORK_ACTUAL_STATUS_MAP;
+ (NSDictionary *)APPLI_CANT_STATUS_MAP;
+ (NSDictionary *)PAYMENT_SYSTEM_MAP;
+ (NSDictionary *)SORT_TYPE_MAP;
+ (NSDictionary *)PERIOD_MAP;
#pragma mark - Status code const


//success
extern NSString const *QK_STT_CODE_SUCCESS;
extern NSString const *QK_STT_CODE_NEW_VERSION;
extern NSString const *QK_STT_CODE_ACCOUNT_STOP;
extern NSString const *QK_STT_CODE_ACCOUNT_CLOSED;
extern NSString const *QK_STT_CODE_ACCESSTOKEN_INVALID;
extern NSString const *QK_STT_CODE_ACCESSTOKEN_EXPIRED;
extern NSString const *QK_STT_CODE_ACCOUNT_INVALID;

//limit for get recruitment list
extern NSString const *QK_CS_REC_LIST_LIMIT;
@end
