//
//  QKEnterStoreInfoViewController.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 4/15/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLShopEnterInfoViewController.h"
#import "QKTableViewCell.h"
#import "QKCLShopInputPhotoViewController.h"
#import "QKCLShopFreeItemModel.h"

@interface QKCLShopEnterInfoViewController ()

@end

static NSString *TextViewIdentifier = @"QKTextViewTableViewCell";

@implementation QKCLShopEnterInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAngleLeftBarButton];
    _shopNameLabel.text = _shopInfo.name;
    [self.tableView registerNib:[UINib nibWithNibName:TextViewIdentifier bundle:nil]  forCellReuseIdentifier:TextViewIdentifier];
    
    [_saveButton setEnabled:NO];
    
    //get freeItemList
    [self getFreeItemList];
    
    [self.tableView reloadData];
}

//call API MST_00011
- (void)getFreeItemList {
    NSMutableDictionary *params = [NSMutableDictionary initWithApiKey];
    [params setObject:_shopInfo.jobTypeLCd forKey:@"jobTypeLCd"];
    
    NSDictionary *response;
    NSError *error;
    BOOL result = [[QKCLRequestManager sharedManager] syncGET:[NSString stringFromConst:qkUrlMasterItemJobTypeL] parameters:params response:&response error:&error showLoading:YES showError:YES];
    if (result) {
        for (NSDictionary *item in response[@"ItemJobTypeLMaster"]) {
            QKCLShopFreeItemModel *model = [[QKCLShopFreeItemModel alloc]init];
            model.freeItemJobTypeLCd = _shopInfo.jobTypeLCd;
            model.freeItemJobTypeLNo = item[@"itemNo"];
            model.freeItemJobTypeLName = item[@"itemName"];
            [_shopInfo.freeItemList addObject:model];
        }
    }
}

#pragma mark - UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2 + _shopInfo.freeItemList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    else {
        return 1;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return NSLocalizedString(@"業種・業態", nil);
    }
    else if (section == 1 + _shopInfo.freeItemList.count) {
        return NSLocalizedString(@"アクセス情報", nil);
    }
    else {
        QKCLShopFreeItemModel *model = [_shopInfo.freeItemList objectAtIndex:section - 1];
        return model.freeItemJobTypeLName;
    }
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = (QKTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"jobTypeCell"];
        if (!cell) {
            cell = [[QKTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"jobTypeCell"];
        }
        switch (indexPath.row) {
            case 0: {
                cell.textLabel.text = @"業種";
                cell.detailTextLabel.text = _shopInfo.jobTypeLName;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                break;
            }
                
            case 1: {
                cell.textLabel.text = @"業態";
                cell.detailTextLabel.text = _shopInfo.jobTypeMName;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                break;
            }
        }
    }
    else if (indexPath.section == 1 + _shopInfo.freeItemList.count) {
        QKTextViewTableViewCell *accessCell = (QKTextViewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:TextViewIdentifier];
        if (accessCell == nil) {
            accessCell = [[QKTextViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TextViewIdentifier];
        }
        
        accessCell.delegate = self;
        [accessCell setMaxLength:200];
        accessCell.textView.tag = indexPath.section;
        [accessCell setText:_shopInfo.accessWay];
        cell = accessCell;
    }
    else {
        QKCLShopFreeItemModel *model = [_shopInfo.freeItemList objectAtIndex:indexPath.section - 1];
        
        QKTextViewTableViewCell *desCell  = (QKTextViewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:TextViewIdentifier forIndexPath:indexPath];
        if (desCell == nil) {
            desCell = [[QKTextViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TextViewIdentifier];
        }
        desCell.delegate = self;
        [desCell setMaxLength:200];
        desCell.textView.tag = indexPath.section;
        [desCell setText:model.freeItemJobTypeLValue];
        cell = desCell;
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 44;
            
        default:
            return 170;
    }
    return 44;
}

#pragma mark - UITextViewDelegate
- (void)editingChanged:(UITextView *)textView {
    if (textView.tag == 1 + _shopInfo.freeItemList.count) {
        _shopInfo.accessWay = textView.text;
    }
    else {
        QKCLShopFreeItemModel *model = [_shopInfo.freeItemList objectAtIndex:textView.tag - 1];
        model.freeItemJobTypeLValue = textView.text;
    }
    [self checkEnableButton];
}

- (void)checkEnableButton {
    BOOL enabled = YES;
    if (_shopInfo.accessWay == nil || [_shopInfo.accessWay isEqualToString:@""]) {
        enabled = NO;
    }
    for (QKCLShopFreeItemModel *item in _shopInfo.freeItemList) {
        if (item.freeItemJobTypeLValue == nil || [item.freeItemJobTypeLValue isEqualToString:@""]) {
            enabled = NO;
            break;
        }
    }
    
    [_saveButton setEnabled:enabled];
}

#pragma  mark - Actions

- (IBAction)saveButtonClicked:(id)sender {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:[QKCLAccessUserDefaults getActiveShopId] forKey:@"shopId"];
        
        [params setObject:[self getJsonFromFreeItemList] forKey:@"json"];
        [params setObject:_shopInfo.accessWay forKey:@"accessWay"];
        
        [[QKCLRequestManager sharedManager] asyncPOST:[NSString stringFromConst:qkUrlShopUpdate] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Update shop info success...");
            if ([responseObject[@"statusCd"] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                [self performSegueWithIdentifier:@"QKAddPhotoShopSegue" sender:self];
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Update shop info error...");
        }];
    }
    else {
        [self showNoInternetViewWithSelector:nil];
    }
}

#pragma mark - getJson

- (NSString *)getJsonFromFreeItemList {
    NSMutableArray *array = [NSMutableArray new];
    for (QKCLShopFreeItemModel *item in _shopInfo.freeItemList) {
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"QKAddPhotoShopSegue"]) {
        QKCLShopInputPhotoViewController *inputPhotoViewController = (QKCLShopInputPhotoViewController *)segue.destinationViewController;
        inputPhotoViewController.accessWay = _shopInfo.accessWay;
        inputPhotoViewController.json = [self getJsonFromFreeItemList];
    }
}

@end
