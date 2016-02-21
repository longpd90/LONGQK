//
//  QKRegisterStoreInfoViewController.m
//  quicker-cl-ios
//
//  Created by Nguyen Huu Anh on 4/16/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKCLShopInputPhotoViewController.h"
#import "QKCLCropImageViewController.h"
#import "QKCLDetailUserGuideViewController.h"
#import "QKCLImageModel.h"
#import "QKCLShopCameraHintViewController.h"

#define kQKShopCameraHintKey @"QKShopCameraHintKey"
#define kQKShopCameraHintValue @"1"

@interface QKCLShopInputPhotoViewController () <QKCropImageViewControllerDelegate, CCAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UIImageView *subImage1;
@property (weak, nonatomic) IBOutlet UIImageView *subImage2;
@property (weak, nonatomic) IBOutlet UIButton *mainImageButton;
@property (weak, nonatomic) IBOutlet UIButton *subImageButton1;
@property (weak, nonatomic) IBOutlet UIButton *subImageButton2;
@property (assign, nonatomic) NSInteger editingImageIndex;
@property (weak, nonatomic) IBOutlet UIImageView *crossImage1;
@property (weak, nonatomic) IBOutlet UIImageView *crossImage2;
@property (weak, nonatomic) IBOutlet UIImageView *crossImage3;
@property (strong, nonatomic) UIImage *editingImage;
@property (weak, nonatomic) IBOutlet UIButton *editButton1;
@property (weak, nonatomic) IBOutlet UIButton *editButton2;
@property (weak, nonatomic) IBOutlet UIButton *editButton3;
@property (nonatomic) NSString *imageId1;
@property (nonatomic) NSString *imageId2;
@property (nonatomic) NSString *imageId3;

@property (strong, nonatomic) UIImage *mainImageData;
@property (strong, nonatomic) UIImage *subImageData1;
@property (strong, nonatomic) UIImage *subImageData2;
@property (strong, nonatomic) CCAlertView *alertView;
@end

@implementation QKCLShopInputPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店舗写真の登録";
    
    [self setAngleLeftBarButton];
    self.mainImageView.clipsToBounds = YES;
    [self checkEnableButtons];
    
    [_completeRegisterShopButton setEnabled:NO];
}

- (void)checkEnableButtons {
    if (self.mainImageData == nil) {
        self.crossImage1.hidden = NO;
        self.crossImage2.hidden = NO;
        self.crossImage3.hidden = NO;
        self.mainImageButton.enabled = YES;
        self.subImageButton1.enabled = NO;
        self.subImageButton2.enabled = NO;
        [self setHiddenEditButton];
        return;
    }
    
    if (self.subImageData1 == nil) {
        self.crossImage1.hidden = YES;
        self.crossImage2.hidden = NO;
        self.crossImage3.hidden = NO;
        self.mainImageButton.enabled = YES;
        self.subImageButton1.enabled = YES;
        self.subImageButton2.enabled = NO;
        [self setHiddenEditButton];
        return;
    }
    
    if (self.subImageData2 == nil) {
        self.crossImage1.hidden = YES;
        self.crossImage2.hidden = YES;
        self.crossImage3.hidden = NO;
        self.mainImageButton.enabled = YES;
        self.subImageButton1.enabled = YES;
        self.subImageButton2.enabled = YES;
        [self setHiddenEditButton];
        return;
    }
    self.crossImage1.hidden = YES;
    self.crossImage2.hidden = YES;
    self.crossImage3.hidden = YES;
    [self setHiddenEditButton];
}

- (void)setHiddenEditButton {
    self.editButton1.hidden = !self.crossImage1.hidden;
    self.editButton2.hidden = !self.crossImage2.hidden;
    self.editButton3.hidden = !self.crossImage3.hidden;
}

#pragma mark - IBAction

- (void)addImageFirstTime:(NSNotification *)notification {
    NSDictionary *dict = notification.userInfo;
    UIImage *image = [dict objectForKey:@"image"];
    NSString *imageId = [dict stringForKey:@"imageId"];
    [self croppedImage:image imageId:imageId];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ImageFromCameraHint" object:nil];
}

- (IBAction)addImage:(id)sender {
    self.editingImageIndex = ((UIButton *)sender).tag - 100;
    if ([[QKCLAccessUserDefaults get:kQKShopCameraHintKey] isEqualToString:kQKShopCameraHintValue]) {
        [self performSegueWithIdentifier:@"QKAddImageShopCustomCameraSegue" sender:self];
    }
    else {
        //first time
        [self performSegueWithIdentifier:@"QKShowShopCameraHintSegue" sender:self];
        [QKCLAccessUserDefaults put:kQKShopCameraHintKey withValue:kQKShopCameraHintValue];
    }
}

- (IBAction)completeRegisterShopClicked:(id)sender {
    if ([self connected]) {
        NSMutableDictionary *params = [NSMutableDictionary initWithApiKeyAndToken];
        [params setObject:[QKCLAccessUserDefaults getUserId] forKey:@"userId"];
        [params setObject:[QKCLAccessUserDefaults getActiveShopId] forKey:@"shopId"];
        [params setObject:_json forKey:@"json"];
        [params setObject:_accessWay forKey:@"accessWay"];
        
        NSMutableSet *set = [[NSMutableSet alloc]init];
        if (_imageId1 != nil && ![_imageId1 isEqualToString:@""]) {
            [set addObject:_imageId1];
        }
        if (_imageId2 != nil && ![_imageId2 isEqualToString:@""]) {
            [set addObject:_imageId2];
        }
        if (_imageId3 != nil && ![_imageId3 isEqualToString:@""]) {
            [set addObject:_imageId3];
        }
        [params setObject:set forKey:@"imageId"];
        
        NSDictionary *response;
        NSError *error;
        BOOL result = [[QKCLRequestManager sharedManager] syncPOST:[NSString stringFromConst:qkUrlShopUpdateComplete] parameters:params response:&response error:&error showLoading:YES showError:YES];
        
        if (result) {
            NSString *title = @"店舗登録が完了しました";
            NSString *detail = @"登録した店舗は「マイぺージ」から\n変更することができます。";
            
            CCAlertView *alertView = [[CCAlertView alloc]initWithImage:[UIImage imageNamed:@"dialog_pic_done"] title:title message:detail delegate:self buttonTitles:@[@"OK"]];
            alertView.delegate = self;
            [alertView showAlert];
        }
    }
    else {
        [self showNoInternetViewWithSelector:nil];
    }
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"QKAddImageShopCustomCameraSegue"]) {
        UINavigationController *nav = [segue destinationViewController];
        QKCLCameraViewController *cameraViewController = (QKCLCameraViewController *)nav.viewControllers[0];
        cameraViewController.presentingVC = self;
        cameraViewController.hintSegue = @"QKShopHintSegue";
        cameraViewController.cropImageType = QKCropImageTypeRectangle;
        switch (_editingImageIndex) {
            case 0:
                cameraViewController.sourceImageType = [NSString stringFromConst:QK_IMAGE_TYPE_MAIN];
                break;
                
            default:
                cameraViewController.sourceImageType = [NSString stringFromConst:QK_IMAGE_TYPE_OTHER];
                break;
        }
    }
    else if ([segue.identifier isEqualToString:@"QKShowGuideSegue"]) {
        QKCLDetailUserGuideViewController *userGuide = (QKCLDetailUserGuideViewController *)[segue destinationViewController];
        userGuide.title = @"画像掲載における注意事項";
        userGuide.textView.text = @"以下に該当するような写真・画像は掲載しないでくだ さい。これらに違反していると判断される場合は、 「Job Quicker」の裁量で削除等適切な対応を取らせ ていただくことがあります";
    }
    else if ([segue.identifier isEqualToString:@"QKShowShopCameraHintSegue"]) {
        QKCLShopCameraHintViewController *hintViewController = (QKCLShopCameraHintViewController *)segue.destinationViewController;
        [hintViewController setIndex:self.editingImageIndex];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addImageFirstTime:) name:@"ImageFromCameraHint" object:nil];
    }
}

#pragma mark - QKCropImageViewControllerDelegate

- (void)croppedImage:(UIImage *)image imageId:(NSString *)imageId {
    switch (self.editingImageIndex) {
        case 0:
            self.mainImageView.image = image;
            self.mainImageData = image;
            _imageId1 = imageId;
            break;
            
        case 1:
            self.subImage1.image = image;
            self.subImageData1 = image;
            _imageId2 = imageId;
            break;
            
        case 2:
            self.subImage2.image = image;
            self.subImageData2 = image;
            _imageId3 = imageId;
            [_completeRegisterShopButton setEnabled:YES];
            break;
    }
    
    [self checkEnableButtons];
}

#pragma mark - CCAlertViewDelegate

- (void)alertView:(CCAlertView *)alertView selectedButtonIndex:(NSInteger)index {
    [self moveToMainMenu];
}

- (void)moveToMainMenu {
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    
    //move to main menu
    UIViewController *mainMenuNavigationViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SWRevealViewController"];
    [[UIApplication sharedApplication] keyWindow].rootViewController = mainMenuNavigationViewController;
    [[[UIApplication sharedApplication] keyWindow] makeKeyAndVisible];
}

@end
