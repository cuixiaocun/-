//
//  HouseDetailVC.m
//  家装
//
//  Created by Admin on 2017/9/11.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "HouseDetailVC.h"
#import "TagsModel.h"
@interface HouseDetailVC ()
{
    UIScrollView *bgScrollView;//最底下的背景
    UIView *topView;//上边
    UIView * bottomView;//下边
}
@end

@implementation HouseDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
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
    [navTitle setText:@"楼盘详情"];
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

    //底部scrollview
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, Frame_NavAndStatus, CXCWidth, CXCHeight)];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:bgScrollView];
    bgScrollView.backgroundColor =BGColor   ;
    
    topView =[[UIView alloc]initWithFrame:CGRectMake(0, 20*Width, CXCWidth,530*Width )];
    [bgScrollView addSubview:topView];
    topView.backgroundColor =[UIColor whiteColor];
    UILabel *promLabel =[[UILabel alloc]initWithFrame:CGRectMake(24*Width, 0, 700*Width, 80*Width)];
    [promLabel setText:@"基本信息"];
    promLabel.textColor =BlackColor;
    [promLabel setFont:[UIFont systemFontOfSize:15]];
    [topView addSubview:promLabel];
    
    UIImageView *xian =[[UIImageView alloc]initWithFrame:CGRectMake(0, promLabel.bottom, CXCWidth, 1.5*Width)];
    [topView addSubview:xian];
    xian.backgroundColor =BGColor;
    
    for (int i=0; i<6; i++) {
        //文字
        if (i<5) {
            UILabel *botLabel =[[UILabel alloc]initWithFrame:CGRectMake(24*Width,30*Width+i*65*Width+xian.bottom,CXCWidth,65*Width)];
            botLabel.font =[UIFont systemFontOfSize:14];
            botLabel.textColor =BlackColor;
            if (i==0) {
                _priceLabel =botLabel;
                
                _priceLabel.text =[NSString stringWithFormat:@"价格：%@", IsNilString([_detailDic objectForKey:@"price"])?@"":[_detailDic objectForKey:@"price"]];
            }else if (i==1) {
                _pianquLabel =botLabel;
            
                _pianquLabel.text =[NSString stringWithFormat:@"所属商圈：%@", IsNilString([_detailDic objectForKey:@""])?@"":[_detailDic objectForKey:@""]];
            }
            else if (i==2) {
                _addressLabel =botLabel;
                _addressLabel.text =[NSString stringWithFormat:@"地址：%@", IsNilString([_detailDic objectForKey:@"addr"])?@"":[_detailDic objectForKey:@"addr"]];
            }else if (i==3) {
                _begainSellLabel =botLabel;
                _begainSellLabel.text =[NSString stringWithFormat:@"开盘：%@", IsNilString([_detailDic objectForKey:@"kp_date"])?@"":[_detailDic objectForKey:@"kp_date"]];
            }else if (i==4) {
                _kfsLabel =botLabel;
                _kfsLabel.text =@"开发商：潍坊歌尔职业有限公司";
            }
            [topView addSubview:botLabel];
            
        }else
        {
            _tagLabel =[SDLabTagsView sdLabTagsViewWithTagsArr:self.dataArr];
            _tagLabel.frame =CGRectMake(24*Width, _kfsLabel.bottom, 460*Width, (_tagLabel.rowNumber+1)*40*Width);
            [topView addSubview:_tagLabel];
            
            
        }
        
        
    }

    
    bottomView  =[[UIView alloc]initWithFrame:CGRectMake(0, topView.bottom+ 20*Width, CXCWidth,530*Width )];
    [bgScrollView addSubview:bottomView];
    bottomView.backgroundColor =[UIColor whiteColor];

    UILabel *promtwoLabel =[[UILabel alloc]initWithFrame:CGRectMake(24*Width, 0, 700*Width, 80*Width)];
    [promtwoLabel setText:@"项目简介"];
    promtwoLabel.textColor =BlackColor;
    [promtwoLabel setFont:[UIFont systemFontOfSize:15]];
    promtwoLabel.backgroundColor =[UIColor whiteColor];
    [bottomView addSubview:promtwoLabel];
    UIImageView *xiantwo =[[UIImageView alloc]initWithFrame:CGRectMake(0, promtwoLabel.bottom, CXCWidth, 1.5*Width)];
    [bottomView addSubview:xiantwo];
    xiantwo.backgroundColor =BGColor;
    

    UILabel *botLabel =[[UILabel alloc]initWithFrame:CGRectMake(24*Width,30*Width+xiantwo.bottom,700*Width,300*Width)];
    botLabel.font =[UIFont systemFontOfSize:14];
    botLabel.textColor =BlackColor;
    botLabel.numberOfLines = 0;
     NSString *str =[NSString stringWithFormat:@"%@", IsNilString([_detailDic objectForKey:@"content"])?@"":[_detailDic objectForKey:@"content"]];
    botLabel.text = str;
    [bottomView addSubview:botLabel];
    _introduceLabel =botLabel;
    CGSize titleSize;//通过文本得到高度
   
    titleSize = [str boundingRectWithSize:CGSizeMake(680*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;

    bottomView.frame =CGRectMake(0, topView.bottom+20*Width,CXCWidth, 81.5*Width+titleSize.height+60*Width+0*Width);
    _introduceLabel.frame =CGRectMake(24*Width, 81.5*Width+30*Width,700*Width ,titleSize.height );
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, bottomView.bottom+90*Width)];
    

}
- (void)returnBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSMutableArray *)dataArr{
    {
        if (!_dataArr){
            NSArray *dataArr =@[@{@"color":@"eb3027",@"title":@"住宅"},@{@"color":@"22b6ff",@"title":@"五证齐全"},@{@"color":@"51b20a",@"title":@"车位充足"},@{@"color":@"eb3027",@"title":@"创意地产"}];
            NSMutableArray *tempArr =[NSMutableArray array];
            for (NSDictionary *dict in dataArr){
                TagsModel *model =[[TagsModel alloc]initWithTagsDict:dict];
                [tempArr addObject:model];
            }
            _dataArr =[tempArr copy];
        }
        return _dataArr;
    }
    
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
