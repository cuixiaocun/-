//
//  XYMScanViewController.m
//  healthcoming
//
//  Created by jack xu on 16/11/15.
//  Copyright © 2016年 Franky. All rights reserved.
//

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#import "XYMScanViewController.h"
#import "XYMScanView.h"
#import <AVFoundation/AVFoundation.h>
#import "AntiFakeVC.h"
@interface XYMScanViewController ()<XYMScanViewDelegate>
{
    int line_tag;
    UIView *highlightView;
    NSString *scanMessage;
    BOOL isRequesting;
}

@property (nonatomic,weak) XYMScanView *scanV;

@end

@implementation XYMScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(CXCHeight<500)
    {
        XYMScanView *scanV = [[XYMScanView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        scanV.delegate = self;
        [self.view addSubview:scanV];
        _scanV = scanV;
    
    }else
    {
        XYMScanView *scanV = [[XYMScanView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight)];
        scanV.delegate = self;
        [self.view addSubview:scanV];
        _scanV = scanV;
    
    }
    

    [self.view setBackgroundColor:[UIColor whiteColor]];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    //替代导航栏的imageview
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, 64)];
    topImageView.userInteractionEnabled = YES;
    topImageView.backgroundColor = NavColor;
    [self.view addSubview:topImageView];
    //添加返回按钮
    UIButton *  returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame = CGRectMake(0, 20, 44, 44);
    [returnBtn setImage:[UIImage imageNamed:navBackarrow] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:returnBtn];
    //注册标签
    UILabel *navTitle =[[UILabel alloc] initWithFrame:CGRectMake(100*Width, 20, 550*Width, 44)];
    [navTitle setText:@"扫码"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor whiteColor]];
    [self.view addSubview:navTitle];
    

    
   }
-(void)returnBtnAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)getScanDataString:(NSString*)scanDataString{
    NSLog(@"二维码内容：%@",scanDataString);
//    ScanResultViewController *scanResultVC = [[ScanResultViewController alloc]init];
//    scanResultVC.view.backgroundColor = [UIColor whiteColor];
//    scanResultVC.view.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
//    scanResultVC.scanDataString = scanDataString;
//    [self.navigationController pushViewController:scanResultVC animated:YES];
    if ([_whichView isEqualToString:@"防伪查询"]) {
        AntiFakeVC *antifack =[[AntiFakeVC alloc]init];
        antifack.dic=@{@"image":@"",@"name":@"温碧泉透白莹润护肤霜套装",@"prices":@"400",@"isTure":@"YES",@"isAuthentication":@"YES"};
        
        [self.navigationController pushViewController:antifack animated:YES];
        return;
        
    }
    [self.delegate getScanString:scanDataString];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
