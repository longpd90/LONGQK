//
//  QKFinalRecruitmentNewViewController.h
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 6/25/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLBaseViewController.h"
#import "QKTableViewCell.h"
#import "QKTextViewTableViewCell.h"
#import "QKCLRecruitmentModel.h"

@protocol QKCLRecruitmentNewStep2ViewControllerDelegate <NSObject>
- (void)popViewControllerWithData:(QKCLRecruitmentModel *)data;
@end

@interface QKCLRecruitmentNewStep2ViewController : QKCLBaseViewController <QKTextViewCellDelegate>
@property (weak, nonatomic) id <QKCLRecruitmentNewStep2ViewControllerDelegate> delegate;
@property (strong, nonatomic) QKCLRecruitmentModel *recruitmentModel;

@end
