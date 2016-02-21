//
//  QKConst.m
//  quicker-cl-ios
//
//  Created by Viet on 5/5/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLConst.h"

@implementation QKCLConst
//Params for API
NSString const *QK_API_KEY = @"apiKey";
NSString const *QK_API_KEY_ACCESS_TOKEN = @"accessToken";
NSString const *QK_API_KEY_OS = @"os";
NSString const *QK_API_KEY_VERSION = @"version";
NSString const *QK_API_STATUS_CODE = @"statusCd";


#pragma mark  - Common const for CL and CS

//Shop status
NSString const *QK_SHOP_STATUS_EXAMINATING = @"00";
NSString const *QK_SHOP_STATUS_EXAM_DEL = @"05";
NSString const *QK_SHOP_STATUS_EXAM_NG = @"10";
NSString const *QK_SHOP_STATUS_EXAM_NG_OTHER = @"11";
NSString const *QK_SHOP_STATUS_EXAM_OK = @"15";
NSString const *QK_SHOP_STATUS_PUBLIC = @"20";
NSString const *QK_SHOP_STATUS_DISABLED = @"30";
NSString const *QK_SHOP_STATUS_DELETED = @"40";
NSString const *QK_SHOP_STATUS_CLOSED = @"50";

//Delete applicant reason
NSString const *QKCL_APP_DEL_REASON_NOT_WORK = @"10";
NSString const *QKCL_APP_DEL_REASON_SHOP = @"20";
NSString const *QKCL_APP_DEL_REASON_ORTHER = @"30";

//Sex
NSString const *SEX_FLG_MALE = @"2";  // Men
NSString const *SEX_FLG_FEMALE = @"1";  // Women


//Occupation
NSString const *OCCUPATION_01 = @"01";  // 01：学生
NSString const *OCCUPATION_02 = @"02";  // 02：主婦・主夫
NSString const *OCCUPATION_03 = @"03";  // 03：アルバイト・パート
NSString const *OCCUPATION_04 = @"04";  // 04：派遣
NSString const *OCCUPATION_05 = @"05";  // 05：家事手伝い
NSString const *OCCUPATION_06 = @"06";  // 06：正社員
NSString const *OCCUPATION_07 = @"07";  // 07：引退/退職
NSString const *OCCUPATION_08 = @"08";  // 08：契約社員
NSString const *OCCUPATION_09 = @"09";  // 09：失業/休職中
NSString const *OCCUPATION_10 = @"10";  // 10：自営/独立
NSString const *OCCUPATION_11 = @"11";  // 11：その他

//Salary unit
NSString const *QK_SALARY_UNIT_HOUR = @"01";
NSString const *QK_SALARY_UNIT_DAY = @"02";
NSString const *QK_SALARY_UNIT_MONTH = @"03";
// Applicant rating Status
NSString const *QK_CL_RATING_WORKER_STATUS_GOOD = @"00";
NSString const *QK_CL_RATING_WORKER_STATUS_NORMAL = @"10";
NSString const *QK_CL_RATING_WORKER_STATUS_BAD = @"20";
//Transfer status
NSString const *QK_TRANSFER_STATUS_BEFORE_WORK = @"00";
NSString const *QK_TRANSFER_STATUS_AFTER_WORK = @"10";
NSString const *QK_TRANSFER_STATUS_ALERT_WORKING = @"20";
NSString const *QK_TRANSFER_STATUS_APPROVE_WORK = @"25";
NSString const *QK_TRANSFER_STATUS_PROCEED_DONE = @"30";
NSString const *QK_TRANSFER_STATUS_PAY_DONE = @"40";
NSString const *QK_TRANSFER_STATUS_PAY_FAILURE = @"50";
NSString const *QK_TRANSFER_STATUS_NO_WORK_BY_USER = @"60";
NSString const *QK_TRANSFER_STATUS_NO_WORK_BY_SHOP = @"70";

//Service period
NSString const *QK_SERVICE_PERIOD_SINGLE = @"10";
NSString const *QK_SERVICE_PERIOD_1_WEEK = @"20";
NSString const *QK_SERVICE_PERIOD_1_MONTH = @"30";
NSString const *QK_SERVICE_PERIOD_HALF_YEAR = @"40";
NSString const *QK_SERVICE_PERIOD_OVER_1_YEAR = @"50";

//Message type
NSString const *QK_MESSAGE_TYPE_NORMAL = @"00";
NSString const *QK_MESSAGE_TYPE_ALERT = @"10";
NSString const *QK_MESSAGE_TYPE_AUTO = @"20";

//Delete flag
NSString const *QK_DEL_FLG_NO = @"0";
NSString const *QK_DEL_FLG_DONE = @"1";

//Delete flag
NSString const *QK_READ_FLG_NO = @"0";
NSString const *QK_READ_FLG_DONE = @"1";

//Open status
NSString const *QK_OPEN_STATUS_PUBLIC = @"00";
NSString const *QK_OPEN_STATUS_NO_PUBLIC = @"10";

//payment way
NSString const *PAYMENT_SYSTEM_TYPE_CD_CARD    = @"00";     // payment card
NSString const *PAYMENT_SYSTEM_TYPE_CD_BANK    = @"10";     // payment bank

//Judge status
NSString const *QK_JUDGE_STATUS_REVIEWING = @"00";
NSString const *QK_JUDGE_STATUS_CHECKING = @"10";
NSString const *QK_JUDGE_STATUS_NG = @"20";
NSString const *QK_JUDGE_STATUS_OK = @"30";

// Image type
NSString const *QK_IMAGE_TYPE_MAIN = @"00";
NSString const *QK_IMAGE_TYPE_OTHER = @"10";
NSString const *QK_IMAGE_TYPE_EXAM = @"20";

//RECRUITMENT STATUS
NSString const *QK_REC_STATUS_BEFORE = @"00";
NSString const *QK_REC_STATUS_DONE_WORKING = @"05";
NSString const *QK_REC_STATUS_STOP = @"10";
NSString const *QK_REC_STATUS_CHOOSING_WORKER = @"20";
NSString const *QK_REC_STATUS_DONE_WORKER = @"30";
NSString const *QK_REC_STATUS_DONE_REC = @"40";
NSString const *QK_REC_STATUS_CLOSE_REC = @"50";
NSString const *QK_REC_STATUS_TRIAL = @"90";

//WORK STATUS
NSString const *QK_WORK_STATUS_WORK_BEFORE = @"00";
NSString const *QK_WORK_STATUS_WORK = @"10";
NSString const *QK_WORK_STATUS_WORK_AFTER = @"20";

//FEE STATUS
NSString const *QK_FEE_STATUS_INVOICE_BEFORE = @"00";
NSString const *QK_FEE_STATUS_INVOICE_DONE = @"10";
NSString const *QK_FEE_STATUS_PAYMENT_BEFORE = @"20";
NSString const *QK_FEE_STATUS_PAYMENT_NOT = @"30";

//TRADE NAME POSITION
NSString const *QK_TRADE_NAME_POSITION_BEFORE = @"00";
NSString const *QK_TRADE_NAME_POSITION_AFTER = @"10";

//PUSH STATUS
NSString const *QK_PUSH_NOTIF_ON = @"00";
NSString const *QK_PUSH_NOTIF_OFF = @"10";

#pragma mark -CONST FOR CL
//Shoptype
NSString const *QK_SHOP_TYPE_CORPORATE = @"00";  // Corporate
NSString const *QK_SHOP_TYPE_INDIVIDUAL = @"10";  // Individual

//APPLICANT STATUS
NSString const *QK_APPLICANT_STATUS_OFFER_WORKING = @"00";   //Offer working
NSString const *QK_APPLICANT_STATUS_OK = @"10";              //OK
NSString const *QK_APPLICANT_STATUS_NG = @"20";              //NG
NSString const *QK_APPLICANT_STATUS_CANCEL = @"30";          //Cancel
NSString const *QK_APPLICANT_STATUS_DONE = @"40";            //Already done

//EMPLOYMENTSTATUS
NSString const *QK_CL_EMPLOYMENT_STATUS_EMPLOYMENT = @"00";       //就業
NSString const *QK_CL_EMPLOYMENT_STATUS_APPLICANTS = @"10";       //不就業(応募者都合)
NSString const *QK_CL_EMPLOYMENT_STATUS_SHOP = @"20";            //不就業(店舗都合)

//WORKACTUALSTATUS
NSString const *QK_CL_WORK_ACTUAL_STATUS_INPUT_BEFORE = @"00";   //実績入力前
NSString const *QK_CL_WORK_ACTUAL_STATUS_INPUT_ALREADY = @"10";  //実績入力済
NSString const *QK_CL_WORK_ACTUAL_STATUS_PENDING = @"20";        //異議申請中
NSString const *QK_CL_WORK_ACTUAL_STATUS_APPROVAL = @"25";       //実績承認

//adoptedAtSamePeriod
NSString const *QK_ADOPTED_AT_SAME_PERIOD_NO = @"0";   //NO
NSString const *QK_ADOPTED_AT_SAME_PERIOD_YES = @"1";   //YES

//sameJobExperienceByCareer
NSString const *QK_JOB_EXPERIENCE_BY_CAREER_SAME_NO = @"0";    //NO
NSString const *QK_JOB_EXPERIENCE_BY_CAREER_SAME_YES = @"1";    //YES

//sameJobExperienceByShkCareer
NSString const *QK_JOB_EXPERIENCE_BY_SHK_CAREER_SAME_NO = @"0";    //NO
NSString const *QK_JOB_EXPERIENCE_BY_SHK_CAREER_SAME_YES = @"1";    //YES

//favoriteCustomerF
NSString const *QK_FAV_CUSTOMER_NO = @"0";     //NO
NSString const *QK_FAV_CUSTOMER_YES = @"1";     //YES

//STATUS
NSString const *QK_STATUS_OK = @"10";     //OK
NSString const *QK_STATUS_NG = @"20";     //NG

//ACCOUNT STATUS
NSString const *QK_ACCOUNT_STATUS_WAIT_APPROVE = @"00";
NSString const *QK_ACCOUNT_STATUS_ENABLED = @"10";
NSString const *QK_ACCOUNT_STATUS_STOP = @"20";
NSString const *QK_ACCOUNT_STATUS_WITHDRAWAL = @"30";
NSString const *QK_ACCOUNT_STATUS_CLOSE = @"40";

//relationType
NSString const *QK_RELATION_TYPE_RECRUITMENT = @"00";
NSString const *QK_RELATION_TYPE_TEMPLATE = @"10";
NSString const *QK_RELATION_TYPE_SHOP = @"20";

//CANDIDATE STATUS
NSString const *QK_CANDIDATE_STATUS_YES_AND_ENOUGH = @"00";
NSString const *QK_CANDIDATE_STATUS_YES_AND_NOT_ENOUGH = @"10";
NSString const *QK_CANDIDATE_STATUS_NO = @"20";

//payStatementStatus
NSString const *QK_PAYMENT_STATUS_PAY = @"00";
NSString const *QK_PAYMENT_STATUS_DEDUCT = @"10";

//multiApplicationStatus
NSString const *QK_MUTIL_APP_STATUS_YES = @"00";
NSString const *QK_MUTIL_APP_STATUS_NO = @"10";
NSString const *QK_MUTIL_APP_STATUS_DONE = @"20";

//PaymentMethod
NSString const *QK_PAYMENT_METHOD_INDAY = @"00";
NSString const *QK_PAYMENT_METHOD_LATER = @"01";
NSString const *QK_PAYMENT_METHOD_BANK_TRANFER = @"02";

//NoticeType
NSString const *QK_CL_NOTICE_ID_0006 = @"0006";
NSString const *QK_CL_NOTICE_ID_0007 = @"0007";
NSString const *QK_CL_NOTICE_ID_0009 = @"0009";
NSString const *QK_CL_NOTICE_ID_0012 = @"0012";
NSString const *QK_CL_NOTICE_ID_0021 = @"0021";
NSString const *QK_CL_NOTICE_ID_0024 = @"0024";
NSString const *QK_CL_NOTICE_ID_0028 = @"0028";
NSString const *QK_CL_NOTICE_ID_0033 = @"0033";
NSString const *QK_CL_NOTICE_ID_0038 = @"0038";
NSString const *QK_CL_NOTICE_ID_0040 = @"0040";
NSString const *QK_CL_NOTICE_ID_0062 = @"0062";

NSString const *QK_CL_NOTICE_LIMIT = @"10";

#pragma mark -Map
+ (NSDictionary *)SHOP_TYPE_MAP {
    static NSDictionary *shopType;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shopType = @{
                     QK_SHOP_TYPE_CORPORATE : NSLocalizedString(@"法人", nil),
                     QK_SHOP_TYPE_INDIVIDUAL : NSLocalizedString(@"個人", nil),
                     };
    });
    return shopType;
}

+ (NSDictionary *)SERVICE_PERIOD_MAP {
    static NSDictionary *dic;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dic = @{
                };
    });
    return dic;
}

+ (NSDictionary *)SEX_FLG_MAP {
    static NSDictionary *sexFlg;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sexFlg = @{
                   SEX_FLG_MALE : @"男性",
                   SEX_FLG_FEMALE : @"女性",
                   };
    });
    return sexFlg;
}

+ (NSDictionary *)OCCUPATION_MAP {
    static NSDictionary *occupation;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        occupation = @{
                       OCCUPATION_01 : NSLocalizedString(@"学生", nil),
                       OCCUPATION_02 : NSLocalizedString(@"主婦・主夫", nil),
                       OCCUPATION_03 : NSLocalizedString(@"アルバイト・パート", nil),
                       OCCUPATION_04 : NSLocalizedString(@"派遣", nil),
                       OCCUPATION_05 : NSLocalizedString(@"家事手伝い", nil),
                       OCCUPATION_06 : NSLocalizedString(@"正社員", nil),
                       OCCUPATION_07 : NSLocalizedString(@"引退/退職", nil),
                       OCCUPATION_08 : NSLocalizedString(@"契約社員", nil),
                       OCCUPATION_09 : NSLocalizedString(@"失業/休職中", nil),
                       OCCUPATION_10 : NSLocalizedString(@"自営/独立", nil),
                       OCCUPATION_11 : NSLocalizedString(@"その他", nil),
                       };
    });
    return occupation;
}

+ (NSDictionary *)PAYMENT_SYSTEM_MAP {
    static NSDictionary *payment;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        payment = @{
                    PAYMENT_SYSTEM_TYPE_CD_CARD : @"クレジットカード",
                    PAYMENT_SYSTEM_TYPE_CD_BANK : @"銀行振込",
                    };
    });
    return payment;
}

+ (NSDictionary *)PAYMENT_METHOD_MAP {
    static NSDictionary *payment;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        payment = @{
                    QK_PAYMENT_METHOD_INDAY : NSLocalizedString(@" 当日現金支払", nil),
                    QK_PAYMENT_METHOD_LATER : NSLocalizedString(@" 後日現金支払", nil),
                    QK_PAYMENT_METHOD_BANK_TRANFER : NSLocalizedString(@"銀行振込", nil)
                    };
    });
    return payment;
}

#pragma mark -status code
//success
NSString const *QK_STT_CODE_SUCCESS            = @"0000";

//CL_ACC_0004
NSString const *QK_STT_CODE_NEW_VERSION = @"0020";
NSString const *QK_STT_CODE_ACCOUNT_STOP = @"0321";
NSString const *QK_STT_CODE_ACCOUNT_CLOSE = @"0322";
NSString const *QK_STT_CODE_SHOP_STOP = @"0408";
NSString const *QK_STT_CODE_SHOP_CLOSE = @"0409";
NSString const *QK_STT_CODE_ACCESSTOKEN_INVALID = @"0120";
NSString const *QK_STT_CODE_ACCESSTOKEN_EXPIRED = @"0300";
NSString const *QK_STT_CODE_ACCOUNT_INVALID = @"0320";
@end
