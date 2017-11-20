//
//  TalkShopStoreVC.m
//  家装
//
//  Created by Admin on 2017/9/23.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "TalkShopStoreVC.h"

@interface TalkShopStoreVC ()<UITextViewDelegate>
{
    UIView *bgScrollView;
    UITextView *textVPL;//评论
    UILabel *yinL;//写下你的评价吧
    UILabel *  uilabel;
    
    
}
@end

@implementation TalkShopStoreVC

- (void)viewDidLoad {
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
    [navTitle setText:@"评论"];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    [navTitle setFont:[UIFont boldSystemFontOfSize:18]];
    [navTitle setNumberOfLines:0];
    [navTitle setTextColor:[UIColor blackColor]];
    [self.view addSubview:navTitle];
    //横线
    UIImageView*xian =[[UIImageView alloc]init];
    xian.backgroundColor =BGColor;
    [topImageView addSubview:xian];
    xian.frame =CGRectMake(0,Frame_NavAndStatus-1, CXCWidth, 1);
    
    
    [self mainView];
}
-(void)mainView
{
    bgScrollView =[[UIView alloc] initWithFrame:CGRectMake(0, Frame_NavAndStatus,CXCWidth, CXCHeight-Frame_NavAndStatus )];
    [bgScrollView setUserInteractionEnabled:YES];
    [bgScrollView setBackgroundColor:BGColor];
    //    bgScrollView.showsHorizontalScrollIndicator = NO;
    //    bgScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:bgScrollView];
    
    UIView* topView =[[UIView alloc]initWithFrame:CGRectMake(0,0, CXCWidth, 300*Width)];
    
    [bgScrollView addSubview:topView];
    //图片
    _phoneImageV =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timg.png"]];
    _phoneImageV.backgroundColor =BGColor;
    _phoneImageV.frame=CGRectMake(24*Width, 30*Width, 160*Width, 160*Width);
    [topView addSubview:_phoneImageV];
    UILabel *pingLabel =[[UILabel alloc]initWithFrame:CGRectMake(_phoneImageV.right+20*Width, _phoneImageV.top, 400*Width, 50*Width)];
    pingLabel.textColor = TextColor;
    pingLabel.font = [UIFont fontWithName:@"Arial" size:14];
    pingLabel.backgroundColor = [UIColor clearColor];
    pingLabel.userInteractionEnabled =YES;
    pingLabel.text =[NSString stringWithFormat:@"%@",@"评价"];
    [topView addSubview:pingLabel   ];
    topView.backgroundColor =[UIColor whiteColor];
    
    NSArray*leftArr =@[@"口碑",@"服务",@"贴心"];
    for (int i=0; i<1; i++) {
        UILabel*proLabel = [[UILabel alloc] initWithFrame:CGRectMake(_phoneImageV.right+16*Width,pingLabel.bottom+60*Width*i+20*Width,100*Width,50*Width)];
        proLabel.textColor = TextColor;
        proLabel.font = [UIFont fontWithName:@"Arial" size:12];
        proLabel.backgroundColor = [UIColor clearColor];
        proLabel.text =[NSString stringWithFormat:@"%@",leftArr[i]];
        proLabel.textAlignment =NSTextAlignmentCenter;
        [topView addSubview:proLabel];
        if (i==0) {
            //星星
            _pfImgView = [[StarView alloc]initWithFrame:CGRectMake(proLabel.right+20*Width,proLabel.top+10*Width, 150*Width, 30*Width)];
            _pfImgView.rating = [[NSString stringWithFormat:@"%@",@"5"] floatValue];
            [topView addSubview:_pfImgView];
            
        }
    }
    
    
    UIImageView *xian=[[UIImageView alloc]initWithFrame:CGRectMake(20*Width,topView.height-1.5*Width, 710*Width,1.5*Width)];
    [topView addSubview:xian];
    xian.backgroundColor =BGColor;
    
    //评论
    UIView *xiaV = [[UIView alloc]initWithFrame:CGRectMake(0, topView.bottom, CXCWidth, 200*Width)];
    xiaV.backgroundColor = [UIColor whiteColor ];
    xiaV.tag =1001;
    [bgScrollView addSubview:xiaV];
    
    
    
    textVPL = [[UITextView alloc]initWithFrame:CGRectMake(25*Width, 20*Width,700*Width , 170*Width)];
    textVPL.delegate  = self;
    textVPL.font =[UIFont systemFontOfSize:14];
    [xiaV addSubview:textVPL];
    
    uilabel =[[UILabel alloc]initWithFrame:CGRectMake(textVPL.left+2  ,textVPL.top+3.5 , 150, 20)];
    uilabel.text = @"你的点评...";
    uilabel.textColor  = [UIColor lightGrayColor];
    uilabel.font = [UIFont systemFontOfSize:14];
    uilabel.enabled = NO;//lable必须设置为不可用
    uilabel.backgroundColor = [UIColor clearColor];
    [xiaV addSubview:uilabel];
    
    
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(40*Width,600*Width , 670*Width, 88*Width);
    layer.backgroundColor = NavColor.CGColor;
    layer.shadowOffset = CGSizeMake(5, 5);
    layer.shadowOpacity = 0.4;
    layer.cornerRadius = 44*Width;
    layer.shadowColor = NavColor.CGColor;
    
    [bgScrollView.layer addSublayer:layer];
    
    //按钮
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setFrame:CGRectMake(40*Width,600*Width , 670*Width, 88*Width)];
    [nextBtn setBackgroundColor:NavColor];
    [nextBtn.layer setCornerRadius:44*Width];
    [nextBtn.layer setMasksToBounds:YES];
    [nextBtn setTitle:@"提交" forState:UIControlStateNormal];
    [nextBtn.titleLabel setTextColor:[UIColor whiteColor]];
    
    [nextBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [nextBtn addTarget:self action:@selector(sureDrawls) forControlEvents:UIControlEventTouchUpInside];
    [bgScrollView addSubview:nextBtn];
    
    
}
- (void)sureDrawls
{
    if ([[NSString stringWithFormat:@"%@",textVPL.text] isEqualToString:@""]||[NSString stringWithFormat:@"%@",textVPL.text].length<5) {
        [MBProgressHUD showSuccess:@"请输入五字以上的文字" ToView:self.view];
        return;
    }
    
    
    NSString* uid  = [NSString stringWithFormat:@"%@",_shopId];
    
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setDictionary:@{
                          @"shop_id":uid,
                          @"data[score]":[NSString stringWithFormat:@"%d",(int)_pfImgView.rating],
                          @"data[content]":[NSString stringWithFormat:@"%@",textVPL.text],
                          }];
    
    [PublicMethod AFNetworkPOSTurl:@"mobileapi/?shop-savecomment" paraments:dic1  addView:self.view addNavgationController:self.navigationController success:^(id responseDic) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseDic options:NSJSONReadingMutableContainers error:nil];
        if ([ [NSString stringWithFormat:@"%@",[dict objectForKey:@"error"]]isEqualToString:@"0"]) {
            
            [MBProgressHUD showSuccess:@"评论成功" ToView:self.view];
            [self performSelector:@selector(pinglunSuccess) withObject:nil afterDelay:1];
            
        }
        
    } fail:^(NSError *error) {
        
    }];
    
    
    
    
    
    
    
}
-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        uilabel.text = @"你的点评...";
    }else{
        uilabel.text = @"";
    }
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    uilabel.text = @"";
    
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [textVPL resignFirstResponder];
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:bgScrollView];//就是触点的坐标。
    NSLog(@"%f-%f",touchPoint.x,touchPoint.y );
    if(touchPoint.y>80*Width&&touchPoint.y<147*Width)
    {
        if(touchPoint.x>315*Width&&touchPoint.x<465*Width)
        {
            _pfImgView.rating =(int) ((touchPoint.x-315*Width)/30*Width*4)+1;
            NSLog(@"*********%f",_pfImgView.rating);
            
            if (_pfImgView.rating>5) {
                _pfImgView.rating=5;
                
            }
            NSLog(@"*********%f",_pfImgView.rating);
            
        }else if(touchPoint.x<315*Width&&touchPoint.x>260*Width){
            _pfImgView.rating=0;
        }else if(touchPoint.x>465*Width){
            _pfImgView.rating=5;
            
        }
        
    }
        
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if (buttonIndex ==0) {
        
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        
    }
    
}







- (void)returnBtnAction
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pinglunSuccess
{
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

@end
