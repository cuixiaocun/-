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
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, 64)];
    topImageView.userInteractionEnabled = YES;
    topImageView.backgroundColor = NavColorWhite;
    [self.view addSubview:topImageView];
    //添加返回按钮
    UIButton *  returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame = CGRectMake(0, 20, 44, 44);
    [returnBtn setImage:[UIImage imageNamed:navBackarrow] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:returnBtn];
    //注册标签
    UILabel *navTitle =[[UILabel alloc] initWithFrame:CGRectMake(100*Width, 20, 550*Width, 44)];
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
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, CXCWidth, CXCHeight)];
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
                _priceLabel.text =@"价格：12000元/㎡";
            }else if (i==1) {
                _addressLabel =botLabel;
                _addressLabel.text =@"所属商圈：高新城市广场";
            }
            else if (i==2) {
                _addressLabel =botLabel;
                _addressLabel.text =@"地区：高新区健康街与淮安路交汇处东南300米";
            }else if (i==3) {
                _begainSellLabel =botLabel;
                _begainSellLabel.text =@"开盘：2017年09月07日28号楼加推";
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
     NSString *str =@"歌尔绿城位于健康街与潍安路交汇处东南300米，位于浞河景观区内，四周被1500亩浞河公园紧紧环抱。歌尔绿城新品即将加推，详情咨询歌尔绿城生活馆。歌尔绿城位于健康街与潍安路交汇处东南300米，位于浞河景观区内，四周被1500亩浞河公园紧紧环抱。歌尔绿城新品即将加推，详情咨询歌尔绿城生活馆。歌尔绿城位于健康街与潍安路交汇处东南300米，位于浞河景观区内，四周被1500亩浞河公园紧紧环抱。歌尔绿城新品即将加推，详情咨询歌尔绿城生活馆。";
    botLabel.text = str;
    [bottomView addSubview:botLabel];
    _introduceLabel =botLabel;
    CGSize titleSize;//通过文本得到高度
   
    titleSize = [str boundingRectWithSize:CGSizeMake(700*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;

    bottomView.frame =CGRectMake(0, topView.bottom+20*Width,CXCWidth, 81.5*Width+titleSize.height+60*Width);
    _introduceLabel.frame =CGRectMake(24*Width, 81.5*Width+30*Width,700*Width ,titleSize.height );
    
    
    
    
    
    
    
    
    
    


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
