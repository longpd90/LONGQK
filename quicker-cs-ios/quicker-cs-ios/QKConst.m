//
//  QKConst.m
//  quicker-cl-ios
//
//  Created by Viet on 5/5/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKConst.h"

@implementation QKConst
//Params for API
NSString const *QK_API_KEY = @"apiKey";
NSString const *QK_API_KEY_ACCESS_TOKEN = @"accessToken";
NSString const *QK_API_KEY_OS = @"os";
NSString const *QK_API_KEY_VERSION = @"version";
NSString const *QK_API_STATUS_CODE = @"statusCd";

#pragma mark  - Common const for CL and CS

//Shop status
NSString const *QK_SHOP_STATUS_EXAMINATING = @"00";
NSString const *QK_SHOP_STATUS_EXAM_NG = @"10";
NSString const *QK_SHOP_STATUS_PUBLIC = @"20";
NSString const *QK_SHOP_STATUS_DISABLED = @"30";
NSString const *QK_SHOP_STATUS_DELETED = @"40";
NSString const *QK_SHOP_STATUS_CLOSED = @"50";


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
NSString const *QK_SALARY_UNIT_HOUR = @"00";
NSString const *QK_SALARY_UNIT_DAY = @"01";
NSString const *QK_SALARY_UNIT_MONTH = @"02";

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
NSString const *QK_REC_STATUS_WORKING = @"00";
NSString const *QK_REC_STATUS_DONE_PERIOD = @"10";
NSString const *QK_REC_STATUS_STOP = @"20";
NSString const *QK_REC_STATUS_CHOOSING = @"30";
NSString const *QK_REC_STATUS_CHOOSE_DONE = @"40";
NSString const *QK_REC_STATUS_DONE_OFFER1 = @"50";
NSString const *QK_REC_STATUS_DONE_OFFER2 = @"60";

//WORK STATUS
NSString const *QK_WORK_STATUS_WORK_BEFORE = @"00";
NSString const *QK_WORK_STATUS_WORK = @"10";
NSString const *QK_WORK_STATUS_WORK_AFTER = @"20";

//WORK ACTUAL STATUS
NSString const *QK_WORK_ACTUAL_STATUS_00 = @"00";
NSString const *QK_WORK_ACTUAL_STATUS_10 = @"10";
NSString const *QK_WORK_ACTUAL_STATUS_20 = @"20";
NSString const *QK_WORK_ACTUAL_STATUS__25 = @"25";

//APPLI CANT STATUS
NSString const *QK_APPLI_CANT_STATUS_NOW = @"00";
NSString const *QK_APPLI_CANT_STATUS_OK = @"10";
NSString const *QK_APPLI_CANT_STATUS_NG = @"20";
NSString const *QK_APPLI_CANT_STATUS_CANCEL1= @"30";
NSString const *QK_APPLI_CANT_STATUS_CANCEL2 = @"35";
NSString const *QK_APPLI_CANT_STATUS_DUPLICATE = @"40";

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

#pragma mark -Const for CS
//SORT TYPE
NSString const *QK_SORT_TYPE_NEAR_LIMMIT = @"00";
NSString const *QK_SORT_TYPE_START_TIME = @"10";
NSString const *QK_SORT_TYPE_HIGH_SALARY = @"20";

//RATING STATUS
NSString const *QK_RATING_STATUS_NO = @"00";
NSString const *QK_RATING_STATUS_YES = @"10";


NSString const *QK_NOTICE_TYPE_MESSAGE = @"20";

#pragma mark- Map
+ (NSDictionary *)SEX_FLG_MAP {
    static NSDictionary *sexFlg;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sexFlg = @{
                   SEX_FLG_MALE : NSLocalizedString(@"男性", nil),
                   SEX_FLG_FEMALE : NSLocalizedString(@"女性", nil),
                   };
    });
    return sexFlg;
}

+ (NSDictionary *)PERIOD_MAP {
    static NSDictionary *period;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        period = @{
                   QK_SERVICE_PERIOD_SINGLE : NSLocalizedString(@"単発", nil),
                   QK_SERVICE_PERIOD_1_WEEK : NSLocalizedString(@"１週間くらい", nil),
                   QK_SERVICE_PERIOD_1_MONTH : NSLocalizedString(@"一か月くらい", nil),
                   QK_SERVICE_PERIOD_HALF_YEAR : NSLocalizedString(@"半年くらい", nil),
                   QK_SERVICE_PERIOD_OVER_1_YEAR : NSLocalizedString(@"一年以上", nil),
                   };
    });
    return period;
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

+ (NSDictionary *)WORK_STATUS_MAP {
    static NSDictionary *workStatus;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        workStatus = @{
                       QK_WORK_STATUS_WORK_BEFORE : NSLocalizedString(@"開始まであと6時間", nil),
                       QK_WORK_STATUS_WORK : NSLocalizedString(@"勤務中", nil),
                       QK_WORK_STATUS_WORK_AFTER : NSLocalizedString(@"実績入力待ち", nil),
                       };
    });
    return workStatus;
}

//+ (NSDictionary *)WORK_ACTUAL_STATUS_MAP {
//    static NSDictionary *workActualStatus;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        workActualStatus = @{
//                       QK_WORK_ACTUAL_STATUS_00: NSLocalizedString(@"実績入力前", nil),
//                       QK_WORK_ACTUAL_STATUS_10 : NSLocalizedString(@"実績入力済", nil),
//                       QK_WORK_ACTUAL_STATUS_20 : NSLocalizedString(@"異議申請中", nil),
//                       QK_WORK_ACTUAL_STATUS_25 : NSLocalizedString(@"実績承認", nil),
//
//                       };
//    });
//    return workActualStatus;
//}

+ (NSDictionary *)APPLI_CANT_STATUS_MAP {
    static NSDictionary *appiCantStatus;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appiCantStatus = @{
                       QK_APPLI_CANT_STATUS_NOW : NSLocalizedString(@"Blank", nil),
                       QK_APPLI_CANT_STATUS_OK : NSLocalizedString(@"選考修了", nil),
                       QK_APPLI_CANT_STATUS_NG : NSLocalizedString(@"選考修了", nil),
                       QK_APPLI_CANT_STATUS_CANCEL1 : NSLocalizedString(@"選考修了", nil),
                       QK_APPLI_CANT_STATUS_CANCEL2 : NSLocalizedString(@"選考終了/採用が取り消されました", nil),
                       QK_APPLI_CANT_STATUS_DUPLICATE : NSLocalizedString(@"選考終了/重複応募のためキャンセル", nil),

                       };
    });
    return appiCantStatus;
}

+ (NSDictionary *)PAYMENT_SYSTEM_MAP {
    static NSDictionary *payment;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        payment = @{
                    PAYMENT_SYSTEM_TYPE_CD_CARD : @"クレジットカード",
                    PAYMENT_SYSTEM_TYPE_CD_BANK : @"銀行",
                    };
    });
    return payment;
}

+ (NSDictionary *)SORT_TYPE_MAP {
    static NSDictionary *sort;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sort = @{
                 QK_SORT_TYPE_NEAR_LIMMIT : NSLocalizedString(@"募集締め切りが近い順", nil),
                 QK_SORT_TYPE_START_TIME : NSLocalizedString(@"バイト開始時間順", nil),
                 QK_SORT_TYPE_HIGH_SALARY : NSLocalizedString(@"時給が高い順", nil)
                 };
    });
    return sort;
}


#pragma mark -status code
//success
NSString const *QK_STT_CODE_SUCCESS             = @"0000";
NSString const *QK_STT_CODE_NEW_VERSION         = @"0020";
NSString const *QK_STT_CODE_ACCOUNT_STOP        = @"0321";
NSString const *QK_STT_CODE_ACCOUNT_CLOSED      = @"0322";
NSString const *QK_STT_CODE_ACCESSTOKEN_INVALID= @"0120";
NSString const *QK_STT_CODE_ACCESSTOKEN_EXPIRED= @"0300";
NSString const *QK_STT_CODE_ACCOUNT_INVALID= @"0320";

//limit for get recruitment list
NSString const *QK_CS_REC_LIST_LIMIT            = @"10";
@end
