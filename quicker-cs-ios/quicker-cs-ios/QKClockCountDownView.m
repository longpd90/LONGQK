//
//  QKClockCountDownView.m
//  quicker-cs-ios
//
//  Created by LongPD-PC on 7/16/15.
//  Copyright (c) 2015 Trente VietNam. All rights reserved.
//

#import "QKClockCountDownView.h"

@implementation QKClockCountDownView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)setup {
    self.backgroundColor = [UIColor clearColor];
    self.drawColor = [UIColor whiteColor];
    self.radius = self.width/2.0 - 1 ;
    self.option = 0.45;
}

- (void)setOption:(float)option {
    _option = option;
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    float xcenter = self.frame.size.width / 2.0;
    float ycenter = self.frame.size.height / 2.0;

    CGContextRef contextCicrle = UIGraphicsGetCurrentContext();
    CGContextAddArc(contextCicrle, xcenter, ycenter, self.radius,0 , 2 * M_PI, 0);
    CGContextSetLineWidth(contextCicrle, 1.0);
    CGContextSetStrokeColorWithColor(contextCicrle, _drawColor.CGColor);
    CGContextStrokePath(contextCicrle);
    
    CGContextRef contextArc = UIGraphicsGetCurrentContext();
    CGContextAddArc(contextArc, xcenter, ycenter, self.radius, 3*M_PI_2,3*M_PI_2 - self.option*2*M_PI , 1);
    CGContextAddLineToPoint(contextArc, self.radius+1, self.radius+1);
    CGContextAddLineToPoint(contextArc, self.radius+1, 0);
    CGContextSetFillColorWithColor(contextArc, _drawColor.CGColor);
    CGContextFillPath(contextArc);
    CGContextStrokePath(contextArc);
}

@end
