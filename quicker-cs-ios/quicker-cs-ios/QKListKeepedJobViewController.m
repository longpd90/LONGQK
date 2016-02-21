//
//  QKListKeepedJobViewController.m
//  quicker-cs-ios
//
//  Created by Nguyen Huu Anh on 7/13/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKListKeepedJobViewController.h"
#import "QKRecruitmentModel.h"
#import "QKKeepedJobCell.h"
#import "QKRecruitmentListViewController.h"
#import "QKRecruitmentDetailViewController.h"

@interface QKListKeepedJobViewController () <UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *listKeepedJob;
@property (nonatomic) NSInteger selectedCell;
@end

@implementation QKListKeepedJobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadListKeepedJob];
     self.navigationItem.title =NSLocalizedString(@"キープ中のバイト", nil);
    [self setLeftBarButtonWithImage:[UIImage imageNamed:@"common_btn_close_01"] hightlight:nil title:nil target:@selector(closeVC)];
    [self setRightBarButtonWithTitle:@"編集" target:@selector(editTableView)];
    // Do any additional setup after loading the view.
}

- (void)loadListKeepedJob {
    if ([self connected]) {
        
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKAccessUserDefaults getUserId] forKey:@"userId"];
        
        
        [[QKRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkCSUrlKeepList] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            self.listKeepedJob = [[NSMutableArray alloc] init];
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                for (NSDictionary *recruitment in responseObject[@"recruitmentList"]) {
                    QKRecruitmentModel *recModel = [[QKRecruitmentModel alloc] initWithResponse:recruitment];
                    [self.listKeepedJob addObject:recModel];
                }
                [self reloadData];
            }
            
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    } else {
        [self showNoInternetViewWithSelector:@selector(loadListKeepedJob)];
    }
}

- (void)reloadData {
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDatasourse

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.listKeepedJob.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QKKeepedJobCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QKKeepedCell"];
    cell.recModel = [self.listKeepedJob objectAtIndex:indexPath.row];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        if ([self connected]) {
            
            NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
            [params setObject:[QKAccessUserDefaults getUserId] forKey:@"userId"];
            QKRecruitmentModel *model = [self.listKeepedJob objectAtIndex:indexPath.row];
            [params setObject:model.recruitmentId forKey:@"recruitmentId"];
            
            [[QKRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkCSUrlKeepDelete] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
                if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
			                 [self.listKeepedJob removeObjectAtIndex:indexPath.row];
			                 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
			                 [self endEdit];
                }
                
            } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"Error: %@", error);
            }];
        } else {
            [self showNoInternetViewWithSelector:@selector(loadListKeepedJob)];
        }
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedCell = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"QKShowRecDetail" sender:self];
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


-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return NSLocalizedString(@"削除", nil);
}

- (void)closeVC {
    NSArray *allViewControllers = self.navigationController.viewControllers;
    for (UIViewController *vc in allViewControllers) {
        if ([vc isKindOfClass:[QKRecruitmentListViewController class]]) {
            [self.navigationController popToViewController:vc animated:YES];
        }
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"QKShowRecDetail"]) {
        QKRecruitmentDetailViewController *detailVC = (QKRecruitmentDetailViewController *)[segue destinationViewController];
        detailVC.recruitment = [self.listKeepedJob objectAtIndex:self.selectedCell];
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
