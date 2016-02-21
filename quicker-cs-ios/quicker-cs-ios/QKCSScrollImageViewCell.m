//
//  QKCSScrollImageViewCellCell.m
//  quicker-cs-ios
//
//  Created by C Anh on 8/19/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSScrollImageViewCell.h"
#import "QKImageModel.h"
#import "UIImageView+AFNetworking.h"

@implementation QKCSScrollImageViewCell

- (void)awakeFromNib {
    // Initialization code
    self.scrollView.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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

        if (_listImages.count > 0) {
            imageModel  = listImages[0];
            [self.imageView1 setImageWithURL:imageModel.imageUrl];
            self.pageControl.hidden = YES;
        }
        if (listImages.count > 1) {
            imageModel = listImages[1];
            [self.imageView2 setImageWithURL:imageModel.imageUrl];
            self.pageControl.hidden = NO;

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
