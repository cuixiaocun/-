//
//  DeclarationCenterVC.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/3.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "DeclarationCenterVC.h"
#import "MydeclarNewListVC.h"
#import "GoToDeclarVC.h"
#import "ManageDeclareVC.h"
#import "GoodsAndNumCell.h"
@interface DeclarationCenterVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView *bgScrollView;//最底下的背景

    NSArray*infoArray;
    UITableView *declarTabel;
}
@end

@implementation DeclarationCenterVC
- (void)viewWillAppear:(BOOL)animated
{
    [self getStoke];

    [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:BGColor];
    
    //图片
    UIImageView *imageview =[[UIImageView alloc] init];
    [imageview setBackgroundColor:NavColor];
    [imageview setFrame:CGRectMake(0, 0, CXCWidth, 64)];
    [self.view addSubview:imageview];
    [self.view sendSubviewToBack:imageview];
    //标题
    UILabel *navTitle =[[UILabel alloc] initWithFrame:CGRectMake(0, 20, CXCWidth, 44)];
    [navTitle setText:@"报单中心"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor whiteColor]];
    [self.view addSubview:navTitle];
    [self makeThisView];
    [PublicMethod getAppKey];

    [self getStoke];

}
- (void)makeThisView
{
   

    declarTabel = [[UITableView alloc]initWithFrame:CGRectMake(0,64, CXCWidth, CXCHeight-64-50)style:UITableViewStyleGrouped];
    [declarTabel setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [declarTabel setDelegate:self];
    [declarTabel setDataSource:self];
    [declarTabel setBackgroundColor:[UIColor clearColor]];
    declarTabel .showsVerticalScrollIndicator = NO;
    [self.view addSubview:declarTabel];
    

    
    
   



}
- (void)myBtnAciton:(UIButton*)btn
{
    if (btn.tag==300) {
        MydeclarNewListVC *mydeclarVC =[[MydeclarNewListVC alloc]init];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        [self.navigationController pushViewController:mydeclarVC animated:YES];
        
    }else if (btn.tag==301) {
        GoToDeclarVC *gotoDeclarVC =[[GoToDeclarVC alloc]init];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];

        [self.navigationController pushViewController:gotoDeclarVC animated:YES];
        

    }else if (btn.tag==302) {
    ManageDeclareVC*gotoDeclarVC =[[ManageDeclareVC alloc]init];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        gotoDeclarVC.statusString =@"全部";
        [self.navigationController pushViewController:gotoDeclarVC animated:YES];
        
    }else if (btn.tag==303) {
        ManageDeclareVC*gotoDeclarVC =[[ManageDeclareVC alloc]init];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        gotoDeclarVC.statusString =@"待审核";
        [self.navigationController pushViewController:gotoDeclarVC animated:YES];

        
    }else if (btn.tag==304) {
        ManageDeclareVC*gotoDeclarVC =[[ManageDeclareVC alloc]init];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        gotoDeclarVC.statusString =@"已审核";
        [self.navigationController pushViewController:gotoDeclarVC animated:YES];

        
    }else if (btn.tag==305) {
        
        
        
    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *str=@"  当前产品数量";
    CGSize titleSize;//通过文本得到高度
    
    titleSize = [str boundingRectWithSize:CGSizeMake( MAXFLOAT,70*Width) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    UILabel*promLabel =[[UILabel alloc]initWithFrame:CGRectMake(0,0 ,CXCWidth,70*Width )];
    promLabel.text =str;
    promLabel.backgroundColor =BGColor;
    promLabel.font =[UIFont systemFontOfSize:14];
    promLabel.textColor =TextGrayColor;

       return promLabel;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 70*Width;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return infoArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80*Width;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    GoodsAndNumCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[GoodsAndNumCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:CellIdentifier ];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
    }
        NSDictionary *dict = [infoArray objectAtIndex:[indexPath row]];
        [cell setDic:dict];
    return cell;
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
    return 850*Width;
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (!bgScrollView) {
        
    //底部scrollview
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, CXCWidth, CXCHeight-44-20)];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:bgScrollView];
    bgScrollView.backgroundColor =BGColor;
//    [bgScrollView setContentSize:CGSizeMake(CXCWidth, 570)];
    NSArray *topArr =@[@"baodan_icon_wobd",@"baodan_icon_to",@"baodan_icon_all",@"baodan_icon_dai",@"baodan_icon_yishenhe",@"proxy_me_icon_shengji",@"proxy_me_icon_tixian",@"proxy_me_icon_liuzhuan",@"proxy_me_icon_huiyuan",@"proxy_me_icon_ka",@"proxy_me_icon_fan",@"proxy_me_icon_shen",@"proxy_me_icon_shou",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",];
    
    NSArray*bottomArr =@[@"我的报单",@"去报单",@"全部",@"待审核",@"已审核",@"",@"",] ;
    for (int i=0; i<6; i++) {
        //大按钮
        UIButton *btn =[[UIButton alloc]initWithFrame:CGRectMake(375*Width*(i%2),20*Width+250*Width*(i/2),374*Width,249*Width)];
        [btn addTarget:self action:@selector(myBtnAciton:) forControlEvents:UIControlEventTouchUpInside] ;
        btn.tag =i+300;
        if (i>1) {
            btn.frame =CGRectMake(375*Width*(i%2),20*Width+77*Width+250*Width*(i/2),374*Width,249*Width);
            
        }
        btn.backgroundColor =[UIColor whiteColor];
        [bgScrollView addSubview:btn];
        if (i==1)
        {
            
            UILabel*declarLabel =[[UILabel alloc]initWithFrame:CGRectMake(0,btn.bottom ,CXCWidth,74*Width )];
            declarLabel.text =@"    报单管理";
            declarLabel.backgroundColor =BGColor;
            declarLabel.font =[UIFont systemFontOfSize:14];
            declarLabel.textColor =TextGrayColor;
            [bgScrollView addSubview:declarLabel];
            
            
            
        }
        if (i<5) {
            
            
            //上边图片
            UIImageView *topImgV =[[UIImageView alloc]initWithFrame:CGRectMake(127.5*Width,44*Width,120*Width,110*Width)];
            topImgV.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",topArr[i]]];
            topImgV.tag =1100+i;
            [btn addSubview:topImgV];
            if (i>2) {
                UILabel*numberLabel =[[UILabel alloc]initWithFrame:CGRectMake(210*Width, 30*Width,45*Width,45*Width )];
                numberLabel.tag =890+i;
                numberLabel.backgroundColor =NavColor;
                numberLabel.textColor =[UIColor whiteColor];
                numberLabel.textAlignment =NSTextAlignmentCenter;
                numberLabel.clipsToBounds = YES;
                numberLabel.font =[UIFont systemFontOfSize:14];
                [numberLabel.layer setMasksToBounds:YES];
                numberLabel.layer.cornerRadius=22.5*Width;
                [btn addSubview:numberLabel];
                numberLabel.hidden =YES;
                
                
                
                
                
            }
            
            //下边文字
            UILabel *botLabel =[[UILabel alloc]initWithFrame:CGRectMake(0*Width,topImgV.bottom,375*Width,85*Width)];
            botLabel.textAlignment=NSTextAlignmentCenter;
            botLabel.font =[UIFont systemFontOfSize:16];
            botLabel.textColor =BlackColor;
            botLabel.text =[NSString stringWithFormat:@"%@",bottomArr[i]];
            [btn addSubview:botLabel];
            
        }
        
    }
    
    
    }

    return bgScrollView;
    
    
}
- (void)getStoke
{
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{
//                          @"uid":[NSString stringWithFormat:@"%@",[[PublicMethod getDataKey:agen] objectForKey:@"id"]],
                          }
     ];
    
    [PublicMethod AFNetworkPOSTurl:@"home/AgentOnlineorder/myagenstock" paraments:dic1  addView:self.view success:^(id responseDic) {
        NSDictionary*  goodsDict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil] ;
        if([ [NSString stringWithFormat:@"%@",[goodsDict objectForKey:@"code"]]isEqualToString:@"0"])
        {
            
            [self geyCount];

            infoArray =[goodsDict objectForKey:@"data"];
            [declarTabel reloadData];
        }
        
    } fail:^(NSError *error) {
        
    }];
    
}
- (void)geyCount
{
    
    //
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{
//                          @"uid":[NSString stringWithFormat:@"%@",[[PublicMethod getDataKey:agen] objectForKey:@"id"]],
                          }
     ];
    
    [PublicMethod AFNetworkPOSTurl:@"home/AgentOnlineorder/countOnlineorderStatus" paraments:dic1  addView:self.view success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([[NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"]) {
            UILabel *numberOne =[self.view viewWithTag:893];
            UILabel *numberTwo =[self.view viewWithTag:894];
            
            NSArray *countArr  =[[dict objectForKey:@"data"] objectForKey:@"statusSum"];
            if (![countArr isEqual:[NSNull null]]) {
              
                numberOne.hidden =YES;
                numberTwo.hidden =YES;

                for (int i=0; i<countArr.count; i++) {
                 if([[NSString stringWithFormat:@"%@",[countArr[i]objectForKey:@"status"]]isEqualToString:@"1"]){
                            numberOne.text =[NSString stringWithFormat:@"%@",[countArr[i] objectForKey:@"sums"]];
                             CGSize titleSize = [[NSString stringWithFormat:@"%@   ",[countArr[i] objectForKey:@"sums"]] boundingRectWithSize:CGSizeMake( MAXFLOAT,45*Width) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
                            numberOne.width =titleSize.width;
                            numberOne.hidden =NO;
                    }
//                 else if([[NSString stringWithFormat:@"%@",[countArr[i]objectForKey:@"status"]]isEqualToString:@"3"])
//                        {
//                            numberTwo.text =[NSString stringWithFormat:@"%@",[countArr[i] objectForKey:@"sums"]];
//                            CGSize titleSize = [[NSString stringWithFormat:@"%@   ",[countArr[i] objectForKey:@"sums"]] boundingRectWithSize:CGSizeMake( MAXFLOAT,45*Width) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
//                            numberTwo.width =titleSize.width;
//                            numberTwo.hidden =NO;
//
//                        
//                        }
                     }
                    
                }else
                {
                    
                    numberOne.hidden =YES;
                    numberTwo.hidden =YES;
                
                }
        }
//
//                    UILabel *numberOne =[self.view viewWithTag:893+i];
//                    numberOne.width =titleSize.width;
//                    if ([[NSString stringWithFormat:@"%@",[countArr[i] objectForKey:@"sums"]]isEqualToString:@"0"]) {
//                        numberOne.hidden =YES;
//                    }else
//                    {
//                        numberOne.text =[NSString stringWithFormat:@"%@",[countArr[i] objectForKey:@"sums"]];
//                        numberOne.hidden =NO;
//
//
//                    }
//                    
//                    
//                }
//                
//
//            }else
//            {
//                for (int i=0; i<3; i++) {
//                    
//                    CGSize titleSize;//通过文本得到高度
//                    NSString *str =[NSString stringWithFormat:@" %@ ",[countArr[i] objectForKey:@"sums"]];
//                    titleSize = [str boundingRectWithSize:CGSizeMake( MAXFLOAT,45*Width) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
//                    
//                    UILabel *numberOne =[self.view viewWithTag:893+i];
//                    numberOne.width =titleSize.width;
//                    
//                    if ([[NSString stringWithFormat:@"%@",[countArr[i] objectForKey:@"sums"]]isEqualToString:@"0"]) {
//                        numberOne.hidden =YES;
//                    }else
//                    {
//                        numberOne.text =[NSString stringWithFormat:@"%@",[countArr[i] objectForKey:@"sums"]];
//                        numberOne.hidden =NO;
//                        
//                    }
//                    
//                    
//                }
//
//            
//            }
//                    }
        
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
