//
//  QKScrollImageCell.h
//  quicker-cs-ios
//
//  Created by Nguyen Huu Anh on 7/2/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QKScrollImageCell : UITableViewCell <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIImageView *circle1;
@property (weak, nonatomic) IBOutlet UIImageView *circle2;
@property (weak, nonatomic) IBOutlet UIImageView *circle3;

@property (strong, nonatomic) NSArray *listImages;

@end
