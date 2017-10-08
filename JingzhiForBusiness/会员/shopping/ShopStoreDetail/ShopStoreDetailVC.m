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


}
@end

@implementation ShopStoreDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:BGColor];
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
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_phoneImageV.right+24*Width,_phoneImageV.top, 460*Width, 60*Width)];
    _nameLabel.text = @"北京凯虹装饰";
    _nameLabel.textColor=[UIColor blackColor];
    _nameLabel.numberOfLines =0;
    _nameLabel.font =[UIFont systemFontOfSize:14];
    _nameLabel.backgroundColor = [UIColor clearColor];
    [bgScrollView addSubview:_nameLabel];
    NSArray *arr =@[@"电话:1000-10000000",@"入驻时间:2009-09-02"];
    for(int i=0;i<2;i++)
    {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(_phoneImageV.right+24*Width,_nameLabel.bottom+i*60*Width, 400*Width, 60*Width)];
        label.text = [NSString stringWithFormat:@"%@",arr[i]];
        label.textColor=TextColor;
        label.numberOfLines =0;
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
            
            img.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"mall_icon_xinyu"]];
            [bgScrollView addSubview:img];
            
            
        }else if(i==1)
        {
            label.frame =CGRectMake(350*Width, xian.bottom, 200*Width, 90*Width);
            
        }else
        {
            label.frame =CGRectMake(550*Width, xian.bottom, 200*Width, 90*Width);
            
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
        
    UIView *introduceView =[[UIView alloc]initWithFrame:CGRectMake(0, xianV.bottom, CXCWidth, 800*Width)];
    [introduceView setBackgroundColor:[UIColor whiteColor]];
    [bgScrollView addSubview:introduceView];
    for (int i=0; i<7; i++) {
        UILabel* proLabel = [[UILabel alloc]init];
        proLabel.numberOfLines =0;
        proLabel.textColor = TextColor;
        proLabel.font = [UIFont systemFontOfSize:14];
        [introduceView addSubview:proLabel];
        if (i==0) {
            
            NSString *titleContent =@"商家名称：山东桥通天下网络科技有限公司.";
            CGSize titleSize;//通过文本得到高度
            titleSize = [titleContent boundingRectWithSize:CGSizeMake(680*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
            proLabel.text = titleContent;
            proLabel.frame =CGRectMake(24*Width ,30*Width, 690*Width,titleSize.height);
            _nameLabel =proLabel;
            
            
        }else if (i==1)
        {
            proLabel.text = @"联系人:张勇";
            proLabel.frame =CGRectMake(24*Width ,_nameLabel.bottom, 690*Width,70*Width);
            _peopleLabel =proLabel;
            
        }else if (i==2)
        {
            proLabel.text = @"联系方式：18363671733";
            proLabel.frame =CGRectMake(24*Width ,_peopleLabel.bottom, 690*Width,70*Width);
            _phoneLabel =proLabel;
            
        }
        else if (i==3)
        {
            proLabel.text = @"主营行业：基础建筑";
            proLabel.frame =CGRectMake(24*Width ,_phoneLabel.bottom, 690*Width,70*Width);
            _companyLabel =proLabel;
            
        }
        else if (i==4)
        {
            NSString *ideaContent =@"所在地点：山东省潍坊市寒亭区胜利街与新华路西南角战天下潍坊国际2203号";
            CGSize ideaSize;//通过文本得到高度
            ideaSize = [ideaContent boundingRectWithSize:CGSizeMake(680*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
            proLabel .numberOfLines =0;
            proLabel.text = ideaContent ;
            proLabel.frame =CGRectMake(24*Width ,_companyLabel.bottom, 690*Width,ideaSize.height);
            _addressLabel =proLabel;
            
        }else if (i==5)
        {
            NSString *ideaContent =@"交通：乘坐230路或者109路到利街与新华路西南角战天下潍坊国际2203号";
            CGSize ideaSize;//通过文本得到高度
            ideaSize = [ideaContent boundingRectWithSize:CGSizeMake(680*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
            proLabel .numberOfLines =0;
            proLabel.text = ideaContent ;
            proLabel.frame =CGRectMake(24*Width ,_addressLabel.bottom, 690*Width,ideaSize.height);
            _jtLabel =proLabel;
            
        }else
        {
        
            NSString *ideaContent =@"简介：浙江百慕生物科技有限公司隶属浙江丽珀集团，成立于2011年3月，注册资本1000万元，是一家从事海洋生物开发销售的公司，主要从事保健品（海参）产品的销售。 旗下的优参堂海参品牌源自于卢炜翎先生创立的优参号参堂，经过一百多年的发展，现已成为最具规模化，现代化，专业化的海参加工生产企业之一。 公司特与世纪联华超市股份有限公司、物美商业集团股份有限公司、天天好大药房等合作，在浙江省多个城市100多家门店进行销售。此外公司还搭档杭州电视台生活频道《生活大参考》、杭州电视台生活频道电商平台共同进行优参堂海参的销售，致力于将品牌以更多样化的形式进行推广，将产品以更方便快捷的渠道送达到消费者手中。";
            CGSize ideaSize;//通过文本得到高度
            ideaSize = [ideaContent boundingRectWithSize:CGSizeMake(680*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
            proLabel .numberOfLines =0;
            proLabel.text = ideaContent ;
            proLabel.frame =CGRectMake(24*Width ,_jtLabel.bottom, 690*Width,ideaSize.height);
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
