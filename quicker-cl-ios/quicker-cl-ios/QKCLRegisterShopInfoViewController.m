//
//  QKAccountJudgeViewController.m
//  quicker-cl-ios
//
//  Created by Viet on 4/15/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLRegisterShopInfoViewController.h"
#import "CCAlertView.h"
#import "QKCLConfirmShopInfoViewController.h"
#import "QKCLShopInfoModel.h"
#import "QKTableViewCell.h"
#import "QKCLSelectMasterCityTableViewController.h"
#import "QKCLSelectMasterPrefectureTableViewController.h"
#import "QKTextFieldTableViewCell.h"

const NSInteger kCorporationNameTag = 1;
const NSInteger kCorporationNameKanaTag = 2;
const NSInteger kShopNameTag = 3;
const NSInteger kShopNameKanaTag = 4;
const NSInteger kPhoneNumTag = 5;
const NSInteger kPostCodeTag = 6;
const NSInteger kAddress1Tag = 7;
const NSInteger kAddress2Tag = 8;


@interface QKCLRegisterShopInfoViewController () <CCAlertViewDelegate, QKCLSelectMasterCityDelegate, QKCLSelectMasterPrefectureDelegate>

@property (nonatomic)   NSInteger selectedCurveIndex;
@end

static NSString *QKCLNormalTableViewCellIdentifier = @"NormalCell";
static NSString *QKCLTextFieldTableViewCellIdentifier = @"QKTextFieldTableViewCell";
@implementation QKCLRegisterShopInfoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //custom nav back
    [self setAngleLeftBarButton];
    
    //clean background uitableview
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.tableView registerNib:[UINib nibWithNibName:QKCLTextFieldTableViewCellIdentifier bundle:nil] forCellReuseIdentifier:QKCLTextFieldTableViewCellIdentifier];
    
    _selectedCurveIndex = -1;
    if (!_shopInfoModel) {
        _shopInfoModel = [[QKCLShopInfoModel alloc]init];
    }
    else {
        if ([_shopInfoModel.jobTypeLCd isEqualToString:[NSString stringFromConst:QK_SHOP_TYPE_CORPORATE]]) {
            _selectedCurveIndex = 0;
        }
        if ([_shopInfoModel.jobTypeLCd isEqualToString:[NSString stringFromConst:QK_SHOP_TYPE_INDIVIDUAL]]) {
            _selectedCurveIndex = 1;
        }
    }
    
    [self checkAddPhoto];
    [self checkSearchCode];
    //[self regiterCutomCell];
}

- (void)regiterCutomCell {
    [self.tableView registerNib:[UINib nibWithNibName:@"QKTextFieldTableViewCell" bundle:nil] forCellReuseIdentifier:@"CorporateCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QKTextFieldTableViewCell" bundle:nil] forCellReuseIdentifier:@"NameCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QKTextFieldTableViewCell" bundle:nil] forCellReuseIdentifier:@"NameKanaCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QKTextFieldTableViewCell" bundle:nil] forCellReuseIdentifier:@"PhoneNumCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"QKTextFieldTableViewCell" bundle:nil] forCellReuseIdentifier:@"PostCodeCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QKTextFieldTableViewCell" bundle:nil] forCellReuseIdentifier:@"Address1Cell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QKTextFieldTableViewCell" bundle:nil] forCellReuseIdentifier:@"Address2Cell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 9;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    else if (section == 1) {
        return 2;
    }
    else if (section == 2) {
        return 2;
    }
    else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    if (indexPath.section == 0) {
        QKTableViewCell *cells = [tableView dequeueReusableCellWithIdentifier:QKCLNormalTableViewCellIdentifier];
        if (cells == nil) {
            cells = [[QKTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QKCLNormalTableViewCellIdentifier];
        }
        cells.accessoryView = nil;
        cells.accessoryType = UITableViewCellAccessoryNone;
        switch (indexPath.row) {
            case 0:
                if (_selectedCurveIndex == 0) {
                    cells.accessoryView = [UIView QKTableViewCellAccessoryCheckmark];
                }
                cells.textLabel.text =  [QKCLConst.SHOP_TYPE_MAP objectForKey:QK_SHOP_TYPE_CORPORATE];
                break;
                
            case 1:
                if (_selectedCurveIndex == 1) {
                    cells.accessoryView = [UIView QKTableViewCellAccessoryCheckmark];
                }
                cells.textLabel.text = [QKCLConst.SHOP_TYPE_MAP objectForKey:QK_SHOP_TYPE_INDIVIDUAL];
                break;
        }
        
        cell =  cells;
    }
    else if (indexPath.section == 1) {
        QKTextFieldTableViewCell *cells = (QKTextFieldTableViewCell *)[tableView dequeueReusableCellWithIdentifier:QKCLTextFieldTableViewCellIdentifier forIndexPath:indexPath];
        if (cells == nil) {
            cells = [[QKTextFieldTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QKCLTextFieldTableViewCellIdentifier];
        }
        switch (indexPath.row) {
            case 0: {
                cells.textField.placeholder = @"ほげほげ";
                cells.textField.tag = kCorporationNameTag;
                cells.textField.text = _shopInfoModel.companyName;
                [cells.textField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
                cell = cells;
                break;
            }
                
            case 1: {
                cells.textField.placeholder = @"ホゲホゲ";
                cells.textField.tag = kCorporationNameKanaTag;
                cells.textField.text = _shopInfoModel.companyNameKana;
                [cells.textField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
                cell = cells;
                break;
            }
        }
    }
    else if (indexPath.section == 2) {
        QKTextFieldTableViewCell *cells = (QKTextFieldTableViewCell *)[tableView dequeueReusableCellWithIdentifier:QKCLTextFieldTableViewCellIdentifier forIndexPath:indexPath];
        if (cells == nil) {
            cells = [[QKTextFieldTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QKCLTextFieldTableViewCellIdentifier];
        }
        switch (indexPath.row) {
            case 0: {
                cells.textField.placeholder = NSLocalizedString(@"ほげほげ", nil);
                cells.textField.tag = kShopNameTag;
                cells.textField.text = _shopInfoModel.name;
                [cells.textField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
                cell = cells;
                break;
            }
                
            case 1:
            {
                cells.textField.placeholder = NSLocalizedString(@"ホゲホゲ", nil);
                cells.textField.tag = kShopNameKanaTag;
                cells.textField.text = _shopInfoModel.nameKana;
                [cells.textField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
                cell = cells;
                break;
            }
        }
    }
    else if (indexPath.section == 3) {
        QKTextFieldTableViewCell *cells = (QKTextFieldTableViewCell *)[tableView dequeueReusableCellWithIdentifier:QKCLTextFieldTableViewCellIdentifier forIndexPath:indexPath];
        if (cells == nil) {
            cells = [[QKTextFieldTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QKCLTextFieldTableViewCellIdentifier];
        }
        cells.textField.placeholder = @"0312345678";
        [cells.textField setKeyboardType:UIKeyboardTypeNumberPad];
        cells.textField.tag = kPhoneNumTag;
        cells.textField.text = _shopInfoModel.phoneNum;
        [cells.textField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
        
        cell = cells;
    }
    else if (indexPath.section == 4) {
        QKTextFieldTableViewCell *cells = (QKTextFieldTableViewCell *)[tableView dequeueReusableCellWithIdentifier:QKCLTextFieldTableViewCellIdentifier forIndexPath:indexPath];
        if (cells == nil) {
            cells = [[QKTextFieldTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QKCLTextFieldTableViewCellIdentifier];
        }
        cells.textField.placeholder = @"1234567";
        [cells.textField setKeyboardType:UIKeyboardTypeNumberPad];
        cells.textField.tag = kPostCodeTag;
        cells.textField.text = _shopInfoModel.postcd;
        [cells.textField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
        cell = cells;
    }
    else if (indexPath.section == 5) {
        QKTableViewCell *cells = [tableView dequeueReusableCellWithIdentifier:QKCLNormalTableViewCellIdentifier];
        if (cells == nil) {
            cells = [[QKTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QKCLNormalTableViewCellIdentifier];
        }
        cells.textLabel.text = _shopInfoModel.addressPrfName;
        cells.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cells.accessoryView = nil;
        cell = cells;
    }
    else if (indexPath.section == 6) {
        QKTableViewCell *cells = [tableView dequeueReusableCellWithIdentifier:QKCLNormalTableViewCellIdentifier];
        if (cells == nil) {
            cells = [[QKTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QKCLNormalTableViewCellIdentifier];
        }
        cells.textLabel.text = _shopInfoModel.addressCityName;
        cells.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cells.accessoryView = nil;
        cell = cells;
    }
    else if (indexPath.section == 7) {
        QKTextFieldTableViewCell *cells = (QKTextFieldTableViewCell *)[tableView dequeueReusableCellWithIdentifier:QKCLTextFieldTableViewCellIdentifier forIndexPath:indexPath];
        if (cells == nil) {
            cells = [[QKTextFieldTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QKCLTextFieldTableViewCellIdentifier];
        }
        cells.textField.placeholder = @"1-2-34";
        cells.textField.tag = kAddress1Tag;
        cells.textField.text = _shopInfoModel.address1;
        [cells.textField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
        
        cell = cells;
    }
    else {
        QKTextFieldTableViewCell *cells = (QKTextFieldTableViewCell *)[tableView dequeueReusableCellWithIdentifier:QKCLTextFieldTableViewCellIdentifier forIndexPath:indexPath];
        if (cells == nil) {
            cells = [[QKTextFieldTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QKCLTextFieldTableViewCellIdentifier];
        }
        cells.textField.placeholder = @"RJBビル 4F";
        cells.textField.tag = kAddress2Tag;
        cells.textField.text = _shopInfoModel.address2;
        [cells.textField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
        cell = cells;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"事業形態";
    }
    else if (section == 1) {
        return @"法人名";
    }
    else if (section == 2) {
        return @"店舗名";
    }
    else if (section  == 3) {
        return @"店舗の電話番号";
    }
    else if (section  == 4) {
        return @"店舗の郵便番号";
    }
    else if (section  == 5) {
        return @"都道府県";
    }
    else if (section  == 6) {
        return @"市区町村";
    }
    else if (section  == 7) {
        return @"番地";
    }
    else {
        return @"ビル・マンション名(任意)";
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 4) {
        UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 80)];
        footerView.backgroundColor = [UIColor clearColor];
        if (_btnSearch == nil) {
            _btnSearch = [[QKGlobalMinButton alloc]initWithFrame:CGRectMake(10, 5, tableView.frame.size.width - 20, 30)];
            [_btnSearch setTitle:@"￼郵便番号から住所を検索" forState:UIControlStateNormal];
            _btnSearch.tag = 1111;
            [_btnSearch addTarget:self action:@selector(searchClick:) forControlEvents:UIControlEventTouchUpInside];
            
            if (_shopInfoModel.postcd == nil || [_shopInfoModel.postcd isEqualToString:@""]) {
                [_btnSearch setEnabled:NO];
            }
            else {
                [_btnSearch setEnabled:YES];
            }
        }
        
        [footerView addSubview:_btnSearch];
        return footerView;
    }
    return nil;
}

- (void)searchClick:(id)sender {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKey];
        [params setObject:_shopInfoModel.postcd forKey:@"postalCd"];
        [[QKCLRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkUrlMasterAddress] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                _shopInfoModel.address1 = responseObject[@"address"];
                
                _shopInfoModel.addressCityName = responseObject[@"cityName"];
                _shopInfoModel.addressCityJisCd = responseObject[@"cityJisCd"];
                
                _shopInfoModel.addressPrfName = responseObject[@"prfName"];
                _shopInfoModel.addressPrfJisCd = responseObject[@"prfJisCd"];
                
                [self.tableView reloadData];
                [self checkAddPhoto];
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Search address fail..");
        }];
    }
    else {
        [self showNoInternetViewWithSelector:nil];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    //    if (section == 5) {
    //        return 80;
    //    }
    return 37;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 4) {
        return 50;
    }
    else {
        return 0.001f;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        cell.accessoryView = [UIView QKTableViewCellAccessoryCheckmark];
        if (_selectedCurveIndex != -1 && _selectedCurveIndex != indexPath.row) {
            NSIndexPath *oldPath = [NSIndexPath indexPathForRow:_selectedCurveIndex inSection:indexPath.section];
            
            cell = [_tableView cellForRowAtIndexPath:oldPath];
            cell.accessoryView = nil;
        }
        _selectedCurveIndex = indexPath.row;
        [self checkAddPhoto];
    }
    
    else if (indexPath.section == 5) {
        [self performSegueWithIdentifier:@"QkSelectPrefectureSegue" sender:self];
    }
    else if (indexPath.section == 6) {
        [self performSegueWithIdentifier:@"QkSelectCitySegue" sender:self];
    }
}

#pragma TEXTFIELD delegate
- (void)checkSearchCode {
    if (_shopInfoModel.postcd == nil || [_shopInfoModel.postcd isEqualToString:@""]) {
        [_btnSearch setEnabled:NO];
    }
    else {
        [_btnSearch setEnabled:YES];
    }
}

- (void)checkAddPhoto {
    BOOL enabled = YES;
    if (_selectedCurveIndex == -1) {
        enabled = NO;
    }
    else if (_selectedCurveIndex == 0) {
        //corporate
        if (_shopInfoModel.companyName == nil || [_shopInfoModel.companyName isEqualToString:@""]) {
            enabled = NO;
        }
        if (_shopInfoModel.companyNameKana == nil || [_shopInfoModel.companyNameKana isEqualToString:@""]) {
            enabled = NO;
        }
    }
    
    if (_shopInfoModel.name == nil || [_shopInfoModel.name isEqualToString:@""]) {
        enabled = NO;
    }
    if (_shopInfoModel.nameKana == nil || [_shopInfoModel.nameKana isEqualToString:@""]) {
        enabled = NO;
    }
    if (_shopInfoModel.phoneNum == nil || [_shopInfoModel.phoneNum isEqualToString:@""]) {
        enabled = NO;
    }
    if (_shopInfoModel.postcd == nil || [_shopInfoModel.postcd isEqualToString:@""]) {
        enabled = NO;
    }
    if (_shopInfoModel.addressPrfName == nil || [_shopInfoModel.addressPrfName isEqualToString:@""]) {
        enabled = NO;
    }
    if (_shopInfoModel.addressCityName == nil || [_shopInfoModel.addressCityName isEqualToString:@""]) {
        enabled = NO;
    }
    if (_shopInfoModel.address1 == nil || [_shopInfoModel.address1 isEqualToString:@""]) {
        enabled = NO;
    }
    
    
    [self.nextButton setEnabled:enabled];
}

#pragma mark -Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"QKCLConfirmShopInfoSegue"]) {
        QKCLConfirmShopInfoViewController *corfirmViewController = (QKCLConfirmShopInfoViewController *)segue.destinationViewController;
        corfirmViewController.isPresented = _isPresented;
        corfirmViewController.shopInfoModel = _shopInfoModel;
    }
    else if ([[segue identifier] isEqualToString:@"QkSelectPrefectureSegue"]) {
        QKCLSelectMasterPrefectureTableViewController *selectPrefecture = (QKCLSelectMasterPrefectureTableViewController *)[segue destinationViewController];
        selectPrefecture.delegate = self;
        QKCLMasterPrefectureModel *masterPrefecture = [[QKCLMasterPrefectureModel alloc]init];
        masterPrefecture.prfJisCd = _shopInfoModel.addressPrfJisCd;
        masterPrefecture.prfName = _shopInfoModel.addressPrfName;
        selectPrefecture.currentPrefectureModel = masterPrefecture;
    }
    else if ([[segue identifier] isEqualToString:@"QkSelectCitySegue"]) {
        QKCLSelectMasterCityTableViewController *selectCity = (QKCLSelectMasterCityTableViewController *)[segue destinationViewController];
        selectCity.delegate = self;
        QKCLMasterCityModel *masterCity = [[QKCLMasterCityModel alloc]init];
        masterCity.prfJisCd = _shopInfoModel.addressPrfJisCd;
        masterCity.cityJisCd = _shopInfoModel.addressCityJisCd;
        masterCity.cityName = _shopInfoModel.addressCityName;
        selectCity.currentCityModel = masterCity;
    }
}

//click add photo
- (IBAction)goToConfirmScreenClicked:(id)sender {
    //get shoptype
    switch (_selectedCurveIndex) {
        case 0: {
            _shopInfoModel.jobTypeLCd = [NSString stringFromConst:QK_SHOP_TYPE_CORPORATE];
            _shopInfoModel.jobTypeLName = [QKCLConst.SHOP_TYPE_MAP objectForKey:QK_SHOP_TYPE_CORPORATE];
            break;
        }
            
        case 1: {
            _shopInfoModel.jobTypeLCd = [NSString stringFromConst:QK_SHOP_TYPE_INDIVIDUAL];
            _shopInfoModel.jobTypeLName = [QKCLConst.SHOP_TYPE_MAP objectForKey:QK_SHOP_TYPE_INDIVIDUAL];
            break;
        }
    }
    
    [self performSegueWithIdentifier:@"QKCLConfirmShopInfoSegue" sender:self];
}

//handle change text
- (void)textChange:(id)sender {
    QKGlobalTextField *textField = (QKGlobalTextField *)sender;
    switch (textField.tag) {
        case kCorporationNameTag:
            _shopInfoModel.companyName = textField.text;
            break;
            
        case kCorporationNameKanaTag:
            _shopInfoModel.companyNameKana = textField.text;
            break;
            
        case kShopNameTag:
            _shopInfoModel.name = textField.text;
            break;
            
        case kShopNameKanaTag:
            _shopInfoModel.nameKana = textField.text;
            break;
            
        case kPhoneNumTag:
            _shopInfoModel.phoneNum = textField.text;
            break;
            
        case kPostCodeTag:
            _shopInfoModel.postcd = textField.text;
            [self checkSearchCode];
            break;
            
        case kAddress1Tag:
            _shopInfoModel.address1 = textField.text;
            break;
            
        case kAddress2Tag:
            _shopInfoModel.address2 = textField.text;
            break;
            
        default:
            break;
    }
    
    
    [self checkAddPhoto];
}

#pragma mark -QKCLSelectMasterCityDelegate
- (void)citySelected:(QKCLMasterCityModel *)selectedCity {
    _shopInfoModel.addressCityName = selectedCity.cityName;
    _shopInfoModel.addressCityJisCd = selectedCity.cityJisCd;
    _shopInfoModel.addressPrfJisCd = selectedCity.prfJisCd;
}

#pragma mark -QKCLSelectMasterCityDelegate
- (void)prefectureSelected:(QKCLMasterPrefectureModel *)selectedPrefecture {
    _shopInfoModel.addressPrfName = selectedPrefecture.prfName;
    _shopInfoModel.addressPrfJisCd = selectedPrefecture.prfJisCd;
}

@end
