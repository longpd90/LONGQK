//
//  PRSConfig.h
//  PusnaRS
//
//  Created by KOSHIDA Takayoshi on 2013/10/02.
//  Copyright (c) 2013年 RSD. All rights reserved.
//

#import "PRSGlobal.h"

/*!
 @class PRSConfig
 
 当クラスのインスタンスをPusnaRSのstartに設定することで、ライブラリ全体の動作を決定します。
 */
@interface PRSConfig : NSObject

/*!
 ライブラリ内ログの出力指定
 
 YES:
   ライブラリ内ログをコンソール出力します。
 NO(default):
   ライブラリ内ログを出力しません。
 */
@property (nonatomic) BOOL logging;

/*!
 本番モード指定
 
 YES(default):
   Pusna-RSの本番環境に接続します。
   Push Notification利用の場合、
   Distributionのプロビジョニングファイルを利用する場合は、YESにする必要があります。
 NO:
   Pusna-RSの開発環境に接続します。
   Push Notification利用の場合、
   Developmentのプロビジョニングファイルを利用する場合は、NOにする必要があります。
 */
@property (nonatomic) BOOL inProduction;

/*!
 デバイス登録: アプリID指定
 
 Pusna-RSにデバイス登録する際のパラメータ指定となります。
 独自にアプリIDを指定する場合にセットしてください。
 たとえば、旧Pusnaを利用していたアプリなどです。旧Pusnaの「通知ID」に相当します。
 
 指定しない場合には、Bundle IDを利用します。
 */
@property (nonatomic, copy) NSString *appId;

/*!
 デバイス登録: デバイスID指定
 
 Pusna-RSにデバイス登録する際のパラメータ指定となります。
 独自にデバイスIDを指定する場合に指定してください。
 たとえば、旧Pusnaを利用していたアプリなどです。
 
 指定しない場合には、ライブラリ側でランダムに生成します。
 生成／指定したデバイスIDは保存して使い回すようにします。
 */
@property (nonatomic, copy) NSString *deviceId;

/*!
 Pusna-RS開発環境 デバイス登録 URL
 
 特別に指定する必要がない限り、設定する必要はありません。
 */
@property (nonatomic, copy) NSString *developmentSubmissionURL;

/*!
 Pusna-RS本番環境 デバイス登録 URL
 
 特別に指定する必要がない限り、設定する必要はありません。
 */
@property (nonatomic, copy) NSString *productionSubmissionURL;

/*!
 デフォルト設定取得
 
 alloc - init は使用せず、こちらをご利用ください。
 */
+ (PRSConfig *)defaultConfig;

@end
