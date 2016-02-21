//
//  QKRegisterShopInfoConfirmViewController.m
//  quicker-cl-ios
//
//  Created by Nguyen Viet Thang on 6/3/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLConfirmShopInfoViewController.h"
#import "QKF10Label.h"
#import "chiase-ios-core/UIImage+Extra.h"
#import "QKTableViewCell.h"

@interface QKCLConfirmShopInfoViewController () {
    float heightNeedToLayout;
}

@end

@implementation QKCLConfirmShopInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //custom back nav
    [self setAngleLeftBarButton];
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
    if (section == 1 || section == 2) {
        return 2;
    }
    else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QKTableViewCell *cell = (QKTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CellView" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[QKTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellView"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        cell.textLabel.text = self.shopInfoModel.jobTypeLName;
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.textLabel.text = self.shopInfoModel.companyName;
        }
        else {
            cell.textLabel.text = self.shopInfoModel.companyNameKana;
        }
    }
    else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            cell.textLabel.text = self.shopInfoModel.name;
        }
        else {
            cell.textLabel.text = self.shopInfoModel.nameKana;
        }
    }
    else if (indexPath.section == 3) {
        cell.textLabel.text = self.shopInfoModel.phoneNum;
    }
    else if (indexPath.section == 4) {
        cell.textLabel.text = self.shopInfoModel.postcd;
    }
    else if (indexPath.section == 5) {
        cell.textLabel.text = self.shopInfoModel.addressPrfName;
    }
    else if (indexPath.section == 6) {
        cell.textLabel.text = self.shopInfoModel.addressCityName;
    }
    else if (indexPath.section == 7) {
        cell.textLabel.text = self.shopInfoModel.address1;
    }
    else {
        cell.textLabel.text = self.shopInfoModel.address2;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return NSLocalizedString(@"事業形態", nil);
    }
    else if (section == 1) {
        return NSLocalizedString(@"法人名", nil);
    }
    else if (section == 2) {
        return NSLocalizedString(@"店舗名", nil);
    }
    else if (section  == 3) {
        return NSLocalizedString(@"店舗の電話番号", nil);
    }
    else if (section  == 4) {
        return NSLocalizedString(@"店舗の郵便番号", nil);
    }
    else if (section  == 5) {
        return NSLocalizedString(@"都道府県", nil);
    }
    else if (section  == 6) {
        return NSLocalizedString(@"市区町村", nil);
    }
    else if (section  == 7) {
        return NSLocalizedString(@"番地", nil);
    }
    else if (section  == 8) {
        return NSLocalizedString(@"ビル・マンション名", nil);
    }
    return @"";
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    CGRect frame = tableView.frame;
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//
//    QKF20Label *headerText = [[QKF20Label alloc]initWithFrame:CGRectMake(10, 15, frame.size.width, 20)];
//    [headerView addSubview:headerText];
//    if (section == 0) {
//        [headerText setText:@"事業形態"];
//    }
//    else if (section == 1) {
//        [headerText setText:@"法人名"];
//    }
//    else if (section == 2) {
//        [headerText setText:@"店舗名"];
//    }
//    else if (section  == 3) {
//        [headerText setText:@"店舗の電話番号"];
//    }
//    else if (section  == 4) {
//        [headerText setText:@"店舗の郵便番号"];
//    }
//    else if (section  == 5) {
//        [headerText setText:@"都道府県"];
//    }
//    else if (section  == 6) {
//        [headerText setText:@"市区町村"];
//    }
//    else if (section  == 7) {
//        [headerText setText:@"番地"];
//    }
//    else if (section  == 8) {
//        [headerText setText:@"ビル・マンション名"];
//    }
//
//    return headerView;
//}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)confirmShopClicked:(id)sender {
    if ([self connected]) {
        //Loading data
        NSLog(@"Regist new shop...");
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setValue:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [params setValue:self.shopInfoModel.jobTypeLCd forKey:@"classificationCd"];
        [params setValue:self.shopInfoModel.companyName forKey:@"companyName"];
        [params setValue:self.shopInfoModel.companyNameKana forKey:@"companyNameKana"];
        [params setValue:self.shopInfoModel.name forKey:@"name"];
        [params setValue:self.shopInfoModel.nameKana forKey:@"nameKana"];
        [params setValue:self.shopInfoModel.phoneNum forKey:@"phoneNum"];
        [params setValue:self.shopInfoModel.postcd forKey:@"postcd"];
        [params setValue:self.shopInfoModel.addressPrfJisCd forKey:@"addressPrfJisCd"];
        [params setValue:self.shopInfoModel.addressCityJisCd forKey:@"addressCityJisCd"];
        [params setValue:self.shopInfoModel.addressPrfName forKey:@"addressPrfJisName"];
        [params setValue:self.shopInfoModel.addressCityName forKey:@"addressCityJisName"];
        [params setValue:self.shopInfoModel.address1 forKey:@"address1"];
        [params setValue:self.shopInfoModel.address2 forKey:@"address2"];
        
        
        [[QKCLRequestManager sharedManager] asyncPOST:[NSString stringFromConst:qkUrlShopRegist] parameters:params showLoading:YES showError:YES constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            NSData*imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString: @"http://img4.wikia.nocookie.net/__cb20130106052101/olympians/images/2/2e/Karate-Kick!_-).jpeg"]];
            [formData appendPartWithFileData:imageData name:@"imageFileOutside" fileName:@"imageFileOutside.jpeg" mimeType:@"image/jpeg"];
            [formData appendPartWithFileData:imageData name:@"imageFileInside" fileName:@"imageFileInside.jpeg" mimeType:@"image/jpeg"];
            
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"Regist shop successful...");
            NSLog(@"status cd : %@", responseObject[@"statusCd"]);
            if ([responseObject[@"statusCd"] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                [QKCLAccessUserDefaults setNewShopId:[responseObject valueForKey:@"shopId"]];
                
                NSString *title = @"新規登録の申請を\n受け付けました";
                NSString *detail = @"店舗申請には最大で2〜3営業日程度\nかかります。詳しくはご案内メールの\n内容をご確認ください。";
                
                CCAlertView *addShopAlertView = [[CCAlertView alloc]initWithImage:[UIImage imageNamed:@"dialog_pic_done"] title:title message:detail delegate:self buttonTitles:@[@"OK"]];
                addShopAlertView.delegate = self;
                [addShopAlertView showAlert];
                
                //enabled
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Regist shop error...");
        }];
    }
    else {
        [self showNoInternetViewWithSelector:nil];
    }
}

#pragma mark - CCAlertViewDelegate
- (void)alertView:(CCAlertView *)alertView selectedButtonIndex:(NSInteger)index {
    if (index == 0) {
        if (_isPresented) {
            [self dismissViewControllerAnimated:YES completion: ^{
                [QKCLAccessUserDefaults put:@"QKAddShopFromSlideMenu" withValue:@""];
                //                QKSlideMenuViewController *vc = [[QKSlideMenuViewController alloc]init];
                //                [vc reloadDatas];
            }];
        }
        else {
            [self performSegueWithIdentifier:@"QKExaminationSegue" sender:self];
        }
    }
}

@end
