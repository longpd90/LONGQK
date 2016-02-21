//
//  QKClWorkerPaymentCalculateSalaryViewController.m
//  quicker-cl-ios
//
//  Created by Quy on 8/10/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKClWorkerPaymentCalculateSalaryViewController.h"
#import "QKCLApplicantTableViewCell.h"
#import "QKGlobalDatePickerView.h"
#import "QKTittleAndTextFieldTableViewCell.h"
#import "QKGlobalNoBorderTextField.h"
#import "QKGlobalMinButton.h"
#import "QKGlobalPickerView.h"
#import "NSNumber+QKCLConvertToCurrency.h"
#import "QKCLApplicantDetailViewController.h"
#import "QKCLWorkerPaymentDoneDetailViewController.h"
#import "QKTableViewCell.h"
#import "QKCLSalaryOptionTableViewCell.h"

typedef enum textFieldTag : NSInteger {
    overtimeTextFieldTag = 1,
    transportTextFieldTag =2,
    itemNameTag = 3,
    itemValueTag = 4,
    itemSignTag = 5,
    nighttimeTextFieldTag = 6,
    salaryPerUnitTag = 7,
    withHoldingTag = 8
} textFieldTag;


@interface QKClWorkerPaymentCalculateSalaryViewController ()<UITableViewDataSource,UITableViewDelegate,QKGlobalDatePickerViewDelegate,QKGlobalPickerViewDelegate,UITextFieldDelegate,CCAlertViewDelegate>

@property (nonatomic,strong) NSDate *endDate;
@property (nonatomic,strong) NSDate *startDate;
@property (nonatomic, strong) NSString *recess;
@property (nonatomic) NSInteger decisionNum;


@property(nonatomic, strong) QKGlobalDatePickerView *startTimePicker;
@property(nonatomic, strong) QKGlobalDatePickerView *endTimePicker;
@property (nonatomic,strong)  QKGlobalPickerView *restTimePicker;
@property (nonatomic,strong) CCAlertView *confirmPaymentAlert;
@property (nonatomic,strong) CCAlertView *successAlertView;
@property (nonatomic,strong) CCAlertView *changDateAndRecessAlertView;

@end

static NSString *QKCLApplicantTableViewCellIdentifier = @"QKCLApplicantTableViewCell";
static NSString *QKCLNormalCellIdentifier = @"normalCell";
static NSString *QKCLWorkTimeCellIdentifier = @"QKCLWorkTimeCell";
static NSString *QKCLAddOptionItemCellIdentifier = @"QKCLAddOptionItemCell";
static NSString *QKCLTotalSalaryCellIdentifier = @"QKCLTotalSalaryCell";
static NSString *QKCLNoOptionItemCellIdentifier = @"QKCLNoOptionItemCell";
static NSString *QKCLOptionItemCellIdentifier = @"QKCLOptionItemCell";
static NSString *QKTittleAndTextFieldTableViewCellIdentifier =@"QKTittleAndTextFieldTableViewCell";

@implementation QKClWorkerPaymentCalculateSalaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAngleLeftBarButton];
    [self setTitle:@"給与支払い"];
    [self.thisTableView registerNib:[UINib nibWithNibName:QKCLApplicantTableViewCellIdentifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:QKCLApplicantTableViewCellIdentifier];
    [self.thisTableView registerNib:[UINib nibWithNibName:QKTittleAndTextFieldTableViewCellIdentifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:QKTittleAndTextFieldTableViewCellIdentifier];
    
    if (!_adoptSalaryModel.optionalItemList) {
        _adoptSalaryModel.optionalItemList = [[NSMutableArray alloc]init];
    }
    _startDate = _adoptSalaryModel.actualStartDt;
    _endDate = _adoptSalaryModel.actualEndDt;
    _recess = [NSString stringWithFormat:@"%ld",(long)_adoptSalaryModel.actualRecess];
  
    
}
#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 3;
        case 2:
            return 3;
        case 3:
            return 1;
        case 4:
            if (_adoptSalaryModel.optionalItemList.count ==0) {
                return 1;
            }else{
                return _adoptSalaryModel.optionalItemList.count;
            }
            
        case 5:
            return 2;
            
        default:
            return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
            
        case 1:
        case 2:
        case 3:
        case 4:
            return 46.0f;
            
        default: return 0.01f;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 90.0f;
        case 1:
            if (indexPath.row == 2  ) {
                return 145.0f;
            }else {
                return 44.0f;
            }
        case 4:
            if (_adoptSalaryModel.optionalItemList.count == 0) {
                return 44.0f;
            }else{
                return 80.0f;
            }
        case 5:
            if (indexPath.row == 0) {
                return 80.0f;
            }else{
                return 85.0f;
            }
        default: return 44.0f;;
    }
}
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 1:
            return NSLocalizedString(@"勤務内容", nil);
        case 2:
            return NSLocalizedString(@"総支給額", nil);
        case 3:
            return NSLocalizedString(@"控除額", nil);
        case 4:
            return NSLocalizedString(@"その他", nil);
        default:
            return nil;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    switch (indexPath.section) {
        case 0: {
            QKCLApplicantTableViewCell *cells = (QKCLApplicantTableViewCell*)[tableView dequeueReusableCellWithIdentifier:QKCLApplicantTableViewCellIdentifier];
            if (!cells) {
                cells = [[QKCLApplicantTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QKCLApplicantTableViewCellIdentifier];
                
            }
            if(self.adoptSalaryModel.adoptUserInfo.adoptionUserImagePath != nil) {
                [cells.avartarImageView setImageWithQKURL:self.adoptSalaryModel.adoptUserInfo.adoptionUserImagePath withCache:YES];
            }
            
            cells.workerName.text = self.adoptSalaryModel.adoptUserInfo.adoptionUserName;
            cells.workerAge.text = [NSString stringWithFormat:@"(%@歳・女性)", [self.adoptSalaryModel.adoptUserInfo.adoptionUserBirthday convertToAge]];
            cell = cells;
            
            break;
        }
        case 1: {
            switch (indexPath.row) {
                case 0: {
                    QKTableViewCell *cells = [tableView dequeueReusableCellWithIdentifier:QKCLNormalCellIdentifier];
                    if (!cells) {
                        cells = [[QKTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:QKCLNormalCellIdentifier];
                        
                    }
                    cells.textLabel.text = @"職種";
                    cells.detailTextLabel.text = _recruitmentModel.jobTypeSName;
                    cell = cells;
                    break;
                }
                case 1: {
                    
                    QKTittleAndTextFieldTableViewCell *cells = [tableView dequeueReusableCellWithIdentifier:QKTittleAndTextFieldTableViewCellIdentifier];
                    if (!cells) {
                        cells = [[QKTittleAndTextFieldTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:QKTittleAndTextFieldTableViewCellIdentifier];
                    }
                    [cells setCurrency:YES];
                    cells.titleLabel.text = @"時給";
                    [cells.textField setKeyboardType:UIKeyboardTypeNumberPad];
                    [cells.textField setCurrencyValue:self.recruitmentModel.salaryPerUnit];
                    [cells.textField setTag:salaryPerUnitTag];
                    [cells.textField addTarget:self action:@selector(editingChange:) forControlEvents:UIControlEventEditingChanged];
                    cell = cells;
                    break;
                }
                case 2: {
                    QKCLWorkerTimeTableViewCell *cells = [tableView dequeueReusableCellWithIdentifier:QKCLWorkTimeCellIdentifier];
                    if (!cells) {
                        cells = [[QKCLWorkerTimeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QKCLWorkTimeCellIdentifier];
                    }
                    
                    [cells.startTimeOutletButton setTitle:[_startDate longDateStringJapanes] forState:UIControlStateNormal ];
                    [cells.endTimeOutletButton setTitle:[_endDate longDateStringJapanes] forState:UIControlStateNormal ];
                    NSTimeInterval totaltime = [_endDate timeIntervalSinceDate:_startDate] - [self.recess integerValue]  * 60;
                    
                    cells.totalTime.text = [self stringFromTimeInterval:totaltime];                 [cells.breakeTimeOutletButton setTitle:[NSString stringWithFormat:@"(休憩%@分)",self.recess] forState:UIControlStateNormal];
                    [cells.breakeTimeOutletButton sizeToFit];
                    [cells.breakeTimeOutletButton addTarget:self action:@selector(changeRecess:) forControlEvents:UIControlEventTouchUpInside];
                    [cells.startTimeOutletButton addTarget:self action:@selector(chooseStartTime:) forControlEvents:UIControlEventTouchUpInside];
                    [cells.endTimeOutletButton addTarget:self action:@selector(chooseEndTime:) forControlEvents:UIControlEventTouchUpInside];
                    cell = cells;
                    break;
                }
                default:
                    
                    break;
            }
            break;
        }
        case 2: {
            switch (indexPath.row) {
                case 0: {
                    
                    QKTittleAndTextFieldTableViewCell *cells = [tableView dequeueReusableCellWithIdentifier:QKTittleAndTextFieldTableViewCellIdentifier];
                    if (!cells) {
                        cells = [[QKTittleAndTextFieldTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:QKTittleAndTextFieldTableViewCellIdentifier];
                    }
                    [cells setCurrency:YES];
                    

                    cells.titleLabel.text = @"深夜勤務手当";
                    [cells.textField setCurrencyValue: self.adoptSalaryModel.actualNighttimeAllowance] ;
                    [cells.textField setKeyboardType:UIKeyboardTypeNumberPad];
                    [cells.textField setTag:nighttimeTextFieldTag];
                    [cells.textField addTarget:self action:@selector(editingChange:) forControlEvents:UIControlEventEditingChanged];
                    
                    cell =cells;
                    break;
                }
                case 1: {
                    QKTittleAndTextFieldTableViewCell *cells = [tableView dequeueReusableCellWithIdentifier:QKTittleAndTextFieldTableViewCellIdentifier];
                    if (cells == nil) {
                        cells = [[QKTittleAndTextFieldTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QKTittleAndTextFieldTableViewCellIdentifier];
                    }
                    [cells.textField setKeyboardType:UIKeyboardTypeNumberPad];
                    [cells.titleLabel setText:@"法定時間外勤務手当"];
                    [cells setCurrency:YES];
                    [cells.textField setPlaceholder:@"0"];
                    [cells.textField setCurrencyValue:self.adoptSalaryModel.actualOvertimeAllowance];
                    [cells.textField addTarget:self action:@selector(editingChange:) forControlEvents:UIControlEventEditingChanged];
                    [cells.textField setTag:overtimeTextFieldTag];
                    cell = cells;
                    break;
                }
                case 2: {
                    QKTittleAndTextFieldTableViewCell *cells = [tableView dequeueReusableCellWithIdentifier:QKTittleAndTextFieldTableViewCellIdentifier];
                    if (cells == nil) {
                        cells = [[QKTittleAndTextFieldTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QKTittleAndTextFieldTableViewCellIdentifier];
                    }
                    [cells.textField addTarget:self action:@selector(editingChange:) forControlEvents:UIControlEventEditingChanged];
                    [cells.textField setKeyboardType:UIKeyboardTypeNumberPad];
                    
                    [cells.titleLabel setText:@"交通費"];
                    [cells setCurrency:YES];
                    [cells.textField setCurrencyValue:self.adoptSalaryModel.actualTransportationExpenses];
                    [cells.textField setTag:transportTextFieldTag];
                    cell = cells;
                    
                    break;
                }
                    
                default:
                    break;
            }
            break;
        }
        case 3: {
            
            QKTittleAndTextFieldTableViewCell *cells = [tableView dequeueReusableCellWithIdentifier:QKTittleAndTextFieldTableViewCellIdentifier];
            if (cells == nil) {
                cells = [[QKTittleAndTextFieldTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:QKTittleAndTextFieldTableViewCellIdentifier];
            }
            [cells setCurrency:YES];
            cells.titleLabel.text = @"源泉徴収";
            
            cells.textField.text = [NSString stringWithFormat:@"%ld",(long)self.adoptSalaryModel.actualWithholding];
            [cells.textField setTag:withHoldingTag];
            [cells.textField addTarget:self action:@selector(editingChange:) forControlEvents:UIControlEventEditingChanged];
            cell=cells;
            break;
        }
        case 4: {
            if ([_adoptSalaryModel.optionalItemList count] == 0) {
                QKCLSalaryOptionTableViewCell *cells = [tableView dequeueReusableCellWithIdentifier:QKCLNoOptionItemCellIdentifier];
                if (!cells) {
                    cells = [[QKCLSalaryOptionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QKCLNoOptionItemCellIdentifier];
                }
                cells.itemNameTextField.delegate = self;
                cells.itemNameTextField.text=@"";
                cells.itemValueTextField.delegate = self;
                cells.itemValueTextField.text=@"";
                [cells.itemValueTextField setKeyboardType:UIKeyboardTypeNumberPad];
                cell = cells;
            }else{
                QKCLSalaryOptionTableViewCell *cells = [tableView dequeueReusableCellWithIdentifier:QKCLOptionItemCellIdentifier];
                if (!cells) {
                    cells = [[QKCLSalaryOptionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QKCLOptionItemCellIdentifier];
                }
                //get data
                QKCLOptionalItemModel *item = [_adoptSalaryModel.optionalItemList objectAtIndex:indexPath.row];
                
                //set data
                [cells setData:item];
                
                [cells.deleteButton addTarget:self action:@selector(deleteRow:) forControlEvents:UIControlEventTouchUpInside];
                cells.deleteButton.tag = indexPath.row;
                
                [cells.signSwitch addTarget:self action:@selector(switchValueChange:) forControlEvents:UIControlEventValueChanged];
                
                [cells.itemNameTextField addTarget:self action:@selector(itemEditingChanged:) forControlEvents:UIControlEventEditingChanged];
                [cells.itemNameTextField setInputMode:InputModeJapanse];
                
                [cells.itemValueTextField setKeyboardType:UIKeyboardTypeNumberPad];
                [cells.itemValueTextField addTarget:self action:@selector(itemEditingChanged:) forControlEvents:UIControlEventEditingChanged];
                cell = cells;
            }
            
            cell.tag = indexPath.row;
            break;
        }
        case 5: {
            switch (indexPath.row) {
                case 0: {
                    cell = [tableView dequeueReusableCellWithIdentifier:QKCLAddOptionItemCellIdentifier];
                    if (!cell) {
                        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QKCLOptionItemCellIdentifier];
                    }
                    
                    QKGlobalMinButton *button = (QKGlobalMinButton*)[cell viewWithTag:500];
                    NSLog(@"cout %d",_adoptSalaryModel.optionalItemList.count);
                    if (  _adoptSalaryModel.optionalItemList.count < 11 && _adoptSalaryModel.optionalItemList.count > 0) {
                        [button setEnabled:YES];
                    } else {
                        [button setEnabled:NO];
                    }
                    
                    [button addTarget:self action:@selector(addOptionItem:) forControlEvents:UIControlEventTouchUpInside];
                    
                    
                    break;
                }
                case 1: {
                    cell = [tableView dequeueReusableCellWithIdentifier:QKCLTotalSalaryCellIdentifier];
                    if (!cell) {
                        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QKCLTotalSalaryCellIdentifier];
                    }
                    
                   
                    QKGlobalButton *button  = (QKGlobalButton*)[cell viewWithTag:900];
                    [button addTarget:self action:@selector(confirmPayment:) forControlEvents:UIControlEventTouchUpInside];
                    
                    break;
                }
                    
                default:
                    break;
            }
        }
        default: break;
    }
    return cell;
}

#pragma mark -Action Confirm Payment
- (void)confirmPayment:(id)sender {
    
    // call api first , now is exmaple
    if ([_recess isEqualToString:[NSString stringWithFormat:@"%d", self.adoptSalaryModel.actualRecess]] && [_startDate isEqualToDate:self.adoptSalaryModel.actualStartDt] && [_endDate isEqualToDate:self.adoptSalaryModel.actualEndDt]) {
        
        [self showConfirmAlertView];
    }else{
        _changDateAndRecessAlertView = [[CCAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"%@,%@,%@,%@",@"勤務実績に入力された勤務時間が",@"募集掲載時の勤務時間よりも短いです。",@"サポートセンターから確認ご連絡を",@"する場合がございます。ご了承ください。"] delegate:self buttonTitles:@[@"OK"]];
        [_changDateAndRecessAlertView showAlert];
    }
}
#pragma mark - CCAlertviewdelegate
- (void)alertView:(CCAlertView *)alertView selectedButtonIndex:(NSInteger)index {
    if (alertView == _confirmPaymentAlert) {
        if (index == 1) {
           
            [self callApiToConfirmPayment];
        }
    }
    if (alertView == _successAlertView) {
        if ( index == 0) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
    if (alertView == _changDateAndRecessAlertView) {
        if (index == 0) {
            [self showConfirmAlertView];
        }
    }
}
- (void)checkDesionNum {
    
    
    if (_decisionNum > 0) {
        //Show diallog
        _successAlertView = [[CCAlertView alloc]initWithImage:[UIImage imageNamed:@"dialog_pic_done"] title:@"給与の支払いが完了しました" message:@"給与は勤務者の確認のあと\n異議申し立てが無ければ\n自動的に振り込まれます" delegate:self buttonTitles:@[@"OK"]];
        [_successAlertView showAlert];
    }else{
        [self performSegueWithIdentifier:@"QKPayMentSalaryForWorkerDoneSegue" sender:self];
    }
}

-(void)showConfirmAlertView {
    NSString *salary = [[NSNumber numberWithInt: [self calculateAllSalary]] convertToCurrency];
    NSNumber *salarymargin = @(self.adoptSalaryModel.margin);
    
    _confirmPaymentAlert = [[CCAlertView alloc]initWithTitle:@"勤務実績を確定しますか？" message:[NSString stringWithFormat: @"支給額\t\t %@円\n\n手数料\t\t%@円",salary,[salarymargin convertToCurrency]] delegate:self buttonTitles:@[@"CANCEL",@"OK"]];
    [_confirmPaymentAlert showAlert];
}
#pragma mark call api to confirm
- (void)callApiToConfirmPayment {
    if ([self connected]) {
        
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [params setValue :self.recruitmentModel.recruitmentId forKey:@"recruitmentId"];
        [params setObject:[QKCLEncryptUtil encyptBlowfish:self.adoptSalaryModel.adoptUserInfo.adoptionUserId ] forKey:@"customerUserId"];
        [params setObject:[self.startDate longDateString] forKey:@"startDt"];
        [params setObject:[self.endDate longDateString] forKey:@"endDt"];
        
        [params setObject: self.recess forKey:@"recess"];
        [params setObject:[NSString stringWithFormat:@"%d",self.adoptSalaryModel.actualSalaryPerUnit ] forKey:@"salaryPerUnit"];
        [params setObject:[NSString stringWithFormat:@"%d", self.adoptSalaryModel.basicSalary] forKey:@"basicSalary"];
        [params setObject:[NSString stringFromConst:QK_SALARY_UNIT_HOUR] forKey:@"salaryUnit"];
        [params setObject:[NSString stringWithFormat:@"%d",_adoptSalaryModel.actualOvertimeAllowance] forKey:@"overtimeAllowance"];
        [params setObject:[NSString stringWithFormat:@"%ld",(long)_adoptSalaryModel.actualTransportationExpenses] forKey:@"transportationExpenses"];
        [params setObject:[NSString stringWithFormat:@"%d", self.adoptSalaryModel.actualNighttimeAllowance ] forKey:@"nighttimeAllowance"];
        [params setObject:[NSString stringWithFormat:@"%d",self.adoptSalaryModel.actualWithholding] forKey:@"withholding"];
        
        //json
        [params setObject:[self getJsonFromOptionItemList] forKey:@"json"];
        
        [[QKCLRequestManager sharedManager] asyncPOST:[NSString stringFromConst:qkClUrlWorkerPayment] parameters:params showLoading:YES showError:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS] ]) {
                
                _decisionNum =  [responseObject[@"decisionNum"] integerValue];
                [self checkDesionNum];
            }
        } failure:
         ^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"fail...%@",error);
         }];
        
    }else {
        [self showNoInternetViewWithSelector:nil];
    }
}
#pragma mark- getJsonFromOptionItemList
- (NSString *)getJsonFromOptionItemList {
    NSMutableArray *array = [NSMutableArray new];
    for (QKCLOptionalItemModel *item in _adoptSalaryModel.optionalItemList) {
        NSDictionary *entry = [[NSDictionary alloc] initWithObjectsAndKeys:
                               item.itemsName, @"items",
                               item.payStatementStatus, @"payStatementStatus",
                               [NSString stringWithFormat:@"%ld",(long)item.amount], @"amount",
                               nil];
        [array addObject:entry];
    }
    NSError *errorDictionary;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&errorDictionary];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}
#pragma mark - UISwicht value change
- (void)switchValueChange:(id)sender {
    UISwitch *sw =(UISwitch*)sender;
    QKCLSalaryOptionTableViewCell* cell = (QKCLSalaryOptionTableViewCell*)[[sender superview] superview];
    QKCLOptionalItemModel *item = [_adoptSalaryModel.optionalItemList objectAtIndex:cell.tag];
    if ([sw isOn]) {
        item.payStatementStatus = [NSString stringFromConst:QK_PAYMENT_STATUS_DEDUCT];
    }else{
        item.payStatementStatus = [NSString stringFromConst:QK_PAYMENT_STATUS_PAY];
    }
    
    [self.thisTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:cell.tag inSection:4]] withRowAnimation:UITableViewRowAnimationNone];
    [self.thisTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:5]] withRowAnimation:UITableViewRowAnimationNone];
    
}
#pragma mark - UITextFieldDeletgate
//- (NSInteger)calculateActualSalary {
//    return _adoptSalaryModel.basicSalary + _adoptSalaryModel.actualTransportationExpenses + _adoptSalaryModel.actualOvertimeAllowance;
//}
- (NSInteger)calculateAllSalary {
    NSInteger itemTotal = 0;
    if (_adoptSalaryModel.optionalItemList.count > 0 ) {
        for (QKCLOptionalItemModel *item in _adoptSalaryModel.optionalItemList) {
            if ([item.payStatementStatus isEqualToString:[NSString stringFromConst:QK_PAYMENT_STATUS_PAY]]) {
                itemTotal +=  item.amount;
            }else{
                itemTotal -=  item.amount;
            }
            
        }
    }
    return  [self calculateBaseSalary:self.recruitmentModel.salaryPerUnit endTime:self.adoptSalaryModel.actualEndDt starTime:_adoptSalaryModel.actualStartDt recess:_recess] + ( _adoptSalaryModel.actualWithholding + itemTotal );
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    QKCLSalaryOptionTableViewCell* cell = (QKCLSalaryOptionTableViewCell*)[[textField superview] superview];
    QKCLOptionalItemModel *item;
    if (_adoptSalaryModel.optionalItemList.count == 0) {
        item = [[QKCLOptionalItemModel alloc]init];
        [_adoptSalaryModel.optionalItemList addObject:item];
    }else{
        item = [_adoptSalaryModel.optionalItemList objectAtIndex:cell.tag];
    }
    
    item.itemsName = cell.itemNameTextField.text;
    item.amount = [cell.itemValueTextField.text integerValue];
    if (item.itemsName &&![item.itemsName isEqualToString:@""] && item.amount) {
        [self.thisTableView reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationNone];
        [self.thisTableView reloadSections:[NSIndexSet indexSetWithIndex:5] withRowAnimation:UITableViewRowAnimationNone];
    }
    
    
}
#pragma mark - action textfield change
- (void)editingChange:(QKGlobalNoBorderTextField*)textField {
    if (textField.tag == overtimeTextFieldTag) {
        _adoptSalaryModel.actualOvertimeAllowance = [textField getCurrencyValue];
    }
    if (textField.tag == transportTextFieldTag) {
        _adoptSalaryModel.actualTransportationExpenses = [textField getCurrencyValue];
    }
    if (textField.tag == salaryPerUnitTag) {
        _recruitmentModel.salaryPerUnit = [textField getCurrencyValue];
        
    }
    if (textField.tag == nighttimeTextFieldTag) {
        _adoptSalaryModel.actualNighttimeAllowance = [textField getCurrencyValue];
        
    }
    if (textField.tag == withHoldingTag) {
        _adoptSalaryModel.actualWithholding = [textField.text integerValue];
    }
    
}
-(void)itemEditingChanged:(UITextField*)textField {
    QKCLSalaryOptionTableViewCell* cell = (QKCLSalaryOptionTableViewCell*)[[textField superview] superview];
    QKCLOptionalItemModel *item = [_adoptSalaryModel.optionalItemList objectAtIndex:cell.tag];
    switch (textField.tag) {
        case itemNameTag:
            item.itemsName = textField.text;
            break;
        case itemValueTag:
            item.amount = abs([textField.text integerValue]);
            break;
        default:
            break;
    }
    [self.thisTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:5]] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma delete cell
- (void)deleteRow:(id)sender {
    UIButton *deleteButton = (UIButton*)sender;
    NSInteger tag = deleteButton.tag;
    [_adoptSalaryModel.optionalItemList removeObjectAtIndex:tag];
    [self.thisTableView reloadSections:[NSIndexSet indexSetWithIndex:4] withRowAnimation:UITableViewRowAnimationNone];
    
    [self.thisTableView reloadSections:[NSIndexSet indexSetWithIndex:5] withRowAnimation:UITableViewRowAnimationNone];
    
    
}
#pragma loadmore cell click
-(void)addOptionItem:(id)sender {
    QKCLOptionalItemModel *newItem = [[QKCLOptionalItemModel alloc]init];
    [_adoptSalaryModel.optionalItemList addObject:newItem];
    
    [self.thisTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_adoptSalaryModel.optionalItemList.count -1 inSection:4]] withRowAnimation:UITableViewRowAnimationBottom];
    if ([_adoptSalaryModel.optionalItemList count] >= 10) {
        [self.thisTableView reloadSections:[NSIndexSet indexSetWithIndex:5] withRowAnimation:UITableViewRowAnimationNone];
    }
    
    
}
#pragma mark - add restime action
- (void)changeRecess:(id)sender {
    [self addRestTimePicker];
}
- (void)chooseStartTime:(id)sender {
    [self addStartTimePicker];
}
- (void)chooseEndTime:(id)sender {
    [self addEndTimePicker];
}
#pragma mark - add restime pickerview
- (void)addRestTimePicker {
    
    if ( !self.restTimePicker) {
        NSMutableArray *restTimeData = [[NSMutableArray alloc] init];
        for (int i = 0; i <= 300; i=i+15) {
            [restTimeData addObject:[NSString stringWithFormat:@"%d", i]];
        }
        self.restTimePicker = [[QKGlobalPickerView alloc] init];
        self.restTimePicker.pickerData = [NSArray arrayWithArray:restTimeData];
    }
    self.restTimePicker.delegate = self;
    if (self.recess &&  ![self.recess isEqualToString:@""]) {
        self.restTimePicker.selectedIndex = [self.restTimePicker.pickerData indexOfObject:self.recess];
    }
    
    [self.restTimePicker show];
    
}
- (void)donePickerView:(QKGlobalPickerView *)pickerView selectedIndex:(NSInteger)selectedIndex {
    _recess = [pickerView.pickerData objectAtIndex:selectedIndex];
    
    [self.thisTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)addStartTimePicker {
    if (!self.startTimePicker) {
        self.startTimePicker = [[QKGlobalDatePickerView alloc] init];
        self.startTimePicker.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        self.startTimePicker.datePicker.minuteInterval = 15;
        self.startTimePicker.delegate = self;
    }
    
    if (self.startDate) {
        [self.startTimePicker setDate:self.startDate];
    }else{
        [self.startTimePicker setDate:[NSDate date]];
    }
    [self.startTimePicker show];
}

- (void)addEndTimePicker {
    
    if (!self.endTimePicker) {
        
        
        self.endTimePicker = [[QKGlobalDatePickerView alloc] init];
        self.endTimePicker.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        self.endTimePicker.datePicker.minuteInterval =15;
        self.endTimePicker.delegate = self;
    }
    
    if (self.endDate) {
        [self.endTimePicker setDate:self.endDate];
    }else{
        [self.endTimePicker setDate:[NSDate date]];
    }
    
    [self.endTimePicker show];
    
}
-(void)pickedDatePicker:(QKGlobalDatePickerView *)datePicker withDate:(NSDate *)date {
    if (datePicker == self.startTimePicker) {
        self.startDate = date;
    }
    else{
        self.endDate = date;
    }
    [self.thisTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
    ;
}
#pragma mark - caculate base
- (NSInteger)calculateBaseSalary:(NSInteger)salaryPerUnit  endTime:(NSDate*)endTime starTime :(NSDate*)starTime recess : (NSString*)recess{
     NSTimeInterval totaltime = [endTime timeIntervalSinceDate:starTime] - [recess integerValue]  * 60;
    NSInteger ti = (NSInteger)totaltime;
    NSInteger  hours = ti / 3600;
   
    
    return self.recruitmentModel.salaryPerUnit * hours;
}
#pragma mark - Convert NStimeInterval to hour and minutes
- (NSString *)stringFromTimeInterval:(NSTimeInterval)interval {
    NSInteger ti = (NSInteger)interval;
    
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    if (minutes == 60) {
        minutes = 0;
        hours = hours + 1;
    }
    
    return [NSString stringWithFormat:@"%ld時間%02ld分", (long)hours, (long)minutes];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //view applicant detail
    if ([segue.identifier isEqualToString:@"QKPayMentSalaryForWorkerDoneSegue"]) {
        QKCLWorkerPaymentDoneDetailViewController *vc = (QKCLWorkerPaymentDoneDetailViewController*)segue.destinationViewController;
        vc.userPassModel = self.adoptSalaryModel;
        vc.recruitmentId = _recruitmentModel.recruitmentId;
    }
}


@end
