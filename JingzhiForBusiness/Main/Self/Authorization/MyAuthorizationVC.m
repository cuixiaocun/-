//
//  MyAuthorizationVC.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/5.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "MyAuthorizationVC.h"
@interface MyAuthorizationVC ()
{
    UIScrollView *bgScrollView;
    UIImageView *mainImgView;

}
@end

@implementation MyAuthorizationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:BGColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    bgScrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,CXCWidth, CXCHeight)];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setBackgroundColor:BGColor];
    [self.view addSubview:bgScrollView];
    [bgScrollView setContentSize:CGSizeMake(CXCWidth, 1334*Width)];
    
    UIImageView *bgImgView =[[UIImageView   alloc]initWithFrame:CGRectMake(0, 0, CXCWidth,1334*Width)];
    [bgImgView setUserInteractionEnabled:YES];
    bgImgView.image =[UIImage imageNamed:@"cert_bg_shan"];
    [bgScrollView addSubview:bgImgView];
    mainImgView =[[UIImageView   alloc]initWithFrame:CGRectMake(50*Width, 64, 650*Width,1100*Width)];
    [mainImgView setUserInteractionEnabled:YES];
    mainImgView.image =[UIImage imageNamed:@"cert_icon_box"];
    [bgScrollView addSubview:mainImgView];
    
    

    

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
    [navTitle setText:@"资格证书"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor whiteColor]];
    [self.view addSubview:navTitle];
  
       [self mainView];
    [self credentials];
}
-(void)mainView
{
    
    //头像外环
    UIImageView *bgtouImg =[[UIImageView alloc]init] ;
    [bgtouImg setFrame:CGRectMake(44*Width, 264*Width, 108*Width, 108*Width)];
    bgtouImg.userInteractionEnabled =YES;
    [bgtouImg setBackgroundColor:[UIColor colorWithRed:248/255.0 green:191/255.0 blue:134/255.0 alpha:1]];
    [mainImgView addSubview:bgtouImg];
    [bgtouImg.layer setCornerRadius:4];
    [bgtouImg.layer setMasksToBounds:YES];
    
    //头像
    UIImageView *touImageV = [[UIImageView alloc]init];
    [touImageV setFrame:CGRectMake(4*Width, 4*Width, 100*Width, 100*Width)];
    [touImageV setImage:[UIImage imageNamed:@"cert_icon_head"]];
    touImageV.tag =3329;
    touImageV.userInteractionEnabled =YES;
    [touImageV.layer setMasksToBounds:YES];
    [bgtouImg addSubview:touImageV];
    //姓名
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(bgtouImg.right+42*Width,bgtouImg.top-10*Width, 400*Width, 55*Width)];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.tag =3330;
    nameLabel.text =@"代理商:";
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textColor = [UIColor whiteColor];
    [mainImgView   addSubview:nameLabel];
    
    //等级
    UILabel *levelLabel = [[UILabel alloc]initWithFrame:CGRectMake(bgtouImg.right+42*Width,nameLabel.bottom, 400*Width, 55*Width)];
    levelLabel.textColor = [UIColor whiteColor];
    levelLabel.tag =3331;
    levelLabel.text =@"等级:";
    levelLabel.textAlignment = NSTextAlignmentLeft;
    levelLabel.font = [UIFont systemFontOfSize:15];
    levelLabel.textColor = [UIColor whiteColor];
    [mainImgView   addSubview:levelLabel];

    //电话
    UILabel *telphoneL = [[UILabel alloc]initWithFrame:CGRectMake(bgtouImg.right+42*Width,levelLabel.bottom+20*Width, 400*Width, 55*Width)];
    telphoneL.textColor = [UIColor whiteColor];
    telphoneL.tag =3332;
    telphoneL.text=@"手机号:";
    telphoneL.textAlignment = NSTextAlignmentLeft;
    telphoneL.font = [UIFont systemFontOfSize:15];
    telphoneL.textColor = [UIColor whiteColor];
    [mainImgView  addSubview:telphoneL];
    
    //微信
    UILabel *wxLabel = [[UILabel alloc]initWithFrame:CGRectMake(bgtouImg.right+42*Width,telphoneL.bottom, 400*Width, 55*Width)];
    wxLabel.textColor = [UIColor whiteColor];
    wxLabel.tag =3333;
    wxLabel.text=@"微信号:";
    wxLabel.textAlignment = NSTextAlignmentLeft;
    wxLabel.font = [UIFont systemFontOfSize:15];
    wxLabel.textColor = [UIColor whiteColor];
    [mainImgView  addSubview:wxLabel];
    
    UIImageView* xianV =[[UIImageView alloc]initWithFrame:CGRectMake(bgtouImg.right+42*Width,levelLabel.bottom+10*Width , 450*Width, 1)];
    xianV.image =[UIImage imageNamed:@"cert_icon_dashed"];
    [mainImgView addSubview:xianV];
    
    UILabel *textLabel =[[UILabel alloc]initWithFrame:CGRectMake(30*Width, 530*Width , 590*Width, 200*Width)];
    textLabel.font =[UIFont systemFontOfSize:14];
    textLabel.textColor = TextColor;
    textLabel.tag =3334;

  
    textLabel.numberOfLines=0;
    [mainImgView addSubview:textLabel];
    
    UIImageView *numberImg =[[UIImageView  alloc]initWithFrame:CGRectMake(60*Width, 770*Width, 520*Width, 120*Width)];
    numberImg.image =[UIImage imageNamed:@"cert_icon_certno"];
    [mainImgView addSubview:numberImg];
    
    UILabel *numberLabel =[[UILabel alloc]initWithFrame:CGRectMake(70*Width,800*Width,500*Width , 80*Width)];
    numberLabel.text =@"NO.";
    numberLabel.textAlignment =NSTextAlignmentCenter;
    [mainImgView addSubview:numberLabel ];
    numberLabel.tag =3335;
    numberLabel.font = [UIFont systemFontOfSize:18];
    numberLabel.textColor =[UIColor colorWithRed:252/255.0 green:109/255.0 blue:13/255.0 alpha:1];
    UILabel *compLabel =[[UILabel alloc]initWithFrame:CGRectMake(25*Width,970*Width,600*Width , 50*Width)];
    compLabel.text =@"授权公司:河南心体荟健康管理有限公司";
    compLabel.textAlignment =NSTextAlignmentRight;
    [mainImgView addSubview:compLabel ];
    compLabel.font = [UIFont systemFontOfSize:12];
    compLabel.textColor =TextColor;

    
    UILabel *timeLabel =[[UILabel alloc]initWithFrame:CGRectMake(25*Width,1020*Width,600*Width , 50*Width)];
    timeLabel.text =@"授权时间:2017年6月22号";
    timeLabel.tag =3337;
    timeLabel.textAlignment =NSTextAlignmentRight;
    [mainImgView addSubview:timeLabel ];
    timeLabel.font = [UIFont systemFontOfSize:12];
    timeLabel.textColor =TextColor;
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    


}
- (void)withDrawlsBtnAction
{
    
    
    
}
- (void)returnBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)credentials
{
    
    [PublicMethod AFNetworkPOSTurl:@"home/Agen/credentials" paraments:@{
    
        @"uid":[NSString stringWithFormat:@"%@",[[PublicMethod getDataKey:agen] objectForKey:@"id"]]}addView:self.view success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"code"]]isEqualToString:@"0"]) {
            
            UILabel*nameLabel =[self.view viewWithTag:3330];
            UILabel*levelLabel =[self.view viewWithTag:3331];
            UILabel*phoneLabel =[self.view viewWithTag:3332];
            UILabel*wechatLabel =[self.view viewWithTag:3333];
            UILabel*promLabel =[self.view viewWithTag:3334];
            UILabel*numberLabel =[self.view viewWithTag:3335];

            UILabel*timeLabel =[self.view viewWithTag:3337];

            nameLabel.text=[NSString stringWithFormat:@"代理人：%@",[[dict objectForKey:@"data"] objectForKey:@"name"]];
            levelLabel.text=[NSString stringWithFormat:@"等级：%@级代理",[[dict objectForKey:@"data"] objectForKey:@"level"]];
            phoneLabel.text=[NSString stringWithFormat:@"手机号：%@",[[dict objectForKey:@"data"] objectForKey:@"phone"]];
            wechatLabel.text =[NSString stringWithFormat:@"微信号：%@",[[dict objectForKey:@"data"] objectForKey:@"webchat"]];
            numberLabel.text =[NSString stringWithFormat:@"NO.%@",[[dict objectForKey:@"data"] objectForKey:@"id"]];
            
            
            NSString *contentStr =[NSString stringWithFormat:@"      兹证明,代理人:%@,身份证号:%@为本公司有效代理,本证明长期有效,并具备法律效应。",[[dict objectForKey:@"data"] objectForKey:@"name"],[[dict objectForKey:@"data"] objectForKey:@"idcard"]] ;
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:contentStr];
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineSpacing = 10;// 字体的行间距
            NSDictionary *attributeDict0 = [NSDictionary dictionaryWithObjectsAndKeys:
                                            
                                            paragraphStyle,NSParagraphStyleAttributeName,
                                            nil];
            [str addAttributes:attributeDict0 range:NSMakeRange(0, str.length)];
            
            NSDictionary *attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                           [UIFont systemFontOfSize:16.0],NSFontAttributeName,
                                           [UIColor blackColor],NSForegroundColorAttributeName,
                                           nil];
            //设置：名字
            [str addAttributes:attributeDict range:NSMakeRange(14, [NSString stringWithFormat:@"%@",[[dict objectForKey:@"data"] objectForKey:@"name"]].length)];
            NSDictionary *attributeDict2 = [NSDictionary dictionaryWithObjectsAndKeys:
                                            [UIFont systemFontOfSize:16.0],NSFontAttributeName,
                                            [UIColor blackColor],NSForegroundColorAttributeName,
                                            nil];
            //设置：身份证号
            [str addAttributes:attributeDict2 range:NSMakeRange(str.length-25-[NSString stringWithFormat:@"%@",[[dict objectForKey:@"data"] objectForKey:@"idcard"]].length, [NSString stringWithFormat:@"%@",[[dict objectForKey:@"data"] objectForKey:@"idcard"]].length)];
            
            promLabel.attributedText = str;
            timeLabel.text =[NSString stringWithFormat:@"授权时间：%@",[[dict objectForKey:@"data"] objectForKey:@"updatetime"]];
            
            
        }
        
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
