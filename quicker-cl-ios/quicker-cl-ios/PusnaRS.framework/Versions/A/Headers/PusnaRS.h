//
//  PusnaRS.h
//  PusnaRS
//  version 1.1.0
//
//  Created by KOSHIDA Takayoshi on 2013/10/02.
//  Copyright (c) 2013年 RSD. All rights reserved.
//

#import "PRSGlobal.h"

@class PRSConfig;

/*!
 @class PusnaRS
 
 Pusna-RSへのデバイス登録を行います。
 */
@interface PusnaRS : NSObject

PRS_SINGLETON_INTERFACE(PusnaRS);


/*!
 デバイス登録: アプリ情報登録(String)
 
 Pusna-RSにデバイス登録する際のパラメータ指定となります。
 アプリ固有の情報を、Pusna-RSに登録したい場合に当メソッドをご利用ください。
 また、当メソッドはライブラリ内のテンポラリ領域に値を保持するのみですので、
 保持した内容を送信するには、sendメソッドをコールしてください。
 
 Pusna-RS上から値を削除するには、valueにnilを指定してセットしてください。
 sendで送信後にPusna-RSから削除されます。
 
 @param value 送信データ
 @param key 送信データのキー
 */
- (void)setAppValueString:(NSString *)value forKey:(NSString *)key;

/*!
 デバイス登録: アプリ情報登録(Long)
 
 @param value 送信データ, NSNumberですが整数型で指定してください。64bit整数で指定可能です。
 @param key 送信データのキー
 @see アプリ情報登録(String)
 */
- (void)setAppValueLong:(NSNumber *)value forKey:(NSString *)key;

/*!
 デバイス登録: アプリ情報登録(Date)
 
 @param value 送信データ
 @param key 送信データのキー
 @see アプリ情報登録(String)
 */
- (void)setAppValueDate:(NSDate *)value forKey:(NSString *)key;

/*!
 ライブラリ開始
 
 application:didFinishLaunchingWithOptions: で1度だけコールしてください。
 */
- (void)start:(PRSConfig *)config;

/*!
 サーバー同期
 
 ライブラリ内のテンポラリ領域に保持したデバイス登録情報を、PusnaRSに送信します。
 */
- (void)send;

/*!
 利用可能状態
 
 @return YES:sendメソッドが利用可能です / NO:sendメソッドは利用不可能です
 */
@property (readonly) BOOL ready;

/*!
 通知ID取得
 
 デバイス登録に利用する通知IDを取得します。
 configで指定した場合はその値となります。
 */
@property (nonatomic, readonly) NSString *appId;

/*!
 デバイスID取得
 
 デバイス登録に利用するデバイスIDを取得します。
 configで指定した場合はその値となります。
 */
@property (nonatomic, readonly) NSString *deviceId;


#pragma mark - Methods for internal use

/*!
 デバイス登録: デバイストークン登録
 
 Pusna-RSにデバイス登録する際のパラメータ指定となります。
 PusnaRSライブラリ内で利用するメソッドですので、アプリからはコールしないでください。
 */
- (void)setDeviceToken:(NSString *)deviceToken;

/*!
 デバイス登録: Push起動日時登録
 
 Pusna-RSにデバイス登録する際のパラメータ指定となります。
 PusnaRSライブラリ内で利用するメソッドですので、アプリからはコールしないでください。
 */
- (void)setLastPushLaunchAt:(NSDate *)date;

/*!
 デバイス登録: Push設定登録
 
 Pusna-RSにPush設定登録する際のパラメータ指定となります。
 PusnaRSライブラリ内で利用するメソッドですので、アプリからはコールしないでください。
 */
- (void)setPushStat;

@end
