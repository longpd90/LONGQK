//
//  QKRecruitmentListQuestionViewController.m
//  quicker-cl-ios
//
//  Created by Quy on 7/6/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLRecruitmentQuestionListViewController.h"
#import "QKCLRecruitmentInformationViewController.h"
#import "QKCLQaModel.h"
#import "QKCLRecruitmentQuestionUnansweredViewController.h"
#import "QKCLRecruitmentQuestionAnsweredShowViewController.h"

static NSString *kQKRecruitmentQuestionTableViewCellIdentifier = @"QKRecruitmentQuestionTableViewCell";

@interface QKCLRecruitmentQuestionListViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSMutableArray *questionNoAnswerArray;
@property (strong, nonatomic) NSMutableArray *questionHistoryAnsweredArray;
@property (strong, nonatomic) NSMutableArray *questionToDayAnsweredArray;
@property (strong, nonatomic) NSString *answeredQuestion;
@property (strong, nonatomic) QKCLQaModel *model;
@property (nonatomic) NSInteger selectedRow;
@property (strong, nonatomic) NSMutableArray *allAlrray;
@property (strong, nonatomic) NSIndexPath *indexQaDelete;
@property (nonatomic) NSInteger totalNum;


@end

@implementation QKCLRecruitmentQuestionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.thisTableView registerNib:[UINib nibWithNibName:kQKRecruitmentQuestionTableViewCellIdentifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kQKRecruitmentQuestionTableViewCellIdentifier];
    _questionNoAnswerArray = [[NSMutableArray alloc] init];
    
    _questionToDayAnsweredArray = [[NSMutableArray alloc] init];
    _questionHistoryAnsweredArray = [[NSMutableArray alloc]init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self instalization];
}

- (void)instalization {
    [_questionNoAnswerArray removeAllObjects];
    [_questionToDayAnsweredArray removeAllObjects];
    [_questionHistoryAnsweredArray removeAllObjects];
    [self.thisTableView setEditing:NO];
    [self.thisTableView setBackgroundColor:[UIColor clearColor]];
    [self getRecruitmentListQuestion];
}

- (void)checkRecruitmentQuestion {
    if (_totalNum > 0) {
        [self.thisTableView setHidden:NO];
        [self.noQuestionView setHidden:YES];
    }
    else {
        [self.thisTableView setHidden:YES];
        [self.noQuestionView setHidden:NO];
        self.parentViewController.navigationController.navigationItem.rightBarButtonItem  = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getRecruitmentListQuestion {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        
        [params setValue:_recruitmentId forKey:@"recruitmentId"];
        [[QKCLRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkClUrlRecruitmentQuestionList] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                _totalNum = [responseObject[@"totalNum"] integerValue];
                for (NSDictionary *dic in responseObject[@"qaList"][@"unanswered"]) {
                    QKCLQaModel *unAnserModel = [[QKCLQaModel alloc]initWithResponse:dic];
                    [self.questionNoAnswerArray addObject:unAnserModel];
                }
                for (NSDictionary *dic in responseObject[@"qaList"][@"answered"]) {
                    QKCLQaModel *answeredModel = [[QKCLQaModel alloc]initWithResponse:dic];
                    [self.questionToDayAnsweredArray addObject:answeredModel];
                }
                for (NSDictionary *dic in responseObject[@"qaList"][@"history"]) {
                    QKCLQaModel *historyModel = [[QKCLQaModel alloc]initWithResponse:dic];
                    [self.questionHistoryAnsweredArray addObject:historyModel];
                }
                
                [self checkRecruitmentQuestion];
                [self reloadTotalNum];
                
                [self.thisTableView reloadData];
                
                //set totalNum to tab
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
    else {
        [self showNoInternetViewWithSelector:@selector(getRecruitmentListQuestion)];
    }
}

#pragma TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return [_questionNoAnswerArray count];
            
        case 1:
            return [_questionToDayAnsweredArray count];
            
        case 2:
            return [_questionHistoryAnsweredArray count];
            
        default: return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedRow = indexPath.row;
    
    switch (indexPath.section) {
        case 0: {
            [self performSegueWithIdentifier:@"QKRecruitmentQuestionDetailNoAnswerSegue" sender:self];
            break;
        }
            
        case 1:
        case 2:
        {
            [self performSegueWithIdentifier:@"QKRecruitmentQuestionDetailAnsweredSegue" sender:self];
            break;
        }
            
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QKRecruitmentQuestionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kQKRecruitmentQuestionTableViewCellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[QKRecruitmentQuestionTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kQKRecruitmentQuestionTableViewCellIdentifier];
    }
    [cell.questionLabel setNumberOfLines:2];
    switch (indexPath.section) {
        case 0: {
            QKCLQaModel *model = [_questionNoAnswerArray objectAtIndex:indexPath.row];
            cell.questionLabel.text = model.question;
            
            break;
        }
            
        case 1: {
            QKCLQaModel *model = [_questionToDayAnsweredArray objectAtIndex:indexPath.row];
            cell.questionLabel.text = model.question;
            break;
        }
            
        case 2:
        {
            QKCLQaModel *model = [_questionHistoryAnsweredArray objectAtIndex:indexPath.row];
            cell.questionLabel.text = model.question;
            
            break;
        }
            
        default:
            break;
    }
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *sectionName;
    switch (section) {
        case 0:
            sectionName = NSLocalizedString(@"未回答", nil);
            break;
            
        case 1:
            sectionName = NSLocalizedString(@"回答済", nil);
            break;
            
            
        case 2:
            sectionName = NSLocalizedString(@"過去の回答", nil);
            break;
            
        default:
            sectionName = nil;
            break;
    }
    return sectionName;
}

- (void)deleteQuestion {
    if ([self connected]) {
        QKCLQaModel *model;
        int delteleStatus;
        switch (_indexQaDelete.section) {
            case 0:
                model = (QKCLQaModel *)[self.questionNoAnswerArray objectAtIndex:self.indexQaDelete.row];
                delteleStatus = 0;
                break;
                
            case 1:
                model = (QKCLQaModel *)[self.questionToDayAnsweredArray objectAtIndex:self.indexQaDelete.row];
                delteleStatus = 1;
                break;
                
            case 2:
                model = (QKCLQaModel *)[self.questionHistoryAnsweredArray objectAtIndex:self.indexQaDelete.row];
                delteleStatus = 2;
                break;
                
            default:
                break;
        }
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:model.qaId forKey:@"qaId"];
        
        [[QKCLRequestManager sharedManager] POST:[NSString stringFromConst:qkClUrlRecruitmentQuestionDelete] parameters:params success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                [[self.allAlrray objectAtIndex:delteleStatus] removeObjectAtIndex:self.indexQaDelete.row];
                
                [self.thisTableView deleteRowsAtIndexPaths:@[self.indexQaDelete] withRowAnimation:UITableViewRowAnimationFade];
                [self reloadTotalNum];
                [self.thisTableView reloadData];
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        self.indexQaDelete = indexPath;
        [self deleteQuestion];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"QKRecruitmentQuestionDetailNoAnswerSegue"]) {
        QKCLRecruitmentQuestionUnansweredViewController *vc = (QKCLRecruitmentQuestionUnansweredViewController *)segue.destinationViewController;
        QKCLQaModel *model = [self.questionNoAnswerArray
                              objectAtIndex:self.selectedRow];
        vc.qaId = model.qaId;
    }
    if ([segue.identifier isEqualToString:@"QKRecruitmentQuestionDetailAnsweredSegue"]) {
        QKCLRecruitmentQuestionAnsweredShowViewController *vc = (QKCLRecruitmentQuestionAnsweredShowViewController *)segue.destinationViewController;
        QKCLQaModel *model = [self.questionToDayAnsweredArray
                              objectAtIndex:self.selectedRow];
        vc.qaId = model.qaId;
    }
}

- (void)reloadTotalNum {
    QKCLRecruitmentInformationViewController *recInfoViewController = (QKCLRecruitmentInformationViewController *)self.parentViewController;
    NSInteger toltalQuesttion = [_questionNoAnswerArray count];
    if (toltalQuesttion > 0) {
        [recInfoViewController.rightButton setTitle:[NSString stringWithFormat:@"質問(%ld)", (long)toltalQuesttion] forState:UIControlStateNormal];
        
        [recInfoViewController.rightButton setTitle:[NSString stringWithFormat:@"質問(%ld)", (long)toltalQuesttion] forState:UIControlStateSelected];
        [recInfoViewController.rightButton1 setTitle:[NSString stringWithFormat:@"質問(%ld)", (long)toltalQuesttion] forState:UIControlStateNormal];
        
        [recInfoViewController.rightButton1 setTitle:[NSString stringWithFormat:@"質問(%ld)", (long)toltalQuesttion] forState:UIControlStateSelected];
    }
    else {
        [recInfoViewController.rightButton setTitle:@"質問" forState:UIControlStateNormal];
        
        [recInfoViewController.rightButton setTitle:@"質問" forState:UIControlStateSelected];
        [recInfoViewController.rightButton1 setTitle:@"質問" forState:UIControlStateNormal];
        
        [recInfoViewController.rightButton1 setTitle:@"質問" forState:UIControlStateSelected];
    }
}

@end
