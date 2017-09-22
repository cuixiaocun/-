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

}

@end

@implementation PostMessageVC
-(void)viewWillAppear:(BOOL)animated
{
}
- (void)viewDidLoad {
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
    [returnBtn setImage:[UIImage imageNamed:@"sf_icon_goBack"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:returnBtn];
    

    //注册标签
    UILabel *navTitle =[[UILabel alloc] initWithFrame:CGRectMake(100*Width, 20, 550*Width, 44)];
    [navTitle setText:@"帖子详情"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor blackColor]];
    [self.view addSubview:navTitle];
    
    
    [self mainView];
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
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, CXCWidth, CXCHeight-64)];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setShowsVerticalScrollIndicator:NO];
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, 10002)];
    [self.view addSubview:bgScrollView];
    tableview  =[[UITableView alloc]initWithFrame:CGRectMake(0,0, CXCWidth, 10001.5)style:UITableViewStyleGrouped];
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
    [self.navigationController pushViewController:edit animated:YES];
    
}
- (void)myBtnAciton:(UIButton *)btn
{
    
    
}
- (void)getBestRecommend
{
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0.01;
    }else
    {        return 100*Width;

        
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==0) {
        return 0*Width;
        
    }else
    {
        return 80*Width;
        
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
    {
        return 1;
        
    }else
        
        return 4;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        {
            NSString *titleContent =@"他们的团队他别细心，非常专业，很棒的，继续努力！他们的团队他别细心，非常专业，很棒的，继续努力！他们的团队他别细心，非常专业，很棒的，继续努力！";
            CGSize titleSize;//通过文本得到高度
            titleSize = [titleContent boundingRectWithSize:CGSizeMake(580*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
            NSString *ideaContent =@"设计理念：看了一段时间后的第一个感受-水真深！因为喜欢摄影的原因，自己喜欢的摄影师又都有着小清新，日系情操。\n所以他们的家看起来也是那种干净，简洁，但每种装饰都有它必须在那里的理由。有从比如埃及带回来的装饰品，有从发货某个二手市场淘回来的小家具...放在那里就让整个房间焕发一种温馨的感觉。\nOk，拉回来，我想说的是，这种审美会传染人。于是我也渐渐开始建立起这样的审美。";
            CGSize ideaSize;//通过文本得到高度
            ideaSize = [ideaContent boundingRectWithSize:CGSizeMake(550*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
            
            
            return ideaSize.height+titleSize.height+160*Width+200*4*Width;
        }
    }else if(indexPath.section==1){
        NSString *ideaContent =@"他们的团队他别细心，非常专业，很棒的，继续努力！他们的团队他别细心，非常专业，很棒的，继续努力！他们的团队他别细心，非常专业，很棒的，继续努力！";
        CGSize ideaSize;//通过文本得到高度
        ideaSize = [ideaContent boundingRectWithSize:CGSizeMake(560*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        return 120*Width+ideaSize.height;

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
        return cell;
        
        
    }else    {
        static NSString *CellIdentifier = @"Cell2";
        
        KnowledgeCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[KnowledgeCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:CellIdentifier ];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
        }
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
            botLabel.text =[NSString stringWithFormat:@"%@",@"     评论"];
        }else if(section ==2) {
            botLabel.text =[NSString stringWithFormat:@"%@",@"    相关热帖"];
            
        }
        [bgview  addSubview:botLabel];
        return bgview;
    }
 
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    if(section ==0)
    {
        return nil;
    }else
    {

    UIButton *addressBtn =[[UIButton alloc]initWithFrame:CGRectMake(0*Width,0,CXCWidth , 80*Width)];
    if(section ==1)
    {
        [addressBtn addTarget:self action:@selector(moreTJ) forControlEvents:UIControlEventTouchUpInside];
        
    }else
    {
        [addressBtn addTarget:self action:@selector(moreTS) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    UILabel *addLabel = [[UILabel alloc] init];
    [addLabel setText:@"查看更多 >"];
    addLabel.tag =30;
    addLabel.textColor =BlackColor;
    addLabel.textAlignment =NSTextAlignmentCenter;
    [addLabel setFont:[UIFont systemFontOfSize:14]];
    [addLabel setFrame:CGRectMake(0*Width,1.5*Width,CXCWidth , 78.5*Width)];
    addLabel.backgroundColor =[UIColor whiteColor];
    [addressBtn addSubview:addLabel];
    [addressBtn setBackgroundColor:[UIColor whiteColor]];
    UIImageView *addShowImgV =[[UIImageView alloc]initWithFrame:CGRectMake(30*Width, 0*Width, 690*Width, 1.5*Width)];
    addressBtn.backgroundColor =BGColor;
    [addressBtn addSubview:addShowImgV];
    return addressBtn;
    }
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
