//
//  DLHomePageViewController.m
//  0008
//
//  Created by 董亮 on 2018/11/27.
//  Copyright © 2018 董亮. All rights reserved.
//

#import "DLHomePageViewController.h"
#import "DLShowTableViewController.h"
#import "DLButton.h"

#import "DLVegetable.h"

#import "AFNetworking.h"


@interface DLHomePageViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *backScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *frontScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;



@end


@implementation DLHomePageViewController


//实现UIScrollView的滚动方法
-(void)scrollViewDidScroll:(UIScrollView *)frontScrollView
{
    //如何计算
    //1.获取滚动的X方向的偏移值
    CGFloat offsetX = frontScrollView.contentOffset.x;
    //用已经偏移了得值加上半页的宽度
    offsetX = offsetX + (frontScrollView.frame.size.width * 0.5);
    
    //2. 用x方向的偏移量的值除以一张图片的宽度，取商就是当前滚动到了第几页（索引）
    int page = offsetX / frontScrollView.frame.size.width;
    
    //3. 将页码设置给UIPageControl
    self.pageControl.currentPage = page;
    // NSLog(@"滚动了，在这里写代码计算滚到了第几页");
}
//轮播图滚动方法

- (void)viewDidLoad {
    [super viewDidLoad];
   //解决登陆后不知道怎么弹出来一个键盘又收回去，有空再从根本解决
    [self.view endEditing:YES];
#pragma mark - 代码自定义首页六个大button
    //代码自定义首页六个大button：
    for (int i = 0; i < 6; i ++) {
        CGFloat buttonsY = 142 *i + 240;
        UIButton *vegButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        //用tag区分每个button
        vegButton.tag = i;
        CGRect frame = CGRectMake(7, buttonsY, 360, 130);
        vegButton.frame = frame;
        vegButton.backgroundColor = [UIColor clearColor];
        NSString *homeButtonimageName = [NSString stringWithFormat:@"%@%d",@"homeimg",i];
        UIImage *image =  [UIImage imageNamed:homeButtonimageName];
        [vegButton setBackgroundImage:image forState:UIControlStateNormal];
        
//        vegButton.layer.cornerRadius = 25;//25是圆角的弧度，根据需求自己更改
//        vegButton.layer.borderWidth = 0.2f;
//       // vegButton.layer.borderColor = CFBridgingRetain([UIColor yellowColor]);//设置边框颜色
//        vegButton.layer.masksToBounds = YES;
        //得到view的遮罩路径
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:vegButton.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(20,20)];
        //创建 layer
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = vegButton.bounds;
        //赋值
        maskLayer.path = maskPath.CGPath;
        vegButton.layer.mask = maskLayer;
        
        
        
        [self.backScrollView addSubview:vegButton];
        //
        //
        [vegButton addTarget:self action:@selector(vegButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
  }
  
    //设置UIScrollViews的contentSzize
  
   // CGFloat maxH = CGRectGetMaxY(self.lastButton.frame);
    self.backScrollView.contentSize = CGSizeMake(0, 1092);
    self.backScrollView.showsVerticalScrollIndicator = NO;
    //动态创建UIImageViewi添加到frontScrollView中去
    //1. 循环创建8个UIImageViewd添加到frontScrollView
    
    CGFloat imgW = 378;
    CGFloat imgH = 183;
    CGFloat imgY = 0;
    
    for (int i = 0; i < 8; i ++) {
    //创建一个imgView
        UIImageView * imgView = [[UIImageView alloc]init];
        
    //设置UIImageView中的图片
        NSString * imgName = [NSString stringWithFormat:@"lunbo_%02d", i + 1];
        imgView.image = [UIImage imageNamed:imgName];
        
    // 计算每个UIImageView在ScrollViewd中的x坐标值
        CGFloat imgX = i  * imgW;
        
    //设置imgView的frame
        imgView.frame = CGRectMake(imgX, imgY, imgW, imgH);
        
    //把imgView添加到UIScrollView中
        [self.frontScrollView addSubview:imgView];
    }
    
    //设置UIScrollView的contentSize（实际内容的大小）
    CGFloat lunBomaxH = self.frontScrollView.frame.size.width * 8;
    self.frontScrollView.contentSize = CGSizeMake(lunBomaxH, 0);
    
    //实现UIScrollView的分页效果
    //当设置允许分页以后，UIScrollView会按照自身的宽度作为一页来进行分页
    self.frontScrollView.pagingEnabled = YES;
    
    //隐藏水平滚动指示器
    self.frontScrollView.showsHorizontalScrollIndicator = NO;

    //指定UIPageControl的总页数
    self.pageControl.numberOfPages = 8;

    //指定默认是第0页
    self.pageControl.currentPage = 0;
    
    //创建一个“计时器”控件NSTimer控件
    //通过scheduledTimerWithTimeInterval这个方法创建的计时器控件，创建好以后自动启动
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(scrollImage) userInfo:nil repeats:YES];
}
//自动滚动图片的方法
//每一秒就执行一次这个方法
-(void)scrollImage
{
    //每次执行这个方法的时候，都要让图片滚动到下一页
    //如果图片现在已经滚动到最后一页了，那么就滚动到y第一页
    //如何滚动到下一页？
    //1. 获取当前UIPageControl的页码
    NSInteger page = self.pageControl.currentPage;
    //2.判断页码是否到了最后一页，如果到了最后一页，那么设置页码为0（回到第一页）。如果没有，让页码+1
    if(page == self.pageControl.numberOfPages - 1){
        //表示已经到达最后一页了
        page = 0;
    }else{
        page++;
    }
    //3.用每页的宽度*（页码+1） == 计算除了下一页的contentOffset.x
    CGFloat offsetX = page * self.frontScrollView.frame.size.width;
    //4.设置UIScrollView的contentOffset等于新的偏移的值
    [self.frontScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    //NSLog(@"每一秒就执行一次这个方法");



}


-(void)vegButtonClick:(UIButton *)sender
{
    NSLog(@"按钮按下了");
    NSString *urlString = @"http://39.96.8.115/button.php";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //发送和接收都用JSON格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //发送给后台，是哪个按钮按下了，后台根据不同的按钮返回不同的数据。
    NSString *buttontag = [NSString stringWithFormat:@"%ld",sender.tag];
    NSLog(@"%@",buttontag);
    NSDictionary *parameters = @{@"buttontag":buttontag
                                 };
    [manager POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //字典转模型
        NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:10];

        [responseObject enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            DLVegetable *vegetables = [DLVegetable vegetablesWithDict:obj];
            [mArray addObject:vegetables];
        }];
        NSLog(@"服务器返回的数据：%@",responseObject);
        NSLog(@"mArray：%@",mArray);
        //DLVegetable *vegetables = [DLVegetable vegetablesWithDict:responseObject];

        DLShowTableViewController *JunguTableViewController = [[DLShowTableViewController alloc]init];
        JunguTableViewController.shucai = mArray;
        
         [self.navigationController pushViewController:JunguTableViewController animated:YES];
//       //[self performSegueWithIdentifier:@"SeguePush" sender:self];
       // NSLog(@"%@",vegetables);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
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
  
    
