//
//  QKCSLoadingView.h
//  quicker-cs-ios
//
//  Created by VietND on 8/4/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QKCSLoadingView : UIRefreshControl
- (void)containingScrollViewDidEndDragging:(UIScrollView *)containingScrollView;
@end
