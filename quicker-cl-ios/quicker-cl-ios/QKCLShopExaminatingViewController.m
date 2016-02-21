//
//  QKAddShopExaminationViewController.m
//  quicker-cl-ios
//
//  Created by Viet on 5/6/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLShopExaminatingViewController.h"
#import "QKCLShopExaminationDoneViewController.h"
#import "QKCLShopInfoModel.h"
#import "AppDelegate.h"

@interface QKCLShopExaminatingViewController ()
@property (strong, nonatomic) NSTimer *timer;
//param
@property (strong, nonatomic) QKCLShopInfoModel *shopInfo;

@end

@implementation QKCLShopExaminatingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self showTab1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (_timer == nil || ![_timer isValid]) {
        // Timer
        _timer = [NSTimer scheduledTimerWithTimeInterval:60.0
                                                  target:self
                                                selector:@selector(timerFired:)
                                                userInfo:nil
                                                 repeats:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - Timer
- (void)timerFired:(id)sender {
    [self checkExamination];
}

- (void)checkExamination {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [[QKCLRequestManager sharedManager] asyncGET:[NSString stringFromConst:qkUrlShopList] parameters:params showLoading:NO showError:YES success: ^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject[QK_API_STATUS_CODE] isEqualToString:[NSString stringFromConst:QK_STT_CODE_SUCCESS]]) {
                NSLog(@"Examination successful...");
                for (NSDictionary *shopDic in responseObject[@"shopList"]) {
                    if ([shopDic[@"shopId"] isEqualToString:[QKCLAccessUserDefaults getNewShopId]]) {
                        if (![shopDic[@"shopStatus"] isEqualToString:[NSString stringFromConst:QK_SHOP_STATUS_EXAMINATING]]) {
                            if ([shopDic[@"shopStatus"] isEqualToString:[NSString stringFromConst:QK_SHOP_STATUS_EXAM_OK]]) {
                                _shopInfo = [[QKCLShopInfoModel alloc] initWithResponse:shopDic];
                                if ([[QKCLAccessUserDefaults getActiveShopId] isEqualToString:@""]) {
                                    [QKCLAccessUserDefaults setActiveShopId:[QKCLAccessUserDefaults getNewShopId]];
                                    [QKCLAccessUserDefaults setActiveShopName:shopDic[@"name"]];
                                    [QKCLAccessUserDefaults setJobTypeLCd:shopDic[@"jobTypeLCd"]];
                                    [QKCLAccessUserDefaults setJobTypeMCd:shopDic[@"jobTypeMCd"]];
                                }
                                [QKCLAccessUserDefaults setNewShopId:@""];
                                //stop timer
                                [self stopTimer];
                                [self performSegueWithIdentifier:@"QKShowJudgeInfoSegue" sender:self];
                            }
                            else if ([shopDic[@"shopStatus"] isEqualToString:[NSString stringFromConst:QK_SHOP_STATUS_EXAM_NG]]) {
                                //stop timer
                                [self stopTimer];
                                [self performSegueWithIdentifier:@"QKReturnAddShopSegue" sender:self];
                            }
                        }
                        
                        break;
                    }
                }
            }
        } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Examination error...");
        }];
    }
    else {
        [self showNoInternetViewWithSelector:@selector(checkExamination)];
    }
}

- (void)stopTimer {
    //stop timer
    if ([_timer isValid]) {
        [_timer invalidate];
        _timer = nil;
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"QKShowJudgeInfoSegue"]) {
        QKCLShopExaminationDoneViewController *vc = (QKCLShopExaminationDoneViewController *)segue.destinationViewController;
        [vc setShopInfo:_shopInfo];
    }
}

- (IBAction)tab1Clicked:(id)sender {
    [self showTab1];
}

- (IBAction)tab2Clicked:(id)sender {
    [self showTab2];
}

- (void)showTab1 {
    [self.tab1Button setSelected:YES];
    [self.tab2Button setSelected:NO];
    self.footerView1.hidden = NO;
    self.footerView2.hidden = YES;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringFromConst:qkCLUrlWebReviewSteps]]]];
}

- (void)showTab2 {
    [self.tab1Button setSelected:NO];
    [self.tab2Button setSelected:YES];
    self.footerView1.hidden = YES;
    self.footerView2.hidden = NO;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringFromConst:qkCLUrlWebReviewFaq]]]];
}

@end
