//
//  HZQRCodeGenerateManager.h
//  HZQRCodeExample
//
//  Created by 季怀斌 on 2017/11/6.
//  Copyright © 2017年 huazhuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface HZQRCodeGenerator : NSObject
//常规二维码
+ (UIImage *)generateDefaultQRCodeImageWithData:(NSString *)data imageViewWidth:(CGFloat)imageViewWidth;
//logo二维码
+ (UIImage *)generateLogoQRCodeImageWithData:(NSString *)data logoImageName:(NSString *)logoImageName logoScaleToSuperView:(CGFloat)logoScaleToSuperView;
//彩色二维码
+ (UIImage *)generateColorQRCodeImageWithData:(NSString *)data backgroundColor:(CIColor *)backgroundColor mainColor:(CIColor *)mainColor;
@end
