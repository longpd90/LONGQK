//
//  QKEditShopInfoViewController.m
//  quicker-cl-ios
//
//  Created by Quy on 5/11/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#define tagMainImage 15
#define tagLeftImage 16
#define tagRightImage 17
#define mainButtonTag 25
#define leftButtonTag 26
#define rightButtonTag 27
#define callCenterAlerTag 200
#define wrongpassAlertTag 500


#define descriptionTag 10
#define alertDeleteShopConfirmTag 100
#define alertEnterPasswordTag 101
#define alertDeleteShopCompleteTag 102

#import "QKEditShopInfoTableViewCell.h"
#import "QKCLShopEditInfoViewController.h"
#import "QKCLCropImageViewController.h"
#import "QKCLCameraViewController.h"
#import "AppDelegate.h"
#import "QKImageView.h"
#import "QKCLShopFreeItemModel.h"

@interface QKCLShopEditInfoViewController () <QKCropImageViewControllerDelegate>

@property (strong, nonatomic) QKCLShopInfoModel *editShopInfo;
@property (nonatomic, assign) NSInteger imageIndex;
@property (strong, nonatomic) NSString *passWord;
@property (strong, nonatomic) NSString *imageId1;
@property (strong, nonatomic) NSString *imageId2;
@property (strong, nonatomic) NSString *imageId3;
@property (strong, nonatomic) UIImage *image1;
@property (strong, nonatomic) UIImage *image2;
@property (strong, nonatomic) UIImage *image3;
@property (strong, nonatomic) CCAlertView *wrongPassAlert;
@property (strong, nonatomic) CCAlertView *enterPassAlv;
@property (strong, nonatomic) CCAlertView *confirmAlv;
@property (strong, nonatomic) CCAlertView *completeAlv;
@property (strong, nonatomic) NSMutableArray *shopArrays;

- (IBAction)mainImageButtonClick:(id)sender;
- (IBAction)leftImageButtonClick:(id)sender;
- (IBAction)rightImageButtonClick:(id)sender;

@end

static NSString *kQKTextViewTableViewCellIdentifier = @"QKTextViewTableViewCell";

@implementation QKCLShopEditInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setRightBarButtonWithTitle:NSLocalizedString(@"完了", nil) target:@selector(updateShopInfo)];
    [self setLeftBarButtonWithTitle:NSLocalizedString(@"キャンセル", nil) target:@selector(goBack:)];
    
    [self.editShopTableView registerNib:[UINib nibWithNibName:kQKTextViewTableViewCellIdentifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:kQKTextViewTableViewCellIdentifier];
    
    //get shop info
    [self getShopInfo];
}

//- (void)checkEnableImage {
//    QKEditShopInfoTableViewCell *cell = (QKEditShopInfoTableViewCell*)[self.editShopTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//    if (cell.mainImage.image != nil) {
//        [cell.mainAddPhotoImage setHidden:YES];
//        [cell.crossMainImage setHidden:NO];
//    }
//    if (cell.subLeftImage.image != nil) {
//        [cell.leftAddPhotoImage setHidden:YES];
//        [cell.crossLeftImage setHidden:NO];
//    }
//    if (cell.subRightImage.image != nil) {
//        [cell.rightAddPhotoImage setHidden:YES];
//        [cell.crossRightImage setHidden:NO];
//    }
//}

- (void)updateShopInfo {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:[QKCLAccessUserDefaults getActiveShopId] forKey:@"shopId"];
        [params setObject:[self getJsonFromFreeItemList] forKey:@"json"];
        [params setValue:_editShopInfo.accessWay forKey:@"accessWay"];
        
        NSMutableSet *set = [[NSMutableSet alloc]init];
        if (_imageId1 != nil && ![_imageId1 isEqualToString:@""]) {
            [set addObject:_imageId1];
        }
        if (_imageId2 != nil && ![_imageId2 isEqualToString:@""]) {
            [set addObject:_imageId2];
        }
        if (_imageId3 != nil && ![_imageId3 isEqualToString:@""]) {
            [set addObject:_imageId3];
        }
        [params setObject:set forKey:@"imageId"];
        
        
        NSDictionary *response;
        NSError *error;
        BOOL result = [[QKCLRequestManager sharedManager] syncPOST:[NSString stringFromConst:qkUrlShopUpdateComplete] parameters:params response:&response error:&error showLoading:YES showError:YES];
        
        if (result) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else {
        [self showNoInternetViewWithSelector:@selector(updateShopInfo)];
    }
}

- (void)getShopInfo {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:[QKCLAccessUserDefaults getActiveShopId] forKey:@"shopId"];
        [[QKCLRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkUrlShopDetail] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                _editShopInfo = [[QKCLShopInfoModel alloc]initWithResponse:responseObject];
                
                if (_editShopInfo.imageFileList.count > 0) {
                    QKCLImageModel *image1Model = _editShopInfo.imageFileList[0];
                    _imageId1 = image1Model.imageId;
                }
                if (_editShopInfo.imageFileList.count > 1) {
                    QKCLImageModel *image2Model = _editShopInfo.imageFileList[1];
                    _imageId2 = image2Model.imageId;
                }
                if (_editShopInfo.imageFileList.count > 2) {
                    QKCLImageModel *image3Model = _editShopInfo.imageFileList[2];
                    _imageId3 = image3Model.imageId;
                }
                
                
                [_editShopTableView reloadData];
                // [self checkEnableImage];
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
    else {
        [self showNoInternetViewWithSelector:@selector(getShopInfo)];
    }
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self checkEnableImage];
//}

#pragma mark - UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3 + _editShopInfo.freeItemList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 1 + _editShopInfo.freeItemList.count || section == 2 + _editShopInfo.freeItemList.count) {
        return 0.01f;
    }
    else {
        return 50.0f;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 1 + _editShopInfo.freeItemList.count || section == 2 + _editShopInfo.freeItemList.count) {
        return nil;
    }
    else {
        QKCLShopFreeItemModel *item = [_editShopInfo.freeItemList objectAtIndex:section - 1];
        return item.freeItemJobTypeLName;
    }
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    if (indexPath.section == 0) {
        QKEditShopInfoTableViewCell *cell1 = (QKEditShopInfoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ShopPhotoTableViewCell"];
        if (!cell1) {
            cell1 = [[QKEditShopInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ShopPhotoTableViewCell"];
        }
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (_imageId1 != nil && ![_imageId1 isEqualToString:@""]) {
            if (_image1) {
                [cell1.mainImage setImage:_image1];
            }
            else {
                QKCLImageModel *mainModel = (QKCLImageModel *)[_editShopInfo.imageFileList objectAtIndex:0];
                [cell1.mainImage setImageWithQKURL:mainModel.imageUrl withCache:YES];
            }
            
            [cell1.mainAddPhotoImage setHidden:YES];
            [cell1.crossMainImage setHidden:NO];
        }
        if (_imageId2 != nil && ![_imageId2 isEqualToString:@""]) {
            if (_image2) {
                [cell1.subLeftImage setImage:_image2];
            }
            else {
                QKCLImageModel *leftModel = (QKCLImageModel *)[_editShopInfo.imageFileList objectAtIndex:1];
                [cell1.subLeftImage setImageWithQKURL:leftModel.imageUrl withCache:YES];
            }
            
            [cell1.leftAddPhotoImage setHidden:YES];
            [cell1.crossLeftImage setHidden:NO];
        }
        if (_imageId3 != nil && ![_imageId3 isEqualToString:@""]) {
            if (_image3) {
                [cell1.subRightImage setImage:_image3];
            }
            else {
                QKCLImageModel *rightModel = (QKCLImageModel *)[_editShopInfo.imageFileList objectAtIndex:2];
                [cell1.subRightImage setImageWithQKURL:rightModel.imageUrl withCache:YES];
            }
            
            [cell1.rightAddPhotoImage setHidden:YES];
            [cell1.crossRightImage setHidden:NO];
        }
        
        cell1.shopNameLabel.text = [QKCLAccessUserDefaults getActiveShopName];
        cell = cell1;
    }
    else if (indexPath.section == 1 + _editShopInfo.freeItemList.count) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"RecommentTextViewCell"];
        UITextView *myTextView = (UITextView *)[cell viewWithTag:50];
        [myTextView setTextContainerInset:UIEdgeInsetsMake(10.0f, 15.0f, 10.0f, 15.0f)];
        [myTextView setTextColor:[UIColor colorWithHexString:@"#888"]];
        myTextView.textAlignment = NSTextAlignmentLeft;
        myTextView.font = [UIFont systemFontOfSize:10.0f];
        myTextView.layer.borderWidth = 1.0f;
        myTextView.layer.cornerRadius = 3.0f;
        myTextView.alpha = 0.9;
        myTextView.layer.borderColor = [UIColor colorWithHexString:@"#D9DBDA"].CGColor;
        [myTextView setText:NSLocalizedString(@"業種、業態、連絡先、住所についてはアプリ上から変更することはできません。変更をご希望の場合は、コールセンターへお問い合わせください。", nil)];
        myTextView.scrollEnabled = NO;
    }
    else if (indexPath.section == 2 + _editShopInfo.freeItemList.count) {
        QKTextViewTableViewCell *cell2 = (QKTextViewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kQKTextViewTableViewCellIdentifier];
        if (!cell2) {
            cell2 = [[QKTextViewTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kQKTextViewTableViewCellIdentifier];
        }
        cell2.delegate = self;
        [cell2 setMaxLength:200];
        [cell2 setText:_editShopInfo.accessWay];
        [cell2.textView setTag:indexPath.section];
        cell = cell2;
    }
    else {
        QKTextViewTableViewCell *cell3 = (QKTextViewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kQKTextViewTableViewCellIdentifier];
        cell3.delegate = self;
        [cell3 setMaxLength:200];
        QKCLShopFreeItemModel *item = [_editShopInfo.freeItemList objectAtIndex:indexPath.section - 1];
        [cell3 setText:item.freeItemJobTypeLValue];
        cell3.textView.tag = indexPath.section;
        cell = cell3;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        QKEditShopInfoTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"ShopPhotoTableViewCell"];
        if (!cell1) {
            cell1 = [[QKEditShopInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ShopPhotoTableViewCell"];
        }
        cell1.shopNameLabel.text = [QKCLAccessUserDefaults getActiveShopName];
        return [cell1 getCellHeight];
    }
    else {
        return 200.0f;
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001f;
}

#pragma mark -Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"QKAddPhotoForShopSegue"]) {
        UINavigationController *nav = [segue destinationViewController];
        QKCLCameraViewController *cameraViewController = (QKCLCameraViewController *)nav.viewControllers[0];
        cameraViewController.hintSegue = @"QKShopHintSegue";
        cameraViewController.cropImageType = QKCropImageTypeRectangle;
        cameraViewController.presentingVC = self;
        switch (_imageIndex) {
            case mainButtonTag:
                cameraViewController.sourceImageType = [NSString stringFromConst:QK_IMAGE_TYPE_MAIN];
                break;
                
            default:
                cameraViewController.sourceImageType = [NSString stringFromConst:QK_IMAGE_TYPE_OTHER];
                
                break;
        }
    }
}

#pragma mark - CropImageDelegate
- (void)croppedImage:(UIImage *)image imageId:(NSString *)imageId {
    switch (_imageIndex) {
        case mainButtonTag: {
            _imageId1 = imageId;
            _image1 = image;
            break;
        }
            
        case leftButtonTag:
            _imageId2 =  imageId;
            _image2 = image;
            
            break;
            
        case rightButtonTag:
            _imageId3 =  imageId;
            _image3 = image;
            break;
            
        default: break;
    }
    [_editShopTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)mainImageButtonClick:(id)sender {
    _imageIndex = ((UIButton *)sender).tag;
    [self performSegueWithIdentifier:@"QKAddPhotoForShopSegue" sender:self];
}

- (IBAction)leftImageButtonClick:(id)sender {
    _imageIndex = ((UIButton *)sender).tag;
    
    [self performSegueWithIdentifier:@"QKAddPhotoForShopSegue" sender:self];
    //  [self performActionSheet];
}

- (IBAction)rightImageButtonClick:(id)sender {
    _imageIndex = ((UIButton *)sender).tag;
    [self performSegueWithIdentifier:@"QKAddPhotoForShopSegue" sender:self];
}

- (IBAction)deleteShopButtonClicked:(id)sender {
    self.enterPassAlv = [[CCAlertView alloc] initWithTitle:@"パスワードの確認" message:@"店舗の削除にはパスワードが必要です" delegate:self buttonTitles:@[@"キャンセル", @"OK"] haveTextField:YES];
    [self.enterPassAlv setTag:alertEnterPasswordTag];
    [self.enterPassAlv showAlert];
}

- (IBAction)callCenterButtonClicked:(id)sender {
    CCAlertView *numberAlert = [[CCAlertView alloc] initWithTitle:@"コールセンターへ 電話をかけます" message:[NSString stringFromConst:kQKCenterPhoneNum] delegate:self buttonTitles:@[@"キャンセル", @"発信"]];
    numberAlert.delegate = self;
    numberAlert.tag = callCenterAlerTag;
    [numberAlert showAlert];
}

- (void)deleteShopCheckPass {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:[QKCLEncryptUtil encyptBlowfish:self.passWord] forKey:@"password"];
        
        [[QKCLRequestManager sharedManager] asyncPOST:[NSString stringFromConst:qkUrlClAccountPasswordReauth] parameters:params showLoading:YES showError:NO success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                NSString *stringLineBreak = [NSString stringWithFormat:@"%@\n%@\n%@", @"削除すると、店舗情報、勤務履歴、", @"請求情報、登録クレジットカード情報などの", @"全ての情報が削除されます"];
                self.confirmAlv = [[CCAlertView alloc] initWithTitle:@"店舗を削除しますか？" message:stringLineBreak delegate:self buttonTitles:@[@"しない", @"削除する"]];
                [self.confirmAlv setTag:alertDeleteShopConfirmTag];
                [self.confirmAlv showAlert];
            }
            else {
                self.wrongPassAlert = [[CCAlertView alloc]initWithTitle:@"パスワードが一致しません" message:@"再度入力をしてください" delegate:self buttonTitles:@[@"キャンセル", @"OK"] haveTextField:YES];
                [self.wrongPassAlert setTag:wrongpassAlertTag];
                [self.wrongPassAlert showAlert];
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Errror:%@", error);
        }];
    }
    else {
        [self showNoInternetViewWithSelector:nil];
    }
}

#pragma mark-CCAlertViewDelegate
- (void)alertView:(CCAlertView *)alertView selectedButtonIndex:(NSInteger)index {
    switch (alertView.tag) {
        case alertEnterPasswordTag: {
            if (index == 1) {
                _passWord = alertView.textField.text;
                [self deleteShopCheckPass];
            }
            break;
        }
            
        case callCenterAlerTag:
        {
            if (index == 1) {
                [self callCenter];
            }
            break;
        }
            
        case alertDeleteShopConfirmTag:
        {
            if (index == 1) {
                [self deleteShop];
            }
            break;
        }
            
        case alertDeleteShopCompleteTag: {
            if (index == 0) {
                [self deleteShopComplete];
            }
            break;
        }
            
        case wrongpassAlertTag:
            
        {
            if (index == 1) {
                self.passWord = alertView.textField.text;
                [self deleteShopCheckPass];
            }
            
            break;
        }
            
        default: break;
    }
}

#pragma mark textFieldDelegate
- (void)editingChanged:(UITextView *)textView {
    if (textView.tag == 2 + _editShopInfo.freeItemList.count) {
        _editShopInfo.accessWay = textView.text;
    }
    else {
        QKCLShopFreeItemModel *item = [_editShopInfo.freeItemList objectAtIndex:textView.tag - 1];
        item.freeItemJobTypeLValue = textView.text;
    }
}

- (void)deleteShop {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:[QKCLAccessUserDefaults getActiveShopId] forKey:@"shopId"];
        [params setObject:[QKCLEncryptUtil encyptBlowfish:self.passWord] forKey:@"password"];
        
        [[QKCLRequestManager sharedManager] asyncPOST:[NSString stringFromConst:qkUrlShopDelete]  parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                [QKCLAccessUserDefaults setActiveShopId:@""];
                _shopArrays = responseObject[@"activeShop"];
                if (_shopArrays == nil || _shopArrays.count == 0) {
                    NSString *msg = [NSString stringWithFormat:@"%@\n%@", NSLocalizedString(@"管理すると店舗が無くなりました", nil), NSLocalizedString(@"必要に応じて新たなに設定してください", nil)];
                    self.completeAlv = [[CCAlertView alloc] initWithImage:[UIImage imageNamed:@"dialog_pic_done"] title:NSLocalizedString(@"店舗を削除しました", nil) message:msg delegate:self buttonTitles:[NSArray arrayWithObjects:NSLocalizedString(@"OK", nil), nil]];
                }
                else {
                    self.completeAlv = [[CCAlertView alloc] initWithImage:[UIImage imageNamed:@"dialog_pic_done"] title:NSLocalizedString(@"店舗を削除しました", nil) message:@"管理する別の店舗へ自動的に移動します" delegate:self buttonTitles:[NSArray arrayWithObjects:NSLocalizedString(@"OK", nil), nil]];
                }
                [self.completeAlv showAlert];
                [self.completeAlv setTag:alertDeleteShopCompleteTag];
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
    else {
        [self showNoInternetViewWithSelector:nil];
    }
}

- (void)deleteShopComplete {
    if (_shopArrays == nil || _shopArrays.count == 0) {
        AppDelegate *vc = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        [vc moveToShopAddScreen];
    }
    else {
        NSDictionary *firstShop = [_shopArrays objectAtIndex:0];
        [QKCLAccessUserDefaults setActiveShopId:firstShop[@"shopId"]];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark- getJsonFromFreeItemList
- (NSString *)getJsonFromFreeItemList {
    NSMutableArray *array = [NSMutableArray new];
    for (QKCLShopFreeItemModel *item in _editShopInfo.freeItemList) {
        NSDictionary *entry = [[NSDictionary alloc] initWithObjectsAndKeys:
                               item.freeItemJobTypeLCd, @"freeItemJobTypeLCd",
                               item.freeItemJobTypeLValue, @"freeItemJobTypeLValue",
                               
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

@end
