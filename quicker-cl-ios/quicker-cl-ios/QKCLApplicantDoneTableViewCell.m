//
//  QKCLApplicantDoneTableViewCell.m
//  quicker-cl-ios
//
//  Created by Quy on 8/5/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLApplicantDoneTableViewCell.h"
#import "QKCLConst.h"
#import "chiase-ios-core/UIColor+Extra.h"
#import "chiase-ios-core/NSString+Extra.h"
#import "NSDate+Extra.h"

@implementation QKCLApplicantDoneTableViewCell

- (void)awakeFromNib {
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        [self.contentView setBackgroundColor:[UIColor colorWithHexString:@"#D9D9D9"]];
    }
    else {
        [self.contentView setBackgroundColor:[UIColor clearColor]];
    }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    if (highlighted) {
        [self.contentView setBackgroundColor:[UIColor colorWithHexString:@"#D9D9D9"]];
    }
    else {
        [self.contentView setBackgroundColor:[UIColor clearColor]];
    }
}

-(void)setData:(QKCLAdoptionUserModel*)adoptUserModel withRecruitment:(QKCLRecruitmentModel*)recruitmentModel {
    [self.jobtypeSNameLabel setText:adoptUserModel.adoptionUserName];
    if (adoptUserModel.adoptionUserImagePath != nil) {
        [self.avartarImageView setImageWithQKURL:adoptUserModel.adoptionUserImagePath withCache:YES];
    }
    self.workTimeLabel.text  = [NSString stringWithFormat:@"(%@歳・女性)", [adoptUserModel.adoptionUserBirthday convertToAge]];
    
    
    if ([recruitmentModel.workStatus isEqualToString:[NSString stringFromConst:QK_WORK_STATUS_WORK_BEFORE ]] ||[recruitmentModel.workStatus isEqualToString:[NSString stringFromConst:QK_WORK_STATUS_WORK ]]) {
        //hide pyment button and cancel button
        [self.paymentButton removeFromSuperview];
        [self.cancelView removeFromSuperview];
        self.noPaymentAndCancelButtonConstrainst.constant = 10.0f;
        [self layoutIfNeeded];
        
    }else if ([recruitmentModel.workStatus isEqualToString:[NSString stringFromConst:QK_WORK_STATUS_WORK_AFTER ]]) {
        if ( [adoptUserModel.workActualStatus isEqualToString:[NSString stringFromConst:QK_CL_WORK_ACTUAL_STATUS_INPUT_BEFORE]]) {
            //actualStatus = 00
            [self.paymentButton setTitle:NSLocalizedString(@"勤務実績を入力する", nil) forState:UIControlStateNormal];
            [self removeConstraint:self.noPaymentButtonContrainst];
            [self removeConstraint:self.noCancelButtonConstrainst];
            [self removeConstraint:self.noPaymentAndCancelButtonConstrainst];
        }
        else if ( [adoptUserModel.workActualStatus isEqualToString:[NSString stringFromConst:QK_CL_WORK_ACTUAL_STATUS_INPUT_ALREADY]]) {
            //actualStatus = 10
            [self.paymentButton removeFromSuperview];
            [self.cancelView removeFromSuperview];
            self.noPaymentAndCancelButtonConstrainst.constant = 10.0f;
            [self layoutIfNeeded];
            
        }else if ( [adoptUserModel.workActualStatus isEqualToString:[NSString stringFromConst:QK_CL_WORK_ACTUAL_STATUS_PENDING]]) {
            //actualStatus = 20
            [self.paymentButton setTitle:NSLocalizedString(@"勤務実績を修正する", nil) forState:UIControlStateNormal];
            [self.cancelView removeFromSuperview];
            [self removeConstraint:self.noPaymentButtonContrainst];
            [self removeConstraint:self.noPaymentAndCancelButtonConstrainst];
            self.noCancelButtonConstrainst.constant = 10.0f;
            [self layoutIfNeeded];
            
        }else if ( [adoptUserModel.workActualStatus isEqualToString:[NSString stringFromConst:QK_CL_WORK_ACTUAL_STATUS_APPROVAL]]) {
            //actualStatus = 25
            [self.paymentButton removeFromSuperview];
            [self.cancelView removeFromSuperview];
            self.noPaymentAndCancelButtonConstrainst.constant = 10.0f;
            [self layoutIfNeeded];
            
        }
        
    }
    
    
    
    
}
@end
