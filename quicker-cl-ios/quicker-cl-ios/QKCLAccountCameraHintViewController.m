//
//  QKSnaphitCameraViewController.m
//  quicker-cl-ios
//
//  Created by LongPD-PC on 4/22/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLAccountCameraHintViewController.h"

@interface QKCLAccountCameraHintViewController ()
@end

@implementation QKCLAccountCameraHintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_isHint) {
        [_cameraButton setHidden:YES];
        _bottomLayout.constant = -44;
        [self.view updateConstraintsIfNeeded];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

#pragma mark -Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"QKShowCameraSegue"]) {
        UINavigationController *nav = [segue destinationViewController];
        QKCLCameraViewController *cameraViewController = (QKCLCameraViewController *)nav.viewControllers[0];
        cameraViewController.hintSegue = @"QKAccountFaceHintSegue";
        cameraViewController.presentingVC = self;
        cameraViewController.cropImageType = QKCropImageTypeSquare;
        cameraViewController.sourceImageType = [NSString stringFromConst:QK_IMAGE_TYPE_MAIN];
        cameraViewController.mode = QKUploadModeProfile;
        cameraViewController.isCaptureForAvatar = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Delegate CustomCamera


- (void)croppedImage:(UIImage *)image imageId:(NSString *)imageId {
    [self dismissViewControllerAnimated:YES completion: ^{
        NSMutableDictionary *userInfo = [[NSMutableDictionary alloc]init];
        [userInfo setObject:image forKey:@"getImageEdited"];
        [userInfo setObject:[NSString stringWithFormat:@"%@", imageId] forKey:@"imageId"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dismissEditImage" object:nil userInfo:userInfo];
    }];
}

- (IBAction)cameraButtonClicked:(id)sender {
}

- (IBAction)closeButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
