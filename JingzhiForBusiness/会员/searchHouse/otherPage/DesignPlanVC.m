//
//  DesignPlanVC.m
//  家装
//
//  Created by Admin on 2017/9/11.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "DesignPlanVC.h"
#import "OtherPhotoCell.h"
@interface DesignPlanVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    UIScrollView *bgScrollView;//最底下的背景
    UIView*topView;
    NSArray *inforArr;
    

}
@end

@implementation DesignPlanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:BGColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    inforArr =[[NSArray alloc]init];
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
    [navTitle setText:@"设计方案"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor blackColor]];
    [self.view addSubview:navTitle];
    
    //底部scrollview
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, Frame_NavAndStatus, CXCWidth, CXCHeight-Frame_NavAndStatus)];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:bgScrollView];

    topView=[[UIView alloc]init];
    topView.frame =CGRectMake(0, 20*Width, CXCWidth, 240*Width);
    topView.backgroundColor =[UIColor whiteColor];
    [bgScrollView addSubview:topView];
    
    for (int i=0; i<3; i++) {
        //文字
        UILabel *botLabel =[[UILabel alloc]initWithFrame:CGRectMake(24*Width,30*Width+i*65*Width,CXCWidth,65*Width)];
        botLabel.font =[UIFont systemFontOfSize:13];
        botLabel.textColor =BlackColor;
        if (i==0) {
            _nameLabel =botLabel;
//            _nameLabel.text =@"小区及设计风格：潍坊歌尔职业米";
        }else if (i==1) {
            _planerLabel =botLabel;
//            _planerLabel.text =@"方案提供者：达美科技";
        }else
        {
            _numberLabel =botLabel;
//            _numberLabel.text =@"预览人数：1000人";
        
        }
        [topView addSubview:botLabel];
    }

    tableview  =[[UITableView alloc]initWithFrame:CGRectMake(0,topView.bottom, CXCWidth, 0)style:UITableViewStyleGrouped];
    [tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    tableview .showsVerticalScrollIndicator = NO;
    [tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableview setDelegate:self];
    [tableview setDataSource:self];
    tableview.scrollEnabled = NO;
    [tableview setBackgroundColor:[UIColor clearColor]];
    tableview .showsVerticalScrollIndicator = NO;
    [bgScrollView addSubview:tableview];
    //底部
    UIView *bottomBgview =[[UIView alloc]initWithFrame:CGRectMake(0, CXCHeight-100*Width, CXCWidth, 100*Width)];
    [bottomBgview setBackgroundColor:[UIColor colorWithRed:59/255.00 green:63/255.00 blue:80/255.00 alpha:1]];
    [self.view addSubview:bottomBgview];
    
    UILabel *subPromLabel =[[UILabel alloc]initWithFrame:CGRectMake(50*Width, 0, 500*Width, 100*Width)];
    [subPromLabel setText:@"喜欢这个风格？找TA设计"];
    [subPromLabel  setFont:[UIFont systemFontOfSize:16]];
    [bottomBgview  addSubview:subPromLabel];
    [subPromLabel  setTextColor:[UIColor whiteColor]];
    UIButton * confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setFrame:CGRectMake(540*Width,20*Width , 170*Width, 60*Width)];
    [confirmBtn setBackgroundColor:orangeColor];
    confirmBtn.layer.cornerRadius =30*Width;
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [confirmBtn setTitle:@"免费设计" forState:UIControlStateNormal];
    [confirmBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [confirmBtn addTarget:self action:@selector(searchSheji) forControlEvents:UIControlEventTouchUpInside];
    [bottomBgview addSubview:confirmBtn];
    [self getInforSJAL];
}
- (void)getInforSJAL
{
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{@"case_id":[NSString stringWithFormat:@"%@",_searchId],
                          }];
    
    [PublicMethod AFNetworkPOSTurl:@"mobileapi/?soufang-shefan.html" paraments:dic1 addView:self.view addNavgationController:self.navigationController    success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"error"]]isEqualToString:@"0"]) {
            NSDictionary *tgDic =[[dict objectForKey:@"data"] objectForKey:@"tigong"];

            NSDictionary *detailDic =[[dict objectForKey:@"data"] objectForKey:@"tigong"];
            _nameLabel.text =[NSString stringWithFormat:@"小区及设计风格：%@",IsNilString([detailDic objectForKey:@"title"])?@"":[detailDic objectForKey:@"title"]];
            _planerLabel.text =[NSString stringWithFormat:@"方案提供者：%@人",IsNilString([tgDic objectForKey:@"name"])?@"":[tgDic objectForKey:@"name"]];
            _numberLabel.text =[NSString stringWithFormat:@"预览人数：%@人",IsNilString([detailDic objectForKey:@"views"])?@"":[detailDic objectForKey:@"views"]];
            
            inforArr  = [[dict objectForKey:@"data"] objectForKey:@"sjimg"];
            if ([inforArr isEqual:[NSNull null]]) {
                inforArr =[[NSArray alloc]init];
                inforArr =[[dict objectForKey:@"data"] objectForKey:@"sjimg"];
                
            }
            [tableview reloadData ];
            tableview.height =560*Width*inforArr.count+200*Width;
            [bgScrollView setContentSize:CGSizeMake(CXCWidth,tableview.bottom)];

        }
        
    } fail:^(NSError *error) {
        
    }];
    
    
    
}
- (void)searchSheji
{

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)returnBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 100*Width;
        
    }else
    {
        return 100*Width;
        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 0*Width;
        
    }else
    {
        return 0*Width;
        
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
    {
        return inforArr.count;
        
    }else
        
        return 4;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 560*Width;
        
    }else
    {
        return 560*Width;
        
    }

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *CellIdentifier = @"CellWithNumber";
        OtherPhotoCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[OtherPhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier ];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
        }
    
        NSDictionary *dict = [inforArr objectAtIndex:[indexPath row]];
        [cell setDic:dict];
        return cell;
        
   
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *bgview =[[UIView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, 100*Width)];
    UILabel *xianV =[[UILabel alloc]initWithFrame:CGRectMake(0*Width,0,CXCWidth,80*Width)];
    xianV.backgroundColor =BGColor;
    [bgview addSubview:xianV];
    //下边文字
    UILabel *botLabel =[[UILabel alloc]initWithFrame:CGRectMake(0*Width,20*Width,CXCWidth,80*Width)];
    botLabel.font =[UIFont systemFontOfSize:16];
    botLabel.textColor =BlackColor;
    botLabel.backgroundColor =[UIColor whiteColor];
    if (section ==0) {
        botLabel.text =[NSString stringWithFormat:@"%@",@"    设计图"];
    }else if(section ==1) {
        botLabel.text =[NSString stringWithFormat:@"%@",@"    设计图"];
        
    }
    [bgview  addSubview:botLabel];
    return bgview;
}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    
//    UIButton *addressBtn =[[UIButton alloc]initWithFrame:CGRectMake(0*Width,0,CXCWidth , 80*Width)];
//    if(section ==0)
//    {
//        [addressBtn addTarget:self action:@selector(moreTJ) forControlEvents:UIControlEventTouchUpInside];
//        
//    }else
//    {
//        [addressBtn addTarget:self action:@selector(moreTS) forControlEvents:UIControlEventTouchUpInside];
//        
//    }
//    
//    UILabel *addLabel = [[UILabel alloc] init];
//    [addLabel setText:@"查看更多 >"];
//    addLabel.tag =30;
//    addLabel.textColor =BlackColor;
//    addLabel.textAlignment =NSTextAlignmentCenter;
//    [addLabel setFont:[UIFont systemFontOfSize:14]];
//    [addLabel setFrame:CGRectMake(0*Width,1.5*Width,CXCWidth , 78.5*Width)];
//    addLabel.backgroundColor =[UIColor whiteColor];
//    [addressBtn addSubview:addLabel];
//    [addressBtn setBackgroundColor:[UIColor whiteColor]];
//    UIImageView *addShowImgV =[[UIImageView alloc]initWithFrame:CGRectMake(30*Width, 0*Width, 690*Width, 1.5*Width)];
//    addressBtn.backgroundColor =BGColor;
//    [addressBtn addSubview:addShowImgV];
//    return addressBtn;
//}
- (void)moreTJ
{
    NSLog(@"111");
}
- (void)moreTS
{
    NSLog(@"222");
    
}
- (void)examinePass:(UIButton*)btn
{
    
    
}
- (void)chooseAddress
{
    
    
}
- (void)changeStatuBtn:(UIButton *)btn
{
    for (int i=0; i<5; i++) {
        UIButton *statuBtn =[self.view viewWithTag:220+i];
        statuBtn.selected=NO;
    }
    btn.selected =YES;
    
    
    
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
