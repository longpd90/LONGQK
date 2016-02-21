//
//  QKGenderTableViewCell.m
//  quicker-cs-ios
//
//  Created by LongPD-PC on 7/1/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKGenderTableViewCell.h"

@implementation QKGenderTableViewCell

- (void)awakeFromNib {
    self.placeView.layer.cornerRadius = 4;
    self.placeView.layer.masksToBounds = YES;
    [_manButton setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [_manButton setBackgroundImage:[self imageWithColor:kQKColorBtnSecondary] forState:UIControlStateSelected];
    [_womanButton setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [_womanButton setBackgroundImage:[self imageWithColor:kQKColorBtnSecondary] forState:UIControlStateSelected];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setGender:(NSInteger)gender {
    _gender = gender;
    if (gender == 2) {
        _manButton.selected = YES;
        _womanButton.selected = NO;
    } else {
        _manButton.selected = NO;
        _womanButton.selected = YES;
    }
}

- (IBAction)genderSelected:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (button.selected) {
        return;
    }
    if (_disableGender) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(genderChanged:)]) {
            [self.delegate genderChanged:_gender];
        }
        return;
    }
    
    if (_gender == 1) {
        _gender = 2;
    } else {
        _gender = 1;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(genderChanged:)]) {
        [self.delegate genderChanged:_gender];
    }
    _manButton.selected =! _manButton.selected;
    _womanButton.selected =! _womanButton.selected;
}

- (void)changeGender {
    if (_gender == 1) {
        _gender = 2;
    } else {
        _gender = 1;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(genderChanged:)]) {
        [self.delegate genderChanged:_gender];
    }
    _manButton.selected =! _manButton.selected;
    _womanButton.selected =! _womanButton.selected;
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
@end
