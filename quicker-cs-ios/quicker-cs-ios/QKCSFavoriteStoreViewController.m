//
//  QKCSFavoriteStoreViewController.m
//  quicker-cs-ios
//
//  Created by C Anh on 8/12/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCSFavoriteStoreViewController.h"
#import "QKCSFavoriteCell.h"
#import "QKShopInfoModel.h"
#import "QKRecruitmentModel.h"
@interface QKCSFavoriteStoreViewController ()
@property (strong, nonatomic) NSMutableArray *listFavoriteShop;
@property (nonatomic) NSInteger selectedCell;
@end

@implementation QKCSFavoriteStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAngleLeftBarButton];
    self.navigationItem.title =NSLocalizedString(@"お気に入り店舗", nil);
    [self loadFavoriteShop];
    [self setRightBarButtonWithTitle:@"編集" target:@selector(editTableView)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    self.nothingView.hidden = YES;
    [super viewWillAppear:YES];
}
- (void) loadFavoriteShop {
    if ([self connected]) {
        // Call API
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKAccessUserDefaults getUserId] forKey:@"userId"];
        
        [[QKRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkCSUrlRecruitmentList] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            
            self.listFavoriteShop = [[NSMutableArray alloc] init];
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                for (NSDictionary *shopList in responseObject[@"recruitmentList"]) {
                    QKRecruitmentModel *shopModel = [[QKRecruitmentModel alloc] initWithResponse:shopList];
                    
                    [self.listFavoriteShop addObject:shopModel];
                }
            }
            if (self.listFavoriteShop.count == 0) {
                self.tableView.hidden = YES;
                self.nothingView.hidden = NO;
                self.navigationItem.rightBarButtonItem = nil;
            }
            else {
                self.tableView.hidden = NO;
                self.nothingView.hidden = YES;
            }
            
            [self.tableView reloadData];
            
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
    else {
        [self showNoInternetViewWithSelector:@selector(loadFavoriteShop)];
    }
}
#pragma mark - UITableViewDatasource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 76.0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.listFavoriteShop.count;
    //    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QKCSFavoriteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QKCSFavoriteCell"];
    cell.shopModel =  [self.listFavoriteShop objectAtIndex:indexPath.row];
    
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        /* Delete Favorite shop
         Call API CS_FAV_0003
         */
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKAccessUserDefaults getUserId] forKey:@"userId"];
        QKShopInfoModel *model = [self.listFavoriteShop objectAtIndex:indexPath.row];
        [params setObject:model.shopId forKey:@"shopId"];
        
        [[QKRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkCSUrlDeleteFromFavoriteList] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                [self.listFavoriteShop removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                [self endEdit];
                [self.tableView reloadData];
            }
            
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    } else {
        [self showNoInternetViewWithSelector:@selector(loadFavoriteShop)];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Did select
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (void)editTableView {
    [self setRightBarButtonWithTitle:@"キャンセル" target:@selector(endEdit)];
    [self.tableView setEditing:YES animated:YES];
}
- (void)endEdit {
    [self setRightBarButtonWithTitle:@"編集" target:@selector(editTableView)];
    [self.tableView setEditing:NO animated:YES];
}
@end
