//
//  StarView.m
//  WXMovie
//
//  Created by mac on 15/3/3.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "StarView.h"
#import "UIViewExt.h"

@implementation StarView{

    UIView *yellowView; //黄色星星
}

//如果此视图使用nib文件画出时,此方法会被调用
- (void)awakeFromNib{

    [self _creatSubviews];

}

//当创建当前类的对象时,使用alloc方式会调用此方法
- (id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self _creatSubviews];
    }
    
    return self;


}

- (void)_creatSubviews{
    
    UIImage *grayImage = [UIImage imageNamed:@"star_hui.png"];
    UIImage *yellowImage = [UIImage imageNamed:@"star_huang.png"];
    
    //灰色星星视图
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, grayImage.size.width * 5, grayImage.size.height)];
    grayView.backgroundColor = [UIColor colorWithPatternImage:grayImage];
    [self addSubview:grayView];
    
    //黄色星星视图
    yellowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, grayImage.size.width * 5, grayImage.size.height)];
    yellowView.backgroundColor = [UIColor colorWithPatternImage:yellowImage];
    [self addSubview:yellowView];
    self.width = self.height * 5;
    
    //通过外部传入的高度设置星星缩放的比例
    float scale = self.frame.size.height / yellowImage.size.height;
    grayView.transform = CGAffineTransformMakeScale(scale, scale);
    yellowView.transform = CGAffineTransformMakeScale(scale, scale);
    
    //更改frame后会改变坐标,将星星视图的坐标设置为原始值
    grayView.origin = CGPointZero;
    yellowView.origin = CGPointZero;
    
    
    

}

//通过外部传入的分数,设置黄色星星的大小
- (void)setRating:(CGFloat)rating{

    _rating = rating;
    float width =  _rating / 5 * self.frame.size.width;
    yellowView.width = width+2;
    
    
}

@end
