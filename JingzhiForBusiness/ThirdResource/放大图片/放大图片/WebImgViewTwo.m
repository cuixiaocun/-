//
//  WebImgViewTwo.m
//  家装
//
//  Created by Admin on 2017/9/20.
//  Copyright © 2017年 cuixiaocun. All rights reserved.
//

#import "WebImgViewTwo.h"
#import "WBImageViewItem.h"

#define kWBImageViewW 250*Width
#define kWBImageViewH 200*Width

#define kWBspace 22.5*Width
@implementation WebImgViewTwo


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
        WBImageViewItem *imageView =[[WBImageViewItem alloc]initWithFrame:[WebImgViewTwo getFrameAtIndex:i]];
        NSLog(@"%@",[NSString stringWithFormat:@"%@",_dataList[i]]);
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_dataList[i]]]];
        imageView.dataList = _dataList;
        imageView.index = i;
        imageView.originSuperView2  =self;
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
    
    
    CGFloat x = index%2*(kWBImageViewW+kWBspace)+130*Width;
    CGFloat y = index/2*(kWBImageViewH+kWBspace);
    
    return CGRectMake(x, y, kWBImageViewW, kWBImageViewH);
    
}

+(CGFloat) heightForCount:(int)count{
    if (count==0) {
        return 0;
    }
    return ((count -1)/2+1)*(kWBImageViewH+kWBspace);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
