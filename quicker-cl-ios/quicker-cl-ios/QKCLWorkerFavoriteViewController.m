//
//  QKCLWorkerFavoriteViewController.m
//  quicker-cl-ios
//
//  Created by Quy on 7/31/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLWorkerFavoriteViewController.h"
#import "QKCLApplicantTableViewCell.h"
#import "QKCLWorkerFavoriteModel.h"
@interface QKCLWorkerFavoriteViewController ()
@property (nonatomic, strong) NSMutableArray *workerFavoriteArray;
@end
static NSString *applicantCell = @"QKCLApplicantTableViewCell";
@implementation QKCLWorkerFavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setAngleLeftBarButton];
    [self setTitle:@"お気に入り勤務者"];
    [self.thisTableView registerNib:[UINib nibWithNibName:applicantCell bundle:[NSBundle mainBundle]] forCellReuseIdentifier:applicantCell];
    
    self.thisView.layer.contents = (id)[UIImage imageNamed:@"account_bgi_fav.png"].CGImage;
    [self.thisView setHidden:YES];
    self.workerFavoriteArray = [[NSMutableArray alloc] init];
    //[self getFavoriteWorkerList];
    
    //This for test
    QKCLWorkerFavoriteModel *model1 = [[QKCLWorkerFavoriteModel alloc] init];
    model1.firstName = @"小林";
    model1.lastName = @"宗太";
    NSString *birthday = @"2000-01-01";
    model1.birthday = [self dateForKey:birthday format:@"yyy-MM-dd"];
    
    [self.workerFavoriteArray addObject:model1];
    QKCLWorkerFavoriteModel *model2 = [[QKCLWorkerFavoriteModel alloc] init];
    model2.firstName = @"小林";
    model2.lastName = @"宗太";
    NSString *birthday2 = @"2001-01-01";
    model2.birthday = [self dateForKey:birthday2 format:@"yyy-MM-dd"];
    [self.workerFavoriteArray addObject:model2];
    QKCLWorkerFavoriteModel *model4 = [[QKCLWorkerFavoriteModel alloc] init];
    [self.workerFavoriteArray addObject:model4];
    
    QKCLWorkerFavoriteModel *model3 = [[QKCLWorkerFavoriteModel alloc] init];
    model3.firstName = @"小林";
    model3.lastName = @"宗太";
    NSString *birthday3 = @"2002-01-01";
    model3.birthday = [self dateForKey:birthday3 format:@"yyy-MM-dd"];
    [self.workerFavoriteArray addObject:model3];
    //[self refreshView];
}

- (NSDate *)dateForKey:(NSString *)key format:(NSString *)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat = format;
    
    return [dateFormatter dateFromString:key];
    //    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    dateFormatter.dateFormat = @"MM/dd/yyyy hh:mm:ss a Z";
    //    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    //    // see https://developer.apple.com/library/ios/qa/qa1480/_index.html
    //
    //
    //    NSDate *date = [dateFormatter dateFromString:dateString];
}

- (void)refreshView {
    if (_workerFavoriteArray.count == 0) {
        [self.thisTableView setHidden:NO];
        [self.thisView setHidden:YES];
    }
    else {
        [self.thisTableView setHidden:YES];
        [self.thisView setHidden:NO];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.workerFavoriteArray count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    QKCLApplicantTableViewCell *cells = (QKCLApplicantTableViewCell *)[tableView dequeueReusableCellWithIdentifier:applicantCell];
    if (cells == nil) {
        cells = [[QKCLApplicantTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:applicantCell];
    }
    
    QKCLWorkerFavoriteModel *model = [self.workerFavoriteArray objectAtIndex:indexPath.row];
    if (model.imagePath != nil) {
        [cells.avartarImageView setImageWithURL:model.imagePath];
    }
    [cells.ratingWorkerIcon setImage:[UIImage imageNamed:@"list_ic_rightfav"]];
    cells.workerName.text = [NSString stringWithFormat:@"%@  %@", model.firstName, model.lastName];
    [cells.avartarImageView setImage:[UIImage imageNamed:@"camera_pic_hint_face"]];
    NSString *age;
    if (model.birthday != nil) {
        age = [model.birthday convertToAge];
    }
    
    
    cells.workerAge.text = [NSString stringWithFormat:@"(%@歳・男性)", age];
    //this for test
    if (indexPath.row == 2) {
        [cells.workerName setHidden:YES];
        [cells.workerAge setHidden:YES];
        [cells.hiddenWorkerLabel setHidden:NO];
        [cells.avartarImageView setImage:[UIImage imageNamed:@"account_pic_blankprofile"]];
        [cells.ratingWorkerIcon setImage:nil];
    }
    cell = cells;
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)getFavoriteWorkerList {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:[QKCLAccessUserDefaults getActiveShopId] forKey:@"shopId"];
        [[QKCLRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkClUrlWorkerFavoriteList] parameters:params showLoading:YES showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                for (NSDictionary *dic in responseObject[@"favoriteList"]) {
                    QKCLWorkerFavoriteModel *model = [[QKCLWorkerFavoriteModel alloc]initWithResponse:dic];
                    [self.workerFavoriteArray addObject:model];
                }
                [self refreshView];
                [self.thisTableView reloadData];
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error... %@", error);
        }];
    }
    else {
        [self showNoInternetViewWithSelector:@selector(getFavoriteWorkerList)];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
