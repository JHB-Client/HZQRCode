//
//  HZWebViewProgressLine.h
//  HZQRCodeExample
//
//  Created by 季怀斌 on 2017/11/8.
//  Copyright © 2017年 huazhuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HZWebViewProgressLine : UIView
@property (nonatomic,strong) UIColor  *lineColor;
//开始加载
-(void)startLoadingAnimation;
//结束加载
-(void)endLoadingAnimation;
@end
