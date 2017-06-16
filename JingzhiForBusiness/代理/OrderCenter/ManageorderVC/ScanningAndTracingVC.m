//
//  ScanningAndTracingVC.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/12.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "ScanningAndTracingVC.h"
#import "XYMScanViewController.h"
#import "ScanAndTracCell.h"
#import "TracingCell.h"
#import "SendGoodsVC.h"
@interface ScanningAndTracingVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *topView;
    UITableView *scanTableView;

}
@end

@implementation ScanningAndTracingVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:BGColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    //替代导航栏的imageview
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, 64)];
    topImageView.userInteractionEnabled = YES;
    topImageView.backgroundColor = NavColor;
    [self.view addSubview:topImageView];
    //添加返回按钮
    UIButton *  returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame = CGRectMake(0, 20, 44, 44);
    [returnBtn setImage:[UIImage imageNamed:navBackarrow] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:returnBtn];
    //注册标签
    UILabel *navTitle =[[UILabel alloc] initWithFrame:CGRectMake(100*Width, 20, 550*Width, 44)];
    [navTitle setText:@"扫码追溯"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor whiteColor]];
    [self.view addSubview:navTitle];
    
    //扫码按钮
    UIButton *  scanningBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    scanningBtn.frame = CGRectMake(CXCWidth-60, 20, 44, 44);
    //    [withDrawlsBtn setImage:[UIImage imageNamed:navBackarrow] forState:UIControlStateNormal];
    scanningBtn.titleLabel.font =[UIFont boldSystemFontOfSize:15];
    [scanningBtn setImage:[UIImage imageNamed:@"tracert_btn_scan"] forState:UIControlStateNormal];
    
    [scanningBtn addTarget:self action:@selector(scanningBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:scanningBtn];
    
    
    [self mainView];
}
- (void)mainView
{
    scanTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, CXCWidth, CXCHeight-100*Width-64)style:UITableViewStyleGrouped];
    [scanTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [scanTableView setDelegate:self];
    [scanTableView setDataSource:self];
    [scanTableView setBackgroundColor:[UIColor clearColor]];
    scanTableView .showsVerticalScrollIndicator = NO;
    [self.view addSubview:scanTableView];
    //底部
    UIView *bottomBgview =[[UIView alloc]initWithFrame:CGRectMake(0, CXCHeight-100*Width, CXCWidth, 100*Width)];
    [bottomBgview setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:bottomBgview];
    //线
    UIImageView*xianBottom =[[UIImageView alloc]init];
    xianBottom.backgroundColor =BGColor;
    [bottomBgview addSubview:xianBottom];
    xianBottom.frame =CGRectMake(0*Width,0*Width, CXCWidth, 1.5*Width);
    
    UILabel *subPromLabel =[[UILabel alloc]initWithFrame:CGRectMake(40*Width, 0, 450*Width, 100*Width)];
    NSString*str =@"已扫描：9箱";
    [subPromLabel    setTextColor:[UIColor colorWithRed:33/255.0 green:36/255.0 blue:38/255.0 alpha:1]];

    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc]initWithString:str];
    NSRange rangel = [[textColor string] rangeOfString:[str substringFromIndex:4]];
    [textColor addAttribute:NSForegroundColorAttributeName value:NavColor range:rangel];
    [subPromLabel setAttributedText:textColor];
    [subPromLabel  setFont:[UIFont systemFontOfSize:14]];
    [bottomBgview   addSubview:subPromLabel];
    //确认提交按钮
    UIButton * confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setFrame:CGRectMake(550*Width,0 , 200*Width, 100*Width)];
    [confirmBtn setBackgroundColor:NavColor];
    confirmBtn.layer.borderColor =[UIColor blueColor].CGColor;
    [confirmBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [confirmBtn.titleLabel setTextColor:[UIColor whiteColor]];
    [confirmBtn addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomBgview addSubview:confirmBtn];

}
- (void)scanningBtnAction
{
    //扫描二维码
    XYMScanViewController *scanView = [[XYMScanViewController alloc]init];
    
    [self.navigationController pushViewController:scanView animated:YES];
    

}
-(void)returnBtnAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        
    
    topView =[[UIView alloc]initWithFrame:CGRectMake(0, 64, CXCWidth, 312*Width)];
    topView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:topView];
    
    //时间
    UILabel* timeLabel  = [[UILabel alloc]init];
    timeLabel.font = [UIFont systemFontOfSize:13];
    timeLabel.text = @"    2017-09-01 12：23：24";
    [topView addSubview:timeLabel];
    timeLabel.frame= CGRectMake(0*Width, 0,CXCWidth,74*Width);
    timeLabel.backgroundColor =BGColor;
    timeLabel.textColor = TextGrayColor;
    //总额
    UILabel* pricesLabel  = [[UILabel alloc]init];
    pricesLabel.font = [UIFont systemFontOfSize:13];
    pricesLabel.textColor = TextGrayColor;
    NSString *totalString =[NSString stringWithFormat:@"总额：¥%@",@"900000"];//总和
    NSMutableAttributedString *textColor = [[NSMutableAttributedString alloc]initWithString:totalString];
    NSRange rangel = [[textColor string] rangeOfString:[totalString substringFromIndex:3]];
    [textColor addAttribute:NSForegroundColorAttributeName value:NavColor range:rangel];
    [pricesLabel setAttributedText:textColor];
    [topView addSubview:pricesLabel];
    pricesLabel.frame= CGRectMake(400*Width, 0,325*Width,74*Width);
    pricesLabel.backgroundColor =BGColor;
    pricesLabel.textAlignment = NSTextAlignmentRight;
    //订单号
    UILabel* orderNumberLabel  = [[UILabel alloc]init];
    orderNumberLabel.font = [UIFont systemFontOfSize:14];
    orderNumberLabel.text = @"    订单号：1953056874376";
    [topView addSubview:orderNumberLabel];
    orderNumberLabel.frame= CGRectMake(0*Width, timeLabel.bottom,CXCWidth,74*Width);
    orderNumberLabel.textColor = TextGrayColor;
    //状态
    UILabel* orderStatuerLabel  = [[UILabel alloc]init];
    orderStatuerLabel.font = [UIFont systemFontOfSize:14];
    orderStatuerLabel.text = @"待审核";
    orderStatuerLabel.textAlignment =NSTextAlignmentRight;
    [topView addSubview:orderStatuerLabel];
    orderStatuerLabel.frame= CGRectMake(400*Width, timeLabel.bottom,325*Width,74*Width);
    orderStatuerLabel.textColor = NavColor;
    
    NSArray*leftArr =@[@"商品",@"数量",@"",@"",@"",@"",@"",];
    
    NSArray*rightArr =@[@"商品12234",@"12",@"",@"",@"",@"",];
    for (int i=0; i<2; i++) {
        //背景
        UIView *bgview =[[UIView alloc]init];
        bgview.backgroundColor =[UIColor whiteColor];
        [topView addSubview:bgview];
        bgview.frame =CGRectMake(0, orderNumberLabel.bottom+82*i*Width, CXCWidth, 82*Width);
        if (i<3) {
            //左边提示
            UILabel* labe = [[UILabel alloc]initWithFrame:CGRectMake(32*Width, 0,200*Width , 82*Width)];
            labe.text = leftArr[i];
            labe.font = [UIFont systemFontOfSize:14];
            labe.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
            [bgview addSubview:labe];
            //右边内容
            UILabel* rightLabel = [[UILabel alloc]init];
            rightLabel.text = rightArr[i];
            rightLabel.frame =CGRectMake(250*Width ,0, 475*Width,82*Width );
            rightLabel.textColor = NavColor;
            rightLabel.textColor = BlackColor;
            rightLabel.textAlignment=NSTextAlignmentRight;
            rightLabel.tag =200+i;
            rightLabel.font = [UIFont systemFontOfSize:14];
            [bgview addSubview:rightLabel];
            //细线
            UIImageView*xianOfGoods =[[UIImageView alloc]init];
            xianOfGoods.backgroundColor =[UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1];
            [bgview addSubview:xianOfGoods];
            xianOfGoods.frame =CGRectMake(24*Width,80.5*Width,CXCWidth,1.5*Width);
            
            
        }
    }
    return topView;
    }else
    
    return nil;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 312*Width;
    }
    return 0.01*Width;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
    {
        return 160*Width;

    }else
    {
        NSArray*arr=@[@{@"key":@"sdlfjhkas李蝴蝶飞飞拉得好索拉卡惊魂甫定啦鸿福路口沙发来撒看好你都是垃圾发货了客气",@"index":@"0"},
                      @{@"key":@"sdlf卡死了带回家科维奇人",@"index":@"1"},
                      @{@"key":@"sdl死了带回家科维奇人",@"index":@"1"},
                      @{@"key":@"sdlfjhkas李蝴蝶飞飞拉得好索拉卡惊魂甫定啦鸿福路口沙发来撒看好你都是垃圾发货了客气哈放弃还老是发货未答复普斯发货了看起来好地方就卡死了带回家科维奇人",@"index":@"1"},
                      @{@"key":@"sdlfjhkas李蝴科维奇人",@"index":@"1"},
                      @{@"key":@"sdlfjhkas李蝴了客气哈放弃还老是发货未答复普斯发货了看起来好地方就卡死了带回家科维奇人",@"index":@"2"},
                      @{@"key":@"sdlfjhkas李蝴蝶飞飞拉得好索拉卡惊魂甫定啦鸿福路口沙发来撒看好你都是垃圾发货了客气哈放弃还老是发货未答复普斯发货了看起来好地方就卡死了带回家科维奇人",@"index":@"2"},
                      @{@"key":@"sdlfjhkas李蝴蝶飞飞拉得好索拉卡惊魂甫定啦鸿福路口沙发来撒看好你都是垃圾发货了客气哈放弃还老是发货未答复普斯发货了看起来好地方就卡死了带回家科维奇人",@"index":@"2"},
                      @{@"key":@"sdlfjhkas李蝴蝶飞飞拉得好索拉卡惊魂甫定啦鸿福路口沙发来撒看好你都是垃圾发货了客气哈放弃还老是发货未答复普斯发货了看起来好地方就卡死了带回家科维奇人",@"index":@"2"}];
        NSString *titleContent =[[arr objectAtIndex:indexPath.row-1] objectForKey:@"key"];
        CGSize titleSize;//通过文本得到高度

        titleSize = [titleContent boundingRectWithSize:CGSizeMake(500*Width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;

        return  titleSize.height+40*Width;
     }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (indexPath.row ==0)
    {
        static NSString *CellIdentifier = @"Cell1";
        TracingCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[TracingCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:CellIdentifier ];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
//        cell.dic=[];
        return cell;
        

    
    }else  {
        
        static NSString *CellIdentifier = @"Cell";
        ScanAndTracCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[ScanAndTracCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:CellIdentifier ];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        NSString *index =[NSString stringWithFormat:@"%ld",indexPath.row];
        NSLog(@"++++++++++++++++%ld",indexPath.row);
        NSArray*arr=@[@{@"key":@"sdlfjhkas李蝴蝶飞飞拉得好索拉卡惊魂甫定啦鸿福路口沙发来撒看好你都是垃圾发货了客气",@"index":@"0"},
                      @{@"key":@"sdlf卡死了带回家科维奇人",@"index":@"1"},
                      @{@"key":@"sdl死了带回家科维奇人",@"index":@"1"},
                      @{@"key":@"sdlfjhkas李蝴蝶飞飞拉得好索拉卡惊魂甫定啦鸿福路口沙发来撒看好你都是垃圾发货了客气哈放弃还老是发货未答复普斯发货了看起来好地方就卡死了带回家科维奇人",@"index":@"1"},
                      @{@"key":@"sdlfjhkas李蝴科维奇人",@"index":@"1"},
                      @{@"key":@"sdlfjhkas李蝴了客气哈放弃还老是发货未答复普斯发货了看起来好地方就卡死了带回家科维奇人",@"index":@"2"},
                      @{@"key":@"sdlfjhkas李蝴蝶飞飞拉得好索拉卡惊魂甫定啦鸿福路口沙发来撒看好你都是垃圾发货了客气哈放弃还老是发货未答复普斯发货了看起来好地方就卡死了带回家科维奇人",@"index":@"2"},
                      @{@"key":@"sdlfjhkas李蝴蝶飞飞拉得好索拉卡惊魂甫定啦鸿福路口沙发来撒看好你都是垃圾发货了客气哈放弃还老是发货未答复普斯发货了看起来好地方就卡死了带回家科维奇人",@"index":@"2"},
                      @{@"key":@"sdlfjhkas李蝴蝶飞飞拉得好索拉卡惊魂甫定啦鸿福路口沙发来撒看好你都是垃圾发货了客气哈放弃还老是发货未答复普斯发货了看起来好地方就卡死了带回家科维奇人",@"index":@"2"}];
        cell.dic =arr[indexPath.row-1];
        
        
        return cell;
        
        
    }
    
    //    NSDictionary *dict = [infoArray objectAtIndex:[indexPath row]];
    //    [cell setDic:dict];
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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
    
}
- (void)confirmButtonAction
{

    //如果满一箱就可以扫描，零头不算
    UILabel *label =[self.view viewWithTag:201];
    SendGoodsVC *sendGoods =[[SendGoodsVC alloc]init];
    [self.navigationController pushViewController:sendGoods animated:YES];
    
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
