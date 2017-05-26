//
//  PersonalCenter.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/5/25.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "PersonalCenter.h"
#import "XYMScanViewController.h"
#import "QRCodeGenerator.h"

@interface PersonalCenter ()

@end

@implementation PersonalCenter

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 80, 40);
    btn.center = self.view.center;
    btn.backgroundColor = [UIColor blueColor];
    [btn setTitle:@"开始扫码" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(startScan) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
}
-(void)startScan{
    CGFloat w=[UIScreen mainScreen].bounds.size.width;
    NSArray*arr=@[[QRCodeGenerator qrImageForString:@"Key" imageSize:400],
                  [QRCodeGenerator qrImageForString:@"key1" imageSize:400 Topimg:[UIImage imageNamed:@"super.jpg"]],
                  [QRCodeGenerator qrImageForString:@"key2" imageSize:400 withPointType:QRPointRect withPositionType:QRPositionNormal withColor:[UIColor yellowColor]],
                  [QRCodeGenerator qrImageForString:@"key3" imageSize:400 withPointType:QRPointRound withPositionType:QRPositionRound withColor:[UIColor redColor]],
                  [QRCodeGenerator qrImageForString:@"key4" imageSize:400 withPointType:QRPointRect withPositionType:QRPositionRound withColor:[UIColor blueColor]],
                  [QRCodeGenerator qrImageForString:@"key5" imageSize:400 withPointType:QRPointRound withPositionType:QRPositionNormal withColor:[UIColor purpleColor]]];
    for (int i=0; i<6; i++) {
        UIImageView*QRCode=[[UIImageView alloc]initWithFrame:CGRectMake(i%3*w/3, (i/3)*w/3, w/3, w/3)];
        QRCode.image=arr[i];
        [self.view addSubview:QRCode];
    }

    
    XYMScanViewController *scanView = [[XYMScanViewController alloc]init];
    
    [self.navigationController pushViewController:scanView animated:YES];
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
