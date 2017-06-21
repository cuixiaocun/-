//
//  RebateVC.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/5.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "RebateVC.h"
#import "RebateCell.h"
#import "RabatForInCell.h"
@interface RebateVC ()<UITextFieldDelegate>
{
    NSString *isInOrOut;// no==出款 yes==收款
    UIView *bottomBgview;
    UIView*bottomBgviewOut;
    NSString *statuString;//所有-0 未转账-1 已转账-2 已完成-3
    UIView *topView;
    UIView *topViewOut;
}
@end

@implementation RebateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:BGColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    isInOrOut =@"NO";
    statuString=@"0";
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
    
    UIImageView*bgImg =[[UIImageView alloc]init];
    bgImg.backgroundColor=[UIColor whiteColor];
    [topImageView addSubview:bgImg];
    bgImg.layer.cornerRadius=2;
    [bgImg   setFrame:CGRectMake(183*Width, 20+(44-56*Width)/2-1, 384*Width, 60*Width)];
    bgImg.userInteractionEnabled = YES;

    
    //会员
    UIButton *hyBtn =[[UIButton alloc]initWithFrame:CGRectMake(2*Width, 2*Width, 190*Width, 56*Width)];
    [hyBtn setBackgroundColor:[UIColor whiteColor]];
    hyBtn.selected=YES;
    
    if (hyBtn.selected==YES) {
        [hyBtn setBackgroundColor:[UIColor whiteColor]];
    }else
    {
        [hyBtn setBackgroundColor:NavColor];
    }
    [hyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [hyBtn setTitleColor:NavColor forState:UIControlStateSelected];
    [hyBtn setTitle:@"我的出款" forState:UIControlStateNormal];
    [hyBtn setTitle:@"我的出款" forState:UIControlStateSelected];
    hyBtn.tag =120;
    hyBtn.titleLabel.font =[UIFont systemFontOfSize:15];
//    hyBtn.layer.cornerRadius=4;
    
    [hyBtn addTarget:self action:@selector(myMoneyBtn:) forControlEvents:UIControlEventTouchUpInside];
    [bgImg addSubview:hyBtn];
    
    //代理
    UIButton *dlBtn =[[UIButton alloc]initWithFrame:CGRectMake(hyBtn.right,2*Width, 190*Width, 56*Width)];
    [dlBtn setBackgroundColor:[UIColor whiteColor]];
    dlBtn.selected=NO;
//    dlBtn.layer.cornerRadius=4;
    
    if (dlBtn.selected==YES) {
        [dlBtn setBackgroundColor:[UIColor whiteColor]];
    }else
    {
        [dlBtn setBackgroundColor:NavColor];
    }
    dlBtn.titleLabel.font =[UIFont systemFontOfSize:15];
    [dlBtn setTitle:@"我的收款" forState:UIControlStateNormal];
    [dlBtn setTitle:@"我的收款" forState:UIControlStateSelected];
    [dlBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [dlBtn setTitleColor:NavColor forState:UIControlStateSelected];
    [bgImg addSubview:dlBtn];
    dlBtn.tag =121;
    [dlBtn addTarget:self action:@selector(myMoneyBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [bgImg addSubview:dlBtn];
    //提现按钮
    UIButton *  withDrawlsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    withDrawlsBtn.frame = CGRectMake(CXCWidth-60, 20, 44, 44);
    //    [withDrawlsBtn setImage:[UIImage imageNamed:navBackarrow] forState:UIControlStateNormal];
    withDrawlsBtn.titleLabel.font =[UIFont boldSystemFontOfSize:15];
    [withDrawlsBtn setTitle:@"查询" forState:UIControlStateNormal];
    [withDrawlsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [withDrawlsBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [withDrawlsBtn addTarget:self action:@selector(withDrawlsBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topImageView addSubview:withDrawlsBtn];

    [self  mainView];
    
    
    
    
    
}
- (void)mainView
{
    [self topShowOut];//先显示出款
    UIView*xianV =[[UIView alloc]initWithFrame:CGRectMake(0, 64+100*Width, CXCWidth, 20*Width)];
    [self.view addSubview:xianV];
    xianV.backgroundColor =BGColor;
    UIView *bgView= [[UIView alloc]initWithFrame:CGRectMake(0, xianV.bottom, CXCWidth, 162*Width)];
    bgView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:bgView];
    
    
    
    
    NSArray*arr =@[@"选择起始时间",@"选择结束时间"];
    NSArray*arrBottom =@[@"输入产出代理",@"输入收款代理",@""];

    for (int i=0; i<2;i++) {
        UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(375*Width*i,0, 375*Width, 80*Width)];
        [bgView addSubview:btn];
        btn.tag =300+i;
        btn.titleLabel.font =[UIFont systemFontOfSize:14];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(chooseTime:) forControlEvents:UIControlEventTouchUpInside];
    }
    UIImageView*sXian =[[UIImageView alloc]initWithFrame:CGRectMake(375*Width, 20*Width, 1*Width, 40*Width)];
    sXian.backgroundColor =BGColor;
    [bgView addSubview:sXian];
    
    UIImageView*hXian =[[UIImageView alloc]initWithFrame:CGRectMake(30*Width, 80*Width, 690*Width, 1.5*Width)];
    hXian.backgroundColor =BGColor;
    [bgView addSubview:hXian];
    for (int i=0; i<3; i++) {
        UITextField *label =[[UITextField alloc]initWithFrame:CGRectMake( 375*Width*i,hXian.bottom, 375*Width, 80*Width)];
        label.tag =33330+i;
        label.delegate=self;
        label.placeholder =arrBottom[i];
        label.textColor = TextColor;
        label.textAlignment =NSTextAlignmentCenter;
        label.font =[UIFont systemFontOfSize:14];
        [bgView addSubview:label];
        if (i==2) {
            label.frame =CGRectMake(375*Width, 20*Width, 1*Width, 40*Width);
            label.backgroundColor =BGColor;
        }
        
    }
    
    UIImageView*botXian =[[UIImageView alloc]initWithFrame:CGRectMake(375*Width,bgView.bottom-60*Width, 1*Width, 40*Width)];
    botXian.backgroundColor =BGColor;
    [self.view addSubview:botXian];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setFrame:CGRectMake(0,64+40*Width+162*Width+100*Width, CXCWidth, CXCHeight-40*Width-162*Width-64-100*Width)];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    self.tableView .showsVerticalScrollIndicator = NO;
    
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    //下拉刷新
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DemoTableHeaderView" owner:self options:nil];
    DemoTableHeaderView *headerView = (DemoTableHeaderView *)[nib objectAtIndex:0];
    self.headerView = headerView;
    //上拉加载
    nib = [[NSBundle mainBundle] loadNibNamed:@"DemoTableFooterView" owner:self options:nil];
    DemoTableFooterView *footerView = (DemoTableFooterView *)[nib objectAtIndex:0];
    self.footerView = footerView;
    infoArray = [[NSMutableArray alloc] init];
    //  [self performSelector:@selector(getInfoList)];
    
    [self bottomShowOut];//先显示出款
    
    
}
//头部出款
-(void)topShowOut
{
    if (!topViewOut) {
        
    
    topViewOut =[[UIView alloc]initWithFrame:CGRectMake(0, 64, CXCWidth, 100*Width)];
    topViewOut.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:topViewOut];
    NSArray *btnArr =@[@"全部",@"未转账",@"已转账"];
    for (int i=0; i<3; i++) {
        UIButton *  statuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        statuBtn.frame = CGRectMake(CXCWidth/3*i, 0,CXCWidth/3-2*Width ,100*Width);
        if (i==0) {
            statuBtn.selected =YES;
        }
        if (i<4) {
            //横线
            UIImageView*xian =[[UIImageView alloc]init];
            xian.backgroundColor =BGColor;
            [topViewOut addSubview:xian];
            xian.frame =CGRectMake(statuBtn.right,25*Width, Width, 50*Width);
            
        }
        //    [withDrawlsBtn setImage:[UIImage imageNamed:navBackarrow] forState:UIControlStateNormal];
        statuBtn.titleLabel.font =[UIFont boldSystemFontOfSize:14];
        [statuBtn setTitle:btnArr[i] forState:UIControlStateNormal];
        [statuBtn setTitleColor:TextGrayColor forState:UIControlStateNormal];
        [statuBtn setTitleColor:NavColor forState:UIControlStateSelected];
        statuBtn.tag =230+i;
        [statuBtn addTarget:self action:@selector(changeStatuBtnOut:) forControlEvents:UIControlEventTouchUpInside];
        [topViewOut addSubview:statuBtn];
    }
    //横线
    UIImageView*xian =[[UIImageView alloc]init];
    xian.backgroundColor =BGColor;
    [topViewOut addSubview:xian];
    xian.frame =CGRectMake(0,98*Width, CXCWidth, 2*Width);
    
    }
    UIButton *btn =[self.view viewWithTag:230];
    [self changeStatuBtn:btn];
    topView.hidden =YES;
    topViewOut.hidden =NO;
    

}
//改变状态--出款的
- (void)changeStatuBtnOut:(UIButton *)btn
{
    for (int i=0; i<3; i++) {
        UIButton *statuBtn =[self.view viewWithTag:230+i];
        statuBtn.selected=NO;
    }
    btn.selected =YES;
    statuString =[NSString stringWithFormat:@"%ld",btn.tag-230];
    
    [self.tableView reloadData];
    
    
}

//头部状态进款的
-(void)topShow
{
    if (!topView) {
        
        
        topView =[[UIView alloc]initWithFrame:CGRectMake(0, 64, CXCWidth, 100*Width)];
        topView.backgroundColor =[UIColor whiteColor];
        [self.view addSubview:topView];
        NSArray *btnArr =@[@"全部",@"未转账",@"已转账",@"已完成"];
        for (int i=0; i<4; i++) {
            UIButton *  statuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            statuBtn.frame = CGRectMake(CXCWidth/4*i, 0,CXCWidth/4-2*Width ,100*Width);
            if (i==0) {
                statuBtn.selected =YES;
            }
            if (i<4) {
                //横线
                UIImageView*xian =[[UIImageView alloc]init];
                xian.backgroundColor =BGColor;
                [topView addSubview:xian];
                xian.frame =CGRectMake(statuBtn.right,25*Width, Width, 50*Width);
                
            }
            //    [withDrawlsBtn setImage:[UIImage imageNamed:navBackarrow] forState:UIControlStateNormal];
            statuBtn.titleLabel.font =[UIFont boldSystemFontOfSize:14];
            [statuBtn setTitle:btnArr[i] forState:UIControlStateNormal];
            [statuBtn setTitleColor:TextGrayColor forState:UIControlStateNormal];
            [statuBtn setTitleColor:NavColor forState:UIControlStateSelected];
            statuBtn.tag =220+i;
            [statuBtn addTarget:self action:@selector(changeStatuBtn:) forControlEvents:UIControlEventTouchUpInside];
            [topView addSubview:statuBtn];
        }
        //横线
        UIImageView*xian =[[UIImageView alloc]init];
        xian.backgroundColor =BGColor;
        [topView addSubview:xian];
        xian.frame =CGRectMake(0,98*Width, CXCWidth, 2*Width);
        
    }
    UIButton *btn =[self.view viewWithTag:220];
    [self changeStatuBtn:btn];
    
    topView.hidden =NO;
    topViewOut.hidden =YES;
    
    
}
//头部状态选择--进款
- (void)changeStatuBtn:(UIButton *)btn
{
    
    for (int i=0; i<4; i++) {
        UIButton *statuBtn =[self.view viewWithTag:220+i];
        statuBtn.selected=NO;
    }
    btn.selected =YES;
    statuString =[NSString stringWithFormat:@"%ld",btn.tag-220];
    [self.tableView reloadData];

    
}
//底部出款
- (void)bottomShowOut

{
    UITextField *textF =[self.view viewWithTag:33330];
    UITextField *text2 =[self.view viewWithTag:33331];
    [textF resignFirstResponder];
    [text2 resignFirstResponder];
    

    if (!bottomBgviewOut) {
     
    
    //底部
    bottomBgviewOut =[[UIView alloc]initWithFrame:CGRectMake(0, CXCHeight-100*Width, CXCWidth, 100*Width)];
    [bottomBgviewOut setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:bottomBgviewOut];
    //线
    UIImageView*xianBottomIn =[[UIImageView alloc]init];
    xianBottomIn.backgroundColor =BGColor;
    [bottomBgviewOut addSubview:xianBottomIn];
    xianBottomIn.frame =CGRectMake(0*Width,0*Width, CXCWidth, 1.5*Width);
    
    UILabel *subPromLabelIn =[[UILabel alloc]initWithFrame:CGRectMake(40*Width, 0, 270*Width, 100*Width)];
    [subPromLabelIn setText:@"待转账总金额:"];
    [subPromLabelIn  setFont:[UIFont systemFontOfSize:15]];
    [bottomBgviewOut   addSubview:subPromLabelIn];
    [subPromLabelIn    setTextColor:[UIColor colorWithRed:33/255.0 green:36/255.0 blue:38/255.0 alpha:1]];
    //底部总价
    UILabel *subNumLabelIn =[[UILabel alloc]initWithFrame:CGRectMake(260*Width, 0, 300*Width, 100*Width)];
    [subNumLabelIn setText:@"¥1240"];
    [subNumLabelIn  setFont:[UIFont systemFontOfSize:17]];
    [subNumLabelIn    setTextColor:NavColor];
    [bottomBgviewOut   addSubview:subNumLabelIn];
    //确认提交按钮
    UIButton * confirmBtnIn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtnIn setFrame:CGRectMake(550*Width,0 , 200*Width, 100*Width)];
    [confirmBtnIn setBackgroundColor:NavColor];
    confirmBtnIn.layer.borderColor =[UIColor blueColor].CGColor;
    [confirmBtnIn setTitle:@"转帐" forState:UIControlStateNormal];
    [confirmBtnIn.titleLabel setTextColor:[UIColor whiteColor]];
    [confirmBtnIn addTarget:self action:@selector(confirmButtonActionOut) forControlEvents:UIControlEventTouchUpInside];
    [bottomBgviewOut addSubview:confirmBtnIn];
    }
    
    bottomBgviewOut.hidden=NO;
    bottomBgview.hidden=YES;



}
//底部进款
- (void)bottomShow
{
    if (!bottomBgview ) {
        //底部
        bottomBgview =[[UIView alloc]initWithFrame:CGRectMake(0, CXCHeight-100*Width, CXCWidth, 100*Width)];
        [bottomBgview setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:bottomBgview];
        //线
        UIImageView*xianBottom =[[UIImageView alloc]init];
        xianBottom.backgroundColor =BGColor;
        [bottomBgview addSubview:xianBottom];
        xianBottom.frame =CGRectMake(0*Width,0*Width, CXCWidth, 1.5*Width);
        
        UILabel *subPromLabel =[[UILabel alloc]initWithFrame:CGRectMake(40*Width, 0, 270*Width, 100*Width)];
        [subPromLabel setText:@"待确认总金额:"];
        [subPromLabel  setFont:[UIFont systemFontOfSize:15]];
        [bottomBgview   addSubview:subPromLabel];
        [subPromLabel    setTextColor:[UIColor colorWithRed:33/255.0 green:36/255.0 blue:38/255.0 alpha:1]];
        //底部总价
        UILabel *subNumLabel =[[UILabel alloc]initWithFrame:CGRectMake(260*Width, 0, 300*Width, 100*Width)];
        [subNumLabel setText:@"¥1240"];
        [subNumLabel  setFont:[UIFont systemFontOfSize:17]];
        [subNumLabel    setTextColor:NavColor];
        [bottomBgview   addSubview:subNumLabel];
        //确认提交按钮
        UIButton * confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [confirmBtn setFrame:CGRectMake(550*Width,0 , 200*Width, 100*Width)];
        [confirmBtn setBackgroundColor:NavColor];
        confirmBtn.layer.borderColor =[UIColor blueColor].CGColor;
        [confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
        [confirmBtn.titleLabel setTextColor:[UIColor whiteColor]];
        [confirmBtn addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [bottomBgview addSubview:confirmBtn];
    }
    bottomBgview.hidden=NO;
    bottomBgviewOut.hidden=YES;
    
    
    
}

-(void)confirmButtonActionOut
{
    UITextField *textF =[self.view viewWithTag:33330];
    UITextField *text2 =[self.view viewWithTag:33331];
    [textF resignFirstResponder];
    [text2 resignFirstResponder];
    [_pickview  remove];

    
    


}
- (void)confirmButtonAction
{
    UITextField *textF =[self.view viewWithTag:33330];
    UITextField *text2 =[self.view viewWithTag:33331];
    [textF resignFirstResponder];
    [text2 resignFirstResponder];
    [_pickview  remove];


    [self.tableView reloadData];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return infoArray.count ;
    return 5;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (([statuString isEqualToString:@"1"]||[statuString isEqualToString:@"0"])&&[isInOrOut isEqualToString:@"NO"]) {
        
        return 300*Width;
    }else if (([statuString isEqualToString:@"2"]||[statuString isEqualToString:@"0"])&&[isInOrOut isEqualToString:@"YES"])
    {
        return 300*Width;

    
    }else
    return 220*Width;
}


- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // no==出款 yes==收款
    if ( [isInOrOut isEqualToString: @"YES"]) {
        if([statuString isEqualToString:@"2"]||[statuString isEqualToString:@"0"])//有按钮
        {        static NSString *CellIdentifier = @"Cell1";
        RabatForInCell*cell =[tableView1 dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[RabatForInCell alloc] initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:CellIdentifier withType:statuString ];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
        }
        //    NSDictionary *dict = [infoArray objectAtIndex:row];
        //    [cell setDic:dict];
        return cell;
        }else
        {
            static NSString *CellIdentifier = @"Cell2";
            RabatForInCell *cell =[tableView1 dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[RabatForInCell alloc] initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:CellIdentifier withType2:statuString ];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                
            }    //    NSDictionary *dict = [infoArray objectAtIndex:row];
            //    [cell setDic:dict];
            return cell;
            
            

        
        }
    }else if ([isInOrOut isEqualToString: @"NO"]){
        if([statuString isEqualToString:@"1"]||[statuString isEqualToString:@"0"])//有按钮
        {
        
         static NSString *CellIdentifier = @"Cell4";
         RebateCell *cell =[tableView1 dequeueReusableCellWithIdentifier:CellIdentifier];
         if (cell == nil) {
        cell = [[RebateCell alloc] initWithStyle:UITableViewCellStyleDefault
                                 reuseIdentifier:CellIdentifier withType:statuString ];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

        }    //    NSDictionary *dict = [infoArray objectAtIndex:row];
        //    [cell setDic:dict];
        return cell;
        }else//无按钮
        {
            static NSString *CellIdentifier = @"Cell3";
            RebateCell *cell =[tableView1 dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[RebateCell alloc] initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:CellIdentifier withType2:statuString ];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                
            }    //    NSDictionary *dict = [infoArray objectAtIndex:row];
            //    [cell setDic:dict];
            return cell;

        
        
        }

    }
    
    return nil;
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (indexPath.row==1) {
    //        DelegateDetailVC *delegateDetail =[[DelegateDetailVC  alloc]init];
    //        [self.navigationController pushViewController:delegateDetail animated:YES];
    //
    //    }else
    //    {
    //        DelegateExamineDetailVC *delegateDetail =[[DelegateExamineDetailVC  alloc]init];
    //        [self.navigationController pushViewController:delegateDetail animated:YES];
    //    }
    
}
#pragma mark - Pull to Refresh
- (void) pinHeaderView
{
    [super pinHeaderView];
    
    // do custom handling for the header view
    DemoTableHeaderView *hv = (DemoTableHeaderView *)self.headerView;
    [hv.activityIndicator startAnimating];
    hv.title.text = @"加载中...";
    [CATransaction begin];
    [self.tableView setFrame:CGRectMake(0,64+20*Width+162*Width, CXCWidth, CXCHeight-20-100*Width)];
    
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    ((DemoTableHeaderView *)self.headerView).arrowImage.hidden = YES;
    [CATransaction commit];;
}
- (void) unpinHeaderView
{
    [super unpinHeaderView];
    
    // do custom handling for the header view
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setAMSymbol:@"AM"];
    [formatter setPMSymbol:@"PM"];
    [formatter setDateFormat:@"yyyy/MM/dd hh:mm:ss a"];
    ((DemoTableHeaderView *)self.headerView).time.text = [NSString stringWithFormat:@"最后更新: %@", [formatter stringFromDate:[NSDate date]]];
    [[(DemoTableHeaderView *)self.headerView activityIndicator] stopAnimating];
}

- (void) headerViewDidScroll:(BOOL)willRefreshOnRelease scrollView:(UIScrollView *)scrollView
{
    DemoTableHeaderView *hv = (DemoTableHeaderView *)self.headerView;
    if (willRefreshOnRelease){
        hv.title.text = @"松开即可更新...";
        currentPage = 1;
        [CATransaction begin];
        [CATransaction setAnimationDuration:0.18f];
        ((DemoTableHeaderView *)self.headerView).arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
        [CATransaction commit];
    }
    
    else{
        
        if ([hv.title.text isEqualToString:@"松开即可更新..."]) {
            currentPage = 1;
            [CATransaction begin];
            [CATransaction setAnimationDuration:0.18f];
            ((DemoTableHeaderView *)self.headerView).arrowImage.transform = CATransform3DIdentity;
            [CATransaction commit];
        }
        
        hv.title.text = @"下拉即可刷新...";
        [CATransaction begin];
        [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
        ((DemoTableHeaderView *)self.headerView).arrowImage.hidden = NO;
        ((DemoTableHeaderView *)self.headerView).arrowImage.transform = CATransform3DIdentity;
        [CATransaction commit];
    }
    
}
//
- (BOOL) refresh
{
    if (![super refresh])
        return NO;
    
    // Do your async call here
    // This is just a dummy data loader:
    [self performSelector:@selector(addItemsOnTop) withObject:nil afterDelay:0];
    
    
    // See -addItemsOnTop for more info on how to finish loading
    return YES;
}
#pragma mark - Load More

- (void) willBeginLoadingMore
{
    DemoTableFooterView *fv = (DemoTableFooterView *)self.footerView;
    [fv.activityIndicator startAnimating];
}

- (void) loadMoreCompleted
{
    [super loadMoreCompleted];
    
    DemoTableFooterView *fv = (DemoTableFooterView *)self.footerView;
    [fv.activityIndicator stopAnimating];
    
    if (!self.canLoadMore) {
        // Do something if there are no more items to load
        
        // We can hide the footerView by: [self setFooterViewVisibility:NO];
        
        // Just show a textual info that there are no more items to load
        fv.infoLabel.hidden = YES;
    }else{
        fv.infoLabel.hidden = NO;
    }
}
- (BOOL) loadMore
{
    if (![super loadMore])
        return NO;
    
    
    [self performSelector:@selector(addItemsOnBottom) withObject:nil afterDelay:0];
    
    
    // Inform STableViewController that we have finished loading more items
    
    return YES;
}


- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    DemoTableFooterView *fv = (DemoTableFooterView *)self.footerView;
    
    if (!isRefreshing && isDragging && scrollView.contentOffset.y < 0) {
        [self headerViewDidScroll:scrollView.contentOffset.y < 0 - [self headerRefreshHeight]
                       scrollView:scrollView];
    } else if (!isLoadingMore && self.canLoadMore) {
        CGFloat scrollPosition = scrollView.contentSize.height - scrollView.frame.size.height - scrollView.contentOffset.y;
        //NSLog(@"%f====%f",scrollPosition,[self footerLoadMoreHeight]);
        if (scrollPosition < [self footerLoadMoreHeight] && scrollPosition > 20) {
            
            [fv.infoLabel setText:@"上拉加载更多..."];
        }else if(scrollPosition < 20){
            //[fv.infoLabel setText:@"释放开始加载..."];
            [fv.infoLabel setText:@"正在加载..."];
            [self loadMore];
        }
        
    }
}

#pragma mark - Dummy data methods
- (void) addItemsOnTop
{
    
    currentPage=1;
    [self performSelector:@selector(getInfoList) withObject:nil afterDelay:0];
    
    DemoTableFooterView *fv = (DemoTableFooterView *)self.footerView;
    
    if (currentPage >= pageCount-1){
        self.canLoadMore = NO; // signal that there won't be any more items to load
    }else{
        self.canLoadMore = YES;
    }
    
    
    
    
    if (!self.canLoadMore) {
        fv.infoLabel.hidden = YES;
    }else{
        fv.infoLabel.hidden = NO;
    }
    
    
    // Call this to indicate that we have finished "refreshing".
    // This will then result in the headerView being unpinned (-unpinHeaderView will be called).
    [self refreshCompleted];
}


- (void) addItemsOnBottom
{
    currentPage++;
    [self performSelector:@selector(getInfoList) withObject:nil afterDelay:0];
    
    
    if (currentPage >= pageCount-1)
        self.canLoadMore = NO; // signal that there won't be any more items to load
    else
        self.canLoadMore = YES;
    
    // Inform STableViewController that we have finished loading more items
    [self loadMoreCompleted];
}
- (void)getInfoList
{
    
    //    [ProgressHUD show:@"加载中"];
    //    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"html/text",@"text/json", @"text/html", @"text/plain",nil];    [manager setSecurityPolicy:[PublicMethod customSecurityPolicy]];
    //
    //    //你的接口地址
    //    NSString *url=[NSString stringWithFormat:@"%@/repair/getByUserId",SERVERURL];
    //    NSDictionary *parameter = @{@"uid":@"",@"status":@"",@"deviceType":@"2"};
    //
    //
    //
    //
    //
    //    [PublicMethod AFNetworkPOSTurl:url paraments:parameter success:^(id responseDic) {
    //
    //
    //        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
    //        NSLog(@"请求成功JSON:%@", dict);
    //
    //        if (dict) {
    //            [ProgressHUD dismiss];
    //
    //            NSMutableArray *array=[[dict objectForKey:@"result"]objectForKey:@"list"];
    //            if ([array isKindOfClass:[NSNull class]]) {
    //                [PublicMethod setAlertInfo:@"暂无信息" andSuperview:self.view];
    //                return ;
    //            }
    //
    //            if (currentPage==1) {
    //                [infoArray removeAllObjects];
    //            }
    //
    //            [infoArray addObjectsFromArray:array];
    //
    //            if ([infoArray count]==0 && currentPage==1) {
    //                [PublicMethod setAlertInfo:@"暂无信息" andSuperview:self.view];
    //
    //            }
    //            pageCount =infoArray.count/10;
    //            //判断是否加载更多
    //            if (array.count==0 || array.count<10){
    //                self.canLoadMore = NO; // signal that there won't be any more items to load
    //            }else{
    //                self.canLoadMore = YES;
    //            }
    //
    //            DemoTableFooterView *fv = (DemoTableFooterView *)self.footerView;
    //            [fv.activityIndicator stopAnimating];
    //
    //            if (!self.canLoadMore) {
    //                fv.infoLabel.hidden = YES;
    //            }else{
    //                fv.infoLabel.hidden = NO;
    //            }
    //
    //            [self.tableView reloadData];
    //
    //        }
    //
    //
    //    } fail:^(NSError *error) {
    //                [ProgressHUD showError:@"网络连接失败"];
    //                NSLog(@"网络连接失败");
    //    }];
    //
    //
}
- (void)chooseTime:(UIButton*)btn
{
    UITextField *textF =[self.view viewWithTag:33330];
    UITextField *text2 =[self.view viewWithTag:33331];
    [textF resignFirstResponder];
    [text2 resignFirstResponder];
    [_pickview  remove];



    [_pickview remove];
    
    NSDate *date=[NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *comps = nil;
    
    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:0];
    
    [adcomps setMonth:0];
    
    [adcomps setDay:0];
    //        isBegin =NO;
    
    
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:date options:0];
    _pickview=[[ZHPickView alloc] initDatePickWithDate:newdate datePickerMode:UIDatePickerModeDate isHaveNavControler:NO];
    _pickview.delegate=self;
    _pickview .tag = btn.tag-100;
    [_pickview show];
    
   }

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultString:(NSString *)resultString{
    if (pickView.tag ==200)
    {
        UIButton *btn = [self.view viewWithTag:300];

        if ([resultString isEqualToString:@"0"]) {
            [btn setTitle:@"选择起始时间" forState:UIControlStateNormal ];
            [btn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
            return;
                
            }

        //选择日期
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *cellDate =[dateFormatter dateFromString:resultString];
        NSLog(@"%@",cellDate);
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSTimeInterval timr  = [cellDate timeIntervalSince1970];
        
        NSInteger time1 = timr;
        
        //当前时间
        NSDate *  senddate=[NSDate date];
        NSDateFormatter  *dateformat=[[NSDateFormatter alloc] init];
        [dateformat setDateFormat:@"yyyy-MM-dd"];
        NSTimeInterval timer  = [senddate timeIntervalSince1970];
        NSInteger time2 = timer;
        
        if(time1>time2+60){
            
            [ProgressHUD showError:@"时间不能晚于今天"];
            return;
            
        }else
        {
            [btn setTitle:[dateFormatter stringFromDate:cellDate] forState:UIControlStateNormal ];
            [btn setTitleColor:TextColor forState:UIControlStateNormal];

        }
        
        
    }else
    {
        if ([resultString isEqualToString:@"0"]) {
            UIButton *btn = [self.view viewWithTag:301];
            [btn setTitle:@"选择结束时间" forState:UIControlStateNormal ];

            [btn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] forState:UIControlStateNormal];
            
            return;
            
        }

        //选择日期
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *cellDate =[dateFormatter dateFromString:resultString];
        NSLog(@"%@",cellDate);
        NSTimeInterval timr  = [cellDate timeIntervalSince1970];
        NSInteger time1 = timr;
        
        //当前时间
        NSDate *  senddate=[NSDate date];
        NSTimeInterval timer  = [senddate timeIntervalSince1970];
        NSInteger time2 = timer;
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        if(time1>time2+60){
            
            
            [ProgressHUD showError:@"时间不能晚于今天"];
            return;
            
        }else
        {
            UIButton *btn = [self.view viewWithTag:301];
            [btn setTitle:[dateFormatter stringFromDate:cellDate] forState:UIControlStateNormal ];
            [btn setTitleColor:TextColor forState:UIControlStateNormal];

        }
        
        
    }
    
}
//我的出款、进款切换按钮
- (void)myMoneyBtn:(UIButton *)btn
{
    UITextField *textF =[self.view viewWithTag:33330];
    UITextField *text2 =[self.view viewWithTag:33331];
    [textF resignFirstResponder];
    [text2 resignFirstResponder];
    [_pickview  remove];


    for (int i=0; i<2; i++) {
        UIButton *btnAll =[self.view viewWithTag:120+i];
        btnAll.selected =NO;
        [btnAll setBackgroundColor:NavColor];
    }
    statuString =0;//每次切换都必须查询全部
    if(btn.tag==120)
    {
        isInOrOut=@"NO";//
        [self bottomShowOut];
        text2.placeholder =@"输入收款代理";
        [self  topShowOut];
        
    }else
    {
        isInOrOut=@"YES";//
        text2.placeholder =@"输入出款代理";

        [self bottomShow];
        [self  topShow];

    }
    [btn setBackgroundColor:[UIColor whiteColor]];
    btn.selected =YES;
    
    [self.tableView reloadData];
    
    
}
//查询按钮
- (void)withDrawlsBtnAction
{
    UITextField *textF =[self.view viewWithTag:33330];
    UITextField *text2 =[self.view viewWithTag:33331];
    [textF resignFirstResponder];
    [text2 resignFirstResponder];
    [_pickview  remove];
    UIButton *btn =[self.view viewWithTag:300];
    UIButton *btn2 =[self.view viewWithTag:301];
    if ([btn.currentTitle isEqualToString:@"选择起始时间"]) {
        [MBProgressHUD showError:@"请选择起始时间" ToView:self.view];
        return;
    }
    if ([btn.currentTitle isEqualToString:@"选择结束时间"]) {
        [MBProgressHUD showError:@"请选择结束时间" ToView:self.view];
        return;
    }

    if(IsNilString( text2.text))
    {
        [MBProgressHUD showError:@"请输入收款/出款代理" ToView:self.view];
        return;
    }

    
    
}

- (void)returnBtnAction
{
    UITextField *textF =[self.view viewWithTag:33330];
    UITextField *text2 =[self.view viewWithTag:33331];
    [textF resignFirstResponder];
    [text2 resignFirstResponder];
    
    [_pickview  remove];
    
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [_pickview  remove];
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITextField *textF =[self.view viewWithTag:33330];
    UITextField *text2 =[self.view viewWithTag:33331];
    [textF resignFirstResponder];
    [text2 resignFirstResponder];
    


}
@end
