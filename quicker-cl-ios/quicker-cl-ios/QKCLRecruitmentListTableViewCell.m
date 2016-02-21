//
//  QKRecruitmentDoneTableViewCell.m
//  quicker-cl-ios
//
//  Created by Viet on 6/30/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLRecruitmentListTableViewCell.h"
#import "chiase-ios-core/NSString+Extra.h"
#import "QKCLConst.h"
#import "QKCLApplicantUserModel.h"
#import "NSDate+Extra.h"

@implementation QKCLRecruitmentListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupInterface];
}

- (void)setupInterface {
    self.recBackgroundView.layer.cornerRadius = 3.0f;
    self.recBackgroundView.backgroundColor = [UIColor whiteColor];
    self.recBackgroundView.layer.borderWidth = 1.0f;
    self.recBackgroundView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.recBackgroundView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setRecruitment:(QKCLRecruitmentModel *)recruitment {
    self.countDownLabel.text = @"";
    self.recruitmentStatusLabel.text = @"";
    
    //Working and choose
    if ([recruitment.recruitmentStatus isEqualToString:[NSString stringFromConst:QK_REC_STATUS_DONE_WORKING]]) {
        self.headerView.backgroundColor = kQKColorKey;
        
        if (recruitment.applicantList.count == 0) {
            self.applicantViewConstraint.constant = 0;
        }
        else {
            self.applicantViewConstraint.constant = 70;
            //Applicant image
            if (recruitment.applicantList.count < 7) {
                self.applicantMoreView.hidden = YES;
            }
            else {
                self.applicantMoreView.hidden = NO;
                self.applicantMoreLabel.text = [NSString stringWithFormat:@"%u", recruitment.applicantList.count - 6];
            }
            self.applicantImageView2.hidden = YES;
            self.applicantImageView3.hidden = YES;
            self.applicantImageView4.hidden = YES;
            self.applicantImageView5.hidden = YES;
            self.applicantImageView6.hidden = YES;
            NSInteger index = 0;
            for (QKCLApplicantUserModel *user in recruitment.applicantList) {
                index++;
                switch (index) {
                    case 1:
                    {
                        [self.applicantImageView1 setImageWithQKURL:user.applicantUserImageUrl placeholderImage:[UIImage imageNamed:@"account_pic_blankprofile"] withCache:YES];
                        break;
                    }
                        
                    case 2:
                    {
                        self.applicantImageView2.hidden = NO;
                        [self.applicantImageView2 setImageWithQKURL:user.applicantUserImageUrl placeholderImage:[UIImage imageNamed:@"account_pic_blankprofile"] withCache:YES];
                        break;
                    }
                        
                    case 3:
                    {
                        self.applicantImageView3.hidden = NO;
                        [self.applicantImageView3 setImageWithQKURL:user.applicantUserImageUrl placeholderImage:[UIImage imageNamed:@"account_pic_blankprofile"] withCache:YES];
                        break;
                    }
                        
                    case 4:
                    {
                        self.applicantImageView4.hidden = NO;
                        [self.applicantImageView4 setImageWithQKURL:user.applicantUserImageUrl placeholderImage:[UIImage imageNamed:@"account_pic_blankprofile"] withCache:YES];
                        break;
                    }
                        
                    case 5:
                    {
                        self.applicantImageView5.hidden = NO;
                        [self.applicantImageView5 setImageWithQKURL:user.applicantUserImageUrl placeholderImage:[UIImage imageNamed:@"account_pic_blankprofile"] withCache:YES];
                        break;
                    }
                        
                    case 6:
                    {
                        self.applicantImageView6.hidden = NO;
                        [self.applicantImageView6 setImageWithQKURL:user.applicantUserImageUrl placeholderImage:[UIImage imageNamed:@"account_pic_blankprofile"] withCache:YES];
                        break;
                    }
                        
                    default:
                        break;
                }
            }
        }
        self.employmentNumLabel.hidden = NO;
        
        
        self.applicantListSizeLabel.text = [NSString stringWithFormat:@"%lu 名から応募がきています。採用の合否を決定しましょう", (unsigned long)recruitment.applicantList.count];
        
        self.recruitmentStatusLabel.text = NSLocalizedString(@"募集終了まで", nil);
        
        
        //count down
        if ([recruitment.closingDt isLaterThanDate:[NSDate date]]) {
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
            NSDateComponents *components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit
                                                       fromDate:[NSDate date]
                                                         toDate:recruitment.closingDt
                                                        options:0];
            
            NSString *countDownString = @"";
            if (components.day > 0) {
                countDownString = [NSString stringWithFormat:@"あと%ld日%ld時間%ld分", (long)components.day, (long)components.hour, (long)components.minute];
            }
            else if (components.hour > 0) {
                countDownString = [NSString stringWithFormat:@"あと%ld時間%ld分", (long)components.hour, (long)components.minute];
            }
            else {
                if (components.minute > 5) {
                    countDownString = [NSString stringWithFormat:@"あと%ld分", (long)components.minute];
                }
                else {
                    countDownString = NSLocalizedString(@"まもなく終了！", nil);
                }
                // self.headerView.backgroundColor = kQKColorKey;
            }
            self.countDownLabel.text = countDownString;
        }
        else {
            self.countDownLabel.text  = NSLocalizedString(@"あと0分", nil);
            //self.headerView.backgroundColor = kQKColorKey;
        }
    }
    
    //Done
    else {
        if ([recruitment.recruitmentStatus isEqualToString:[NSString stringFromConst:QK_REC_STATUS_DONE_WORKER]] || [recruitment.recruitmentStatus isEqualToString:[NSString stringFromConst:QK_REC_STATUS_CLOSE_REC]]) {
            self.headerView.backgroundColor = kQKColorBtnSecondary;
        }
        else {
            self.headerView.backgroundColor = kQKColorDisabled;
        }
        self.applicantViewConstraint.constant = 0;
        self.employmentNumLabel.hidden = YES;
        
        if ([recruitment.recruitmentStatus isEqualToString:[NSString stringFromConst:QK_REC_STATUS_STOP]]) {
            self.recruitmentStatusLabel.text = NSLocalizedString(@"この募集は終了しました", nil);
        }
        else if ([recruitment.recruitmentStatus isEqualToString:[NSString stringFromConst:QK_REC_STATUS_DONE_WORKER]]) {
            self.recruitmentStatusLabel.text = NSLocalizedString(@"この募集は終了しました", nil);
        }
        else if ([recruitment.recruitmentStatus isEqualToString:[NSString stringFromConst:QK_REC_STATUS_DONE_REC]]) {
            self.recruitmentStatusLabel.text = NSLocalizedString(@"この募集は終了しました", nil);
        }
        else if ([recruitment.recruitmentStatus isEqualToString:[NSString stringFromConst:QK_REC_STATUS_CLOSE_REC]]) {
            self.recruitmentStatusLabel.text = NSLocalizedString(@"この募集は終了しました", nil);
        }
    }
    
    
    //common field
    self.jobtypeSNameLabel.text = recruitment.jobTypeSName;
    self.recruitmentStatusNameLabel.text = recruitment.recruitmentStatusName;
    //worktime
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MM月dd日 HH:mm"];
    NSString *startDate = [dateFormatter stringFromDate:recruitment.startDt];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *endDate = [dateFormatter stringFromDate:recruitment.endDt];
    
    if ([recruitment.startDt isSameDayWithDate:recruitment.endDt]) {
        self.workTimeLabel.text = [NSString stringWithFormat:@"%@ ~ %@", startDate, endDate];
    }
    else {
        self.workTimeLabel.text = [NSString stringWithFormat:@"%@ ~ 翌%@", startDate, endDate];
    }
    
    
    //Applicant ok
    self.applicationListCountLabel.text = [NSString stringWithFormat:@"%ld", (long)recruitment.adoptionList.count];
    self.employmentNumLabel.text = [NSString stringWithFormat:@"(残り%ld名)", (long)recruitment.employmentNum - recruitment.adoptionList.count];
}

@end
