//
//  QKNewOfferViewController.m
//  quicker-cl-ios
//
//  Created by Nguyen Viet Thang on 5/26/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLRecruitmentNewStep1ViewController.h"
#import "QKCLSelectJobTypeViewController.h"
#import "QKCLSelectPreferenceConditionViewController.h"
#import "QKCLMasterPreferenceConditionModel.h"
#import "QKTextViewTableViewCell.h"
#import "QKCLRecruitmentNewStep2ViewController.h"

@interface QKCLRecruitmentNewStep1ViewController () <QKCLSelectJobTypeDelegate, QKCLSelectPreferenceConditionDelegate, QKGlobalPickerViewDelegate, QKTextViewCellDelegate, QKCLRecruitmentNewStep2ViewControllerDelegate>

@property (retain, nonatomic) QKGlobalPickerView *transportationPickerView;
@property (strong, nonatomic) NSArray *transportationArrays;
@property (nonatomic) BOOL transportationIsSet;


@end

static NSString *qKTextViewIdentifier = @"QKTextViewTableViewCell";
@implementation QKCLRecruitmentNewStep1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setDelaysContentTouches:YES];
    //custom back on navigation br
    [self setAngleLeftBarButton];
    
    //init transportationArrays
    int initValue = 0;
    NSMutableArray *paymentValueArray = [[NSMutableArray alloc]init];
    while (initValue <= 3000) {
        [paymentValueArray addObject:[NSString stringWithFormat:@"%i", initValue]];
        initValue = initValue + 50;
    }
    _transportationArrays = [NSArray arrayWithArray:paymentValueArray];
    
    if (!self.recuitmentModel) {
        self.recuitmentModel = [[QKCLRecruitmentModel alloc]init];
    }
    //init data for precondition
    if (self.recuitmentModel.preferenceConditionList == nil) {
        self.recuitmentModel.preferenceConditionList = [[NSMutableArray alloc]init];
    }
    
    //setup for transportation PickerView
    self.transportationPickerView = [[QKGlobalPickerView alloc] init];
    self.transportationPickerView.delegate = self;
    self.transportationPickerView.pickerData = _transportationArrays;
    
    //regist cell
    [self.tableView registerNib:[UINib nibWithNibName:qKTextViewIdentifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:qKTextViewIdentifier];
    
    //check next button
    [self checkNextButtonEnabled];
}

#pragma Method View
- (void)viewWillAppear:(BOOL)animated {
    //[self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addTransportPickerView {
    if (!self.transportationPickerView) {
        self.transportationPickerView = [[QKGlobalPickerView alloc]init];
        self.transportationPickerView.delegate = self;
        self.transportationPickerView.pickerData = [NSArray arrayWithArray:_transportationArrays];
    }
    self.transportationPickerView.selectedIndex = [self.transportationPickerView.pickerData indexOfObject:[NSString stringWithFormat:@"%ld", (long)self.recuitmentModel.transportationExpenses]];
    
    [self.transportationPickerView show];
}

#pragma mark - QKPickerView Delegate

- (void)donePickerView:(QKGlobalPickerView *)pickerView selectedIndex:(NSInteger)selectedIndex {
    self.transportationIsSet = YES;
    self.recuitmentModel.transportationExpenses = [[pickerView.pickerData objectAtIndex:selectedIndex] integerValue];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationNone];
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations: ^{
        [self.transportationPickerView removeFromSuperview];
    } completion:nil];
    [self checkNextButtonEnabled];
}

#pragma TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 4) {
        return 2;
    }
    else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        QKTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JobTypeSCell"];
        if (!cell) {
            cell = [[QKTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"JobTypeSCell"];
        }
        cell.textLabel.text = @"職種";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (self.recuitmentModel.jobTypeSName && ![self.recuitmentModel.jobTypeSName isEqualToString:@""]) {
            cell.detailTextLabel.text = self.recuitmentModel.jobTypeSName;
        }
        else {
            cell.detailTextLabel.text = NSLocalizedString(@"選択してください", nil);
        }
        
        return cell;
    }
    else if (indexPath.section == 4) {
        QKTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TransportationExpensesCell"];
        if (!cell) {
            cell = [[QKTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"TransportationExpensesCell"];
        }
        if (indexPath.row == 0) {
            cell.textLabel.text = @"交通費";
            if (self.recuitmentModel.transportationExpenses == 0 && !self.transportationIsSet) {
                cell.detailTextLabel.text = NSLocalizedString(@"選択してください", nil);
            }
            else {
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", (long)self.recuitmentModel.transportationExpenses];
            }
            
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        else {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = @"こだわり条件";
            NSString *preConditionString = [self makePreferenceConditionString];
            if ([preConditionString isEqualToString:@""]) {
                cell.detailTextLabel.text = NSLocalizedString(@"選択してください", nil);
            }
            else {
                cell.detailTextLabel.text = [self makePreferenceConditionString];
            }
        }
        
        return cell;
    }
    else {
        QKTextViewTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:qKTextViewIdentifier forIndexPath:indexPath];
        if (!cell) {
            cell = [[QKTextViewTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:qKTextViewIdentifier];
        }
        
        if (indexPath.section == 1) {
            cell.textView.tag = 10;
            [cell setMaxLength:200];
            [cell setText:self.recuitmentModel.descriptions];
            NSString *placeholder = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@", @"(例)", @"配膳や注文をとってもらう仕事がメインにな", @"るかと思います。手が空いた時は皿洗いの可", @"能性もあります。平均年齢21歳、大学生を中", @"心としたスタッフ達と元気に働けます!"];
            [cell setPlaceHolder:placeholder];
        }
        else if (indexPath.section == 2) {
            cell.textView.tag = 20;
            [cell setMaxLength:100];
            [cell setText:self.recuitmentModel.applicantQualification];
            
            NSString *placeholder = [NSString stringWithFormat:@"%@\n%@\n%@\n%@", @"(例)", @"・きちんとした電話応対ができる方", @"・居酒屋での勤務経験", @"・コミュニケーションスキルの高い方"];
            [cell setPlaceHolder:placeholder];
        }
        else {
            cell.textView.tag = 30;
            [cell setMaxLength:100];
            [cell setText:self.recuitmentModel.baggageAndClothes];
            
            NSString *placeholder = [NSString stringWithFormat:@"%@\n%@", @"(例)", @"・動きやすい服装でお願いします(スカート不可)"];
            [cell setPlaceHolder:placeholder];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        [self performSegueWithIdentifier:@"QKSelectJobTypeSegue" sender:self];
    }
    else if (indexPath.section == 4) {
        if (indexPath.row == 0) {
            [self addTransportPickerView];
        }
        else {
            [self performSegueWithIdentifier:@"QKSelectMetritSegue" sender:self];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 || indexPath.section == 4) {
        return 44;
    }
    else {
        return 200;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 20;
    }
    else {
        return 37;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return @"仕事内容";
    }
    else if (section == 2) {
        return @"応募資格";
    }
    else if (section == 3) {
        return @"持ち物・服装";
    }
    else if (section == 4) {
        return @"待遇";
    }
    else {
        return @"";
    }
}

#pragma mark - QKTextViewCellDelegate
- (void)editingChanged:(UITextView *)textView {
    switch (textView.tag) {
        case 10:
            self.recuitmentModel.descriptions = textView.text;
            break;
            
        case 20:
            self.recuitmentModel.applicantQualification = textView.text;
            break;
            
        case 30:
            self.recuitmentModel.baggageAndClothes = textView.text;
            break;
            
        default:
            break;
    }
    [self checkNextButtonEnabled];
}

- (void)checkNextButtonEnabled {
    BOOL enabled = YES;
    if (self.recuitmentModel.jobTypeSCd == nil || [self.recuitmentModel.jobTypeSCd isEqual:@""]) {
        enabled = NO;
    }
    if (self.recuitmentModel.descriptions == nil || [self.recuitmentModel.descriptions isEqual:@""]) {
        enabled = NO;
    }
    if (self.recuitmentModel.applicantQualification == nil || [self.recuitmentModel.applicantQualification isEqual:@""]) {
        enabled = NO;
    }
    if (self.recuitmentModel.baggageAndClothes == nil || [self.recuitmentModel.baggageAndClothes isEqual:@""]) {
        enabled = NO;
    }
    
    [_nextButton setEnabled:enabled];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"QKSelectJobTypeSegue"]) {
        QKCLSelectJobTypeViewController *jobTypeViewController = (QKCLSelectJobTypeViewController *)[segue destinationViewController];
        jobTypeViewController.delegate = self;
        jobTypeViewController.jobType = QKJobTypeS;
        QKCLMasterJobTypeModel *jobTypeS = [[QKCLMasterJobTypeModel alloc]init];
        jobTypeS.jobTypeSCd = self.recuitmentModel.jobTypeSCd;
        jobTypeS.jobTypeName = self.recuitmentModel.jobTypeSName;
        jobTypeViewController.currentJobType = jobTypeS;
    }
    else if ([[segue identifier] isEqualToString:@"QKSelectMetritSegue"]) {
        QKCLSelectPreferenceConditionViewController *metrictController = (QKCLSelectPreferenceConditionViewController *)[segue destinationViewController];
        metrictController.delegate = self;
        NSMutableArray *preConditionCdArrays = [[NSMutableArray alloc]init];
        for (QKCLMasterPreferenceConditionModel *model in self.recuitmentModel.preferenceConditionList) {
            [preConditionCdArrays addObject:model.preferenceConditionCd];
        }
        metrictController.currentConditionCdArrays = preConditionCdArrays;
    }
    else if ([[segue identifier] isEqualToString:@"QKFinalRecruitmentNewSegue"]) {
        QKCLRecruitmentNewStep2ViewController *finalRNVC = (QKCLRecruitmentNewStep2ViewController *)[segue destinationViewController];
        finalRNVC.delegate = self;
        
        if (self.recuitmentModel) {
            finalRNVC.recruitmentModel = self.recuitmentModel;
        }
    }
    else if ([[segue identifier] isEqualToString:@"QKShowDisplayRule"]) {
        QKCLWebViewController *webVC = (QKCLWebViewController *)[segue destinationViewController];
        webVC.stringURL = @"jp.yahoo.com";
    }
    else if ([[segue identifier] isEqualToString:@"QKShowJoinRule"]) {
        QKCLWebViewController *webVC = (QKCLWebViewController *)[segue destinationViewController];
        webVC.stringURL = @"jp.yahoo.com";
    }
}

- (IBAction)nextButtonClick:(id)sender {
}

#pragma mark - QKSelectJobTypeDelegate
- (void)jobTypeSelected:(QKCLMasterJobTypeModel *)selectedJobType {
    self.recuitmentModel.jobTypeSCd = selectedJobType.jobTypeSCd;
    self.recuitmentModel.jobTypeSName = selectedJobType.jobTypeName;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationRight];
    [self checkNextButtonEnabled];
}

#pragma mark - QKSelectPreferenceConditionDelegate
- (void)preferenceConditionSelected:(NSMutableArray *)selectedConditionArrays {
    self.recuitmentModel.preferenceConditionList = selectedConditionArrays;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:4];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationRight];
}

#pragma mark -Action
- (NSString *)makePreferenceConditionString {
    NSString *preConditionValue = @"";
    
    
    BOOL isFirst = YES;
    for (int i = 0; i < self.recuitmentModel.preferenceConditionList.count; i++) {
        QKCLMasterPreferenceConditionModel *modfl = [self.recuitmentModel.preferenceConditionList objectAtIndex:i];
        if (isFirst) {
            preConditionValue =  modfl.preferenceConditionName;
            isFirst = NO;
        }
        else {
            preConditionValue = [NSString stringWithFormat:@"%@,%@", preConditionValue, modfl.preferenceConditionName];
        }
    }
    
    return preConditionValue;
}

#pragma mark - QKFinalRecruitmentNewViewControllerDelegate

- (void)popViewControllerWithData:(QKCLRecruitmentModel *)data {
    self.recuitmentModel = data;
}

@end
