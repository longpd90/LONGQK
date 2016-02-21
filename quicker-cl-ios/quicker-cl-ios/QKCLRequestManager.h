//
//  QKRequestManager.h
//  quicker-cl-ios
//
//  Created by Viet on 5/14/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface QKCLRequestManager : AFHTTPRequestOperationManager
+ (QKCLRequestManager *)sharedManager;
@end
