//
//  QKRegisterShopHintViewController.m
//  quicker-cl-ios
//
//  Created by Viet on 7/3/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLShopCameraHintViewController.h"
#import "QKCLCameraViewController.h"
#import "QKCLCropImageViewController.h"

@interface QKCLShopCameraHintViewController () <QKCropImageViewControllerDelegate>
@end

@implementation QKCLShopCameraHintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if (_isHint) {
        [_cameraButton setHidden:YES];
        _bottomConstraint.constant = -44;
        [self.view updateConstraintsIfNeeded];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"QKShowCameraSegue"]) {
        UINavigationController *nav = [segue destinationViewController];
        QKCLCameraViewController *cameraViewController = (QKCLCameraViewController *)nav.viewControllers[0];
        cameraViewController.presentingVC = self;
        cameraViewController.hintSegue = @"QKShopHintSegue";
        cameraViewController.cropImageType = QKCropImageTypeRectangle;
        switch (_index) {
            case 0:
                cameraViewController.sourceImageType = [NSString stringFromConst:QK_IMAGE_TYPE_MAIN];
                break;
                
            default:
                cameraViewController.sourceImageType = [NSString stringFromConst:QK_IMAGE_TYPE_OTHER];
                break;
        }
    }
}

#pragma mark-QKCropImageViewControllerDelegate
- (void)croppedImage:(UIImage *)image imageId:(NSString *)imageId {
    [self dismissViewControllerAnimated:YES completion: ^{
        NSMutableDictionary *userInfo = [[NSMutableDictionary alloc]init];
        [userInfo setObject:image forKey:@"image"];
        [userInfo setObject:imageId forKey:@"imageId"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ImageFromCameraHint" object:nil userInfo:userInfo];
    }];
}

- (IBAction)closeButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
