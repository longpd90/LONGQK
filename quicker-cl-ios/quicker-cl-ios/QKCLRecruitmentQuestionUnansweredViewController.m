//
//  QKRecruitmentQuestionDetailViewController.m
//  quicker-cl-ios
//
//  Created by Quy on 7/21/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLRecruitmentQuestionUnansweredViewController.h"
#import "QKCLRecruitmentInformationViewController.h"
#import "QKCLRecruitmentQuestionListViewController.h"
#import "QKRecruitmentQuestionTableViewCell.h"
#import "QKTextViewTableViewCell.h"
#import "QKCLQaModel.h"
@interface QKCLRecruitmentQuestionUnansweredViewController () <UITableViewDelegate, UITableViewDataSource, QKTextViewCellDelegate>
@property (strong, nonatomic) NSString *answer;
@property (nonatomic) CGFloat heightOfTextView;

@property (strong, nonatomic) QKCLQaModel *model;
@end
static NSString *kQKRecruitmentQuestionTableViewCellIdentifier = @"QKRecruitmentQuestionTableViewCell";
static NSString *kQKTextViewTableViewCellIdentifier = @"QKTextViewTableViewCell";
@implementation QKCLRecruitmentQuestionUnansweredViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAngleLeftBarButton];
    self.navigationItem.title = NSLocalizedString(@"質問への回答", nil);
    [self setRightBarButtonWithTitle:@"削除" target:@selector(deleteQuestion:)];
    [self.answeredButtonOutlet setEnabled:NO];
    [self.thisTableView registerNib:[UINib nibWithNibName:kQKRecruitmentQuestionTableViewCellIdentifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kQKRecruitmentQuestionTableViewCellIdentifier];
    [self.thisTableView registerNib:[UINib nibWithNibName:kQKTextViewTableViewCellIdentifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kQKTextViewTableViewCellIdentifier];
    self.bottomView.backgroundColor = [UIColor clearColor];
    [self getRecruitmentQuestion];
    [self.thisTableView setBackgroundColor:[UIColor clearColor]];
    
    //self.thisTableView.scrollEnabled = YES;
}

- (void)deleteQuestion:(id)sender {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:self.qaId forKey:@"qaId"];
        
        [[QKCLRequestManager sharedManager] asyncPOST:[NSString stringFromConst:qkClUrlRecruitmentQuestionDelete] parameters:params showLoading:YES showError:NO success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            else {
                CCAlertView *alert = [[CCAlertView alloc]initWithImage:[UIImage imageNamed:@"dialog_pic_delete"] title:nil message:responseObject[@"msg"] delegate:self buttonTitles:@[@"OK"]];
                
                [alert showAlert];
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
    else {
        [self showNoInternetViewWithSelector:nil];
    }
}

- (void)getRecruitmentQuestion {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        
        [params setObject:self.qaId
                   forKey:@"qaId"];
        [[QKCLRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkClUrlRecruitmentQuestionDetail] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"statuscd succes %@", responseObject[QK_API_STATUS_CODE]);
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                self.model = [[QKCLQaModel alloc]initWithResponse:responseObject];
                
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
        [self showNoInternetViewWithSelector:@selector(getRecruitmentQuestion)];
    }
}

#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    switch (indexPath.section) {
        case 0:
        {
            QKRecruitmentQuestionTableViewCell *cells = (QKRecruitmentQuestionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kQKRecruitmentQuestionTableViewCellIdentifier forIndexPath:indexPath];
            
            [cells.questionLabel setText:self.model.question];
            
            
            cell = cells;
            
            break;
        }
            
        case 1: {
            QKTextViewTableViewCell *cells = (QKTextViewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kQKTextViewTableViewCellIdentifier forIndexPath:indexPath];
            cells.textView.text = self.answer;
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 56.0f;
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
            
            return self.thisTableView.frame.size.height -  64.0 - self.bottomView.height - (56.0 * 2) - self.heightOfTextView - self.tabBarController.tabBar.frame.size.height;
            
        case 2:
            return 115.0f;
            
        default:
            break;
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (void)editingChanged:(UITextView *)textView {
    self.answer = textView.text;
    if (self.answer != nil && ![self.answer isEqualToString:@""]) {
        [self.answeredButtonOutlet setEnabled:YES];
    }
    else {
        [self.answeredButtonOutlet setEnabled:NO];
    }
}

- (IBAction)answerButtonClicked:(id)sender {
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
        [self showNoInternetViewWithSelector:@selector(answerButtonClicked:)];
    }
}

@end
