//
//  LogisticsDetailVC.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/12.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "LogisticsDetailVC.h"
#import "LogisticsCell.h"
#import "NSString+MLLabel.h"
@interface LogisticsDetailVC ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>
{
    //底部scrollview
    UIScrollView *bgScrollView;
    UITableView *logisticsTableView;
    

}

@end

@implementation LogisticsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    //替代导航栏的imageview
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, Frame_NavAndStatus)];
    topImageView.userInteractionEnabled = YES;
    topImageView.backgroundColor = NavColorWhite;
    [self.view addSubview:topImageView];
    //添加返回按钮
    UIButton *  returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame = CGRectMake(0, Frame_rectStatus, Frame_rectNav, Frame_rectNav);
    [returnBtn setImage:[UIImage imageNamed:navBackarrow] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:returnBtn];
    
    //注册标签
    UILabel *navTitle =[[UILabel alloc] initWithFrame:CGRectMake(200*Width, Frame_rectStatus, 350*Width, Frame_rectNav)];
    [navTitle setText:@"物流详情"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor blackColor]];
    [self.view addSubview:navTitle];
    
    
    
    [self mainView];
}
- (void)mainView
{
//    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64,CXCWidth, 466*Width)];
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, Frame_NavAndStatus,CXCWidth, CXCHeight-Frame_NavAndStatus)];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setBackgroundColor:BGColor];
    UIView *topView =[[UIView alloc]initWithFrame:CGRectMake(0, 20*Width, CXCWidth, 200*Width)];
    [topView setBackgroundColor:[UIColor whiteColor]];
    [bgScrollView addSubview:topView];
    
    [self.view addSubview:bgScrollView];
    UILabel*nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(30*Width, 25*Width, 260*Width, 50*Width)];
    nameLabel.text =[NSString stringWithFormat:@"%@",[_dicDetail objectForKey:@"receivename"] ];
    
    nameLabel.font =[UIFont systemFontOfSize:16];
    [topView addSubview:nameLabel];
    NSLog(@"物流====%@",_dicDetail);
    
    UILabel*numberLabel =[[UILabel alloc]initWithFrame:CGRectMake(nameLabel.right+20*Width, 25*Width, 300*Width, 50*Width)];
    numberLabel.text =[NSString stringWithFormat:@"%@",[_dicDetail objectForKey:@"phone"] ];
    numberLabel.font =[UIFont systemFontOfSize:16];
    [topView addSubview:numberLabel];
    
    UIImageView *imgView =[[UIImageView alloc]initWithFrame:CGRectMake(20*Width, nameLabel.bottom+46*Width,24*Width, 32*Width)];
    [imgView setImage:[UIImage imageNamed:@"wuliu_icon_location"]];
    [topView addSubview:imgView];
    

    
    UILabel *addressLabel  =[[UILabel alloc]initWithFrame:CGRectMake(imgView.right+ 20*Width, nameLabel.bottom,640*Width, 125*Width)];
    [topView addSubview:addressLabel];
    addressLabel.text =[NSString stringWithFormat:@"%@%@",[_dicDetail objectForKey:@"namepath"],[_dicDetail objectForKey:@"address"] ];
    addressLabel.font =[UIFont systemFontOfSize:13];
    addressLabel.numberOfLines= 0;
    addressLabel.textColor =TextGrayColor;
//    NSArray*arr =@[@"",@"待支付",@"待发货",@"已发货",@"已完成",@"取消",@"驳回",@"",];
    nameLabel.text =@"孙俪";
    numberLabel.text =@"18737373711";
    addressLabel.text =@"山东省潍坊市奎文区胜利街文化路7星假日酒店2929";
    NSArray*leftArr =@[@"快递公司",@"运单号",@"",@"",@"",@"",] ;
//    int i =[[_dicDetail objectForKey:@"status"] intValue];
    NSArray*rightArr =@[[NSString stringWithFormat:@"%@",@"顺丰快递"]   ,[NSString stringWithFormat:@"%@",@"1111093048905453" ],@"",@"",@"",] ;
//    NSArray*rightArr =@[[NSString stringWithFormat:@"%@",_logisticscom ]   ,[NSString stringWithFormat:@"%@",_logistics ],@"",@"",@"",] ;

        for (int i=0; i<2; i++) {
            //背景
            UIView *bgview =[[UIView alloc]init];
            bgview.backgroundColor =[UIColor whiteColor];
            [bgScrollView addSubview:bgview];
            bgview.frame =CGRectMake(0, topView.bottom+i*82*Width+20*Width, CXCWidth, 82*Width);
            //左边提示
            UILabel* labe = [[UILabel alloc]initWithFrame:CGRectMake(32*Width, 0,200*Width , 82*Width)];
            labe.text = leftArr[i];
            //            labe.textAlignment=NSTextAlignmentLeft;
            labe.font = [UIFont systemFontOfSize:14];
            labe.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
            [bgview addSubview:labe];
            //右边显示
            UILabel* rightLabel = [[UILabel alloc]init];
            rightLabel.text = rightArr[i];
            rightLabel.frame =CGRectMake(250*Width ,0, 475*Width,82*Width );
            rightLabel.textAlignment=NSTextAlignmentRight;
            rightLabel.tag =200+i;
            rightLabel.font = [UIFont systemFontOfSize:14];
            if(i==0)
            {
                rightLabel.textColor = NavColor;

            }else
            {
                rightLabel.textColor = BlackColor;

            }
            [bgview addSubview:rightLabel];

            //分割线
            UIImageView*xian =[[UIImageView alloc]init];
            xian.backgroundColor =BGColor;
            [bgview addSubview:xian];
            xian.frame =CGRectMake(0,80.5*Width, CXCWidth, 1.5*Width);
            
        }
    UIWebView * webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, topView.bottom+200*Width,CXCWidth ,CXCHeight-Frame_NavAndStatus )];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"https://m.kuaidi100.com/index_all.html?type=%@&postid=%@",_logisticscom,_logistics]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];

    
    [webView loadRequest:request];
    webView.delegate =self;
    webView.userInteractionEnabled =NO;
    webView.scrollView.scrollEnabled =NO;

    [bgScrollView addSubview:webView];

        
    
    
    
    
    
    
//    
//    logisticsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, CXCWidth, CXCHeight-64)style:UITableViewStyleGrouped];
//    [logisticsTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    [logisticsTableView setDelegate:self];
//    [logisticsTableView setDataSource:self];
//    [logisticsTableView setBackgroundColor:[UIColor clearColor]];
//    logisticsTableView .showsVerticalScrollIndicator = NO;
//    [self.view addSubview:logisticsTableView];
//
    
    
    
    
    

}
- (void)returnBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return bgScrollView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 506*Width;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray*arr=@[];
        NSString *titleContent =[[arr objectAtIndex:indexPath.row] objectForKey:@"key"];
        CGSize titleSize;//通过文本得到高度
        
        titleSize = [titleContent boundingRectWithSize:CGSizeMake(600*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        
        return  titleSize.height+100*Width;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *CellIdentifier = @"Cell";
        LogisticsCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[LogisticsCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:CellIdentifier ];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
    NSArray*arr=@[];

        cell.dic =arr[indexPath.row];
        
        
        return cell;
        
    
}
- (void)changeStatuBtn:(UIButton *)btn
{
    for (int i=0; i<3; i++) {
        UIButton *statuBtn =[self.view viewWithTag:220+i];
        statuBtn.selected=NO;
    }
    btn.selected =YES;
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
    
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //方法1 实际使用js方法实现
    CGFloat documentWidth = [[webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('content').offsetWidth"] floatValue];
    CGFloat documentHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"content\").offsetHeight;"] floatValue];
    NSLog(@"documentSize = {%f, %f}", documentWidth, documentHeight);
    
    //方法2
    CGRect frame = webView.frame;
    frame.size.width = CXCWidth;
    frame.size.height = 1;
    //    webView.scrollView.scrollEnabled = NO;
    webView.frame = frame;
    frame.size.height = webView.scrollView.contentSize.height;
    NSLog(@"frame = %@", [NSValue valueWithCGRect:frame]);
    webView.frame = frame;
//    [goodsTableview setFrame:CGRectMake(0,webView.bottom,CXCWidth,ImgsArr.count*400*Width)];
//    [goodsTableview reloadData];
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, webView.bottom+10*Width)];

    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
   //判断是否是单击
    if (navigationType == (UIWebViewNavigationTypeLinkClicked |UIWebViewNavigationTypeBackForward |UIWebViewNavigationTypeFormResubmitted))
    {
        return NO;
    
    }
    return YES;
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
