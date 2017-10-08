//
//  FreeSendVC.m
//  家装
//
//  Created by Admin on 2017/9/23.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "FreeSendVC.h"
#import "FreeSendLPV.h"
#import "FreeSendESFV.h"
#import "FreeSendZFV.h"
@interface FreeSendVC ()
{
    NSString *statuString;
    NSIndexPath *index;
    NSString *typeStr;
    
    FreeSendLPV *free;
    FreeSendESFV *free2;
    FreeSendZFV *free3 ;

}
@end

@implementation FreeSendVC
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden =YES;
    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:BGColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    //替代导航栏的imageview
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, Frame_NavAndStatus)];
    topImageView.userInteractionEnabled = YES;
    topImageView.backgroundColor = NavColor;
    [self.view addSubview:topImageView];
//    //添加返回按钮
//    UIButton *  returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    returnBtn.frame = CGRectMake(0, Frame_rectStatus, Frame_rectNav, Frame_rectNav);
//    [returnBtn setImage:[UIImage imageNamed:navBackarrow] forState:UIControlStateNormal];
//    [returnBtn addTarget:self action:@selector(returnBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    [topImageView addSubview:returnBtn];
    
    //注册标签
    UILabel *navTitle =[[UILabel alloc] initWithFrame:CGRectMake(200*Width, Frame_rectStatus, 350*Width, Frame_rectNav)];
    [navTitle setText:@"免费发布"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor whiteColor]];
    [self.view addSubview:navTitle];
    //横线
    UIImageView*xian =[[UIImageView alloc]init];
    xian.backgroundColor =BGColor;
    [topImageView addSubview:xian];
    xian.frame =CGRectMake(0,Frame_NavAndStatus-1, CXCWidth, 1);
    
    [self mainView];
    
    
    
    
    
}
- (void)returnBtnAction
{
    [free.pickview remove];
    [free2.pickview remove];
    [free3.pickview remove];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)mainView
{
    typeStr =@"220";
    UIView *topView =[[UIView alloc]initWithFrame:CGRectMake(0, Frame_NavAndStatus, CXCWidth, 85*Width)];
    topView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:topView];
    NSArray *btnArr =@[@"楼盘",@"二手房",@"租房",];
    for (int i=0; i<3; i++) {
        UIButton *  statuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        statuBtn.frame = CGRectMake(CXCWidth/3*i, 0,CXCWidth/3-2*Width ,85*Width);
        if (i==0) {
            statuBtn.selected =YES;
        }
        statuBtn.titleLabel.font =[UIFont boldSystemFontOfSize:14];
        [statuBtn setTitle:btnArr[i] forState:UIControlStateNormal];
        [statuBtn setTitleColor:TextGrayColor forState:UIControlStateNormal];
        [statuBtn setTitleColor:NavColor forState:UIControlStateSelected];
        statuBtn.tag =220+i;
        [statuBtn addTarget:self action:@selector(changeStatuBtn:) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:statuBtn];
    }
    //可移动image
    
    UIImageView *imageview =[[UIImageView alloc] init];
    [imageview setTag:14];
    [imageview setBackgroundColor:NavColor];
    [imageview setFrame:CGRectMake(0, Frame_NavAndStatus+85*Width, CXCWidth/3, 3*Width)];
    [self.view addSubview:imageview];
    
    //横线
    UIImageView*xian =[[UIImageView alloc]init];
    xian.backgroundColor =BGColor;
    [topView addSubview:xian];
    xian.frame =CGRectMake(0,83.5*Width, CXCWidth, 1.5*Width);
    
    free =[[FreeSendLPV alloc]initWithFrame:CGRectMake(0, topView.bottom, CXCWidth,CXCHeight-(Frame_NavAndStatus +1))withViewController:self];
    [self.view addSubview:free];
    free.hidden =NO;
    
    free2 =[[FreeSendESFV alloc]initWithFrame:CGRectMake(0, topView.bottom, CXCWidth,CXCHeight-65)withViewController:self];
    [self.view addSubview:free2];
    free2.hidden =YES;
    
    free3 =[[FreeSendZFV alloc]initWithFrame:CGRectMake(0, topView.bottom, CXCWidth,CXCHeight-65)withViewController:self];
    [self.view addSubview:free3];
    free3.hidden =YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)changeStatuBtn:(UIButton *)btn
{
    [free.pickview remove];
    [free2.pickview remove];
    [free3.pickview remove];
    [free resignFirstResponderAllTextFiled ];
    [free2 resignFirstResponderAllTextFiled ];
    [free3 resignFirstResponderAllTextFiled ];
    
    UIImageView *imageview =(UIImageView *)[self.view viewWithTag:14];
    [UIView animateWithDuration:0.15 animations:^{
        [imageview setFrame:CGRectMake(CXCWidth/3*(btn.tag-220), Frame_NavAndStatus+85*Width, CXCWidth/3, 3*Width)];
    }completion:^(BOOL finished){
        
    }];
    
    typeStr =[NSString stringWithFormat:@"%ld",(long)btn.tag];
    for (int i=0; i<3; i++) {
        UIButton *statuBtn =[self.view viewWithTag:220+i];
        statuBtn.selected=NO;
    }
    
    statuString =[NSString stringWithFormat:@"%ld",btn.tag-220];
    btn.selected =YES;
    if (btn.tag==220) {
        free.hidden =NO;
        free2.hidden=YES;
        free3.hidden =YES;
    }else if (btn.tag==221)
    {
        free.hidden =YES;
        free2.hidden=NO;
        free3.hidden =YES;
    
    }else
    {
        free.hidden =YES;
        free2.hidden=YES;
        free3.hidden =NO;

    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return infoArray.count ;
    return 10 ;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([typeStr isEqualToString:@"222"]) {
        return  492*Width;
        
    }
    return  410*Width;
    
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
