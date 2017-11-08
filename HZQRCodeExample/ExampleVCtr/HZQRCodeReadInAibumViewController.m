//
//  HZQRCodeReadInAibumViewController.m
//  HZQRCodeExample
//
//  Created by 季怀斌 on 2017/11/7.
//  Copyright © 2017年 huazhuo. All rights reserved.
//

#import "HZQRCodeReadInAibumViewController.h"
#import "HZQRCode.h"
@interface HZQRCodeReadInAibumViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@end

@implementation HZQRCodeReadInAibumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"相册二维码识别";
    
    UIButton *albumBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, self.view.width - 200, 100)];
    [albumBtn setTitle:@"进入相册" forState:UIControlStateNormal];
    albumBtn.backgroundColor = [UIColor redColor];
    [albumBtn addTarget:self action:@selector(albumBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:albumBtn];
}

// 获取相册里的图片
- (void)albumBtnClick:(UIButton *)btn {
    // 1.判断相册是否可以打开
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    // 2. 创建图片选择控制器
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    /**
     typedef NS_ENUM(NSInteger, UIImagePickerControllerSourceType) {
     UIImagePickerControllerSourceTypePhotoLibrary, // 相册
     UIImagePickerControllerSourceTypeCamera, // 用相机拍摄获取
     UIImagePickerControllerSourceTypeSavedPhotosAlbum // 相簿
     }
     */
    // 3. 设置打开照片相册类型(显示所有相簿)
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    // 照相机
    // ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    // 4.设置代理
    ipc.delegate = self;
    // 5.modal出这个控制器
    [self presentViewController:ipc animated:YES completion:nil];
}

// 获取图片后的操作
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // 销毁控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 设置图片
    UIImage *QRCodeImg = info[UIImagePickerControllerOriginalImage];
    
   
    NSString *scannedResult = [[HZQRCodeScanManager sharedManager] readQRCodeImg:QRCodeImg];
    
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"扫描结果" message:scannedResult delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
