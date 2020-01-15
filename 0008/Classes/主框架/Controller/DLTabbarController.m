//
//  DLTabbarController.m
//  0008
//
//  Created by 董亮 on 2018/8/7.
//  Copyright © 2018年 董亮. All rights reserved.
//

#import "DLTabbarController.h"
#import "DLTabBar.h"
@interface DLTabbarController ()

@end

@implementation DLTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //获取四个子控制器
    UIViewController *v1 = [self loadSubViewControllerWithSBName:@"Home"];
    UIViewController *v2 = [self loadSubViewControllerWithSBName:@"Recommend"];
    UIViewController *v3 = [self loadSubViewControllerWithSBName:@"Retrospect"];
    UIViewController *v4 = [self loadSubViewControllerWithSBName:@"Mine"];
    
    
    
    //设置tabbarController 子控制器
    self.viewControllers = @[v1,v2,v3,v4];
   // v1.tabBarItem.image = [UIImage imageNamed:@"TabBarHome"];
    
    // 创建一个自定义tabbar 使用系统的tabbar多多少少会有一些问题
    DLTabBar *tabbar = [[DLTabBar alloc]init];
    
    //使用 block（遵守协议，使用代理方法）
    tabbar.tabbarButtonBlock = ^(NSInteger index){
        self.selectedIndex = index;
    };
    
    
    //设置tabbar的frame为系统tabbar的frame
   // tabbar.frame = self.tabBar.frame;
    
    tabbar.frame = CGRectMake(0, 729, 375, 83);
    
//    
//    NSLog(@"66666666666666666666");
//    NSLog(@"%f",self.tabBar.frame.size.width);
//    NSLog(@"%f",self.tabBar.frame.size.height);
//     NSLog(@"%f",self.tabBar.frame.origin.x);
//     NSLog(@"%f",self.tabBar.frame.origin.y);
//    NSLog(@"66666666666666666666");
//    // 1. 用一个临时变量保存返回值。
//    CGRect temp = self.tabBar.frame;
//    // 2. 给这个变量赋值。因为变量都是L-Value，可以被赋值
//    temp.size.height = 83;
//    // 3. 修改frame的值
//    tabbar.frame = temp;
    NSLog(@"66666666666666666666");
    NSLog(@"%f",tabbar.frame.size.width);
    NSLog(@"%f",tabbar.frame.size.height);
    NSLog(@"66666666666666666666");
    
    tabbar.backgroundColor = [UIColor redColor];
    

//    tabbar.backgroundColor = [UIColor redColor];
    //添加到tabbarController中
    [self.view addSubview:tabbar];
    
    for(int i = 0;i < self.viewControllers.count; ++i)
    {
        
       
//     tabbarButton.backgroundColor = [UIColor blueColor];
        
        //获取图片
        
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Tabbar%d",i+1]];
        UIImage *imagePress = [UIImage imageNamed:[NSString stringWithFormat:@"TabbarSel%d",i+1]];
        [tabbar addButtonWithImage:image andImageSel:imagePress];
    }
    [self.view addSubview:tabbar];
}


-(UIViewController *)loadSubViewControllerWithSBName:(NSString *)name{
    //获取sb对象
    UIStoryboard *sb = [UIStoryboard storyboardWithName:name bundle:nil];
    return  [sb instantiateInitialViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)viewDidAppear
//{
//    self.tabBar.bounds.size.height = 83;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
 }
*/

@end
