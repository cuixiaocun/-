//
//  PhotoSampleVC.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/1.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "PhotoSampleVC.h"
#import "EGOImageButton.h"
@interface PhotoSampleVC ()
{
    UIScrollView *bgScrollView;
}

@end

@implementation PhotoSampleVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view setBackgroundColor:BGColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    //替代导航栏的imageview
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, 64)];
    topImageView.userInteractionEnabled = YES;
    topImageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topImageView];
    
    //添加返回按钮
    UIButton *  returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame = CGRectMake(0, 20, 44, 44);
    [returnBtn setImage:[UIImage imageNamed:@"idCard_btn_goBack_red"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:returnBtn];
    
    //导航栏标签
    UILabel *navTitle =[[UILabel alloc] initWithFrame:CGRectMake(100*Width, 20, 550*Width, 44)];
    [navTitle setText:@"拍照示例"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:TextColor];
    [self.view addSubview:navTitle];
    
    [self mainView];
    
}
- (void)returnBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)mainView
{
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64,CXCWidth, CXCHeight-64 )];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setBackgroundColor:BGColor];
    [self.view addSubview:bgScrollView];
//    [bgScrollView setContentSize:CGSizeMake(CXCWidth, 1500)];
    
    UIImageView*xian =[[UIImageView alloc]init];
    xian.backgroundColor =[UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1];
    [bgScrollView addSubview:xian];
    xian.frame =CGRectMake(40*Width,40*Width, 670*Width, 1.5*Width);
    UILabel *wzLabel =[[UILabel alloc]initWithFrame:CGRectMake(250*Width, 0, 250*Width, 80*Width)];
    wzLabel.textColor =TextColor;
    wzLabel.backgroundColor =BGColor;
    wzLabel.text =@"身份证正反面照";
    wzLabel.textAlignment =NSTextAlignmentCenter;
    wzLabel.font =[UIFont systemFontOfSize:14];
    [bgScrollView addSubview:wzLabel];
    
    


    UIImageView *oppositeImg = [[UIImageView alloc]initWithFrame:CGRectMake(0*Width, 80*Width, CXCWidth, 860*Width)];
    oppositeImg.userInteractionEnabled = YES;
    oppositeImg.backgroundColor = [UIColor whiteColor];
    [bgScrollView addSubview:oppositeImg];
    

    
    
    //正面和反面
    for (int i=0; i<3; i++) {
             EGOImageButton *oppositeBtn =[[EGOImageButton alloc]init];
        if (i==0) {
            [oppositeBtn setImage:[UIImage imageNamed:@"register_icon_templet_front"] forState:UIControlStateNormal];
            
        }else if(i==1)
        {
            [oppositeBtn setImage:[UIImage imageNamed:@"register_icon_templet_back"] forState:UIControlStateNormal];
            
            
        }else
        {
            [oppositeBtn setImage:[UIImage imageNamed:@"register_icon_sao"] forState:UIControlStateNormal];

        }
        
        oppositeBtn.frame= CGRectMake(145*Width,48*Width+322*Width*i,460*Width, 290*Width);
        if(i==2)
        {
            oppositeBtn.frame= CGRectMake(145*Width,690*Width,460*Width, 120*Width);

        }
        oppositeBtn.tag =30+i;
        [oppositeImg addSubview:oppositeBtn];
    }
    
    
    
    
}
- (void)putUpPhoto
{
    
    
}
- (void)seeTheEG
{
    
    
    
}
- (void)oppositeBtn:(UIButton *)btn
{
    
    
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
