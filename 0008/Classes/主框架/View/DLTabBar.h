//
//  DLTabBar.h
//  0008
//
//  Created by 董亮 on 2018/8/8.
//  Copyright © 2018年 董亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLTabBar : UIView

//写block属性（相当于代理的协议，协议方法，id属性）
@property(nonatomic,copy) void(^tabbarButtonBlock)(NSInteger);
-(void)addButtonWithImage:(UIImage *)image andImageSel:(UIImage *)imageSel;

@end
