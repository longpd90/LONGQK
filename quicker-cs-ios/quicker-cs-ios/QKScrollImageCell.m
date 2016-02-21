//
//  QKScrollImageCell.m
//  quicker-cs-ios
//
//  Created by Nguyen Huu Anh on 7/2/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKScrollImageCell.h"
#import "UIImageView+AFNetworking.h"
#import "QKImageModel.h"

@implementation QKScrollImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.scrollView.delegate = self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width * _listImages.count, 215);
}

- (void)setListImages:(NSArray *)listImages {
    @try {
        _listImages = listImages;
        self.pageControl.numberOfPages = _listImages.count;
        QKImageModel *imageModel;
        if (listImages.count > 0) {
            imageModel = listImages[0];
            [self.imageView1 setImageWithURL:imageModel.imageUrl];
        }
        if (listImages.count > 1) {
            imageModel = listImages[1];
            [self.imageView2 setImageWithURL:imageModel.imageUrl];
        }
        if (listImages.count > 2) {
            imageModel = listImages[2];
            [self.imageView3 setImageWithURL:imageModel.imageUrl];
        }
    }
    @catch (NSException *exception)
    {
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, 0)];
    float screen_size = self.scrollView.frame.size.width;
    self.pageControl.currentPage = scrollView.contentOffset.x / screen_size;
}
@end
