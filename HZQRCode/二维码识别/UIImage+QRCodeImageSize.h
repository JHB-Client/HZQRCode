//
//  UIImage+QRCodeImageSize.h
//  HZQRCodeExample
//
//  Created by 季怀斌 on 2017/11/6.
//  Copyright © 2017年 huazhuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (QRCodeImageSize)
//返回一张不超过屏幕尺寸的image
+ (UIImage *)imageSizeWithScreenImage:(UIImage *)image;
@end
