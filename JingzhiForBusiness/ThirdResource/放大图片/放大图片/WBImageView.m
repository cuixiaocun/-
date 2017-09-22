//
//  WBImageView.m
//  WBImageViewDemo
//
//  Created by wang xinkai on 15/4/15.
//  Copyright (c) 2015年 wxk. All rights reserved.
//

/*
 
 1.点击放大动画，在present出来的VC.view里面完成
 
 2.点击dismiss动画，在WBImageView完成
 
 */



#import "WBImageView.h"
#import "WBImageViewItem.h"
#define kWBImageViewWH 205*Width
#define kWBspace 22.5*Width
@implementation WBImageView



-(void)setDataList:(NSArray *)dataList{
    
    _dataList= dataList;
    
    //    tableView重用时，先移除原有的item
    for (UIView* view in self.subviews) {
        if (view.tag >=1000 &&view.tag<=1009) {
            
            [view removeFromSuperview];
        }
        
    }
    
    for (int i = 0; i<dataList.count; i++) {
        
        //        初始化
        WBImageViewItem *imageView =[[WBImageViewItem alloc]initWithFrame:[WBImageView getFrameAtIndex:i]];
              NSLog(@"%@",[NSString stringWithFormat:@"%@",_dataList[i]]);
       [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_dataList[i]]]];
        imageView.dataList = _dataList;
        imageView.index = i;
        imageView.originSuperView  =self;
        imageView.tag = 1000+i;
        [self addSubview:imageView];
        
    }
    
}
-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}
-(WBImageViewItem*)itemAtIndex:(NSInteger)index{
    
    return (WBImageViewItem*)[self viewWithTag:index+1000];
}



//返回图片的frame 根据图片的index
+(CGRect)getFrameAtIndex:(NSInteger)index{
    
    
    CGFloat x = index%3*(kWBImageViewWH+kWBspace);
    CGFloat y = index/3*(kWBImageViewWH+kWBspace);
    
    return CGRectMake(x, y, kWBImageViewWH, kWBImageViewWH);
    
}

+(CGFloat) heightForCount:(int)count{
    if (count==0) {
        return 0;
    }
    return ((count -1)/3+1)*(kWBImageViewWH+kWBspace);
}

@end
