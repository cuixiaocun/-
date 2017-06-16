//
//  IsTureAlterView.m
//  JingzhiForBusiness
//
//  Created by Admin on 2017/6/6.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "IsTureAlterView.h"

@implementation IsTureAlterView
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithTitile:(NSString*)titileString{
    if (self == [super init]) {
      
        {
            self.frame =CGRectMake(0, 0, CXCWidth, CXCHeight);
            //若存在就不走里边的直接hidden=no;
            if (!self.blackBgView) {
                self.blackBgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, CXCWidth, CXCHeight)];
                [self.blackBgView setAlpha:0.5];
                [self.blackBgView  setBackgroundColor:[UIColor blackColor]];
                [self addSubview:self.blackBgView];
                
                self.alterView=[[UIView alloc]initWithFrame:CGRectMake(65*Width, CXCHeight/2-125*Width, 620*Width, 250*Width)];
                [self addSubview:self.alterView];
                [self.alterView setBackgroundColor:[UIColor whiteColor]];
                [self.alterView.layer setCornerRadius:20*Width];
                [self.alterView.layer setBorderWidth:1.0*Width];
                self.alterView.layer.borderColor =BGColor.CGColor;
                [self.alterView.layer setMasksToBounds:YES];
                
                
                UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(0*Width, 0*Width, 620*Width, 155*Width)];
                label.textAlignment =NSTextAlignmentCenter;
                label.textColor =BlackColor;
                [label setText:titileString];
                [self.alterView addSubview:label];
                
                //线
                UIImageView*xian =[[UIImageView alloc]init];
                xian.backgroundColor =BGColor;
                [self.alterView addSubview:xian];
                xian.frame =CGRectMake(0*Width,153*Width, 620*Width, 2*Width);
                //取消按钮
                UIButton*cancelBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, xian.bottom, 310*Width, 100*Width)];
                [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
                [cancelBtn setTitleColor:BlackColor forState:UIControlStateNormal];
                [cancelBtn addTarget:self action:@selector(cancelBtn) forControlEvents:UIControlEventTouchUpInside];
                
                [self.alterView addSubview:cancelBtn];
                //确认按钮
                UIButton*tureBtn =[[UIButton alloc]initWithFrame:CGRectMake(310*Width, xian.bottom, 310*Width, 100*Width)];
                [tureBtn setBackgroundColor:NavColor];
                [tureBtn setTitle:@"确认" forState:UIControlStateNormal];
                [tureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [tureBtn addTarget:self action:@selector(tureBtn) forControlEvents:UIControlEventTouchUpInside];
                [self.alterView addSubview:tureBtn];
            }
            
           self. blackBgView.hidden=NO;
           self. alterView.hidden =NO;
            
        }
        
        
        
        
        
    }
    return self;
}
- (void)cancelBtn
{
    [self.delegate cancelBtnActin];
}
-(void)tureBtn
{
    [self.delegate tureBtnAction];
}

@end
