//
//  DLDetailViewController.m
//  0008
//
//  Created by 董亮 on 2018/12/18.
//  Copyright © 2018 董亮. All rights reserved.
//

#import "DLDetailViewController.h"
#import "AFNetworking.h"

@interface DLDetailViewController ()

@end

@implementation DLDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:248/255.0f green:209/255.0f blue:78/255.0f alpha:1];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(30, 140, 300, 21);
    label.text = @"详细信息展示页面...";
    label.textColor = [UIColor colorWithRed:72/255.0f green:85/255.0f blue:124/255.0f alpha:1];
    label.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:label];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.frame = CGRectMake(30, 540, 300, 21);
    label2.text = @"详细信息展示页面...";
    label2.textColor = [UIColor colorWithRed:72/255.0f green:85/255.0f blue:124/255.0f alpha:1];
    label2.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:label2];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


//- (void)loadDetailInfo{
//
//    NSString *urlString = @"http://39.96.8.115/button.php";
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    //发送和接收都用JSON格式
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//
//
//    [manager POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//
//        //字典转模型
//        NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:10];
//
//        [responseObject enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            DLVegetable *vegetables = [DLVegetable vegetablesWithDict:obj];
//            [mArray addObject:vegetables];
//        }];
//
//
//        NSLog(@"服务器返回的数据：%@",responseObject);
//        NSLog(@"mArray：%@",mArray);
//                //DLVegetable *vegetables = [DLVegetable vegetablesWithDict:responseObject];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//    }];
//
//
//
//}


@end
