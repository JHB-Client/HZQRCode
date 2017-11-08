//
//  HZQRCodeScanningView.h
//  HZQRCodeExample
//
//  Created by 季怀斌 on 2017/11/6.
//  Copyright © 2017年 huazhuo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    HZCornerLoactionDefault,// 默认与边框线同中心点
    HZCornerLoactionInside,//在边框线内部
    HZCornerLoactionOutside//在边框线外部
} HZCornerLoaction;

typedef enum : NSUInteger {
    HZScanningAnimationStyleDefault,//单线扫描样式
    HZScanningAnimationStyleGrid,//网格扫描样式
} HZScanningAnimationStyle;

@interface HZQRCodeScanningView : UIView
/** 扫描样式，默认 ScanningAnimationStyleDefault */
@property (nonatomic, assign) HZScanningAnimationStyle scanningAnimationStyle;
/** 扫描线名 */
@property (nonatomic, copy) NSString *scanningImageName;
/** 边框颜色，默认白色 */
@property (nonatomic, strong) UIColor *borderColor;
/** 边角位置，默认 CornerLoactionDefault */
@property (nonatomic, assign) HZCornerLoaction cornerLocation;
/** 边角颜色，默认微信颜色 */
@property (nonatomic, strong) UIColor *cornerColor;
/** 边角宽度，默认 2.f */
@property (nonatomic, assign) CGFloat cornerWidth;
/** 扫描区周边颜色的 alpha 值，默认 0.2f */
@property (nonatomic, assign) CGFloat backgroundAlpha;
/** 扫描线动画时间，默认 0.02 */
@property (nonatomic, assign) NSTimeInterval animationTimeInterval;

/** 添加定时器 */
- (void)addTimer;
/** 移除定时器(切记：一定要在Controller视图消失的时候，停止定时器) */
- (void)removeTimer;
@end
