//
//  QKCheckStoreInfoViewController.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 4/16/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLShopShowInfoViewController.h"
#import "QKCLAccessUserDefaults.h"
#import "QKCLShopEditInfoViewController.h"
#import "QKImageView.h"
#import "QKCLShopFreeItemModel.h"
#import "QKCLShowShopImageTableViewCell.h"
#import "QKTableViewCell.h"
#import "QKTextViewTableViewCell.h"
#import "QKCLPhoneNumTableViewCell.h"

@interface QKCLShopShowInfoViewController ()

@property (weak, nonatomic) IBOutlet UITableView *thisTableview;
@property (strong, nonatomic) QKCLShopInfoModel *shopInfo;

@end

static NSString *QKCLTextViewCellIdentifier =@"QKTextViewTableViewCell";

@implementation QKCLShopShowInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //審査情報の確認
    [self setAngleLeftBarButton];
    [self setRightBarButtonWithTitle:NSLocalizedString(@"編集", nil) target:@selector(editShopInfo)];
    
    [self.thisTableview registerNib:[UINib nibWithNibName:QKCLTextViewCellIdentifier bundle:nil] forCellReuseIdentifier:QKCLTextViewCellIdentifier];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    //contructor
    [self getShopInfomation];
}

- (void)getShopInfomation {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:[QKCLAccessUserDefaults getActiveShopId] forKey:@"shopId"];
        
        
        [[QKCLRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkUrlShopDetail] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                _shopInfo = [[QKCLShopInfoModel alloc]initWithResponse:responseObject];
                [self.thisTableview reloadData];
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
    else {
        [self showNoInternetViewWithSelector:@selector(getShopInfomation)];
    }
}

#pragma mark - UITableViewDatasource
- (void)editShopInfo {
    [self performSegueWithIdentifier:@"QKEditShopInfo" sender:self];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4 + _shopInfo.freeItemList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2 + _shopInfo.freeItemList.count || section == 1 + _shopInfo.freeItemList.count) {
        return 2;
    }
    else{
        return 1;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 0.001f;
    }
    return 44;
}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 0.01f;
//}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"";
    }else if (section == 1 + _shopInfo.freeItemList.count) {
        return NSLocalizedString(@"業種・業態", nil);
    }else if (section == 2 + _shopInfo.freeItemList.count) {
        return NSLocalizedString(@"連絡先・住所", nil);
    }else if (section == 3 + _shopInfo.freeItemList.count) {
        return NSLocalizedString(@"アクセス情報", nil);
    }else{
        QKCLShopFreeItemModel *item = [_shopInfo.freeItemList objectAtIndex:section -1];
        return item.freeItemJobTypeLName;
    }
    
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        QKCLShowShopImageTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"PhotoShopCell"];
        if (!cell1) {
            cell1 = [[QKCLShowShopImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PhotoShopCell"];
        }
        cell1.shopNameLabel.text =[QKCLAccessUserDefaults getActiveShopName];
        
        if (_shopInfo.imageFileList.count > 0) {
            QKCLImageModel *mainModel = [_shopInfo.imageFileList objectAtIndex:0];
            [cell1.mainImageView setImageWithQKURL:mainModel.imageUrl withCache:YES];
        }
        if (_shopInfo.imageFileList.count > 1) {
            QKCLImageModel *leftModel = [_shopInfo.imageFileList objectAtIndex:1];
            [cell1.leftSubImageView setImageWithQKURL:leftModel.imageUrl withCache:YES];
        }
        if (_shopInfo.imageFileList.count > 2) {
            QKCLImageModel *rightModel = [_shopInfo.imageFileList objectAtIndex:2];
            [cell1.rightSubImageView setImageWithQKURL:rightModel.imageUrl withCache:YES];
        }
        cell =cell1;
    }else if(indexPath.section == 1 +_shopInfo.freeItemList.count) {
        QKTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"JobTypeShopCell"];
        if (!cell2) {
            cell2 =[[QKTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"JobTypeShopCell"];
        }
        switch (indexPath.row) {
            case 0:
                cell2.textLabel.text = NSLocalizedString(@"業種", nil);
                cell2.detailTextLabel.text = _shopInfo.jobTypeLName;
                
                break;
                
            case 1:
                cell2.textLabel.text =  NSLocalizedString(@"業態", nil);
                cell2.detailTextLabel.text = _shopInfo.jobTypeMName;
                
            default:
                break;
        }
        cell =cell2;
    }else if(indexPath.section == 2 +_shopInfo.freeItemList.count) {
        switch (indexPath.row) {
            case 0: {
                QKCLPhoneNumTableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:@"phoneCell"];
                if (!cell3) {
                    cell3 =[[QKCLPhoneNumTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"phoneCell"];
                }
                cell3.phoneImageView.image = [UIImage imageNamed:@"list_ic_tel"];
                cell3.phoneNumLabel.text = _shopInfo.phoneNum;
                cell = cell3;
                break;
            }
            case 1: {
                QKTextViewTableViewCell *cell4 = [tableView dequeueReusableCellWithIdentifier:QKCLTextViewCellIdentifier];
                [cell4 setText:_shopInfo.getFullAddressString];
                [cell4 setEditable:NO];
                [cell4.textView setScrollEnabled:NO];
                cell = cell4;
                break;
            }
        }
        
    }else if(indexPath.section == 3 +_shopInfo.freeItemList.count) {
        QKTextViewTableViewCell *cell5 = [tableView dequeueReusableCellWithIdentifier:QKCLTextViewCellIdentifier];
        [cell5 setText:_shopInfo.accessWay];
        [cell5 setEditable:NO];
        [cell5.textView setScrollEnabled:NO];
        cell = cell5;
    }else{
        QKCLShopFreeItemModel *item = [_shopInfo.freeItemList objectAtIndex:indexPath.section - 1];
        QKTextViewTableViewCell *cell6 = [tableView dequeueReusableCellWithIdentifier:QKCLTextViewCellIdentifier];
        [cell6 setText:item.freeItemJobTypeLValue];
        [cell6 setEditable:NO];
        [cell6.textView setScrollEnabled:NO];
        cell = cell6;
    }
    
    if (cell == nil) {
        cell = [UITableViewCell new];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        QKCLShowShopImageTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"PhotoShopCell"];
        if (!cell1) {
            cell1 = [[QKCLShowShopImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PhotoShopCell"];
        }
        cell1.shopNameLabel.text =[QKCLAccessUserDefaults getActiveShopName];
        return [cell1 getCellHeight];
        
    }else if(indexPath.section == 1 +_shopInfo.freeItemList.count) {
        return 44;
    }else if(indexPath.section == 2 +_shopInfo.freeItemList.count) {
        switch (indexPath.row) {
            case 0: {
                return 44;
            }
            case 1: {
                QKTextViewTableViewCell *cell4 = [tableView dequeueReusableCellWithIdentifier:QKCLTextViewCellIdentifier];
                [cell4 setText:_shopInfo.getFullAddressString];
                [cell4 setEditable:NO];
                return [cell4 getCellHeight];
            }
        }
        
    }else if(indexPath.section == 3 +_shopInfo.freeItemList.count) {
        QKTextViewTableViewCell *cell5 = [tableView dequeueReusableCellWithIdentifier:QKCLTextViewCellIdentifier];
        [cell5 setText:_shopInfo.accessWay];
        [cell5 setEditable:NO];
        return [cell5 getCellHeight];
    }else{
        QKCLShopFreeItemModel *item = [_shopInfo.freeItemList objectAtIndex:indexPath.section - 1];
        QKTextViewTableViewCell *cell6 = [tableView dequeueReusableCellWithIdentifier:QKCLTextViewCellIdentifier];
        [cell6 setText:item.freeItemJobTypeLValue];
        [cell6 setEditable:NO];
        
        return [cell6 getCellHeight];
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    //VietND:we need to override it.
}

@end
