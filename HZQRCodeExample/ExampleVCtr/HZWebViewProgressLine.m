//
//  HZWebViewProgressLine.m
//  HZQRCodeExample
//
//  Created by 季怀斌 on 2017/11/8.
//  Copyright © 2017年 huazhuo. All rights reserved.
//

#import "HZWebViewProgressLine.h"
#import "UIView+Frame.h"
@implementation HZWebViewProgressLine

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    self.backgroundColor = lineColor;
}

-(void)startLoadingAnimation{
    self.hidden = NO;
    self.width = 0.0;
    
    __weak UIView *weakSelf = self;
    [UIView animateWithDuration:0.4 animations:^{
        weakSelf.width = [UIScreen mainScreen].bounds.size.width * 0.6;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            weakSelf.width = [UIScreen mainScreen].bounds.size.width * 0.8;
        }];
    }];
    
    
}

-(void)endLoadingAnimation{
    __weak UIView *weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.width = [UIScreen mainScreen].bounds.size.width;
    } completion:^(BOOL finished) {
        weakSelf.hidden = YES;
    }];
}
@end
