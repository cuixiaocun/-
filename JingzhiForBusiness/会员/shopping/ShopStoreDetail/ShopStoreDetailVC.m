//
//  ShopStoreDetailVC.m
//  家装
//
//  Created by Admin on 2017/9/23.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "ShopStoreDetailVC.h"

@interface ShopStoreDetailVC ()
{
    UIScrollView *bgScrollView;//
    UIView *topview ;
    NSDictionary *detailDic;
    UIView *introduceView ;
    


}
@end

@implementation ShopStoreDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:BGColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    detailDic =[[NSDictionary alloc]init];
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
    [navTitle setText:@"商铺"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor blackColor]];
    [self.view addSubview:navTitle];
    //横线
    UIImageView*xian =[[UIImageView alloc]init];
    xian.backgroundColor =BGColor;
    [topImageView addSubview:xian];
    xian.frame =CGRectMake(0,Frame_NavAndStatus-1, CXCWidth, 1);
    [self getInfor];
    [self mainView];
}
- (void)mainView
{
    //底部scrollview
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, Frame_NavAndStatus, CXCWidth, CXCHeight-Frame_NavAndStatus)];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:bgScrollView];
    
    topview =[[UIView alloc]initWithFrame:CGRectMake(0, 0,CXCWidth , 330*Width)];
    topview.backgroundColor = [UIColor whiteColor];
    [bgScrollView addSubview:topview];
    //图片
    _phoneImageV =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timg.png"]];
    _phoneImageV.backgroundColor =BGColor;
    _phoneImageV.frame=CGRectMake(24*Width, 30*Width, 190*Width, 190*Width);
    [bgScrollView addSubview:_phoneImageV];
    //名称
    _nameLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(_phoneImageV.right+24*Width,_phoneImageV.top, 460*Width, 60*Width)];
    _nameLabel1.text = @"";
    _nameLabel1.textColor=[UIColor blackColor];
    _nameLabel1.numberOfLines =0;
    _nameLabel1.font =[UIFont systemFontOfSize:14];
    _nameLabel1.backgroundColor = [UIColor clearColor];
    [bgScrollView addSubview:_nameLabel1];
    NSArray *arr =@[@"电话:1000-10000000",@"入驻时间:2009-09-02"];
    for(int i=0;i<2;i++)
    {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(_phoneImageV.right+24*Width,_nameLabel1.bottom+i*60*Width, 400*Width, 60*Width)];
        label.text = [NSString stringWithFormat:@"%@",arr[i]];
        label.textColor=TextColor;
        label.numberOfLines =0;
        label.tag=4800+i;
        label.font =[UIFont systemFontOfSize:13];
        label.backgroundColor = [UIColor clearColor];
        [bgScrollView addSubview:label];
        
    }
    //横线
    UIImageView*xian =[[UIImageView alloc]init];
    xian.backgroundColor =BGColor;
    [bgScrollView addSubview:xian];
    xian.frame =CGRectMake(0,_phoneImageV.bottom+28.5*Width, CXCWidth, 1.5*Width);
    
    NSArray *arr2 =@[@"信誉:",@"口碑:09",@"关注:20"];
    for(int i=0;i<3;i++)
    {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(187.5*i*Width,xian.bottom, 187.5*Width, 90*Width)];
        if (i==0) {
            label.frame =CGRectMake(20*Width, xian.bottom,80*Width, 90*Width);
            UIImage *heartImg =[UIImage imageNamed:@"mall_icon_xinyu"];
            
            UIImageView *img =[[UIImageView alloc]initWithFrame:CGRectMake(label.right,xian.bottom+(90*Width-heartImg.size.height-2)/2,heartImg.size.width*3 , heartImg.size.height-1)];
            img.tag =1200;
            img.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mall_icon_xinyu"]];
            [bgScrollView addSubview:img];
            
            
        }else if(i==1)
        {
            label.frame =CGRectMake(350*Width, xian.bottom, 200*Width, 90*Width);
            label.tag =190;

        }else
        {
            label.frame =CGRectMake(550*Width, xian.bottom, 200*Width, 90*Width);
            label.tag =191;

        }
        label.text = [NSString stringWithFormat:@"%@",arr2[i]];
        label.textColor=TextGrayColor;
        label.numberOfLines =0;
        
        label.font =[UIFont systemFontOfSize:13];
        label.backgroundColor = [UIColor clearColor];
        [bgScrollView addSubview:label];
        
    }
    
    UILabel *xianV =[[UILabel alloc]initWithFrame:CGRectMake(0*Width,xian.bottom+90*Width,CXCWidth,100*Width)];
    xianV.backgroundColor =BGColor;
    [bgScrollView addSubview:xianV];
    //下边文字
    UILabel *botLabel =[[UILabel alloc]initWithFrame:CGRectMake(0*Width,xian.bottom+90*Width,CXCWidth,78*Width)];
    botLabel.font =[UIFont systemFontOfSize:16];
    botLabel.textColor =BlackColor;
    botLabel.backgroundColor =[UIColor whiteColor];
    botLabel.text =[NSString stringWithFormat:@"%@",@"    商家介绍"];
    [bgScrollView addSubview:botLabel];
        
    introduceView =[[UIView alloc]initWithFrame:CGRectMake(0, xianV.bottom, CXCWidth, 800*Width)];
    [introduceView setBackgroundColor:[UIColor whiteColor]];
    [bgScrollView addSubview:introduceView];
    for (int i=0; i<7; i++) {
        UILabel* proLabel = [[UILabel alloc]init];
        proLabel.numberOfLines =0;
        proLabel.textColor = TextColor;
        proLabel.font = [UIFont systemFontOfSize:14];
        [introduceView addSubview:proLabel];
        if (i==0) {
            
           
            _nameLabel =proLabel;
            
            
        }else if (i==1)
        {
            _peopleLabel =proLabel;
            
        }else if (i==2)
        {
            _phoneLabel =proLabel;
        }
        else if (i==3)
        {
            _companyLabel =proLabel;
        }
        else if (i==4)
        {
            _addressLabel =proLabel;
            
        }else if (i==5)
        {
            _jtLabel =proLabel;
            
        }else
        {
            _jianjieLabel =proLabel;
        }
    }
    introduceView.frame =CGRectMake(0, xianV.bottom, CXCWidth, _jianjieLabel.bottom);
    [bgScrollView setContentSize:CGSizeMake(CXCWidth,introduceView.bottom)];
    
}
- (void)returnBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)getInfor{
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{
                          @"shop_id":[NSString stringWithFormat:@"%@",_shopId],
                          }];
    
    [PublicMethod AFNetworkPOSTurl:@"mobileapi/?shop-index.html" paraments:dic1  addView:self.view addNavgationController:self.navigationController success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
                if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"error"]]isEqualToString:@"0"]) {
                   
                    detailDic =[[dict objectForKey:@"data"] objectForKey:@"shop"];
                    [_phoneImageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,[detailDic objectForKey:@"thumb"]]]];
                    
                    _nameLabel1.text =[detailDic  objectForKey:@"title"];
                    
                    UILabel *gzLabel =[self.view viewWithTag:4800];
                    gzLabel.text =[NSString stringWithFormat:@"电话:%@", IsNilString([detailDic  objectForKey:@"phone"])?@"":[detailDic objectForKey:@"phone"]];
                    UILabel *yysLabel =[self.view viewWithTag:4801];
                    
                    yysLabel.text =[NSString stringWithFormat:@"入驻时间:%@",[PublicMethod timeWithTimeIntervalString:[detailDic objectForKey:@"dateline"]]];
                    
                    
                    UIImageView *img =[self.view viewWithTag:1200];
                    UIImage *heartImg =[UIImage imageNamed:@"mall_icon_xinyu"];
                    NSString *score =[NSString stringWithFormat:@"%@",[detailDic  objectForKey:@"audit"]];
                    img.frame =CGRectMake(100*Width,_phoneImageV.bottom+30*Width+(90*Width-heartImg.size.height-2)/2,heartImg.size.width*[score integerValue], heartImg.size.height-1);
                    
                    UILabel *sjLabel =[self.view viewWithTag:190];
                    sjLabel.text =[NSString stringWithFormat:@"口碑:%@",[detailDic  objectForKey:@"avg_score"]];
                    
                    UILabel *fwLabel =[self.view viewWithTag:191];
                    fwLabel.text =[NSString stringWithFormat:@"关注:%@", [detailDic  objectForKey:@"views"] ];
                    
                    NSString *titleContent =[NSString stringWithFormat:@"商家名称：%@",[detailDic  objectForKey:@"title"]];
                    CGSize titleSize;//通过文本得到高度
                    titleSize = [titleContent boundingRectWithSize:CGSizeMake(680*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
                    _nameLabel.text = titleContent;
                    _nameLabel.frame =CGRectMake(24*Width ,30*Width, 690*Width,titleSize.height);
//                    _peopleLabel.text = [NSString stringWithFormat:@"联系人:%@",[detailDic  objectForKey:@""]];
                    _peopleLabel.text = [NSString stringWithFormat:@"联系人:%@",@""];

                    _peopleLabel.frame =CGRectMake(24*Width ,_nameLabel.bottom, 690*Width,70*Width);
                    _phoneLabel.text = [NSString stringWithFormat:@"联系方式：%@",[detailDic  objectForKey:@"phone"]];
                    _phoneLabel.frame =CGRectMake(24*Width ,_peopleLabel.bottom, 690*Width,70*Width);
                    _companyLabel.text =[NSString stringWithFormat:@"主营行业：%@",[detailDic  objectForKey:@"cat_title"]];
                    _companyLabel.frame =CGRectMake(24*Width ,_phoneLabel.bottom, 690*Width,70*Width);
                    NSString *ideaContent =[NSString stringWithFormat:@"所在地点：%@",[detailDic  objectForKey:@"addr"]];
                    CGSize ideaSize;//通过文本得到高度
                    ideaSize = [ideaContent boundingRectWithSize:CGSizeMake(680*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
                    _addressLabel .numberOfLines =0;
                    _addressLabel.text = ideaContent ;
                    _addressLabel.frame =CGRectMake(24*Width ,_companyLabel.bottom, 690*Width,ideaSize.height);

                    NSString *ideaContent2 =[NSString stringWithFormat:@"交通：%@",[detailDic  objectForKey:@"addr"]];
                    CGSize ideaSize2;//通过文本得到高度
                    ideaSize2 = [ideaContent2 boundingRectWithSize:CGSizeMake(680*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
                    _jtLabel .numberOfLines =0;
                    _jtLabel.text = ideaContent2 ;
                    _jtLabel.frame =CGRectMake(24*Width ,_addressLabel.bottom, 690*Width,ideaSize2.height);
                    
                    NSString *ideaContent3 =[NSString stringWithFormat:@"简介：%@",[detailDic  objectForKey:@"info"]];
                    CGSize ideaSize3;//通过文本得到高度
                    ideaSize3 = [ideaContent3 boundingRectWithSize:CGSizeMake(680*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
                    _jianjieLabel .numberOfLines =0;
                    _jianjieLabel.text = ideaContent3 ;
                    _jianjieLabel.frame =CGRectMake(24*Width ,_jtLabel.bottom, 690*Width,ideaSize3.height);
                    introduceView.frame =CGRectMake(0, _phoneImageV.bottom+110*Width, CXCWidth, _jianjieLabel.bottom);
                    [bgScrollView setContentSize:CGSizeMake(CXCWidth,introduceView.bottom)];
                }
        
    } fail:^(NSError *error) {
        
    }];
    
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
