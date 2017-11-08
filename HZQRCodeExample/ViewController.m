//
//  ViewController.m
//  HZQRCodeExample
//
//  Created by 季怀斌 on 2017/11/6.
//  Copyright © 2017年 huazhuo. All rights reserved.
//

#import "ViewController.h"
#import "HZQRCodeGenerateViewController.h"
#import "HZQRCodeScanViewController.h"
#import "HZQRCodeReadInAibumViewController.h"
#import "HZQRCodeLongPressToReadViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor greenColor];
    self.navigationItem.title = @"二维码";
    
    //1.
    UIButton *generateBtn = [[UIButton alloc] initWithFrame:CGRectMake(90, 150, 200, 50)];
    [generateBtn setTitle:@"生成二维码" forState:UIControlStateNormal];
    generateBtn.backgroundColor = [UIColor redColor];
    [generateBtn addTarget:self action:@selector(generateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:generateBtn];
    
    //2.
    UIButton *scanBtn = [[UIButton alloc] initWithFrame:CGRectMake(90, 250, 200, 50)];
    scanBtn.backgroundColor = [UIColor redColor];
    [scanBtn setTitle:@"扫描二维码" forState:UIControlStateNormal];
    [scanBtn addTarget:self action:@selector(scanBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scanBtn];
    
    //3.
    UIButton *albumToReadBtn = [[UIButton alloc] initWithFrame:CGRectMake(90, 350, 200, 50)];
    albumToReadBtn.backgroundColor = [UIColor redColor];
    [albumToReadBtn setTitle:@"相册识别二维码" forState:UIControlStateNormal];
    [albumToReadBtn addTarget:self action:@selector(albumToReadBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:albumToReadBtn];
    
    //4.
    UIButton *longPressToReadBtn = [[UIButton alloc] initWithFrame:CGRectMake(90, 450, 200, 50)];
    longPressToReadBtn.backgroundColor = [UIColor redColor];
    [longPressToReadBtn setTitle:@"长按识别二维码" forState:UIControlStateNormal];
    [longPressToReadBtn addTarget:self action:@selector(longPressToReadBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:longPressToReadBtn];
    
    
}



- (void)generateBtnClick:(UIButton *)btn {
    
    HZQRCodeGenerateViewController *QRCodeGenerateVCtr = [HZQRCodeGenerateViewController new];
    [self.navigationController pushViewController:QRCodeGenerateVCtr animated:YES];
}

- (void)scanBtnClick:(UIButton *)btn {
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        HZQRCodeScanViewController *vc = [[HZQRCodeScanViewController alloc] init];
                        [self.navigationController pushViewController:vc animated:YES];
                    });
                    // 用户第一次同意了访问相机权限
                    NSLog(@"用户第一次同意了访问相机权限 - - %@", [NSThread currentThread]);

                } else {
                    // 用户第一次拒绝了访问相机权限
                    NSLog(@"用户第一次拒绝了访问相机权限 - - %@", [NSThread currentThread]);
                }
            }];
        } else if (status == AVAuthorizationStatusAuthorized) { // 用户允许当前应用访问相机
            HZQRCodeScanViewController *vc = [[HZQRCodeScanViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        } else if (status == AVAuthorizationStatusDenied) { // 用户拒绝当前应用访问相机
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请去-> [设置 - 隐私 - 相机 - SGQRCodeExample] 打开访问开关" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {

            }];

            [alertC addAction:alertA];
            [self presentViewController:alertC animated:YES completion:nil];

        } else if (status == AVAuthorizationStatusRestricted) {
            NSLog(@"因为系统原因, 无法访问相册");
        }
    } else {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {

        }];

        [alertC addAction:alertA];
        [self presentViewController:alertC animated:YES completion:nil];
    }
}

- (void)albumToReadBtnClick:(UIButton *)btn {
    HZQRCodeReadInAibumViewController *QRCodeReadInAibumVCtr = [HZQRCodeReadInAibumViewController new];
    
    [self.navigationController pushViewController:QRCodeReadInAibumVCtr animated:YES];
}

- (void)longPressToReadBtnClick:(UIButton *)btn {
    HZQRCodeLongPressToReadViewController *QRCodeLongPressToReadVCtr = [HZQRCodeLongPressToReadViewController new];
    
    [self.navigationController pushViewController:QRCodeLongPressToReadVCtr animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
