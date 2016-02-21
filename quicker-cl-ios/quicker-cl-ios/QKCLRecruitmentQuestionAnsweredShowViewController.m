//
//  QKRecruitmentQuestionDetailAnsweredViewController.m
//  quicker-cl-ios
//
//  Created by Quy on 7/22/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLRecruitmentQuestionAnsweredShowViewController.h"
#import "QKCLQaModel.h"
#import "QKRecruitmentQuestionTableViewCell.h"
#import "QKTextViewTableViewCell.h"
#import "QKCLRecruitmentQuestionAnsweredEditViewController.h"
@interface QKCLRecruitmentQuestionAnsweredShowViewController () <UITableViewDataSource, UITableViewDelegate>



@property (nonatomic) CGFloat heightOfTextView;

@property (strong, nonatomic) QKCLQaModel *model;
@end
static NSString *kQKRecruitmentQuestionTableViewCellIdentifier = @"QKRecruitmentQuestionTableViewCell";
static NSString *kQKTextViewTableViewCellIdentifier = @"QKTextViewTableViewCell";
@implementation QKCLRecruitmentQuestionAnsweredShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAngleLeftBarButton];
    [self setTitle:@"質問への回答"];
    [self setRightBarButtonWithTitle:@"編集" target:@selector(editQuestion:)];
    [self.thisTableView registerNib:[UINib nibWithNibName:kQKRecruitmentQuestionTableViewCellIdentifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kQKRecruitmentQuestionTableViewCellIdentifier];
    [self.thisTableView registerNib:[UINib nibWithNibName:kQKTextViewTableViewCellIdentifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kQKTextViewTableViewCellIdentifier];
    self.bottomView.backgroundColor = [UIColor clearColor];
    
    [self.thisTableView setBackgroundColor:[UIColor clearColor]];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getRecruitmentQuestionAnswered];
}

- (void)editQuestion:(id)sender {
    [self performSegueWithIdentifier:@"QKRecruitmentQuestionEditSegue" sender:self];
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
            //[cells.lengthText setHidden:YES];
            cells.textView.text = self.model.answer;
            [cells setEditable:NO];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"QKRecruitmentQuestionEditSegue"]) {
        QKCLRecruitmentQuestionAnsweredEditViewController *vc = (QKCLRecruitmentQuestionAnsweredEditViewController *)segue.destinationViewController;
        vc.qaId = self.model.qaId;
    }
}

@end
