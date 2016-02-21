//
//  QKConst.h
//  quicker-cl-ios
//
//  Created by Viet on 5/5/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kQKAPIKeyValue          @"23z37jp77fjxk45hnkyt8ud84g6tzugj"
#define kQKOSValue              @"0"
#define kQKBasicAuthUserName    @"shk"
#define kQKBasicAuthPassword    @"258456"
#define kQKBasicAuthString      @"shk:258456@"
#define kQKBlowfishKey          @"8bddb8d4d181f7e9"
#define kQKVersion              @"0.1"
#define kQKNewVersionAppName    @""
#define kQKCenterPhoneNum       @"123456789"


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

#pragma mark -Enum
typedef enum QKCropImageType : NSInteger {
    QKCropImageTypeRectangle = 0,
    QKCropImageTypeSquare
} QKCropImageType;

typedef enum QKUploadMode : NSInteger {
    QKUploadModeImage = 0,
    QKUploadModeProfile,
} QKUploadMode;

typedef enum QKType : NSInteger {
    QKTypeAccountStop = 0,
    QKTypeAccountClose,
    QKTypeShopStop,
    QKTypeShopClose
} QKType;

typedef enum QKStoreImageTye : NSInteger {
    QKStoreNoImage = 0,
    QKStoreImage
} QKStoreImageTye;

typedef enum QKPaymentSettingMode : NSInteger {
    QKPaymentSettingModeNormal = 0,
    QKPaymentSettingModeOther,
} QKPaymentSettingMode;


@interface QKCLConst : NSObject
/**
 *  Const
 */
//Params for API
extern NSString const *QK_API_KEY;
extern NSString const *QK_API_KEY_ACCESS_TOKEN;
extern NSString const *QK_API_KEY_OS;
extern NSString const *QK_API_KEY_VERSION;
extern NSString const *QK_API_STATUS_CODE;


#pragma mark  - Common const for CL and CS

//Shop status
extern NSString const *QK_SHOP_STATUS_EXAMINATING;
extern NSString const *QK_SHOP_STATUS_EXAM_DEL;
extern NSString const *QK_SHOP_STATUS_EXAM_NG;
extern NSString const *QK_SHOP_STATUS_EXAM_NG_OTHER;
extern NSString const *QK_SHOP_STATUS_EXAM_OK;
extern NSString const *QK_SHOP_STATUS_PUBLIC;
extern NSString const *QK_SHOP_STATUS_DISABLED;
extern NSString const *QK_SHOP_STATUS_DELETED;
extern NSString const *QK_SHOP_STATUS_CLOSED;

//Delete applicant reason

extern NSString const *QKCL_APP_DEL_REASON_NOT_WORK;
extern NSString const *QKCL_APP_DEL_REASON_SHOP;
extern NSString const *QKCL_APP_DEL_REASON_ORTHER;

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
// Applicant rating Status
extern NSString const *QK_CL_RATING_WORKER_STATUS_GOOD;
extern NSString const *QK_CL_RATING_WORKER_STATUS_NORMAL;
extern NSString const *QK_CL_RATING_WORKER_STATUS_BAD;
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
extern NSString const *QK_REC_STATUS_BEFORE;
extern NSString const *QK_REC_STATUS_DONE_WORKING;
extern NSString const *QK_REC_STATUS_STOP;
extern NSString const *QK_REC_STATUS_CHOOSING_WORKER;
extern NSString const *QK_REC_STATUS_DONE_WORKER;
extern NSString const *QK_REC_STATUS_DONE_REC;
extern NSString const *QK_REC_STATUS_CLOSE_REC;
extern NSString const *QK_REC_STATUS_TRIAL;

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


/**
 *  CONST FOR CL
 */
//Shoptype
extern NSString const *QK_SHOP_TYPE_CORPORATE; // Corporate
extern NSString const *QK_SHOP_TYPE_INDIVIDUAL; // Individual

//APPLICANT STATUS
extern NSString const *QK_APPLICANT_STATUS_OFFER_WORKING;   //Offer working
extern NSString const *QK_APPLICANT_STATUS_OK;              //OK
extern NSString const *QK_APPLICANT_STATUS_NG;              //NG
extern NSString const *QK_APPLICANT_STATUS_CANCEL;          //Cancel
extern NSString const *QK_APPLICANT_STATUS_DONE;            //Already done

//EMPLOYMENTSTATUS
extern NSString const *QK_CL_EMPLOYMENT_STATUS_EMPLOYMENT;      //就業
extern NSString const *QK_CL_EMPLOYMENT_STATUS_APPLICANTS;      //不就業(応募者都合)
extern NSString const *QK_CL_EMPLOYMENT_STATUS_SHOP;        //不就業(店舗都合)

//WORKACTUALSTATUS
extern NSString const *QK_CL_WORK_ACTUAL_STATUS_INPUT_BEFORE;  //実績入力前
extern NSString const *QK_CL_WORK_ACTUAL_STATUS_INPUT_ALREADY;  //実績入力済
extern NSString const *QK_CL_WORK_ACTUAL_STATUS_PENDING;        //異議申請中
extern NSString const *QK_CL_WORK_ACTUAL_STATUS_APPROVAL;       //実績承認

//adoptedAtSamePeriod
extern NSString const *QK_ADOPTED_AT_SAME_PERIOD_NO;   //NO
extern NSString const *QK_ADOPTED_AT_SAME_PERIOD_YES;   //YES

//sameJobExperienceByCareer
extern NSString const *QK_JOB_EXPERIENCE_BY_CAREER_SAME_NO;   //NO
extern NSString const *QK_JOB_EXPERIENCE_BY_CAREER_SAME_YES;   //YES

//sameJobExperienceByShkCareer
extern NSString const *QK_JOB_EXPERIENCE_BY_SHK_CAREER_SAME_NO;   //NO
extern NSString const *QK_JOB_EXPERIENCE_BY_SHK_CAREER_SAME_YES;   //YES

//favoriteCustomerF
extern NSString const *QK_FAV_CUSTOMER_NO;   //NO
extern NSString const *QK_FAV_CUSTOMER_YES;   //YES

//STATUS
extern NSString const *QK_STATUS_OK;     //OK
extern NSString const *QK_STATUS_NG;     //NG

//CUSTOMER STATUS
extern NSString const *QK_ACCOUNT_STATUS_WAIT_APPROVE;
extern NSString const *QK_ACCOUNT_STATUS_ENABLED;
extern NSString const *QK_ACCOUNT_STATUS_STOP;
extern NSString const *QK_ACCOUNT_STATUS_WITHDRAWAL;
extern NSString const *QK_ACCOUNT_STATUS_CLOSE;

//relationType
extern NSString const *QK_RELATION_TYPE_RECRUITMENT;
extern NSString const *QK_RELATION_TYPE_TEMPLATE;
extern NSString const *QK_RELATION_TYPE_SHOP;

//CANDIDATE STATUS
extern NSString const *QK_CANDIDATE_STATUS_YES_AND_ENOUGH;
extern NSString const *QK_CANDIDATE_STATUS_YES_AND_NOT_ENOUGH;
extern NSString const *QK_CANDIDATE_STATUS_NO;

//payStatementStatus
extern NSString const *QK_PAYMENT_STATUS_PAY;
extern NSString const *QK_PAYMENT_STATUS_DEDUCT;

//PaymentMethod
extern NSString const *QK_PAYMENT_METHOD_INDAY;
extern NSString const *QK_PAYMENT_METHOD_LATER;
extern NSString const *QK_PAYMENT_METHOD_BANK_TRANFER;

//NoticeType
extern NSString const *QK_CL_NOTICE_ID_0006;
extern NSString const *QK_CL_NOTICE_ID_0007;
extern NSString const *QK_CL_NOTICE_ID_0009;
extern NSString const *QK_CL_NOTICE_ID_0012;
extern NSString const *QK_CL_NOTICE_ID_0021;
extern NSString const *QK_CL_NOTICE_ID_0024;
extern NSString const *QK_CL_NOTICE_ID_0028;
extern NSString const *QK_CL_NOTICE_ID_0033;
extern NSString const *QK_CL_NOTICE_ID_0038;
extern NSString const *QK_CL_NOTICE_ID_0040;
extern NSString const *QK_CL_NOTICE_ID_0062;

//
extern NSString const *QK_MUTIL_APP_STATUS_YES;
extern NSString const *QK_MUTIL_APP_STATUS_NO;
extern NSString const *QK_MUTIL_APP_STATUS_DONE;

extern NSString const *QK_CL_NOTICE_LIMIT;

#pragma mark - Map
+ (NSDictionary *)SHOP_TYPE_MAP;
+ (NSDictionary *)SEX_FLG_MAP;
+ (NSDictionary *)SERVICE_PERIOD_MAP;
+ (NSDictionary *)OCCUPATION_MAP;
+ (NSDictionary *)PAYMENT_SYSTEM_MAP;
+ (NSDictionary *)PAYMENT_METHOD_MAP;

#pragma mark -status code
//success
extern NSString const *QK_STT_CODE_SUCCESS;
extern NSString const *QK_STT_CODE_NEW_VERSION;
extern NSString const *QK_STT_CODE_ACCOUNT_STOP;
extern NSString const *QK_STT_CODE_ACCOUNT_CLOSE;
extern NSString const *QK_STT_CODE_SHOP_STOP;
extern NSString const *QK_STT_CODE_SHOP_CLOSE;
extern NSString const *QK_STT_CODE_ACCESSTOKEN_INVALID;
extern NSString const *QK_STT_CODE_ACCESSTOKEN_EXPIRED;
extern NSString const *QK_STT_CODE_ACCOUNT_INVALID;

@end
