//
//  QKListQACell.m
//  quicker-cs-ios
//
//  Created by Nguyen Huu Anh on 7/2/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKListQACell.h"
#import "QKQaModel.h"
#import "QKF42Label.h"
#import "QKF33Label.h"

@implementation QKListQACell

- (void)setListQA:(NSArray *)listQA {
    _listQA = listQA;
    float width = CGRectGetWidth([UIApplication sharedApplication].keyWindow.frame) - 30;
    float y = 0;
    if (listQA.count == 0 || !listQA) {
        QKF42Label *qLabel = [[QKF42Label alloc] initWithFrame:CGRectMake(0, y, width, 15)];
        qLabel.text = @"投稿された質問はまだありません";
        qLabel.textAlignment = NSTextAlignmentCenter;
        [self.qaListView addSubview: qLabel];
        y = CGRectGetMaxY(qLabel.frame) + 10.0;
    } else {
        for (QKQaModel *qaModel in listQA) {
            QKF42Label *qLabel = [[QKF42Label alloc] initWithFrame:CGRectMake(0, y, width, 15)];
            qLabel.text = [NSString stringWithFormat:@"Q. %@", qaModel.question];
            CGRect labelFrame = qLabel.frame;
            labelFrame.size.width = width;
            qLabel.frame = labelFrame;
            [qLabel sizeToFit];
            [self.qaListView addSubview: qLabel];
            y = CGRectGetMaxY(qLabel.frame) + 10.0;
            
            QKF33Label *aLabel = [[QKF33Label alloc] initWithFrame:CGRectMake(5, y, width, 15.0)];
            if ([qaModel.answer isEqualToString:@""]) {
                aLabel.text = @"担当者の回答待ちです";
                aLabel.textColor = [UIColor lightGrayColor];
            } else {
                aLabel.text = qaModel.answer;
            }
            
            labelFrame = aLabel.frame;
            labelFrame.size.width = width;
            aLabel.frame = labelFrame;
            [aLabel sizeToFit];
            [self.qaListView addSubview:aLabel];
            y = CGRectGetMaxY(aLabel.frame) + 10.0;
        }
        CGRect frame = self.qaListView.frame;
        frame.size.height = y;
        self.qaListView.frame  = frame;
    }
    self.heightQAListViewContrain.constant = y;
    if (y == 0) {
        self.topContrain = 0;
    }
}

@end
