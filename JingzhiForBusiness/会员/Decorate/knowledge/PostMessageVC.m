//
//  PostMessageVC.m
//  家装
//
//  Created by Admin on 2017/9/20.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "PostMessageVC.h"
#import "PostHeaderCell.h"
#import "PostTalkCell.h"
#import "KnowledgeCell.h"
#import "EditCommentVC.h"
@interface PostMessageVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    UIScrollView *bgScrollView;//最底下的背景
    NSMutableArray *inforArrPL;//评论
    NSDictionary *detailDic;//详情
    NSMutableArray *inforArrWZ;//文章

}

@end

@implementation PostMessageVC
-(void)viewWillAppear:(BOOL)animated
{
}
- (void)viewDidLoad {
    [super viewDidLoad];
    inforArrPL =[[NSMutableArray alloc]init];
    inforArrWZ =[[NSMutableArray alloc]init];
    detailDic =[[NSDictionary alloc]init];

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
    [navTitle setText:@"帖子详情"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor blackColor]];
    [self.view addSubview:navTitle];
    
    
    [self mainView];
    [self getBestRecommend];
    [self getWZ];
}
- (void)rightBtnAction
{
    
}
-(void)returnBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)mainView
{
    
    //底部scrollview
//    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, Frame_NavAndStatus, CXCWidth, CXCHeight-Frame_NavAndStatus)];
//    [bgScrollView setUserInteractionEnabled:YES];
//    [bgScrollView setShowsVerticalScrollIndicator:NO];
//    [self.view addSubview:bgScrollView];
    tableview  =[[UITableView alloc]initWithFrame:CGRectMake(0,Frame_NavAndStatus, CXCWidth, CXCHeight-Frame_NavAndStatus-85*Width)style:UITableViewStyleGrouped];
//    [tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    tableview .showsVerticalScrollIndicator = NO;
//    [tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [tableview setDelegate:self];
    [tableview setDataSource:self];
//    tableview.scrollEnabled = NO;
    [tableview setBackgroundColor:[UIColor clearColor]];
    tableview .showsVerticalScrollIndicator = NO;
    [self.view addSubview:tableview];
    
    //底部
    UIView *bottomBgview =[[UIView alloc]initWithFrame:CGRectMake(0, CXCHeight-100*Width, CXCWidth, 100*Width)];
    [bottomBgview setBackgroundColor:[UIColor colorWithRed:59/255.00 green:63/255.00 blue:80/255.00 alpha:1]];
    [self.view addSubview:bottomBgview];
    
    UILabel *subPromLabel =[[UILabel alloc]initWithFrame:CGRectMake(50*Width, 0, 500*Width, 100*Width)];
    [subPromLabel setText:@"评论"];
    [subPromLabel  setFont:[UIFont systemFontOfSize:16]];
    [bottomBgview  addSubview:subPromLabel];
    [subPromLabel  setTextColor:[UIColor whiteColor]];
    UIButton * confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setFrame:CGRectMake(540*Width,20*Width , 170*Width, 60*Width)];
    [confirmBtn setBackgroundColor:orangeColor];
    confirmBtn.layer.cornerRadius =30*Width;
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [confirmBtn setTitle:@"发表评论" forState:UIControlStateNormal];
    [confirmBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [confirmBtn addTarget:self action:@selector(talkBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomBgview addSubview:confirmBtn];
    

    
    
}
- (void)talkBtnAction
{
    EditCommentVC *edit =[[EditCommentVC alloc]init];
    edit.askId =_askId;
    [self.navigationController pushViewController:edit animated:YES];
    
}
- (void)myBtnAciton:(UIButton *)btn
{
    
    
}
- (void)getBestRecommend
{
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{
                          @"ask_id":_askId,
                          }
     ];
    
    [PublicMethod AFNetworkPOSTurl:@"mobileapi/?luntan-qa.html" paraments:dic1  addView:self.view addNavgationController:self.navigationController success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dict);
        if(![[NSString stringWithFormat:@"%@",[[dict objectForKey:@"data"] objectForKey:@"answers"]]isEqualToString:@"<null>"])
        {
            inforArrPL =[[dict objectForKey:@"data"] objectForKey:@"answers"];

        }
        detailDic =[[dict objectForKey:@"data"] objectForKey:@"detail"];
        [tableview  reloadData];
        [bgScrollView setContentSize:CGSizeMake(CXCWidth, tableview.bottom*2)];

        
    } fail:^(NSError *error) {
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.01;
    }else
    {
        return 100*Width;

        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 0.01*Width;
        
    }else
    {
        return 0.01*Width;
        
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
    {
        return 1;
    }else if(section==1)
    {
        return inforArrPL.count;
    }
    return inforArrWZ.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        NSString *titleContent =[NSString stringWithFormat:@"%@",[detailDic objectForKey:@"title"]];
        CGSize titleSize;//通过文本得到高度
        titleSize = [titleContent boundingRectWithSize:CGSizeMake(600*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        NSString *ideaContent =[NSString stringWithFormat:@"%@",[detailDic objectForKey:@"intro"]];
        CGSize ideaSize;//通过文本得到高度
        ideaSize = [ideaContent boundingRectWithSize:CGSizeMake(550*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        int count = [[NSString stringWithFormat:@"%@",[detailDic objectForKey:@"thumb"]]isEqualToString:@"<null>"]?0:1;
        
        return ideaSize.height+titleSize.height+260*Width+235*count*Width;
    }else if(indexPath.section==1){
        
        NSString *ideaContent =[inforArrPL[indexPath.row] objectForKey:@"contents"];
        CGSize ideaSize;//通过文本得到高度
        ideaSize = [ideaContent boundingRectWithSize:CGSizeMake(600*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        return 120*Width+ideaSize.height+40*Width;

    }else
    {
        return 185*Width;
    
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        static NSString *CellIdentifier = @"CellWithNumber";
        
        PostHeaderCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[PostHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier ];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        }
        cell.dic =detailDic;
        return cell;
        
        
    }else if (indexPath.section==1)
    {
        static NSString *CellIdentifier = @"Cell";
        
        PostTalkCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[PostTalkCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:CellIdentifier ];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
        }
        cell.dic =inforArrPL[indexPath.row];
        return cell;
        
        
    }else {
        static NSString *CellIdentifier = @"Cell2";
        
        KnowledgeCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[KnowledgeCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:CellIdentifier ];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
        }
        cell.dic =inforArrWZ[indexPath.row];

        return cell;
        
        
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section ==0)
    {
        return nil;
    }else
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
        if (section ==1) {
            botLabel.text =[NSString stringWithFormat:@"%@",@"    评论"];
        }else if(section ==2) {
            botLabel.text =[NSString stringWithFormat:@"%@",@"    相关热帖"];
            
        }
        [bgview  addSubview:botLabel];
        return bgview;
    }
 
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    return nil;
}
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
-(void)getWZ{
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
   
    [PublicMethod AFNetworkPOSTurl:@"mobileapi/index.php?luntan-related_links" paraments:dic1  addView:self.view addNavgationController:self.navigationController success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dict);
        inforArrWZ =[[dict objectForKey:@"data"] objectForKey:@"related_links"];
        [tableview reloadData];
        [bgScrollView setContentSize:CGSizeMake(CXCWidth, tableview.bottom*2)];

    } fail:^(NSError *error) {
        
    }];
    
}

@end
