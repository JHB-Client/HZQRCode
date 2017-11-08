//
//  HZQRCodeScanManager.h
//  HZQRCodeExample
//
//  Created by 季怀斌 on 2017/11/6.
//  Copyright © 2017年 huazhuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
//
@class HZQRCodeScanManager;
@protocol HZQRCodeScanManagerDelegate <NSObject>
@required
//二维码扫描获取数据的回调方法 (metadataObjects: 扫描二维码数据信息)
- (void)QRCodeScanManager:(HZQRCodeScanManager *)scanManager didOutputMetadataObjects:(NSArray *)metadataObjects;
@optional
//根据光线强弱值打开手电筒的方法 (brightnessValue: 光线强弱值)
- (void)QRCodeScanManager:(HZQRCodeScanManager *)scanManager brightnessValue:(CGFloat)brightnessValue;
@end
@interface HZQRCodeScanManager : NSObject
+ (instancetype)sharedManager;
@property (nonatomic, weak) id<HZQRCodeScanManagerDelegate> delegate;

//
- (void)setupSessionPreset:(NSString *)sessionPreset metadataObjectTypes:(NSArray *)metadataObjectTypes currentController:(UIViewController *)currentController;
/** 开启会话对象扫描 */
- (void)startRunning;
/** 停止会话对象扫描 */
- (void)stopRunning;
/** 移除 videoPreviewLayer 对象 */
- (void)videoPreviewLayerRemoveFromSuperlayer;
///** 播放音效文件 */
//- (void)palySoundName:(NSString *)name;
/** 重置根据光线强弱值打开手电筒的 delegate 方法 */
- (void)resetSampleBufferDelegate;
/** 取消根据光线强弱值打开手电筒的 delegate 方法 */
- (void)cancelSampleBufferDelegate;

//
- (NSString *)readQRCodeImg:(UIImage *)QRCodeImg;
@end
