//
//  HZQRCodeGenerateViewController.m
//  HZQRCodeExample
//
//  Created by 季怀斌 on 2017/11/7.
//  Copyright © 2017年 huazhuo. All rights reserved.
//

#import "HZQRCodeGenerateViewController.h"
#import "HZQRCode.h"
#import "UIView+Frame.h"
@interface HZQRCodeGenerateViewController ()
//** <#注释#>*/
@property (nonatomic, weak) UITextField *QRCodeDataTextField;
@property (nonatomic, weak) UIImageView *normalQRCodeImgView;
@property (nonatomic, weak) UIImageView *logoQRCodeImgView;
@property (nonatomic, weak) UIImageView *colorQRCodeImgView;
@end

@implementation HZQRCodeGenerateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    self.navigationItem.title = @"二维码生成";
    
    //
    UITextField *QRCodeDataTextField = [[UITextField alloc] initWithFrame:CGRectMake(90, 100, 200, 50)];
    QRCodeDataTextField.backgroundColor = [UIColor redColor];
    QRCodeDataTextField.placeholder = @"请输入生成二维码的内容";
    [self.view addSubview:QRCodeDataTextField];
    self.QRCodeDataTextField = QRCodeDataTextField;
    
    //
    UIButton *generateBtn = [[UIButton alloc] initWithFrame:CGRectMake(130, 200, 100, 50)];
    [generateBtn setTitle:@"提交" forState:UIControlStateNormal];
    generateBtn.backgroundColor = [UIColor redColor];
    [generateBtn addTarget:self action:@selector(generateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:generateBtn];
    
    //
    UIImageView *normalQRCodeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 300, 100, 100)];
    [self.view addSubview:normalQRCodeImgView];
    self.normalQRCodeImgView = normalQRCodeImgView;
    
    //
    UIImageView *logoQRCodeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(130, 300, 100, 100)];
    [self.view addSubview:logoQRCodeImgView];
    self.logoQRCodeImgView = logoQRCodeImgView;
    
    //
    UIImageView *colorQRCodeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(240, 300, 100, 100)];
    [self.view addSubview:colorQRCodeImgView];
    self.colorQRCodeImgView = colorQRCodeImgView;
}


- (void)generateBtnClick:(UIButton *)btn {
    
  if (self.QRCodeDataTextField.text.length == 0) return;
   [self.QRCodeDataTextField resignFirstResponder];
    
    //
   UIImage *QRCodeImg = [HZQRCodeGenerator generateDefaultQRCodeImageWithData:self.QRCodeDataTextField.text imageViewWidth:self.normalQRCodeImgView.width];
    self.normalQRCodeImgView.image = QRCodeImg;
    
    //
    UIImage *logoQRCodeImg = [HZQRCodeGenerator generateLogoQRCodeImageWithData:self.QRCodeDataTextField.text logoImageName:@"logo.png" logoScaleToSuperView:0.3];
    self.logoQRCodeImgView.image = logoQRCodeImg;

    //
    if (@available(iOS 10.0, *)) {
        UIImage *colorQRCodeImg = [HZQRCodeGenerator generateColorQRCodeImageWithData:self.QRCodeDataTextField.text backgroundColor:[CIColor redColor] mainColor:[CIColor greenColor]];
        self.colorQRCodeImgView.image = colorQRCodeImg;
    } else {
        // Fallback on earlier versions
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
