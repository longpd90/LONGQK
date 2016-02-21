//
//  QKEditRecruitmentQuestionDetailAnsweredViewController.m
//  quicker-cl-ios
//
//  Created by Quy on 7/22/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLRecruitmentQuestionAnsweredEditViewController.h"
#import "QKCLQaModel.h"
#import "QKTextViewTableViewCell.h"
#import "QKRecruitmentQuestionTableViewCell.h"
#import "QKCLRecruitmentInformationViewController.h"

@interface QKCLRecruitmentQuestionAnsweredEditViewController () <CCAlertViewDelegate, QKTextViewCellDelegate>

@property (nonatomic) CGFloat heightOfTextView;
@property (strong, nonatomic) NSString *answer;
@property (strong, nonatomic) QKCLQaModel *model;
@end
static NSString *kQKRecruitmentQuestionTableViewCellIdentifier = @"QKRecruitmentQuestionTableViewCell";
static NSString *kQKTextViewTableViewCellIdentifier = @"QKTextViewTableViewCell";
@implementation QKCLRecruitmentQuestionAnsweredEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftBarButtonWithTitle:@"キャンセル" target:@selector(goBack:)];
    [self setTitle:@"質問への回答"];
    [self setRightBarButtonWithTitle:@"完了" target:@selector(saveAnsered:)];
    [self.thisTableView registerNib:[UINib nibWithNibName:kQKRecruitmentQuestionTableViewCellIdentifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kQKRecruitmentQuestionTableViewCellIdentifier];
    [self.thisTableView registerNib:[UINib nibWithNibName:kQKTextViewTableViewCellIdentifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kQKTextViewTableViewCellIdentifier];
    [self getRecruitmentQuestionAnswered];
    [self.thisTableView setBackgroundColor:[UIColor clearColor]];
    // Do any additional setup after loading the view.
}

- (void)saveAnsered:(id)sender {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:self.qaId forKey:@"qaId"];
        [params setObject:self.answer forKey:@"answer"];
        [params setValue:[NSString stringFromConst:QK_RELATION_TYPE_RECRUITMENT] forKey:@"relationType"];
        [params setValue:[NSString stringFromConst:QK_OPEN_STATUS_PUBLIC] forKey:@"openStatus"];
        [[QKCLRequestManager sharedManager] asyncPOST:[NSString stringFromConst:qkClUrlRecruitmentQuestionAnswer] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failed ... %@ ", error);
        }];
    }
    else {
        [self showNoInternetViewWithSelector:@selector(saveAnsered:)];
    }
}

#pragma AMRK QKTextViewDelegate
- (void)editingChanged:(UITextView *)textView {
    self.answer = textView.text;
}

#pragma mark UITableviewDeledgate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 56.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    switch (indexPath.section) {
        case 0:
        {
            QKRecruitmentQuestionTableViewCell *cells = (QKRecruitmentQuestionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kQKRecruitmentQuestionTableViewCellIdentifier forIndexPath:indexPath];
            
            [cells.questionLabel setText:
             self.model.question];
            
            
            cell = cells;
            
            break;
        }
            
        case 1: {
            QKTextViewTableViewCell *cells = (QKTextViewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kQKTextViewTableViewCellIdentifier forIndexPath:indexPath];
            
            [cells setMaxLength:200];
            [cells setText:self.answer];
            cells.delegate = self;
            cell  = cells;
            break;
        }
            
        default:
            break;
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return NSLocalizedString(@"質問", nil);
            
        case 1:
            return NSLocalizedString(@"回答", nil);
            
        default:
            return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            QKRecruitmentQuestionTableViewCell *cells = (QKRecruitmentQuestionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kQKRecruitmentQuestionTableViewCellIdentifier];
            [cells.questionLabel setNumberOfLines:0];
            cells.questionLabel.preferredMaxLayoutWidth = CGRectGetWidth(cells.frame) - 44;
            [cells.questionLabel setText:self.model.question];
            
            self.heightOfTextView = [self calculateHeightForConfiguredSizingCell:cells inTableView:tableView];
            return self.heightOfTextView;
        }
            
        case 1:
            
            return self.thisTableView.frame.size.height -  64.0 - self.bottomView.height - (56.0 * 2) - self.heightOfTextView;
            
        case 2:
            return 84.0f;
            
        default:
            break;
    }
    return 44;
}

- (void)getRecruitmentQuestionAnswered {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        
        [params setObject:self.qaId
                   forKey:@"qaId"];
        [[QKCLRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkClUrlRecruitmentQuestionDetail] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"statuscd succes %@", responseObject[QK_API_STATUS_CODE]);
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                self.model = [[QKCLQaModel alloc]initWithResponse:responseObject];
                self.answer = self.model.answer;
                [self.thisTableView reloadData];
                
                //set totalNum to tab
            }
            else {
                NSLog(@"responseObject : %@ ", responseObject[@"msg"]);
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
    else {
        [self showNoInternetViewWithSelector:@selector(getRecruitmentQuestionAnswered)];
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (void)deleteAnswerAndQuestion {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:self.qaId forKey:@"qaId"];
        
        [[QKCLRequestManager sharedManager] POST:[NSString stringFromConst:qkClUrlRecruitmentQuestionDelete] parameters:params success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                CCAlertView *alert = [[CCAlertView alloc]initWithImage:[UIImage imageNamed:@"dialog_pic_done"] title:nil message:@"質問を削除しました" delegate:self buttonTitles:@[@"OK"]];
                [alert setTag:200];
                [alert showAlert];
            }
            else {
                CCAlertView *alert = [[CCAlertView alloc]initWithImage:[UIImage imageNamed:@"dialog_pic_delete"] title:nil message:responseObject[@"msg"] delegate:self buttonTitles:@[@"OK"]];
                
                [alert showAlert];
            }
            
            //check invalidAccount
            //[[QKRequestManager sharedManager]checkInvalidAccount:responseObject];
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
    else {
        [self showNoInternetViewWithSelector:nil];
    }
}

- (IBAction)deleteQuestion:(id)sender {
    CCAlertView *alert = [[CCAlertView alloc]initWithTitle:@"質問を削除しますか？" message:nil delegate:self buttonTitles:@[@"しない", @"削除する"]];
    [alert setTag:100];
    [alert showAlert];
}

- (void)alertView:(CCAlertView *)alertView selectedButtonIndex:(NSInteger)index {
    if (alertView.tag == 100) {
        if (index == 1) {
            [self deleteAnswerAndQuestion];
        }
    }
    if (alertView.tag == 200) {
        if (index == 0) {
            NSMutableArray *allViewControllers = [NSMutableArray arrayWithArray:[self.navigationController viewControllers]];
            for (UIViewController *aViewController in allViewControllers) {
                if ([aViewController isKindOfClass:[QKCLRecruitmentInformationViewController class]]) {
                    [self.navigationController popToViewController:aViewController animated:YES];
                }
            }
        }
    }
}

@end
