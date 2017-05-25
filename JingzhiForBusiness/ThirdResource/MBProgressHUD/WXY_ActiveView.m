//
//  WXY_ActiveView.m
//  AppBuilder
//
//  Created by wang rain on 12-3-1.
//  Copyright (c) 2012年 青岛联科时代科技. All rights reserved.
//

#import "WXY_ActiveView.h"

@implementation WXY_ActiveView
@synthesize animationView;
@synthesize middle_title;
@synthesize middle_titleFont;
@synthesize middle_titleColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        self.animationView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        [NSThread detachNewThreadSelector:@selector(beginActiveView) toTarget:self withObject:nil];
        
        
        
    }
    return self;
}

-(void)beginActiveView
{
    NSAutoreleasePool *pool =[[NSAutoreleasePool alloc] init];
    self.animationView.animationImages=[NSArray arrayWithObjects:
                                        [UIImage imageNamed:@"loading_01.jpg"],
                                        [UIImage imageNamed:@"loading_02.jpg"],
                                        [UIImage imageNamed:@"loading_03.jpg"],
                                        [UIImage imageNamed:@"loading_04.jpg"],
                                        [UIImage imageNamed:@"loading_05.jpg"],
                                        [UIImage imageNamed:@"loading_06.jpg"],nil];
    self.animationView.animationDuration=1;
   // animationView.animationRepeatCount=0;
    [self.animationView startAnimating];
    [self addSubview:self.animationView];
    
    
//    UILabel *label =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//    [label setTextAlignment:UITextAlignmentCenter];
//    [label setBackgroundColor:[UIColor clearColor]];
//    [self addSubview:label];
    
    [self performSelectorOnMainThread:@selector(goMain:) withObject:nil waitUntilDone:NO];
    [pool release];
}

-(void)goMain:(UILabel *)label{
//    [label setText:self.middle_title];
//    [label setTextColor:self.middle_titleColor];
//    [label setFont:[UIFont systemFontOfSize:self.middle_titleFont]];
//    [label release];
}

-(void)stopActiveView
{
    [self.animationView removeFromSuperview];
    [self removeFromSuperview];
}

-(void)setMiddleTitleText:(NSString *)text andFontOfInteger:(NSInteger)i andColor:(UIColor *)color{
    self.middle_title=text;
    self.middle_titleFont=i;
    self.middle_titleColor=color;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)dealloc{
    [animationView release];
    [middle_title release];
    [middle_titleColor release];
    [super release];
}

@end
