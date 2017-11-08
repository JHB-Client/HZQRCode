//
//  HZQRCodeLongPressToReadViewController.m
//  HZQRCodeExample
//
//  Created by 季怀斌 on 2017/11/7.
//  Copyright © 2017年 huazhuo. All rights reserved.
//

#import "HZQRCodeLongPressToReadViewController.h"
#import "UIView+Frame.h"
#import "HZQRCode.h"
@interface HZQRCodeLongPressToReadViewController ()

@end

@implementation HZQRCodeLongPressToReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"长按二维码识别";
    
    //
    UIImageView *QRCodeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 100, self.view.width - 100, self.view.width - 100)];
    UIImage *QRCodeImg = [HZQRCodeGenerator generateDefaultQRCodeImageWithData:@"https://www.baidu.com" imageViewWidth:QRCodeImgView.width];
    QRCodeImgView.image = QRCodeImg;
    
    //
    QRCodeImgView.userInteractionEnabled = YES;
    [self.view addSubview:QRCodeImgView];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToReadQRCode:)];
    [QRCodeImgView addGestureRecognizer:longPress];
    
}



#pragma mark -- longPressToReadQRCode
- (void)longPressToReadQRCode:(UILongPressGestureRecognizer *)longPress {
    
    if (longPress.state != UIGestureRecognizerStateBegan) return;
    UIImageView*tempImageView=(UIImageView*)longPress.view;
    if(tempImageView.image){
       
        NSString *scannedResult = [[HZQRCodeScanManager sharedManager] readQRCodeImg:tempImageView.image];
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"扫描结果" message:scannedResult delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }else {
        
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"扫描结果" message:@"您还没有生成二维码" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
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
