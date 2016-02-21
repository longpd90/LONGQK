//
//  QKJobQuestionViewController.m
//  quicker-cs-ios
//
//  Created by LongPD-PC on 6/9/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKRecruitmentQuestionNewViewController.h"
#import "QKTextViewTableViewCell.h"
#import "QKCSWebViewController.h"
#define updateButtonTag 10
#define LastCell @"LastCell"
static NSString *kQKTextViewTableViewCellIdentifier = @"QKTextViewTableViewCell";

@interface QKRecruitmentQuestionNewViewController () <QKTextViewCellDelegate, CCAlertViewDelegate>
@property (strong, nonatomic) NSString *textViewContent;
@property (strong, nonatomic) CCAlertView *confirmAlert;

@end

@implementation QKRecruitmentQuestionNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"質問を投稿", nil);
    
    [self setLeftBarButtonWithTitle:@"キャンセル" target:@selector(cancel:)];
    [self.thisTableView registerNib:[UINib nibWithNibName:kQKTextViewTableViewCellIdentifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kQKTextViewTableViewCellIdentifier];
    
    [self.updateButtonOutlet setEnabled:NO];
    // Do any additional setup after loading the view.
    
    self.thisTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITableView -delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QKTextViewTableViewCell *cell = (QKTextViewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kQKTextViewTableViewCellIdentifier];
    if (!cell) {
        cell = [[QKTextViewTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kQKTextViewTableViewCellIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    cell.delegate = self;
    [cell.contentTextView setText:self.textViewContent];
    cell.contentTextView.textView.placeholderTextColor = [UIColor darkGrayColor];
    cell.contentTextView.textView.placeholder = @"例)当日の服装指定などはありますか?買い物の帰り伺おうと思ってます。";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 56.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.view.frame.size.height - self.thisView.height - 64.0f - 56.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return NSLocalizedString(@"質問文を入力してください", nil);
}


- (void)updateQuestion {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:self.recruimentId forKey:@"recruitmentId"];
        [params setObject:self.textViewContent forKey:@"question"];
        [[QKRequestManager sharedManager] asyncPOST:[NSString stringFromConst:qkCSUrlRecruitmentQuestion] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                CCAlertView *alertView = [[CCAlertView alloc] initWithImage:[UIImage imageNamed:@"dialog_pic_done"] title:@"質問を投稿しました" andMessage:nil style:QKAlertViewStyleWhite];
                [alertView showAlert];
                alertView.delegate = self;
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failed update question %@", error);
        }];
    }
    else {
        [self showNoInternetViewWithSelector:@selector(updateQuestion)];
    }
}

#pragma mark  textView delegate
- (void)editingTextChanged:(NSString *)textContent {
    self.textViewContent = textContent;
    if (self.textViewContent != nil && ![self.textViewContent isEqualToString:@""]) {
        [self.updateButtonOutlet setEnabled:YES];
    }
    else {
        [self.updateButtonOutlet setEnabled:NO];
    }
}

- (IBAction)policyClicked:(id)sender {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    QKCSWebViewController *webViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"QKWebViewController"];
    webViewController.title = NSLocalizedString(@"プライバシーポリシー", nil);
    webViewController.stringURL = [NSString stringFromConst:qkCSUrlWebCopyright];
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (IBAction)termOfUseClicked:(id)sender {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    QKCSWebViewController *webViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"QKWebViewController"];
    webViewController.title = NSLocalizedString(@"利用規約", nil);
    webViewController.stringURL = [NSString stringFromConst:qkCSUrlWebAgreement];
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (IBAction)updateQuestionButtonClicked:(id)sender {
    [self updateQuestion];
}

- (void)cancel:(UIButton *)sender {
    [self.view endEditing:YES];
    self.confirmAlert = [[CCAlertView alloc]initWithTitle:@"質問をキャンセルしますか？" message:@"質問内容は破棄されます。" delegate:self buttonTitles:@[@"しない", @"キャンセルする"]];
    [self.confirmAlert showAlert];
}

#pragma mak - CCAlertView delegate

- (void)alertView:(CCAlertView *)alertView selectedButtonIndex:(NSInteger)index {
    if (alertView == self.confirmAlert) {
        if (index == 1) {
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

- (void)clickOnAlertView:(CCAlertView *)alertView {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
