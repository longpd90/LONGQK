//
//  QKUserGuideViewController.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 6/8/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLUserGuideViewController.h"
#import "QKCLWebViewController.h"
@implementation QKCLUserGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"ガイドライン", nil);
    [self setAngleLeftBarButton];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark - UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QKUserGuidesCell"];
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Guide 1";
            break;
            
        case 1:
            cell.textLabel.text = @"Guide 2";
            break;
            
        case 2:
            cell.textLabel.text = @"Guide 3";
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [self performSegueWithIdentifier:@"QKShowUserGuide1" sender:self];
            break;
            
        case 1:
            [self performSegueWithIdentifier:@"QKShowUserGuide2" sender:self];
            break;
            
        case 2:
            [self performSegueWithIdentifier:@"QKShowUserGuide3" sender:self];
            break;
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    QKCLWebViewController *qkWebViewController = (QKCLWebViewController *)segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"QKShowUserGuide1"]) {
        qkWebViewController.title = @"Guide 1";
        qkWebViewController.stringURL = [NSString stringFromConst:qkCLUrlWebGuidelineWriting];
    }
    if ([segue.identifier isEqualToString:@"QKShowUserGuide2"]) {
        qkWebViewController.title = @"Guide 2";
        qkWebViewController.stringURL = [NSString stringFromConst:qkCLUrlWebGuidelineWriting];
    }
}

@end
