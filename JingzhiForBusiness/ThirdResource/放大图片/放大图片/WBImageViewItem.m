//
//  WBImageViewItem.m
//  WBImageViewDemo
//
//  Created by wang xinkai on 15/4/15.
//  Copyright (c) 2015年 wxk. All rights reserved.
//

#import "WBImageViewItem.h"
//#import "WBImageViewController.h"
#import "AKGallery.h"

//#import "UIView+UIViewController.h"
@implementation WBImageViewItem

-(id)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
//        布局方式
        self.contentMode = UIViewContentModeScaleAspectFit;
//        打开响应
        self.userInteractionEnabled = YES;
//        添加tap手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAct)];
        [self addGestureRecognizer:tap];
        
//        创建时 保存frame
        _originFrame = frame;
        
    }
    return self;
}


//点击时间需要传递到cell中
-(void)sendTouchEventToCell{
    NSSet *touch = nil;
    UIEvent *event = nil;
    
    
    UIResponder *next = self.nextResponder;
    
    while (![next isKindOfClass:[UITableViewCell class]]) {
        
        next = next.nextResponder;
        
//        避免死循环 添加终止条件
        if ([next isKindOfClass:[UIViewController class]]) {
            return;
        }
        
    }
    
    
    
    [next touchesEnded:touch withEvent:event];

}

//tap 触发的方法
-(void)tapAct{
    
    [self sendTouchEventToCell];
    NSMutableArray* arr= @[].mutableCopy;
    
    for (int  i = 0; i<_dataList.count; i++) {
    
        AKGalleryItem* item = [AKGalleryItem itemWithTitle:[NSString stringWithFormat:@"%d",i+1] url:nil img:[UIImage imageNamed:@"86.jpg"]];
        
        [arr addObject:item];
    }

    AKGallery* gallery = AKGallery.new;
    gallery.items=arr;
    gallery.custUI=AKGalleryCustUI.new;
    gallery.selectIndex=self.index;
    gallery.completion=^{
        NSLog(@"completion gallery");
        
    };
       //show gallery
    [self presentAKGallery:gallery animated:YES completion:nil];
//
//    WBImageViewController *controller = [[WBImageViewController alloc] init];
//    
//    controller.dataList = self.dataList;
//    //       NSLog(@"%@",_dataList);
//    controller.currentIndex = self.index;
//    controller.currentItem = self;
//    
//    [self.viewController presentViewController:controller animated:NO completion:nil];

}

-(void)presentAKGallery:(AKGallery *)gallery animated:(BOOL)flag completion:(void (^)(void))completion{
    
    //todo:defaults

    [gallery.navigationController.navigationBar setBarTintColor:[UIColor grayColor]];

    
    [self.viewController presentViewController:gallery animated:flag completion:completion];

}

//计算出item相对于window的frame
-(CGRect)getNewFrameAtWindow:(CGRect)originFrame{
    
    //    1.原有坐标系  2.原有坐标  3.新坐标系
    
    return [self.superview convertRect:self.frame toView:self.window];
    
}

@end
