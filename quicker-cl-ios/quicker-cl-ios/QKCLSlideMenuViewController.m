//
//  QKSlideMenuViewController.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 5/21/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLSlideMenuViewController.h"
#import "SWRevealViewController.h"
#import "QKCLShopInfoModel.h"
#import "chiase-ios-core/NSDictionary+ParseResult.h"
#import "QKSlideMenuCell.h"
#import "QKCLImageModel.h"
#import "QKCLAddNewShopViewController.h"
#import "QKCLMyPageViewController.h"
#import "QKCLMainMenuViewController.h"
#import "QKCLRegisterShopInfoViewController.h"
#import "QKCLStopViewController.h"
#import "QKCLCloseViewController.h"
#import "QKCLShopEnterInfoViewController.h"
#import "QKCLAddNewShopViewController.h"
#import "QKCLShopExaminatingViewController.h"

@interface QKCLSlideMenuViewController () <CCAlertViewDelegate>
@property BOOL isEditting;
@property (weak, nonatomic) IBOutlet UIView *navigationView;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navigationContain;
@property (weak, nonatomic) IBOutlet UIButton *addNewShopButton;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@property (strong, nonatomic) CCAlertView *enterPassAlv;
@property (strong, nonatomic) CCAlertView *wrongPassAlert;
@property (strong, nonatomic) CCAlertView *confirmAlv;
@property (strong, nonatomic) CCAlertView *deleteDoneAlv;
@property (nonatomic) NSIndexPath *indexShopDelete;
@property (nonatomic) int numItemPerPage;
@property (nonatomic) NSInteger totalNum;
@property (strong, nonatomic) NSString *autoroadCd;
@property (strong, nonatomic) NSMutableArray *deleteShopArray;
@property (strong, nonatomic) NSString *passWord;
@end

@implementation QKCLSlideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.numItemPerPage = 10;
    self.listShops = [[NSMutableArray alloc] init];
    [self initRefreshControl];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadDatas];
    [self checkEdittingTable];
}

- (void)initRefreshControl {
    float witdh = [UIApplication sharedApplication].keyWindow.frame.size.width;
    UIView *refreshView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.menuTableView insertSubview:refreshView atIndex:0]; //the tableView is a IBOutlet
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.tintColor = [UIColor clearColor];
    [self.refreshControl addTarget:self action:@selector(reloadDatas) forControlEvents:UIControlEventValueChanged];
    [refreshView addSubview:self.refreshControl];
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.center = CGPointMake((witdh) / 2, 25.0);
    [self.refreshControl addSubview:indicator];
    [indicator startAnimating];
}

- (void)reloadDatas {
    self.totalNum = 0;
    self.autoroadCd = @"";
    [self.listShops removeAllObjects];
    [self getAllShop];
}

- (void)loadMoreDatas {
    if (self.totalNum > self.listShops.count) {
        [self getAllShop];
    }
}

- (void)getAllShop {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        
        [params setObject:[NSNumber numberWithInt:self.numItemPerPage] forKey:@"limit"];
        if (self.autoroadCd != nil) {
            [params setObject:self.autoroadCd forKey:@"autoroadCd"];
        }
        [[QKCLRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkUrlShopList] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                NSArray *listShop = [responseObject objectForKey:@"shopList"];
                for (NSDictionary *shopInfoDic in listShop) {
                    QKCLShopInfoModel *shopModel = [[QKCLShopInfoModel alloc] initWithResponse:shopInfoDic];
                    
                    [self.listShops addObject:shopModel];
                }
                
                self.totalNum = [responseObject intForKey:@"totalNum"];
                self.autoroadCd = [responseObject stringForKey:@"autoroadCd"];
                
                [self.menuTableView reloadData];
            }
            [self.refreshControl endRefreshing];
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            [self.refreshControl endRefreshing];
            NSLog(@"Error: %@", error);
        }];
    }
    else {
        [self showNoInternetViewWithSelector:@selector(getAllShop)];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (self.listShops.count < self.totalNum) {
        return [self.listShops count] + 1;
    }
    else
        return [self.listShops count];
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView numberOfRowsInSection:0] == self.listShops.count) {
        QKSlideMenuCell *cell = (QKSlideMenuCell *)[tableView dequeueReusableCellWithIdentifier:@"QKMenuCell"];
        QKCLShopInfoModel *shopInfoModel = (QKCLShopInfoModel *)[self.listShops objectAtIndex:indexPath.row];
        if (![shopInfoModel.shopStatus isEqualToString:[NSString stringFromConst:QK_SHOP_STATUS_EXAM_DEL]] && ![shopInfoModel.shopStatus isEqualToString:[NSString stringFromConst:QK_SHOP_STATUS_EXAM_NG_OTHER]] && ![shopInfoModel.shopStatus isEqualToString:[NSString stringFromConst:QK_SHOP_STATUS_EXAM_NG]]) {
            [cell setupInterfaceWithData:shopInfoModel];
        }
        
        return cell;
    }
    else if (indexPath.row < self.listShops.count) {
        QKSlideMenuCell *cell = (QKSlideMenuCell *)[tableView dequeueReusableCellWithIdentifier:@"QKMenuCell"];
        QKCLShopInfoModel *shopInfoModel = (QKCLShopInfoModel *)[self.listShops objectAtIndex:indexPath.row];
        if (![shopInfoModel.shopStatus isEqualToString:[NSString stringFromConst:QK_SHOP_STATUS_EXAM_DEL]] && ![shopInfoModel.shopStatus isEqualToString:[NSString stringFromConst:QK_SHOP_STATUS_EXAM_NG_OTHER]] && ![shopInfoModel.shopStatus isEqualToString:[NSString stringFromConst:QK_SHOP_STATUS_EXAM_NG]]) {
            [cell setupInterfaceWithData:shopInfoModel];
        }
        
        return cell;
    }
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QKLoadMoreCell"];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self checkCellCanEdittingWithIndexpath:indexPath];
        self.indexShopDelete = indexPath;
        self.enterPassAlv = [[CCAlertView alloc] initWithTitle:@"パスワードの確認" message:@"店舗の削除にはパスワードが必要です" delegate:self buttonTitles:@[@"キャンセル", @"OK"] haveTextField:YES];
        [self.enterPassAlv showAlert];
    }
}

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    return [self checkCellCanEdittingWithIndexpath:indexPath];
//}

//- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    // rows in section 0 should not be selectable
//    if ([self checkCellCanEdittingWithIndexpath:indexPath]) {
//        return indexPath;
//    }
//     return nil;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QKCLShopInfoModel *model = (QKCLShopInfoModel *)[self.listShops objectAtIndex:indexPath.row];
    [QKCLAccessUserDefaults setActiveShopId:model.shopId];
    [QKCLAccessUserDefaults setActiveShopName:model.name];
    [QKCLAccessUserDefaults setJobTypeLCd:model.jobTypeLCd];
    [QKCLAccessUserDefaults setJobTypeMCd:model.jobTypeMCd];
    
    [self checkStatusShop:model];
    //[tableView reloadData];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger lastRowIndex = [tableView numberOfRowsInSection:0];
    if (indexPath.row == lastRowIndex - 1) {
        [self loadMoreDatas];
    }
}

- (IBAction)editting:(id)sender {
    [self.view layoutIfNeeded];
    
    [self checkEdittingTable];
}

- (void)checkEdittingTable {
    SWRevealViewController *revealController = self.revealViewController;
    [self.menuTableView setEditing:self.isEditting animated:YES];
    if (self.isEditting) {
        [self.editButton setTitle:@"キャンセル" forState:UIControlStateNormal];
        self.addNewShopButton.hidden = YES;
        [revealController setFrontViewPosition:FrontViewPositionRightMost animated:YES];
        self.navigationContain.constant = 8.0;
    }
    else {
        [self.editButton setTitle:@"編集" forState:UIControlStateNormal];
        self.addNewShopButton.hidden = NO;
        [revealController setFrontViewPosition:FrontViewPositionRight animated:YES];
        self.navigationContain.constant = 53.0;
    }
    [UIView animateWithDuration:0.3
                     animations: ^{
                         [self.view layoutIfNeeded];
                     }];
    self.isEditting = !self.isEditting;
}

- (IBAction)addNewShop:(id)sender {
    [self performSegueWithIdentifier:@"QKAddNewShopSegue" sender:self];
}

- (void)deleteShopCheckPass {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:[QKCLEncryptUtil encyptBlowfish:self.passWord] forKey:@"password"];
        [[QKCLRequestManager sharedManager] POST:[NSString stringFromConst:qkUrlClAccountPasswordReauth] parameters:params success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                NSString *stringLineBreak = [NSString stringWithFormat:@"%@\n%@\n%@", @"削除すると、店舗情報、勤務履歴、", @"請求情報、登録クレジットカード情報などの", @"全ての情報が削除されます。"];
                self.confirmAlv = [[CCAlertView alloc] initWithTitle:@"店舗を削除しますか？" message:stringLineBreak delegate:self buttonTitles:@[@"しない", @"削除する"]];
                [self.confirmAlv showAlert];
            }
            else {
                self.wrongPassAlert = [[CCAlertView alloc]initWithTitle:@"パスワードが一致しません" message:@"再度入力をしてください" delegate:self buttonTitles:@[@"キャンセル", @"OK"] haveTextField:YES];
                [self.wrongPassAlert showAlert];
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:[NSString stringWithFormat:@"%@", error] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
            
            NSLog(@"error...%@", error);
        }];
    }
    else {
        [self showNoInternetViewWithSelector:nil];
    }
}

#pragma mark - CCAlertViewDelegate

- (void)alertView:(CCAlertView *)alertView selectedButtonIndex:(NSInteger)index {
    if (alertView == self.enterPassAlv) {
        if (index == 1) {
            self.passWord = alertView.textField.text;
            [self deleteShopCheckPass];
        }
    }
    if (alertView == self.wrongPassAlert) {
        if (index == 1) {
            self.passWord = alertView.textField.text;
            [self deleteShopCheckPass];
        }
    }
    if (alertView == self.confirmAlv) {
        if (index == 1) {
            if ([self connected]) {
                QKCLShopInfoModel *shopModel = (QKCLShopInfoModel *)[self.listShops objectAtIndex:self.indexShopDelete.row];
                NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
                [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
                [params setObject:shopModel.shopId forKey:@"shopId"];
                [params setObject:[QKCLEncryptUtil encyptBlowfish:self.enterPassAlv.textField.text] forKey:@"password"];
                [[QKCLRequestManager sharedManager] asyncPOST:[NSString stringFromConst:qkUrlShopDelete] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
                    if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                        [self.listShops removeObjectAtIndex:self.indexShopDelete.row];
                        
                        self.totalNum--;
                        [self.menuTableView deleteRowsAtIndexPaths:@[self.indexShopDelete] withRowAnimation:UITableViewRowAnimationFade];
                        
                        self.deleteShopModel = [[QKCLShopInfoModel alloc]initWithResponse:responseObject[@"activeShop"]];
                        
                        
                        _deleteDoneAlv = [[CCAlertView alloc]initWithImage:[UIImage imageNamed:@"dialog_pic_done"] title:@"店舗を削除しました" andMessage:@"管理する別の店舗へ自動的に移動します" style:QKAlertViewStyleWhite];
                        [_deleteDoneAlv showAlert];
                    }
                } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"Error: %@", error);
                }];
            }
            else {
                [self showNoInternetViewWithSelector:nil];
            }
        }
    }
}

- (void)checkShopToMove {
    if ([self.deleteShopModel.shopStatus isEqualToString:[NSString stringFromConst:QK_SHOP_STATUS_EXAMINATING]]) {
        //move to D-7-1 screen
        [self transitionToShopExaming];
    }
    else if (self.deleteShopModel == (id)[NSNull null]) {
        [self performSegueWithIdentifier:@"QKAddNewShopSegue" sender:self];
    }
    else {
        [self.menuTableView reloadData];
    }
}

- (void)clickOnAlertView:(CCAlertView *)alertView {
    if (alertView == self.deleteDoneAlv) {
        [self checkShopToMove];
    }
}

#pragma mark -Action Transition
- (void)transitionToShopExaming {
    QKCLShopExaminatingViewController *vc = (QKCLShopExaminatingViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"QKRegistShopExaminationViewController"];
    [self.revealViewController pushFrontViewController:vc
                                              animated:YES];
}

- (void)transitionToShopExamNG {
    [self performSegueWithIdentifier:@"QKAddNewShopSegue" sender:self];
}

- (void)transitionToShopExamOK {
    [self performSegueWithIdentifier:@"QKAddNewShopSegue" sender:self];
    
    //    [self.revealViewController pushFrontViewController:vc animated:YES];
}

- (void)transitionToShopPublic {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"QKChangeShopNotification" object:nil];
    [self.revealViewController revealToggleAnimated:YES];
}

- (void)opimize:(NSString *)identifi vc:(id)vc {
}

- (void)transitionToShopDisable {
    QKCLStopViewController *vc = (QKCLStopViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"QKCLStopViewController"];
    
    vc.state = 1;
    [self.revealViewController pushFrontViewController:vc animated:YES];
}

- (void)transitionToShopClosed {
    QKCLCloseViewController *vc = (QKCLCloseViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"QKCLCloseViewController"];
    vc.state = 1;
    [self.revealViewController pushFrontViewController:vc
                                              animated:YES];
}

- (void)checkStatusShop:(QKCLShopInfoModel *)model {
    if ([model.shopStatus isEqualToString:[NSString stringFromConst:QK_SHOP_STATUS_EXAM_NG]]) {
        [self transitionToShopExamNG];
    }
    if ([model.shopStatus isEqualToString:[NSString stringFromConst:QK_SHOP_STATUS_EXAM_OK]]) {
        [self transitionToShopExamOK];
    }
    if ([model.shopStatus isEqualToString:[NSString stringFromConst:QK_SHOP_STATUS_PUBLIC]]) {
        [self transitionToShopPublic];
    }
    if ([model.shopStatus isEqualToString:[NSString stringFromConst:QK_SHOP_STATUS_DISABLED]]) {
        [self transitionToShopDisable];
    }
    if ([model.shopStatus isEqualToString:[NSString stringFromConst:QK_SHOP_STATUS_CLOSED]]) {
        [self transitionToShopClosed];
    }
}

#pragma mark - Extra function

- (BOOL)checkCellCanEdittingWithIndexpath:(NSIndexPath *)index {
    @try {
        if (self.listShops.count >index.row) {
            QKCLShopInfoModel *shopInfoModel = (QKCLShopInfoModel *)[self.listShops objectAtIndex:index.row];
            if ([shopInfoModel.shopId isEqualToString:[QKCLAccessUserDefaults getActiveShopId]]) {
                return YES;
            }
            if ([shopInfoModel.shopStatus isEqualToString:[NSString stringFromConst:QK_SHOP_STATUS_EXAMINATING]]) {
                if ([self.menuTableView isEditing]) {
                    return YES;
                }
                return NO;
            }
            if ([shopInfoModel.shopStatus isEqualToString:[NSString stringFromConst:QK_SHOP_STATUS_EXAM_NG]]) {
                return YES;
            }
            if ([shopInfoModel.shopStatus isEqualToString:[NSString stringFromConst:QK_SHOP_STATUS_DELETED]]) {
                return YES;
            }
            if ([shopInfoModel.shopStatus isEqualToString:[NSString stringFromConst:QK_SHOP_STATUS_DISABLED]]) {
                return NO;
            }
             return YES;
        }else{
            return NO;
        }
       
    }
    @catch (NSException *ex)
    {
        return NO;
    }
}

#pragma mark -Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"QKAddNewShopSegue"]) {
        UINavigationController *nav = [segue destinationViewController];
        QKCLAddNewShopViewController *registShopViewController = (QKCLAddNewShopViewController *)[nav.viewControllers firstObject];
        if ([_listShops count]  == 0) {
            registShopViewController.isPresented = NO;
        }
        else {
            registShopViewController.isPresented = YES;
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [self setIsEditting:NO];
    [self.menuTableView reloadData];
}

@end
