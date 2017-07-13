//
//  OrderCenterVC.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/3.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "OrderCenterVC.h"
#import "MyOrderListVC.h"
#import "GotoOrderVC.h"
#import "ManageOrderVC.h"
@interface OrderCenterVC ()
{
    UIScrollView *bgScrollView;//最底下的背景
    
    
}
@end

@implementation OrderCenterVC
- (void)viewWillAppear:(BOOL)animated
{
    [self geyCount];

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
    [navTitle setText:@"订单中心"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor whiteColor]];
    [self.view addSubview:navTitle];
    [self makeThisView];
    [PublicMethod getAppKey];
    [self geyCount];
}
- (void)makeThisView
{
    
    //底部scrollview
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 44+20, CXCWidth, CXCHeight-44-20)];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:bgScrollView];
    bgScrollView.backgroundColor =BGColor;
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, 570)];
    
    
    NSArray *topArr =@[@"order_icon_wodingdan",@"order_icon_to",@"baodan_icon_all",@"baodan_icon_dai",@"order_icon_daifahuo",@"baodan_icon_done",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",];
    NSArray*bottomArr =@[@"我的订单",@"去下单",@"全部",@"未发货",@"已发货",@"已完成",@"",] ;
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
            declarLabel.text =@"    订单管理";
            declarLabel.backgroundColor =BGColor;
            declarLabel.font =[UIFont systemFontOfSize:14];
            declarLabel.textColor =TextGrayColor;
            [bgScrollView addSubview:declarLabel];
            
            
            
        }
        
            
            //上边图片
            UIImageView *topImgV =[[UIImageView alloc]initWithFrame:CGRectMake(127.5*Width,44*Width,120*Width,110*Width)];
            topImgV.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",topArr[i]]];
            topImgV.tag =1100+i;
            [btn addSubview:topImgV];
            if (i>2&&i<6) {
                CGSize titleSize;//通过文本得到高度
                
                titleSize = [@" 99+ " boundingRectWithSize:CGSizeMake( MAXFLOAT,45*Width) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
                
                
                
                UILabel*numberLabel =[[UILabel alloc]initWithFrame:CGRectMake(210*Width, 30*Width,titleSize.width,45*Width )];
                numberLabel.tag =890+i;
                numberLabel.backgroundColor =NavColor;
                numberLabel.textColor =[UIColor whiteColor];
                numberLabel.textAlignment =NSTextAlignmentCenter;
                numberLabel.clipsToBounds = YES;
                numberLabel.font =[UIFont systemFontOfSize:14];
                [numberLabel.layer setMasksToBounds:YES];
                numberLabel.layer.cornerRadius=22.5*Width;
                [btn addSubview:numberLabel];
                
                
                
                
                
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
- (void)myBtnAciton:(UIButton*)btn
{
    if (btn.tag==300) {
        MyOrderListVC *orderVC =[[MyOrderListVC alloc]init];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        [self.navigationController pushViewController:orderVC animated:YES];

        
    }else if (btn.tag==301) {
        GotoOrderVC *orderVC =[[GotoOrderVC alloc]init];
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        [self.navigationController pushViewController:orderVC animated:YES];

        
    }else if (btn.tag==302) {
        ManageOrderVC *orderVC =[[ManageOrderVC alloc]init];
        orderVC.statusString =@"全部";
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        [self.navigationController pushViewController:orderVC animated:YES];

    }
    else if (btn.tag==303) {
        ManageOrderVC *orderVC =[[ManageOrderVC alloc]init];
        orderVC.statusString =@"未发货";
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        [self.navigationController pushViewController:orderVC animated:YES];
        

    }
    else if (btn.tag==304) {
        ManageOrderVC *orderVC =[[ManageOrderVC alloc]init];
        orderVC.statusString =@"已发货";
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        [self.navigationController pushViewController:orderVC animated:YES];
        

    }
    else if (btn.tag==305) {
        ManageOrderVC *orderVC =[[ManageOrderVC alloc]init];
        orderVC.statusString =@"已完成";
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        [self.navigationController pushViewController:orderVC animated:YES];
        

    }

    
}
- (void)geyCount
{
    
    //
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{
//                          @"uid":[NSString stringWithFormat:@"%@",[[PublicMethod getDataKey:agen] objectForKey:@"id"]],
                          
                          }
     ];
    
    [PublicMethod AFNetworkPOSTurl:@"home/AgentOnlineorder/countAgenorderStatus" paraments:dic1  addView:self.view success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([[NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"]) {
            UILabel *numberOne =[self.view viewWithTag:893];
            UILabel *numberTwo =[self.view viewWithTag:894];
            UILabel *numberthree =[self.view viewWithTag:895];

            NSArray *countArr  =[[dict objectForKey:@"data"] objectForKey:@"statusSum"];
            if (![countArr isEqual:[NSNull null]]) {
                
                numberOne.hidden =YES;
                numberTwo.hidden =YES;
                numberthree.hidden =YES;

                for (int i=0; i<countArr.count; i++) {
                    if([[NSString stringWithFormat:@"%@",[countArr[i]objectForKey:@"status"]]isEqualToString:@"2"]){
                        numberOne.text =[NSString stringWithFormat:@"%@",[countArr[i] objectForKey:@"sums"]];
                        CGSize titleSize = [[NSString stringWithFormat:@"  %@ ",[countArr[i] objectForKey:@"sums"]] boundingRectWithSize:CGSizeMake( MAXFLOAT,45*Width) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
                        numberOne.width =titleSize.width;
                        numberOne.hidden =NO;
                    }else if([[NSString stringWithFormat:@"%@",[countArr[i]objectForKey:@"status"]]isEqualToString:@"3"])
                    {
                        numberTwo.text =[NSString stringWithFormat:@"%@",[countArr[i] objectForKey:@"sums"]];
                        CGSize titleSize = [[NSString stringWithFormat:@"  %@ ",[countArr[i] objectForKey:@"sums"]] boundingRectWithSize:CGSizeMake( MAXFLOAT,45*Width) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
                        numberTwo.width =titleSize.width;
                        numberTwo.hidden =NO;
                        
                        
                    }
//                    else if([[NSString stringWithFormat:@"%@",[countArr[i]objectForKey:@"status"]]isEqualToString:@"4"])
//                    {
//                        numberthree.text =[NSString stringWithFormat:@"%@",[countArr[i] objectForKey:@"sums"]];
//                        CGSize titleSize = [[NSString stringWithFormat:@"  %@ ",[countArr[i] objectForKey:@"sums"]] boundingRectWithSize:CGSizeMake( MAXFLOAT,45*Width) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
//                        numberthree.width =titleSize.width;
//                        numberthree.hidden =NO;
//                        
//                        
//                    }

                }
                
            }else
            {
                
                
                numberOne.hidden =YES;
                numberTwo.hidden =YES;
                numberthree.hidden =YES;
                
            }
        }
        
    } fail:^(NSError *error) {
        
    }];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
