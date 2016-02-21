//
//  QKFinalRecruitmentNewViewController.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 6/25/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLRecruitmentNewStep2ViewController.h"
#import "QKGlobalPickerView.h"
#import "QKGlobalDatePickerView.h"
#import "QKTittleAndTextFieldTableViewCell.h"
#import "QKCLRecruitmentDetailViewController.h"
#import "QKCLMasterPreferenceConditionModel.h"
#import "QKCLTableView.h"

@interface QKCLRecruitmentNewStep2ViewController () <QKGlobalPickerViewDelegate, QKGlobalDatePickerViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet QKCLTableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *errorLable;
@property (strong, nonatomic) QKGlobalPickerView *employmentPicker;
@property (strong, nonatomic) QKGlobalPickerView *paymentMethodPicker;
@property (strong, nonatomic) QKGlobalDatePickerView *startTimePicker;
@property (strong, nonatomic) QKGlobalDatePickerView *endTimePicker;
@property (strong, nonatomic) QKGlobalPickerView *restTimePicker;


@end

@implementation QKCLRecruitmentNewStep2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAngleLeftBarButton];
    self.title = @"新規募集";
    if (!self.recruitmentModel) {
        self.recruitmentModel  = [[QKCLRecruitmentModel alloc] init];
    }
    [self.tableView registerNib:[UINib nibWithNibName:@"QKTextViewTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"QKTextViewCell"];
}

- (void)addEmploymentPicker {
    if (!self.employmentPicker) {
        NSMutableArray *employmentData = [[NSMutableArray alloc] init];
        for (int i = 1; i <= 5; i++) {
            [employmentData addObject:[NSString stringWithFormat:@"%d", i]];
        }
        self.employmentPicker = [[QKGlobalPickerView alloc] init];
        self.employmentPicker.pickerData = [NSArray arrayWithArray:employmentData];
    }
    self.employmentPicker.delegate = self;
    if (self.recruitmentModel.employmentNum && self.recruitmentModel.employmentNum != 0) {
        self.employmentPicker.selectedIndex = [self.employmentPicker.pickerData indexOfObject:[NSString stringWithFormat:@"%ld", (long)self.recruitmentModel.employmentNum]];
    }
    
    [self.employmentPicker show];
}

- (void)addPaymentMethodPicker {
    if (!self.paymentMethodPicker) {
        self.paymentMethodPicker = [[QKGlobalPickerView alloc] init];
        self.paymentMethodPicker.pickerData = [NSArray arrayWithArray:[[QKCLConst PAYMENT_METHOD_MAP] allValues]];
    }
    self.paymentMethodPicker.delegate = self;
    if (self.recruitmentModel.paymentMethod && ![self.recruitmentModel.paymentMethod isEqualToString:@""]) {
        self.paymentMethodPicker.selectedIndex = [[[QKCLConst PAYMENT_METHOD_MAP] allKeys] indexOfObject:self.recruitmentModel.paymentMethod];
    }
    
    [self.paymentMethodPicker show];
}

- (void)addRestTimePicker {
    if (!self.restTimePicker) {
        NSMutableArray *restTimeData = [[NSMutableArray alloc] init];
        for (int i = 0; i <= 300; i = i + 15) {
            [restTimeData addObject:[NSString stringWithFormat:@"%d", i]];
        }
        self.restTimePicker = [[QKGlobalPickerView alloc] init];
        self.restTimePicker.pickerData = [NSArray arrayWithArray:restTimeData];
    }
    self.restTimePicker.delegate = self;
    if (self.recruitmentModel.recess && ![self.recruitmentModel.recess isEqualToString:@""]) {
        self.restTimePicker.selectedIndex = [self.restTimePicker.pickerData indexOfObject:self.recruitmentModel.recess];
    }
    
    [self.restTimePicker show];
}

- (void)addStartTimePicker {
    if (!self.startTimePicker) {
        self.startTimePicker = [[QKGlobalDatePickerView alloc] init];
        self.startTimePicker.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        self.startTimePicker.datePicker.minuteInterval = 15;
        self.startTimePicker.delegate = self;
    }
    
    if (self.recruitmentModel.startDt) {
        [self.startTimePicker setDate:self.recruitmentModel.startDt];
    }
    else {
        [self.startTimePicker setDate:[NSDate date]];
    }
    [self.startTimePicker show];
}

- (void)addEndTimePicker {
    //    if (!self.endTimePicker) {
    self.endTimePicker = [[QKGlobalDatePickerView alloc] init];
    self.endTimePicker.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    self.endTimePicker.datePicker.minuteInterval = 15;
    
    [self.endTimePicker.datePicker setMinimumDate:self.recruitmentModel.startDt];
    [self.endTimePicker.datePicker setMaximumDate:[self.recruitmentModel.startDt dateByAddingTimeInterval:60 * 60 * 24]];
    self.endTimePicker.delegate = self;
    
    //    }
    if (self.recruitmentModel.endDt) {
        [self.endTimePicker setDate:self.recruitmentModel.endDt];
    }else if (self.recruitmentModel.startDt) {
        [self.endTimePicker setDate:self.recruitmentModel.startDt];
    }
    else {
        [self.endTimePicker setDate:[NSDate date]];
    }
    [self.endTimePicker show];
}

#pragma mark - date picker delegate
- (void)pickedDatePicker:(QKGlobalDatePickerView *)datePicker withDate:(NSDate *)date {
    if (datePicker == self.startTimePicker) {
        self.recruitmentModel.startDt = date;
        
        if (self.recruitmentModel.endDt) {
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
            NSDateComponents *components = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit
                                                       fromDate:self.recruitmentModel.startDt
                                                         toDate:self.recruitmentModel.endDt
                                                        options:0];
            NSInteger yearIntValue = [components year];
            NSInteger monthIntValue = [components month];
            NSInteger dayIntValue = [components day];
            NSInteger hourIntValue = [components hour];
            NSInteger minuteIntValue = [components minute];
            
            BOOL isReset = NO;
            
            if (yearIntValue == 0) {
                if (monthIntValue == 0) {
                    if (dayIntValue == 1) {
                        if (hourIntValue > 0) {
                            isReset =YES;
                        }else if (hourIntValue == 0) {
                            if (minuteIntValue > 0) {
                                isReset =YES;
                            }
                        }
                    }
                    else if (dayIntValue == 0) {
                        if (hourIntValue < 0) {
                            isReset =YES;
                        }
                    }
                    else {
                        isReset =YES;
                    }
                }
                else {
                    isReset =YES;
                }
            }
            else {
                
                isReset =YES;
            }
            
            if (isReset) {
                self.recruitmentModel.endDt = nil;
            }
        }
        
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
    }
    else {
        self.recruitmentModel.endDt = date;
        NSLog(@"%@", [self getStringFromDate:date]);
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
    }
}

#pragma mark - TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 3;
            break;
            
        case 1:
            return 3;
            break;
            
        case 2:
            return 1;
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        return 200.0;
    }
    else {
        return 44.0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            QKTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QKNormalCell"];
            if (!cell) {
                cell = [[QKTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"QKNormalCell"];
            }
            cell.textLabel.text = @"採用人数";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld名", (long)self.recruitmentModel.employmentNum];
            return cell;
        }
        else if (indexPath.row == 1) {
            QKTittleAndTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QKTittleAndTextFieldTableViewCell"];
            if (!cell) {
                cell = [[QKTittleAndTextFieldTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"QKTittleAndTextFieldTableViewCell"];
            }
            cell.titleLabel.text = @"時給";
            cell.textField.placeholder =@"0";
            if (self.recruitmentModel.salaryPerUnit != 0) {
                [cell.textField setCurrencyValue:self.recruitmentModel.salaryPerUnit];
            }
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            cell.textField.tag = 100;
            cell.textField.delegate = self;
            UILabel *label = (UILabel *)[cell viewWithTag:50];
            label.text = @"円";
            [cell.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            
            return cell;
        }
        else {
            QKTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QKNormalCell"];
            if (!cell) {
                cell = [[QKTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"QKNormalCell"];
            }
            cell.textLabel.text = @"支払い方法";
            
            if (self.recruitmentModel.paymentMethod && ![self.recruitmentModel.paymentMethod isEqualToString:@""]) {
                NSInteger index = [[[QKCLConst PAYMENT_METHOD_MAP] allKeys] indexOfObject:self.recruitmentModel.paymentMethod];
                cell.detailTextLabel.text = [[[QKCLConst PAYMENT_METHOD_MAP] allValues] objectAtIndex:index];
            }
            else {
                cell.detailTextLabel.text = NSLocalizedString(@"選択してください", nil);
            }
            
            return cell;
        }
    }
    else if (indexPath.section == 1) {
        QKTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QKNormalCell"];
        if (!cell) {
            cell = [[QKTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"QKNormalCell"];
        }
        if (indexPath.row == 0) {
            cell.textLabel.text = @"開始";
            if (self.recruitmentModel.startDt) {
                cell.detailTextLabel.text = [self getStringFromDate:self.recruitmentModel.startDt];
            }
            else {
                cell.detailTextLabel.text = NSLocalizedString(@"選択してください", nil);
            }
        }
        else if (indexPath.row == 1) {
            cell.textLabel.text = @"終了";
            if (self.recruitmentModel.endDt) {
                cell.detailTextLabel.text = [self getStringFromDate:self.recruitmentModel.endDt];
            }
            else {
                cell.detailTextLabel.text = NSLocalizedString(@"選択してください", nil);
            }
        }
        else {
            cell.textLabel.text = @"休憩";
            if (self.recruitmentModel.recess) {
            }
            else {
                self.recruitmentModel.recess = @"0";
            }
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@分", self.recruitmentModel.recess];
        }
        
        return cell;
    }
    else if (indexPath.section == 2) {
        QKTextViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QKTextViewCell"];
        if (!cell) {
            cell = [[QKTextViewTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"QKTextViewCell"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setMaxLength:100];
        cell.delegate = self;
        [cell setPlaceHolder:NSLocalizedString(@"(例)\nビールサーバーの扱い経験はありますか?ま\nた、重いジョッキを運んでもらうこともあり\nますが、問題ないですか?", nil)];
        [cell setText:self.recruitmentModel.question];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                [self addEmploymentPicker];
            }
            else if (indexPath.row == 2) {
                [self addPaymentMethodPicker];
            }
            break;
            
        case 1:
            if (indexPath.row == 0) {
                [self addStartTimePicker];
            }
            else if (indexPath.row == 1) {
                [self addEndTimePicker];
            }
            else if (indexPath.row == 2) {
                [self addRestTimePicker];
            }
            break;
            
        case 2:
            break;
            
        default:
            break;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return @"勤務時間";
    }
    else if (section == 2) {
        return @"応募者への質問（任意）";
    }
    else {
        return @"";
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.0;
    }
    else {
        return 37.0;
    }
}

#pragma mark - QKTextViewCellDelegate

- (void)editingChanged:(UITextView *)textView {
    self.recruitmentModel.question = textView.text;
}

#pragma mark - QKGlobalPickerDelegate

- (void)donePickerView:(QKGlobalPickerView *)pickerView selectedIndex:(NSInteger)selectedIndex {
    if (pickerView == self.employmentPicker) {
        self.recruitmentModel.employmentNum = [[pickerView.pickerData objectAtIndex:selectedIndex] integerValue];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    }
    else if (pickerView == self.restTimePicker) {
        self.recruitmentModel.recess = [pickerView.pickerData objectAtIndex:selectedIndex];
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
    }
    else if (pickerView == self.paymentMethodPicker) {
        self.recruitmentModel.paymentMethod = [[[QKCLConst PAYMENT_METHOD_MAP] allKeys] objectAtIndex:selectedIndex];
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }
}

#pragma mark - Extra function

- (NSString *)getStringFromDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    return [dateFormatter stringFromDate:date];
}

- (NSString *)stringForServer:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [dateFormatter stringFromDate:date];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (self.delegate && [self.delegate respondsToSelector:@selector(popViewControllerWithData:)]) {
        [self.delegate popViewControllerWithData:self.recruitmentModel];
    }
}

- (IBAction)registRecruitment:(id)sender {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:[QKCLAccessUserDefaults getActiveShopId] forKey:@"shopId"];
        [params setObject:self.recruitmentModel.jobTypeSCd forKey:@"jobTypeSCd"];
        [params setObject:self.recruitmentModel.descriptions forKey:@"description"];
        [params setObject:self.recruitmentModel.applicantQualification forKey:@"applicantQualification"];
        [params setObject:self.recruitmentModel.baggageAndClothes forKey:@"baggageAndClothes"];
        [params setObject:[NSString stringWithFormat:@"%ld", (long)self.recruitmentModel.transportationExpenses] forKey:@"transportationExpenses"];
        if (self.recruitmentModel.startDt) {
            [params setObject:[self stringForServer:self.recruitmentModel.startDt] forKey:@"startDt"];
        }
        
        if (self.recruitmentModel.endDt) {
            [params setObject:[self stringForServer:self.recruitmentModel.endDt] forKey:@"endDt"];
        }
        
        NSMutableSet *set = [[NSMutableSet alloc] init];
        for (QKCLMasterPreferenceConditionModel *preferenceCondition in self.recruitmentModel.preferenceConditionList) {
            [set addObject:preferenceCondition.preferenceConditionCd];
        }
        [params setObject:set forKey:@"preferenceConditionCd"];
        
        [params setObject:[NSString stringWithFormat:@"%@", self.recruitmentModel.recess] forKey:@"recess"];
        [params setObject:[NSString stringWithFormat:@"01"] forKey:@"salaryUnit"];
        [params setObject:[NSString stringWithFormat:@"%ld", (long)self.recruitmentModel.salaryPerUnit] forKey:@"salaryPerUnit"];
        [params setObject:[NSString stringWithFormat:@"%ld", (long)self.recruitmentModel.employmentNum] forKey:@"employmentNum"];
        
        if (self.recruitmentModel.paymentMethod) {
            [params setObject:self.recruitmentModel.paymentMethod forKey:@"paymentMethod"];
        }
        
        if (self.recruitmentModel.question) {
            [params setObject:self.recruitmentModel.question forKey:@"question"];
        }
        
        [[QKCLRequestManager sharedManager] asyncPOST:[NSString stringFromConst:qkUrlRecruitmentRegist] parameters:params showLoading:YES showError:NO success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"register shop success");
            NSString *statusCd = [responseObject objectForKey:@"statusCd"];
            if ([statusCd isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                self.errorLable.hidden = YES;
                self.recruitmentModel = [[QKCLRecruitmentModel alloc] initWithResponse:responseObject];
                [self performSegueWithIdentifier:@"QKConfirmNewRecruiltmentSegue" sender:self];
            }
            else {
                self.errorLable.hidden = NO;
                self.errorLable.text = [responseObject objectForKey:@"msg"];
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Register shop error %@", [error localizedDescription]);
        }];
    }
    
    
    else {
        [self showNoInternetViewWithSelector:nil];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"QKConfirmNewRecruiltmentSegue"]) {
        QKCLRecruitmentDetailViewController *recruitNewVC = (QKCLRecruitmentDetailViewController *)[segue destinationViewController];
        recruitNewVC.recruitmentModel = self.recruitmentModel;
    }
}

#pragma mark - TextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField.tag == 100 && [textField.text isEqualToString:@"0"]) {
        textField.text = @"";
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag == 100 && [textField.text isEqualToString:@""]) {
        textField.text = @"0";
    }
}

#pragma mark - TextFieldChange

- (void)textFieldDidChange:(QKGlobalNoBorderTextField *)sender {
    if (sender.tag == 100) {
        @try {
            self.recruitmentModel.salaryPerUnit = [sender getCurrencyValue];
        }
        @catch (NSException *exception)
        {
            self.recruitmentModel.salaryPerUnit = 0;
        }
    }
}

@end
