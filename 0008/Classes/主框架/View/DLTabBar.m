//
//  DLTabBar.m
//  0008
//
//  Created by 董亮 on 2018/8/8.
//  Copyright © 2018年 董亮. All rights reserved.
//

#import "DLTabBar.h"
@interface DLTabBarButton: UIButton
@property(nonatomic,weak)UIButton *currentButton;
@end

@implementation DLTabBarButton
-(void)setHighlighted:(BOOL)highlighted
{
    //[super setHighlighted:highlighted];
}
@end
@interface DLTabBar()

@property(nonatomic,weak)UIButton *currentButton;

@end
@implementation DLTabBar

-(void)addButtonWithImage:(UIImage *)image andImageSel:(UIImage *)imageSel
{
    //创建一个Button
    DLTabBarButton *tabbarButton = [[DLTabBarButton alloc]init];
    //设置button的图片
    [tabbarButton setBackgroundImage:image forState:(UIControlStateNormal)];
    [tabbarButton setBackgroundImage:imageSel forState:(UIControlStateSelected)];
    //  监听button
    [tabbarButton addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchDown];
    //这句话仅仅是取消了高亮的效果而没有取消高亮的状态，高亮的状态仍然存在
    // tabbarButton.adjustsImageWhenHighlighted = NO;
    //添加到自己上
    [self addSubview:tabbarButton];
}
//点击 tabbar 上按钮的时候调用
-(void)tabBarButtonClick:(UIButton*) sender
{
    //取消记录的按钮的选中状态
    self.currentButton.selected = NO;
    //设置点击的按钮位选中状态
    sender.selected = YES;
    //记录选中的按钮
    self.currentButton = sender;
    //切换控制器
   // self.selectedIndex = sender.tag;
    //判断block是否有值（代理方法 是不是能够相应）
    if(self.tabbarButtonBlock){
        //执行block(执行代理方法)
        self.tabbarButtonBlock(sender.tag);
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    for (int i = 0; i < self.subviews.count; ++i) {
        //获取button
        UIButton *tabbarButton = self.subviews[i];
        //设置 tag 切换控制器
        tabbarButton.tag = i;
        //计算按钮的frame
        
        CGFloat w = (KScreenSzieWidth) / 4;
        CGFloat h = 83;
        CGFloat x = i * w;
        CGFloat y = 0;
        
        tabbarButton.frame = CGRectMake(x, y, w, h);
        
        
        //点击一下第一个按钮
        if(i == 0){
            [self tabBarButtonClick:tabbarButton];
        }
    }
   
}



@end
