//
//  TalkDesignerVC.m
//  家装
//
//  Created by Admin on 2017/9/19.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "TalkDesignerVC.h"

@interface TalkDesignerVC ()<UITextViewDelegate>
{
    UIView *bgScrollView;
    UITextView *textVPL;//评论
    UILabel *yinL;//写下你的评价吧
    UILabel *  uilabel;
    

}
@end

@implementation TalkDesignerVC
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
    [navTitle setText:@"找设计师"];
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
    xian.frame =CGRectMake(0,63, CXCWidth, 1);
    
    
    [self mainView];
}
-(void)mainView
{
    bgScrollView =[[UIView alloc] initWithFrame:CGRectMake(0, 64,CXCWidth, CXCHeight-64 )];
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

    NSArray*leftArr =@[@"设计",@"服务",@"贴心"];
    for (int i=0; i<3; i++) {
        UILabel*proLabel = [[UILabel alloc] initWithFrame:CGRectMake(_phoneImageV.right+16*Width,pingLabel.bottom+60*Width*i+20*Width,100*Width,50*Width)];
        proLabel.textColor = TextColor;
        proLabel.font = [UIFont fontWithName:@"Arial" size:12];
        proLabel.backgroundColor = [UIColor clearColor];
        proLabel.text =[NSString stringWithFormat:@"%@",leftArr[i]];
        proLabel.textAlignment =NSTextAlignmentCenter;
        [topView addSubview:proLabel];
        if (i==0) {
            //星星
            _sjImgView = [[StarView alloc]initWithFrame:CGRectMake(proLabel.right+20*Width,proLabel.top+10*Width, 150*Width, 30*Width)];
            _sjImgView.rating = [[NSString stringWithFormat:@"%@",@"5"] floatValue];
            [topView addSubview:_sjImgView];
            
        }else if (i==1) {
            //星星
            _fwImgView = [[StarView alloc]initWithFrame:CGRectMake(proLabel.right+20*Width,proLabel.top+10*Width, 180*Width, 30*Width)];
            _fwImgView.rating = [[NSString stringWithFormat:@"%@",@"5"] floatValue];
            [topView addSubview:_fwImgView];
            
        }else if (i==2) {
            //星星
            _txImgView = [[StarView alloc]initWithFrame:CGRectMake(proLabel.right+20*Width,proLabel.top+10*Width, 180*Width, 30*Width)];
            _txImgView.rating = [[NSString stringWithFormat:@"%@",@"5"] floatValue];
            [topView addSubview:_txImgView];
            
            
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

}
-(void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        uilabel.text = @"写下你的评论吧...";
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
            _sjImgView.rating = ((touchPoint.x-315*Width)/30*Width*4);
            NSLog(@"*********%f",_sjImgView.rating);
            
            if (_sjImgView.rating>5) {
                _sjImgView.rating=5;
                
            }
            NSLog(@"*********%f",_sjImgView.rating);
            
        }else if(touchPoint.x<315*Width&&touchPoint.x>260*Width){
            _sjImgView.rating=5;
        }else if(touchPoint.x>465*Width){
            _sjImgView.rating=5;
            
        }
        
    }
    if(touchPoint.y>140*Width&&touchPoint.y<200*Width)
    {
        if(touchPoint.x>315*Width&&touchPoint.x<465*Width)
        {
            _fwImgView.rating = ((touchPoint.x-315*Width)/30*Width*4);
            NSLog(@"_fwImgView*********%f",_fwImgView.rating);
            
            if (_fwImgView.rating>5) {
                _fwImgView.rating=5;
                
            }
            NSLog(@"_fwImgView*********%f",_fwImgView.rating);
            
        }else if(touchPoint.x<315*Width&&touchPoint.x>260*Width){
            _fwImgView.rating=0;
        }else if(touchPoint.x>465*Width){
            _fwImgView.rating=5;
            
        }
        
    }
    if(touchPoint.y>200*Width&&touchPoint.y<260*Width)
    {
        if(touchPoint.x>315*Width&&touchPoint.x<465*Width)
        {
            _txImgView.rating = ((touchPoint.x-315*Width)/30*Width*4);
            NSLog(@"_txImgView*********%f",_txImgView.rating);
            
            if (_txImgView.rating>5) {
                _txImgView.rating=5;
                
            }
            NSLog(@"_txImgView*********%f",_txImgView.rating);
            
        }else if(touchPoint.x<315*Width&&touchPoint.x>260*Width){
            _txImgView.rating=0;
        }else if(touchPoint.x>470*Width){
            _txImgView.rating=5;
            
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
