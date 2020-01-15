//
//  DLNavigationController.m
//  0008
//
//  Created by 董亮 on 2018/8/8.
//  Copyright © 2018年 董亮. All rights reserved.
//

#import "DLNavigationController.h"

@interface DLNavigationController ()

@end

@implementation DLNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置导航栏图片
    [self.navigationBar setBackgroundImage:[UIImage imageNamed: @"Navi1"] forBarMetrics:(UIBarMetricsDefault)];
    
//    [self.navigationBar setBackgroundColor:[UIColor redColor]];
//    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    [[UINavigationBar appearance] setTranslucent:NO];
  //  self.navigationController.navigationBar.translucent = NO;
  //  [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    
   // 245 205 81
    //navigationbar自定义字体大小颜色等属性
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    
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
