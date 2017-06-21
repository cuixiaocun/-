//
//  GoodsDetailVC.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/17.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "GoodsDetailVC.h"
#import "HYConfirmOrderVC.h"
#import <WebKit/WebKit.h>
#import "LoginPage.h"
@interface GoodsDetailVC ()<UIScrollViewDelegate,SDCycleScrollViewDelegate,WKNavigationDelegate, WKUIDelegate>
{
    UIScrollView *bgScrollView;//最底下的背景
    //替代导航栏的imageview
    UIImageView *topImageView;
    UIImageView* topImageViewNomal;
    NSMutableArray *inforArr;
   
    UIView* blackBgView;//输入框背景透明黑
    UIView *alterView;//弹出输入框
    
}
@property (strong, nonatomic) WKWebView *webView;

@end

@implementation GoodsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    inforArr =[[NSMutableArray alloc]init];

    
       [self mainView];

    
   }

- (void)shateButton
{

    
    
    
    
    

}
- (void)mainView
{
    //底部scrollview
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CXCWidth, CXCHeight)];
    [bgScrollView setUserInteractionEnabled:YES];
    bgScrollView.delegate =self;
    [bgScrollView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:bgScrollView];
    bgScrollView.backgroundColor =[UIColor whiteColor];
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, 2800*Width)];
    topImageView= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, 64)];
    topImageView.userInteractionEnabled = YES;
    topImageView.backgroundColor = NavColor;
    [self.view addSubview:topImageView];
    topImageView.alpha =0.0;
    //注册标签
    UILabel *navTitle =[[UILabel alloc] initWithFrame:CGRectMake(100*Width, 20, 550*Width, 44)];
    [navTitle setText:@"产品详情"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor whiteColor]];
    [topImageView addSubview:navTitle];
    

    //添加返回按钮
    UIButton *  returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame = CGRectMake(0, 20, 44, 44);
    [returnBtn setImage:[UIImage imageNamed:navBackarrow] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:returnBtn];
    //右
    UIButton *shareBtn = [[UIButton alloc] initWithFrame:CGRectMake( CXCWidth-44, 20, 44, 44)];
    shareBtn.backgroundColor = [UIColor clearColor];
    [shareBtn addTarget:self action:@selector(shateButton) forControlEvents:UIControlEventTouchUpInside];
    [shareBtn setImage:[UIImage imageNamed:@"details_btn_share_white"] forState:UIControlStateNormal];
    [topImageView addSubview:shareBtn];
    
    
    topImageViewNomal= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, 64)];
    topImageViewNomal.userInteractionEnabled = YES;
    topImageViewNomal.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topImageViewNomal];
    topImageViewNomal.alpha =1.0;

    
    //添加返回按钮
    UIButton *  returnBtnNomal = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtnNomal.frame = CGRectMake(0, 20, 44, 44);
    [returnBtnNomal setImage:[UIImage imageNamed:@"details_btn_goback"] forState:UIControlStateNormal];
    [returnBtnNomal addTarget:self action:@selector(returnBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageViewNomal addSubview:returnBtnNomal];
    //右
    UIButton *shareBtnNomal = [[UIButton alloc] initWithFrame:CGRectMake( CXCWidth-44, 20, 44, 44)];
    shareBtnNomal.backgroundColor = [UIColor clearColor];
    [shareBtnNomal addTarget:self action:@selector(shateButton) forControlEvents:UIControlEventTouchUpInside];
    [shareBtnNomal setImage:[UIImage imageNamed:@"details_btn_share"] forState:UIControlStateNormal];
    [topImageViewNomal addSubview:shareBtnNomal];
    
    //顶部广告图
     SDCycleScrollView* cycleScrollView2 =[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, CXCWidth,560*Width) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder@2x"]];
    cycleScrollView2.backgroundColor =TextGrayGray3Color;
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor];
    cycleScrollView2.localizationImageNamesGroup =@[@"vip_banner_01",@"vip_banner_01"];
    //    cycleScrollView2.imageURLStringsGroup = imagesArray;//放上图片
    // 自定义分页控件小圆标颜色
    [bgScrollView addSubview:cycleScrollView2];
    
    UILabel *nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(24*Width, 20*Width+cycleScrollView2.bottom, 670*Width, 80*Width)];
    nameLabel.text =@"商品名称";
    nameLabel.textColor =BlackColor;
    nameLabel.font =[UIFont systemFontOfSize:14];
    [bgScrollView addSubview:nameLabel];
    
    UILabel *jifenLabel =[[UILabel alloc]initWithFrame:CGRectMake(24*Width, nameLabel.bottom+15*Width, 500*Width, 30*Width)];
    jifenLabel.text =@"最高可抵扣积分：300";
    jifenLabel.font =[UIFont  systemFontOfSize:12];
    jifenLabel.textColor =TextGrayGrayColor;
    [bgScrollView addSubview:jifenLabel];
    
    UILabel *pricesLabel =[[UILabel alloc]initWithFrame:CGRectMake(24*Width, jifenLabel.bottom+15*Width, 500*Width, 60*Width)];
    pricesLabel.text =@"¥ 300.00";
    pricesLabel.font =[UIFont  systemFontOfSize:16];
    pricesLabel.textColor =NavColor;
    [bgScrollView addSubview:pricesLabel];
    //线
    UIImageView *xian =[[UIImageView alloc]initWithFrame:CGRectMake(0, pricesLabel.bottom+10*Width, CXCWidth, 20*Width)];
    xian.backgroundColor =BGColor;
    [bgScrollView addSubview:xian];
    //数量
    UIView *numberBgview =[[UIView alloc]initWithFrame:CGRectMake(0, xian.bottom, CXCWidth, 82*Width)];
    numberBgview.backgroundColor =[UIColor whiteColor];
    [bgScrollView addSubview:numberBgview];
    
    //数量选择
    UIButton *chooseBtn =[[UIButton alloc]initWithFrame:CGRectMake(300*Width, 0,450*Width,82*Width)];
    [numberBgview addSubview:chooseBtn];
    chooseBtn.tag =10;
    [chooseBtn addTarget:self action:@selector(numberChoose) forControlEvents:UIControlEventTouchUpInside];
    //显示
    UILabel*  proLabel = [[UILabel alloc]initWithFrame:CGRectMake(32*Width, 0,200*Width , 82*Width)];
    proLabel.tag = 10101010;
    proLabel.text = @"购买数量";
    proLabel.font = [UIFont boldSystemFontOfSize:15];
    proLabel.textColor = [UIColor grayColor];
    [numberBgview addSubview:proLabel];
    //文字购买数量
    UILabel* rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(0*Width, 0,350*Width , 82*Width)];
    rightLabel.text = @"1";
    rightLabel.tag =20;
    rightLabel.textAlignment =NSTextAlignmentRight;
    rightLabel.font = [UIFont systemFontOfSize:16];
    rightLabel.textColor = BlackColor;
    [chooseBtn addSubview:rightLabel];
    //箭头
    UIImageView  *jiantou =[[UIImageView alloc]initWithFrame:CGRectMake(680*Width,23*Width,31*Width , 31*Width)];
    [numberBgview addSubview:jiantou];
    [jiantou setImage:[UIImage imageNamed:@"register_btn_nextPage"]];
    //线
    UIImageView *xian2 =[[UIImageView alloc]initWithFrame:CGRectMake(0, numberBgview.bottom+10*Width, CXCWidth, 20*Width)];
    xian2.backgroundColor =BGColor;
    [bgScrollView addSubview:xian2];
//    //下方webview
//    _webView =[[WKWebView alloc]initWithFrame:CGRectMake(0,xian2.bottom,CXCWidth , 100*Width)];
//    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];
//    _webView.backgroundColor =[UIColor whiteColor];
//    [self.view addSubview:_webView];
//    
//    _webView.UIDelegate= self;
//    _webView.navigationDelegate = self;
//    
//    _webView.scrollView.bounces = NO;
//    _webView.scrollView.showsHorizontalScrollIndicator = NO;
//    _webView.scrollView.scrollEnabled = YES;
//    
//    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://player.youku.com/embed/XNTM5MTUwNDA0"]];
//    [_webView loadRequest:request];
    
    
    
    
    
    
    
    
    
    
   
    
    

    
    //确认提交按钮
    UIButton * shopCartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shopCartBtn setFrame:CGRectMake(0*Width,CXCHeight-100*Width , 375*Width, 100*Width)];
    [shopCartBtn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:112/255.0 blue:48/255.0 alpha:1]];
    [shopCartBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [shopCartBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [shopCartBtn addTarget:self action:@selector(shopCartBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shopCartBtn];
    
    //确认提交按钮
    UIButton * buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [buyBtn setFrame:CGRectMake(375*Width,CXCHeight-100*Width , 375*Width, 100*Width)];
    [buyBtn setBackgroundColor:NavColor];
    buyBtn.layer.borderColor =[UIColor blueColor].CGColor;
    [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [buyBtn addTarget:self action:@selector(buyBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buyBtn];
   
}
- (void)numberChoose
{
    [self alterView:[@"1" integerValue] ];



}
-(void)shopCartBtnAction
{
    [MBProgressHUD showSuccess:@"此商品在购物车中+1" ToView:self.view];
    NSString*num =[NSString stringWithFormat:@"%d",1];
    NSLog(@"%@",[PublicMethod getObjectForKey:shopingCart ]);

    if (![PublicMethod getObjectForKey:shopingCart]) {

        
        NSMutableDictionary *infoDict = [[NSMutableDictionary alloc]init];
        [infoDict setValue:@"温碧泉白里透红凝润四件套(洁面乳、柔肤水、保湿霜、面膜)" forKey:@"goodsTitle"];
        [infoDict setValue:@"10.00" forKey:@"goodsPrice"];
        [infoDict setValue:[NSNumber numberWithBool:NO] forKey:@"selectState"];
        [infoDict setValue:[NSString stringWithFormat:@"%.2f",([@"10.0" floatValue] *[num floatValue])] forKey:@"goodsTotalPrice"];
        [infoDict setValue:[NSNumber numberWithInt:[num intValue]] forKey:@"goodsNum"];
        [infoDict setValue:@"1" forKey:@"goodID"];

        //封装数据模型
//        GoodsInfoModel *goodsModel = [[GoodsInfoModel alloc]initWithDict:infoDict];
//        //将数据模型放入数组中
        [inforArr addObject:infoDict];
        [[NSUserDefaults standardUserDefaults] setObject:inforArr forKey:shopingCart];
        [[NSUserDefaults standardUserDefaults] synchronize];
//        [PublicMethod setObject:inforArr key:shopingCart];
//        NSLog(@"%@",[PublicMethod getObjectForKey:shopingCart ]);
    }else
    {
        
   NSArray* inforArray = [PublicMethod getObjectForKey:shopingCart];
        [inforArr addObjectsFromArray: inforArray];

        NSMutableDictionary *infoDict = [[NSMutableDictionary alloc]init];
        [infoDict setValue:@"温碧泉白里透红凝润四件套(洁面乳、柔肤水、保湿霜、面膜)" forKey:@"goodsTitle"];
        [infoDict setValue:@"10.00" forKey:@"goodsPrice"];
        [infoDict setValue:[NSNumber numberWithBool:NO] forKey:@"selectState"];
        [infoDict setValue:[NSString stringWithFormat:@"%.2f",([@"10.0" floatValue] *[num floatValue])] forKey:@"goodsTotalPrice"];
        [infoDict setValue:[NSNumber numberWithInt:[num intValue]] forKey:@"goodsNum"];
        //封装数据模型
        //将数据模型放入数组中
        [inforArr addObject:infoDict ];
        
    }
    NSLog(@"%@",[PublicMethod getObjectForKey:shopingCart ]);


}
- (void)buyBtnAction
{
    if (![PublicMethod getDataStringKey:@"IsLogin"]) {//若没登录请登录
        LoginPage *loginPage =[[LoginPage     alloc]init];
        loginPage.status =@"present";
        [self.navigationController pushViewController:loginPage animated:YES];
        return;
    }
    HYConfirmOrderVC *confirmOrderVC =[[HYConfirmOrderVC alloc]init];
    [self.navigationController pushViewController:confirmOrderVC animated:YES];
    
}
-(void)returnBtnAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat sectionHeaderHeight;
    
    sectionHeaderHeight =560*Width;
    
        //去掉UItableview的section的headerview黏性
        if (scrollView.contentOffset.y<=sectionHeaderHeight && scrollView.contentOffset.y>=0)
        {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        }
        else if (scrollView.contentOffset.y>=sectionHeaderHeight)
        {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    NSLog(@"scrollView.contentOffset.y=%f",scrollView.contentOffset.y);
    
    //相对于图片的偏移量
    CGFloat reOffset = scrollView.contentOffset.y ;
    //    (kOriginalImageHeight - 64)这个数值决定了导航条在图片上滑时开始出现  alpha 从 0 ~ 0.99 变化
    //    当图片底部到达导航条底部时 导航条  aphla 变为1 导航条完全出现
    CGFloat alpha = reOffset /(560.0*Width-64) ;
    NSLog(@"reOffset=%f",reOffset);

//    if (alpha <= 1)//下拉永不显示导航栏
//    {
//        alpha = 0;
//    }
//    else//上划前一个导航栏的长度是渐变的
//    {
//        alpha -= 1;
//    }
    // 设置导航条的背景图片 其透明度随  alpha 值 而改变
    topImageView.alpha =alpha;
    topImageViewNomal.alpha =1-alpha;
    
    //  = [self imageWithColor:[UIColor colorWithRed:0.412 green:0.631 blue:0.933 alpha:alpha]];
    //    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}
//alterView
- (void)alterView:(NSInteger)index
{
    //若存在就不走里边的直接hidden=no;
    if (!blackBgView) {
        blackBgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, CXCHeight)];
        [blackBgView setAlpha:0.5];
        [blackBgView  setBackgroundColor:[UIColor blackColor]];
        [self.view addSubview:blackBgView];
        
        
        alterView=[[UIView alloc]initWithFrame:CGRectMake(75*Width, 200*Width, 620*Width, 360*Width)];
        [self.view addSubview:alterView];
        [alterView setBackgroundColor:[UIColor whiteColor]];
        [alterView.layer setCornerRadius:20*Width];
//        [alterView.layer setBorderWidth:1.0*Width];
//        alterView.layer.borderColor =BGColor.CGColor;
        [alterView.layer setMasksToBounds:YES];
        
        
        UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(0*Width, 0*Width, 620*Width, 120*Width)];
        label.textAlignment =NSTextAlignmentCenter;
        [label setText:@"修改拿货数量"];
        [alterView addSubview:label];
        
        //购买商品的数量
        UITextField*  _numCountLab = [[UITextField alloc]initWithFrame:CGRectMake(210*Width,label.bottom,190*Width , 90*Width)];
        _numCountLab.textAlignment = NSTextAlignmentCenter;
        _numCountLab.tag=120;
        _numCountLab.keyboardType =UIKeyboardTypeNumberPad;
        _numCountLab.layer.borderColor =BGColor.CGColor;
        [_numCountLab.layer setBorderWidth:1.0*Width];
        [alterView addSubview:_numCountLab];
        
        //减按钮
        UIButton* _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.frame = CGRectMake(120*Width, label.bottom, 90*Width, 90*Width);
        [_deleteBtn addTarget:self action:@selector(deleteBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _deleteBtn.tag = 11;
        [_deleteBtn setImage:[UIImage imageNamed:@"register_btn_reduce_modify_black"] forState:UIControlStateNormal];
        [_deleteBtn.layer setBorderWidth:1.0*Width];
        _deleteBtn.layer.borderColor =BGColor.CGColor;
        [alterView addSubview:_deleteBtn];
        _deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(15*Width, 15*Width,15*Width, 15*Width);
        
        
        //加按钮
        UIButton* _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.frame = CGRectMake(400*Width, label.bottom, 90*Width, 90*Width);
        _addBtn.imageEdgeInsets = UIEdgeInsetsMake(15*Width, 15*Width,15*Width, 15*Width);
        
        [_addBtn.layer setBorderWidth:1.0*Width];
        _addBtn.layer.borderColor =BGColor.CGColor;
        [_addBtn setImage:[UIImage imageNamed:@"register_btn_add_modify_black"] forState:UIControlStateNormal];
        
        [_addBtn addTarget:self action:@selector(addBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _addBtn.tag = 12;
        [alterView addSubview:_addBtn];
        //线
        UIImageView*xian =[[UIImageView alloc]init];
        xian.backgroundColor =BGColor;
        [alterView addSubview:xian];
        xian.frame =CGRectMake(0*Width,260*Width, 620*Width, 1*Width);
        //取消按钮
        UIButton*cancelBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, xian.bottom, 310*Width, 100*Width)];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:BlackColor forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelBtn) forControlEvents:UIControlEventTouchUpInside];
        [alterView addSubview:cancelBtn];
        //确认按钮
        UIButton*tureBtn =[[UIButton alloc]initWithFrame:CGRectMake(310*Width, xian.bottom, 310*Width, 100*Width)];
        [tureBtn setBackgroundColor:NavColor];
        [tureBtn setTitle:@"确认" forState:UIControlStateNormal];
        [tureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [tureBtn addTarget:self action:@selector(tureBtn) forControlEvents:UIControlEventTouchUpInside];
        [alterView addSubview:tureBtn];
    }
    
    UITextField *textF =[self.view viewWithTag:120];
    [textF becomeFirstResponder];//收起键盘
    UILabel *numberLabel =[self.view viewWithTag:20];
    textF.text =[NSString stringWithFormat:@"%@",numberLabel.text];//取得数量
    
    blackBgView.hidden=NO;
    alterView.hidden =NO;
    
}
//-
- (void)deleteBtnAction
{
    UITextField *textF =[self.view viewWithTag:120];
    if(textF.text.length==0||[textF.text isEqualToString:@"0"])
    {
        return;
        
    }else
    {
        textF.text =[NSString stringWithFormat:@"%ld",([textF.text integerValue]-1)];
        
        
    }
    
    
}
//+
- (void)addBtnAction
{
    UITextField *textF =[self.view viewWithTag:120];
    textF.text =[NSString stringWithFormat:@"%ld",([textF.text integerValue]+1)];
    
    
}
//确认
- (void)tureBtn
{
    
    blackBgView.hidden=YES;
    
    alterView.hidden =YES;
    
    
    UITextField *textF =[self.view viewWithTag:120];
    [textF resignFirstResponder];
    UILabel *numberLabel =[self.view viewWithTag:20];
    numberLabel.text =textF.text;
}
//取消
-(void)cancelBtn
{
    UITextField *textF =[self.view viewWithTag:120];
    [textF resignFirstResponder];
    
    blackBgView.hidden=YES;
    
    alterView.hidden =YES;
    
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
