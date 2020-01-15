//
//  DLShowInfoViewController.m
//  0008
//
//  Created by 董亮 on 2019/1/14.
//  Copyright © 2019 董亮. All rights reserved.
//

#import "DLShowInfoViewController.h"

//第三方框架
#import <Charts/Charts-Swift.h>
#import "AFNetworking.h"
#import "SVProgressHUD.h"

#import "DLBaseInfo.h"
#import "DLData.h"
#import "DLPhData.h"
#import "DLGzData.h"
#import "DLDdlData.h"

#import "SymbolsValueFormatter.h"
#import "DateValueFormatter.h"
#import "SetValueFormatter.h"

#import "DLShapeView.h"



#define Yvalue 10 

@interface DLShowInfoViewController ()<UIScrollViewDelegate,ChartViewDelegate>

@property (weak, nonatomic) UIScrollView *backView;
@property (nonatomic,strong) NSArray *baseInfoArry;

//@property(strong,nonatomic)LineChartView *lineChartTemp;
@property (nonatomic,strong) LineChartView * lineView;
@property (nonatomic,strong) LineChartView * lineView2;
@property (nonatomic,strong) LineChartView * lineView3;
@property (nonatomic,strong) LineChartView * lineView4;

@property (nonatomic, strong) LineChartDataSet *set1;//折线
@property (nonatomic, strong) LineChartDataSet *set3;//折线
@property (nonatomic, strong) LineChartDataSet *set5;//折线
@property (nonatomic, strong) LineChartDataSet *set7;//折线

@property(strong,nonatomic)NSArray *dataArry;
@property(strong,nonatomic)NSArray *phArry;
@property(strong,nonatomic)NSArray *gzArry;
@property(strong,nonatomic)NSArray *ddlArry;

@property (nonatomic,strong) UILabel * markY;

@end

@implementation DLShowInfoViewController

- (void)dataloading
{
    //显示加载标题
    [SVProgressHUD showWithStatus:@"传感器数据加载中"];
    //设置HUD的Style
    [SVProgressHUD setDefaultStyle:(SVProgressHUDStyleLight)];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
    /*
     SVProgressHUDAnimationTypeFlat,     // default animation type, custom flat animation (indefinite animated ring)
     SVProgressHUDAnimationTypeNative    // iOS native UIActivityIndicatorView
     */
    //动画效果
    [SVProgressHUD setDefaultAnimationType:(SVProgressHUDAnimationTypeFlat)];
    //设置多少秒后隐藏
    [SVProgressHUD dismissWithDelay:10.0];
}

- (void)dataLoadSucess
{
    //加载成功动画
    [SVProgressHUD showSuccessWithStatus:@"传感器数据加载完成"];
    [SVProgressHUD dismissWithDelay:1.0];
}

-(void)setDataArry:(NSArray *)dataArry
{
    _dataArry = dataArry;
    [self.backView addSubview:self.lineView];
    [self dataLoadSucess];
     self.lineView.data = [self setData];
}
-(void)setPhArry:(NSArray *)phArry
{
    _phArry = phArry;

    [self.backView addSubview:self.lineView2];
    self.lineView2.data = [self setPhData];
}
-(void)setGzArry:(NSArray *)gzArry
{
    _gzArry = gzArry;

    [self.backView addSubview:self.lineView3];
    self.lineView3.data = [self setGzData];
}
-(void)setDdlArry:(NSArray *)ddlArry
{
    _ddlArry = ddlArry;

    [self.backView addSubview:self.lineView4];
    self.lineView4.data = [self setDdlData];
}



- (UILabel *)markY{
    if (!_markY) {
        _markY = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 35, 25)];
        _markY.font = [UIFont systemFontOfSize:15.0];
        _markY.textAlignment = NSTextAlignmentCenter;
        _markY.text =@"markY";
        _markY.textColor = [UIColor blackColor];
        _markY.backgroundColor = [UIColor grayColor];
    }
    return _markY;
}
-(void)setBaseInfoArry:(NSArray *)baseInfoArry
{
    _baseInfoArry = baseInfoArry;
    [self setLabels];
    
    DLBaseInfo *model = _baseInfoArry[0];
    
    NSString *ID = model.ID;
    NSString *plant = model.plantTime;
    NSString *pick = model.pickTime;
    
    [self loadDataWith:ID :plant :pick];
    [self loadPhDataWith:ID :plant :pick];
    [self loadGzDataWith:ID :plant :pick];
    [self loadDdlDataWith:ID :plant :pick];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
        [self dataloading];
        [self setBacks];
        [self getBaseInfoWith:_qrCodeString];
        [self.backView addSubview:[self roundBackViewWith:10 :10 :355 :170]];
        [self.backView addSubview:[self roundBackViewWith:10 :Yvalue + 177 :355 :245]];
        [self.backView addSubview:[self roundBackViewWith:10 :Yvalue + 429 :355 :245]];
        [self.backView addSubview:[self roundBackViewWith:10 :Yvalue + 681 :355 :245]];
        [self.backView addSubview:[self roundBackViewWith:10 :Yvalue + 933 :355 :245]];

    
    //测试
      [self.backView addSubview:self.lineView2];
}

- (void)setLabels
{
    // 1. 获取模型数据
    DLBaseInfo *model = self.baseInfoArry[0];
    // 3. 把模型数据设置给
    
    UILabel *lablel = [[UILabel alloc] init];
    lablel.frame = CGRectMake(30, Yvalue + 10, 300, 30);
    lablel.text = @"产品基本信息";
    lablel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    lablel.textColor = [UIColor colorWithRed:141/255.0f green:142/255.0f blue:146/255.0f alpha:1];
    //lablel.textAlignment = NSTextAlignmentCenter;
    lablel.textAlignment = NSTextAlignmentLeft;
    [self.backView addSubview:lablel];
   // lablel.font = [UIFont fontWithName:nil size:20];

    UILabel *labelNum = [[UILabel alloc] init];
    labelNum.frame = CGRectMake(30, Yvalue + 40, 300, 21);
   // labelNum.text = _qrCodeString;
    labelNum.text = [NSString stringWithFormat:@"标示码：%@",_qrCodeString];
    labelNum.textColor = [UIColor blackColor];
    labelNum.textAlignment = NSTextAlignmentLeft;
    labelNum.font = [UIFont systemFontOfSize:14];
    [self.backView addSubview:labelNum];

    UILabel *productName = [[UILabel alloc] init];
    productName.frame = CGRectMake(30, Yvalue + 60 , 300, 21);
    productName.text = [NSString stringWithFormat:@"产品名：%@",model.prodName];
    productName.textColor = [UIColor blackColor];
    productName.textAlignment = NSTextAlignmentLeft;
    productName.font = [UIFont systemFontOfSize:14];
    [self.backView addSubview:productName];

    UILabel *plantTime = [[UILabel alloc] init];
    plantTime.frame = CGRectMake(30, Yvalue + 80 , 300, 21);
    plantTime.text = [NSString stringWithFormat:@"种植时间：%@",model.plantTime];
    plantTime.textColor = [UIColor blackColor];
    plantTime.textAlignment = NSTextAlignmentLeft;
    plantTime.font = [UIFont systemFontOfSize:14];
    [self.backView addSubview:plantTime ];
    
    UILabel *pickUpTime = [[UILabel alloc] init];
    pickUpTime.frame = CGRectMake(30, Yvalue + 100 , 300, 21);
    pickUpTime.text = [NSString stringWithFormat:@"采摘时间：%@",model.pickTime];
    pickUpTime.textColor = [UIColor blackColor];
    pickUpTime.textAlignment = NSTextAlignmentLeft;
    pickUpTime.font = [UIFont systemFontOfSize:14];
    [self.backView addSubview:pickUpTime];


    UILabel *factoryName = [[UILabel alloc] init];
    factoryName.frame = CGRectMake(30, Yvalue + 120, 300, 21);
    factoryName.text = [NSString stringWithFormat:@"产    地：%@",model.farmName];
//    factoryName.lineBreakMode = NSLineBreakByWordWrapping;
//    factoryName.numberOfLines = 2;
    factoryName.textColor = [UIColor blackColor];
    factoryName.textAlignment = NSTextAlignmentLeft;
    [self.backView addSubview:factoryName];
    factoryName.font = [UIFont systemFontOfSize:12];
    
    UILabel *lable3 = [[UILabel alloc] init];
    lable3.frame = CGRectMake(30, Yvalue + 187, 300, 30);
    lable3.text = @"产品生长温湿度信息";
    lable3.textColor = [UIColor colorWithRed:141/255.0f green:142/255.0f blue:146/255.0f alpha:1];
   // lable3.textAlignment = NSTextAlignmentCenter;
    lable3.textAlignment = NSTextAlignmentLeft;
    lable3.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    [self.backView addSubview:lable3];


    UILabel *lable4 = [[UILabel alloc] init];
    lable4.frame = CGRectMake(30, Yvalue + 439, 300, 30);
    lable4.text = @"产品生长土壤PH值信息";
    lable4.textColor = [UIColor colorWithRed:141/255.0f green:142/255.0f blue:146/255.0f alpha:1];
    // lable3.textAlignment = NSTextAlignmentCenter;
    lable4.textAlignment = NSTextAlignmentLeft;
    lable4.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    [self.backView addSubview:lable4];
    
    UILabel *lable5 = [[UILabel alloc] init];
    lable5.frame = CGRectMake(30, Yvalue + 691, 300, 30);
    lable5.text = @"产品生长光照强度信息";
    lable5.textColor = [UIColor colorWithRed:141/255.0f green:142/255.0f blue:146/255.0f alpha:1];
    // lable3.textAlignment = NSTextAlignmentCenter;
    lable5.textAlignment = NSTextAlignmentLeft;
    lable5.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    [self.backView addSubview:lable5];
    
    UILabel *lable6 = [[UILabel alloc] init];
    lable6.frame = CGRectMake(30, Yvalue + 943, 300, 30);
    lable6.text = @"产品生长土壤电导率信息";
    lable6.textColor = [UIColor colorWithRed:141/255.0f green:142/255.0f blue:146/255.0f alpha:1];
    // lable3.textAlignment = NSTextAlignmentCenter;
    lable6.textAlignment = NSTextAlignmentLeft;
    lable6.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    [self.backView addSubview:lable6];
//    UIImageView *line = [self createImageViewFrame:CGRectMake(30, Yvalue ,(KScreenSzieWidth - 60), 1) imageName:nil color:[UIColor blackColor]];
//    UIImageView *line2 = [self createImageViewFrame:CGRectMake(30, Yvalue + 155, (KScreenSzieWidth - 60), 1) imageName:nil color:[UIColor blackColor]];
//
//    UIImageView *line3 = [self createImageViewFrame:CGRectMake(30, Yvalue + 215 ,(KScreenSzieWidth - 60), 0.5) imageName:nil color:[UIColor lightGrayColor]];
//    UIImageView *line4 = [self createImageViewFrame:CGRectMake(30, Yvalue + 425, (KScreenSzieWidth - 60), 0.5) imageName:nil color:[UIColor lightGrayColor]];
//
//    [self.backView addSubview:line];
//    [self.backView addSubview:line2];
//    [self.backView addSubview:line3];
//    [self.backView addSubview:line4];
    
}

-(void)setBacks{
    // self.view.backgroundColor = [UIColor colorWithRed:241/255.0f green:241/255.0f blue:241/255.0f alpha:1];
    
    UIScrollView *backScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 375 , KScreenSzieHeight)];
    _backView = backScrollView;
    backScrollView.showsVerticalScrollIndicator = NO;
    //_backView = backScrollView;
    // backScrollView = _backView;
    backScrollView.contentSize = CGSizeMake(0,2000);
    backScrollView.backgroundColor = [UIColor colorWithRed:241/255.0f green:241/255.0f blue:241/255.0f alpha:1];
      //  backScrollView.backgroundColor = [UIColor grayColor];
    
//     backScrollView.backgroundColor = DeepBlue;
    
    [self.view addSubview:backScrollView];
    backScrollView.scrollEnabled = YES;
    


}

-(UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName color:(UIColor *)color
{
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:frame];
    
    if (imageName)
    {
        imageView.image=[UIImage imageNamed:imageName];
    }
    if (color)
    {
        imageView.backgroundColor=color;
    }
    
    return imageView;
}


-(void)getBaseInfoWith:(NSString *)ProdID
{
    NSLog(@"产品基本信息");
    NSString *urlString = @"http://39.96.8.115/baseinfo.php";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //发送和接收都用JSON格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString *prodCode = [NSString stringWithFormat:@"%@",ProdID];
    NSLog(@"%@",prodCode);
    NSDictionary *parameters = @{@"prodcode":prodCode
                                 };
    [manager POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:10];
        
        [responseObject enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            
            DLBaseInfo *baseInfo = [DLBaseInfo baseInfoWithDict:obj];
            [mArray addObject:baseInfo];
            
            
        }];
        NSLog(@"服务器返回的数据：%@",responseObject);
        NSLog(@"mArray:%@",mArray);

        //判断一个数组是否为空
        if (mArray != nil && ![mArray isKindOfClass:[NSNull class]] && mArray.count != 0)
        {
         //如果使用_dataArry = mArray 则不会调用dataArray的set方法
         self.baseInfoArry = mArray;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
}

-(void)loadDataWith:(NSString *)ProdID :(NSString *)fromTime :(NSString *)endTime
{
    
    NSLog(@"加载温湿度数据");
    NSString *urlString = @"http://39.96.8.115/data.php";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //发送和接收都用JSON格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString *prodCode = [NSString stringWithFormat:@"%@",ProdID];
    NSLog(@"%@",prodCode);
    NSDictionary *parameters = @{@"prodcode":prodCode,
                                 @"fromTime":fromTime,
                                 @"endTime":endTime,
                                 
                                 
                                 };
    [manager POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:10];
        
        [responseObject enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            DLData *data = [DLData DataWithDict:obj];
            [mArray addObject:data];
        }];
         NSLog(@"服务器返回的数据：%@",responseObject);
        
         NSLog(@"fromTime:%@",fromTime);
         NSLog(@"endTime:%@",endTime);
        
         NSLog(@"温湿度数据数组mArray:%@",mArray);
        
        if (mArray != nil && ![mArray isKindOfClass:[NSNull class]] && mArray.count != 0)
        {
            //如果使用_dataArry = mArray 则不会调用dataArray的set方法
            self.dataArry = mArray;
        }
        
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
    
}

// ph值数据加载
-(void)loadPhDataWith:(NSString *)ProdID :(NSString *)fromTime :(NSString *)endTime
{
    
    NSLog(@"加载ph值数据");
    NSString *urlString = @"http://39.96.8.115/phdata.php";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //发送和接收都用JSON格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString *prodCode = [NSString stringWithFormat:@"%@",ProdID];
    NSLog(@"%@",prodCode);
    NSDictionary *parameters = @{@"prodcode":prodCode,
                                 @"fromTime":fromTime,
                                 @"endTime":endTime,
                                 
                                 
                                 };
    [manager POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:10];
        
        [responseObject enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            DLPhData *data = [DLPhData PhWithDict:obj];
            [mArray addObject:data];
        }];
        NSLog(@"服务器返回的数据：%@",responseObject);
        
        NSLog(@"fromTime:%@",fromTime);
        NSLog(@"endTime:%@",endTime);
        
        NSLog(@"ph值mArray:%@",mArray);
        
        if (mArray != nil && ![mArray isKindOfClass:[NSNull class]] && mArray.count != 0)
        {
            //如果使用_dataArry = mArray 则不会调用dataArray的set方法
            self.phArry = mArray;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
}


// 光照强度数据加载
-(void)loadGzDataWith:(NSString *)ProdID :(NSString *)fromTime :(NSString *)endTime
{
    
    NSLog(@"加载光照强度数据");
    NSString *urlString = @"http://39.96.8.115/gzdata.php";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //发送和接收都用JSON格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString *prodCode = [NSString stringWithFormat:@"%@",ProdID];
    NSLog(@"%@",prodCode);
    NSDictionary *parameters = @{@"prodcode":prodCode,
                                 @"fromTime":fromTime,
                                 @"endTime":endTime,
                                 
                                 
                                 };
    [manager POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:10];
        
        [responseObject enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            DLGzData *data = [DLGzData GzWithDict:obj];
            [mArray addObject:data];
        }];
        NSLog(@"服务器返回的数据：%@",responseObject);
        
        NSLog(@"fromTime:%@",fromTime);
        NSLog(@"endTime:%@",endTime);
        
        NSLog(@"光照强度mArray:%@",mArray);
        
        if (mArray != nil && ![mArray isKindOfClass:[NSNull class]] && mArray.count != 0)
        {
            //如果使用_dataArry = mArray 则不会调用dataArray的set方法
            self.gzArry = mArray;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
}

// 电导率数据加载
-(void)loadDdlDataWith:(NSString *)ProdID :(NSString *)fromTime :(NSString *)endTime
{
    
    NSLog(@"加载光照强度数据");
    NSString *urlString = @"http://39.96.8.115/ddldata.php";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //发送和接收都用JSON格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString *prodCode = [NSString stringWithFormat:@"%@",ProdID];
    NSLog(@"%@",prodCode);
    NSDictionary *parameters = @{@"prodcode":prodCode,
                                 @"fromTime":fromTime,
                                 @"endTime":endTime,
                                 
                                 };
    [manager POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:10];
        
        [responseObject enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            DLDdlData *data = [DLDdlData DdlWithDict:obj];
            [mArray addObject:data];
        }];
        NSLog(@"服务器返回的数据：%@",responseObject);
        NSLog(@"fromTime:%@",fromTime);
        NSLog(@"endTime:%@",endTime);
        
        NSLog(@"电导率mArray:%@",mArray);
        
        if (mArray != nil && ![mArray isKindOfClass:[NSNull class]] && mArray.count != 0)
        {
            //如果使用_dataArry = mArray 则不会调用dataArray的set方法
            self.ddlArry = mArray;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
}
#pragma --lineView
- (LineChartView *)lineView {
    if (!_lineView) {
        _lineView = [[LineChartView alloc] initWithFrame:CGRectMake(15, Yvalue + 210, 345, 200)];
        _lineView.delegate = self;//设置代理
        _lineView.backgroundColor =  [UIColor whiteColor];
        _lineView.noDataText = @"暂无数据";
        _lineView.chartDescription.enabled = YES;
        _lineView.chartDescription.text = @"生长温湿度曲线";
        _lineView.scaleYEnabled = YES;//取消Y轴缩放
        _lineView.doubleTapToZoomEnabled = NO;//取消双击缩放
        _lineView.dragEnabled = YES;//启用拖拽图标
        _lineView.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
        _lineView.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
        //设置滑动时候标签
        ChartMarkerView *markerY = [[ChartMarkerView alloc]
                                    init];
        markerY.offset = CGPointMake(-999, -8);
        markerY.chartView = _lineView;
        _lineView.marker = markerY;
        [markerY addSubview:self.markY];
        
        _lineView.rightAxis.enabled = NO;//不绘制右边轴
        ChartYAxis *leftAxis = _lineView.leftAxis;//获取左边Y轴
        leftAxis.labelCount = 5;//Y轴label数量，数值不一定，如果forceLabelsEnabled等于YES, 则强制绘制制定数量的label, 但是可能不平均
        leftAxis.forceLabelsEnabled = NO;//不强制绘制指定数量的label
        leftAxis.labelCount = 10;
        leftAxis.axisMinimum = -20;//设置Y轴的最小值
        leftAxis.axisMaximum = 99;//设置Y轴的最大值
        leftAxis.inverted = NO;//是否将Y轴进行上下翻转
        leftAxis.axisLineColor = [UIColor blackColor];//Y轴颜色
        leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc]init];
        leftAxis.labelPosition = YAxisLabelPositionOutsideChart;//label位置
        leftAxis.labelTextColor = [UIColor blackColor];//文字颜色
        leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];//文字字体
        leftAxis.gridColor = [UIColor grayColor];//网格线颜色
        leftAxis.gridAntialiasEnabled = NO;//开启抗锯齿
        
        ChartXAxis *xAxis = _lineView.xAxis;
        xAxis.granularityEnabled = YES;//设置重复的值不显示
        xAxis.labelPosition= XAxisLabelPositionBottom;//设置x轴数据在底部
        xAxis.gridColor = [UIColor clearColor];
        xAxis.labelTextColor = [UIColor blackColor];//文字颜色
 
        xAxis.axisLineColor = [UIColor grayColor];
        _lineView.maxVisibleCount = 99;//
        //描述及图例样式
        //        [_lineView setDescriptionText:@""];
        _lineView.legend.enabled = NO;
       // _lineView.legend.
        [_lineView animateWithXAxisDuration:1.0f];
    }
    return _lineView;
}

- (LineChartView *)lineView2 {
    if (!_lineView2) {
        _lineView2 = [[LineChartView alloc] initWithFrame:CGRectMake(15, Yvalue + 462, 345, 200)];
        _lineView2.delegate = self;//设置代理
        _lineView2.backgroundColor =  [UIColor whiteColor];
        _lineView2.noDataText = @"暂无数据";
        _lineView2.chartDescription.enabled = YES;
        _lineView2.chartDescription.text = @"生长PH值曲线";
        _lineView2.scaleYEnabled = YES;//取消Y轴缩放
        _lineView2.doubleTapToZoomEnabled = NO;//取消双击缩放
        _lineView2.dragEnabled = YES;//启用拖拽图标
        _lineView2.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
        _lineView2.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
        //设置滑动时候标签
        ChartMarkerView *markerY = [[ChartMarkerView alloc]
                                    init];
        markerY.offset = CGPointMake(-999, -8);
        markerY.chartView = _lineView;
        _lineView2.marker = markerY;
        [markerY addSubview:self.markY];
        
        _lineView2.rightAxis.enabled = NO;//不绘制右边轴
        ChartYAxis *leftAxis = _lineView2.leftAxis;//获取左边Y轴
        leftAxis.labelCount = 5;//Y轴label数量，数值不一定，如果forceLabelsEnabled等于YES, 则强制绘制制定数量的label, 但是可能不平均
        leftAxis.forceLabelsEnabled = NO;//不强制绘制指定数量的label
        leftAxis.labelCount = 10;
        leftAxis.axisMinimum = 4;//设置Y轴的最小值
        leftAxis.axisMaximum = 9;//设置Y轴的最大值
        leftAxis.inverted = NO;//是否将Y轴进行上下翻转
        leftAxis.axisLineColor = [UIColor blackColor];//Y轴颜色
        leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc]init];
        leftAxis.labelPosition = YAxisLabelPositionOutsideChart;//label位置
        leftAxis.labelTextColor = [UIColor blackColor];//文字颜色
        leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];//文字字体
        leftAxis.gridColor = [UIColor grayColor];//网格线颜色
        leftAxis.gridAntialiasEnabled = NO;//开启抗锯齿
        
        ChartXAxis *xAxis = _lineView2.xAxis;
        xAxis.granularityEnabled = YES;//设置重复的值不显示
        xAxis.labelPosition= XAxisLabelPositionBottom;//设置x轴数据在底部
        xAxis.gridColor = [UIColor clearColor];
        xAxis.labelTextColor = [UIColor blackColor];//文字颜色
        
        xAxis.axisLineColor = [UIColor grayColor];
        _lineView2.maxVisibleCount = 99;//
        //描述及图例样式
        //        [_lineView setDescriptionText:@""];
        _lineView2.legend.enabled = NO;
        // _lineView.legend.
        [_lineView2 animateWithXAxisDuration:1.0f];
    }
    return _lineView2;
}



- (LineChartView *)lineView3 {
    if (!_lineView3) {
        _lineView3 = [[LineChartView alloc] initWithFrame:CGRectMake(15, Yvalue + 714, 345, 200)];
        _lineView3.delegate = self;//设置代理
        _lineView3.backgroundColor =  [UIColor whiteColor];
        _lineView3.noDataText = @"暂无数据";
        _lineView3.chartDescription.enabled = YES;
        _lineView3.chartDescription.text = @"生长光照强度曲线";
        _lineView3.scaleYEnabled = YES;//取消Y轴缩放
        _lineView3.doubleTapToZoomEnabled = NO;//取消双击缩放
        _lineView3.dragEnabled = YES;//启用拖拽图标
        _lineView3.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
        _lineView3.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
        //设置滑动时候标签
        ChartMarkerView *markerY = [[ChartMarkerView alloc]
                                    init];
        markerY.offset = CGPointMake(-999, -8);
        markerY.chartView = _lineView3;
        _lineView3.marker = markerY;
        [markerY addSubview:self.markY];
        
        _lineView3.rightAxis.enabled = NO;//不绘制右边轴
        ChartYAxis *leftAxis = _lineView3.leftAxis;//获取左边Y轴
        leftAxis.labelCount = 5;//Y轴label数量，数值不一定，如果forceLabelsEnabled等于YES, 则强制绘制制定数量的label, 但是可能不平均
        leftAxis.forceLabelsEnabled = NO;//不强制绘制指定数量的label
        leftAxis.labelCount = 10;
        leftAxis.axisMinimum = 0;//设置Y轴的最小值
        leftAxis.axisMaximum = 50000;//设置Y轴的最大值
        leftAxis.inverted = NO;//是否将Y轴进行上下翻转
        leftAxis.axisLineColor = [UIColor blackColor];//Y轴颜色
        leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc]init];
        leftAxis.labelPosition = YAxisLabelPositionOutsideChart;//label位置
        leftAxis.labelTextColor = [UIColor blackColor];//文字颜色
        leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];//文字字体
        leftAxis.gridColor = [UIColor grayColor];//网格线颜色
        leftAxis.gridAntialiasEnabled = NO;//开启抗锯齿
        
        ChartXAxis *xAxis = _lineView3.xAxis;
        xAxis.granularityEnabled = YES;//设置重复的值不显示
        xAxis.labelPosition= XAxisLabelPositionBottom;//设置x轴数据在底部
        xAxis.gridColor = [UIColor clearColor];
        xAxis.labelTextColor = [UIColor blackColor];//文字颜色
        
        xAxis.axisLineColor = [UIColor grayColor];
        _lineView3.maxVisibleCount = 99;//
        //描述及图例样式
        //        [_lineView setDescriptionText:@""];
        _lineView3.legend.enabled = NO;
        // _lineView.legend.
        [_lineView3 animateWithXAxisDuration:1.0f];
    }
    return _lineView3;
}

- (LineChartView *)lineView4 {
    if (!_lineView4) {
        _lineView4 = [[LineChartView alloc] initWithFrame:CGRectMake(15, Yvalue + 966, 345, 200)];
        _lineView4.delegate = self;//设置代理
        _lineView4.backgroundColor =  [UIColor whiteColor];
        _lineView4.noDataText = @"暂无数据";
        _lineView4.chartDescription.enabled = YES;
        _lineView4.chartDescription.text = @"土壤电导率值曲线";
        _lineView4.scaleYEnabled = YES;//取消Y轴缩放
        _lineView4.doubleTapToZoomEnabled = NO;//取消双击缩放
        _lineView4.dragEnabled = YES;//启用拖拽图标
        _lineView4.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
        _lineView4.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显
        //设置滑动时候标签
        ChartMarkerView *markerY = [[ChartMarkerView alloc]
                                    init];
        markerY.offset = CGPointMake(-999, -8);
        markerY.chartView = _lineView4;
        _lineView4.marker = markerY;
        [markerY addSubview:self.markY];
        
        _lineView4.rightAxis.enabled = NO;//不绘制右边轴
        ChartYAxis *leftAxis = _lineView4.leftAxis;//获取左边Y轴
        leftAxis.labelCount = 5;//Y轴label数量，数值不一定，如果forceLabelsEnabled等于YES, 则强制绘制制定数量的label, 但是可能不平均
        leftAxis.forceLabelsEnabled = NO;//不强制绘制指定数量的label
        leftAxis.labelCount = 10;
        leftAxis.axisMinimum = 0;//设置Y轴的最小值
        leftAxis.axisMaximum = 200;//设置Y轴的最大值
        leftAxis.inverted = NO;//是否将Y轴进行上下翻转
        leftAxis.axisLineColor = [UIColor blackColor];//Y轴颜色
        leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc]init];
        leftAxis.labelPosition = YAxisLabelPositionOutsideChart;//label位置
        leftAxis.labelTextColor = [UIColor blackColor];//文字颜色
        leftAxis.labelFont = [UIFont systemFontOfSize:10.0f];//文字字体
        leftAxis.gridColor = [UIColor grayColor];//网格线颜色
        leftAxis.gridAntialiasEnabled = NO;//开启抗锯齿
        
        ChartXAxis *xAxis = _lineView4.xAxis;
        xAxis.granularityEnabled = YES;//设置重复的值不显示
        xAxis.labelPosition= XAxisLabelPositionBottom;//设置x轴数据在底部
        xAxis.gridColor = [UIColor clearColor];
        xAxis.labelTextColor = [UIColor blackColor];//文字颜色
        
        xAxis.axisLineColor = [UIColor grayColor];
        _lineView4.maxVisibleCount = 99;//
        //描述及图例样式
        //        [_lineView setDescriptionText:@""];
        _lineView4.legend.enabled = NO;
        // _lineView.legend.
        [_lineView4 animateWithXAxisDuration:1.0f];
    }
    return _lineView4;
}


- (LineChartData *)setData{
    
    NSInteger xVals_count = self.dataArry.count;//X轴上要显示多少条数据
    //X轴上面需要显示的数据
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i <= xVals_count - 1; i++) {
        @autoreleasepool {
            
        
        // 1. 获取模型数据
        DLData *model = self.dataArry[i];
        // 3. 把模型数据设置给单元格
        NSString *Date = model.Date;
        //        NSString *temperature = model.wendu;
        //        NSString *humidity = model.shidu;
        
        NSString *dateString = [Date substringFromIndex:5];
        NSString *date = [dateString substringToIndex:8];
        
        [xVals addObject: [NSString stringWithFormat:@"%@",date]];
            
        }
        
    }
    _lineView.xAxis.valueFormatter = [[DateValueFormatter alloc]initWithArr:xVals];
    //对应Y轴上面需要显示的数据
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < xVals_count; i++) {
        @autoreleasepool {
            
        
        DLData *model = self.dataArry[i];
        int humidity = [(model.shidu) intValue];//使用intValue
        
        // NSLog(@"%ld",temperature);
        //int a = arc4random() % 100;
        
        ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:humidity];
        [yVals addObject:entry];
        }
    }
    
    LineChartDataSet *set1 = nil;
    if (_lineView.data.dataSetCount > 0) {
        LineChartData *data = (LineChartData *)_lineView.data;
        set1 = (LineChartDataSet *)data.dataSets[0];
        set1.values = yVals;
        set1.valueFormatter = [[SetValueFormatter alloc]initWithArr:yVals];
        return data;
    }else{
        //创建LineChartDataSet对象
        set1 = [[LineChartDataSet alloc]initWithValues:yVals label:nil];
        //设置折线的样式
        set1.lineWidth = 1.0/[UIScreen mainScreen].scale;//折线宽度
        
        set1.drawValuesEnabled = YES;//是否在拐点处显示数据
        set1.valueFormatter = [[SetValueFormatter alloc]initWithArr:yVals];
        
        set1.valueColors = @[[UIColor brownColor]];//折线拐点处显示数据的颜色
        
        [set1 setColor:[UIColor brownColor]];//折线颜色
        set1.highlightColor = [UIColor redColor];
        //    set1.drawSteppedEnabled = NO;//是否开启绘制阶梯样式的折线图
        //折线拐点样式
        set1.drawCirclesEnabled = NO;//是否绘制拐点
        set1.drawFilledEnabled = YES;//是否填充颜色
        
        //将 LineChartDataSet 对象放入数组中
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        //添加第二个LineChartDataSet对象
        
        NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
        for (int i = 0; i <  xVals_count; i++) {
            //  int a = arc4random() % 80;
            DLData *model = self.dataArry[i];
            int temperature = [(model.wendu) intValue];//使用intValue
            
            
            ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:temperature];
            [yVals2 addObject:entry];
        }
        LineChartDataSet *set2 = [set1 copy];
        set2.values = yVals2;
        set2.drawValuesEnabled = NO;
        [set2 setColor:[UIColor blueColor]];
        
        [dataSets addObject:set2];
        //创建 LineChartData 对象, 此对象就是lineChartView需要最终数据对象
        LineChartData *data = [[LineChartData alloc]initWithDataSets:dataSets];
        
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:11.f]];//文字字体
        [data setValueTextColor:[UIColor blackColor]];//文字颜色
        
        
        return data;
    }
    
}




- (LineChartData *)setPhData{
    
    NSInteger xVals_count = self.phArry.count;//X轴上要显示多少条数据
    //X轴上面需要显示的数据
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i <= xVals_count - 1; i++) {
        @autoreleasepool {
            
            
            // 1. 获取模型数据
            DLPhData *model = self.phArry[i];
            // 3. 把模型数据设置给单元格
            NSString *Date = model.Date;
            //        NSString *temperature = model.wendu;
            //        NSString *humidity = model.shidu;
            
            NSString *dateString = [Date substringFromIndex:5];
            NSString *date = [dateString substringToIndex:8];
            
            [xVals addObject: [NSString stringWithFormat:@"%@",date]];
            
        }
        
    }
    _lineView2.xAxis.valueFormatter = [[DateValueFormatter alloc]initWithArr:xVals];
    //对应Y轴上面需要显示的数据
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < xVals_count; i++) {
        @autoreleasepool {
            
            
            DLPhData *model = self.phArry[i];
            float ph = [(model.ph) floatValue];//使用intValue
            
            // NSLog(@"%ld",temperature);
            //int a = arc4random() % 100;
            
            ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:ph];
            [yVals addObject:entry];
        }
    }
    
    LineChartDataSet *set3 = nil;
    if (_lineView2.data.dataSetCount > 0) {
        LineChartData *data = (LineChartData *)_lineView2.data;
        set3 = (LineChartDataSet *)data.dataSets[0];
        set3.values = yVals;
        set3.valueFormatter = [[SetValueFormatter alloc]initWithArr:yVals];
        return data;
    }else{
        //创建LineChartDataSet对象
        set3 = [[LineChartDataSet alloc]initWithValues:yVals label:nil];
        //设置折线的样式
        set3.lineWidth = 1.0/[UIScreen mainScreen].scale;//折线宽度
        
        set3.drawValuesEnabled = YES;//是否在拐点处显示数据
        set3.valueFormatter = [[SetValueFormatter alloc]initWithArr:yVals];
        
        set3.valueColors = @[[UIColor brownColor]];//折线拐点处显示数据的颜色
        
        [set3 setColor:[UIColor orangeColor]];//折线颜色
        set3.highlightColor = [UIColor redColor];
        //    set1.drawSteppedEnabled = NO;//是否开启绘制阶梯样式的折线图
        //折线拐点样式
        set3.drawCirclesEnabled = NO;//是否绘制拐点
        set3.drawFilledEnabled = YES;//是否填充颜色
        
        //将 LineChartDataSet 对象放入数组中
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set3];
        
        //添加第二个LineChartDataSet对象
        
//        NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
//        for (int i = 0; i <  xVals_count; i++) {
//            //  int a = arc4random() % 80;
//            DLData *model = self.phArry[i];
//            int temperature = [(model.wendu) intValue];//使用intValue
//
//
//            ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:temperature];
//            [yVals2 addObject:entry];
//        }
//        LineChartDataSet *set4 = [set3 copy];
//        set4.values = yVals2;
//        set4.drawValuesEnabled = NO;
//        [set4 setColor:[UIColor blueColor]];
//
//        [dataSets addObject:set4];
        //创建 LineChartData 对象, 此对象就是lineChartView需要最终数据对象
        LineChartData *data = [[LineChartData alloc]initWithDataSets:dataSets];
        
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:11.f]];//文字字体
        [data setValueTextColor:[UIColor blackColor]];//文字颜色
        
        
        return data;
    }
    
}



- (LineChartData *)setGzData{
    
    NSInteger xVals_count = self.gzArry.count;//X轴上要显示多少条数据
    //X轴上面需要显示的数据
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i <= xVals_count - 1; i++) {
        @autoreleasepool {
            
            
            // 1. 获取模型数据
            DLPhData *model = self.gzArry[i];
            // 3. 把模型数据设置给单元格
            NSString *Date = model.Date;
            //        NSString *temperature = model.wendu;
            //        NSString *humidity = model.shidu;
            
            NSString *dateString = [Date substringFromIndex:5];
            NSString *date = [dateString substringToIndex:8];
            
            [xVals addObject: [NSString stringWithFormat:@"%@",date]];
            
        }
        
    }
    _lineView3.xAxis.valueFormatter = [[DateValueFormatter alloc]initWithArr:xVals];
    //对应Y轴上面需要显示的数据
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < xVals_count; i++) {
        @autoreleasepool {
            
            
            DLGzData *model = self.gzArry[i];
            int gz = [(model.gz) intValue];//使用intValue
            
            // NSLog(@"%ld",temperature);
            //int a = arc4random() % 100;
            
            ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:gz];
            [yVals addObject:entry];
        }
    }
    
    LineChartDataSet *set5 = nil;
    if (_lineView3.data.dataSetCount > 0) {
        LineChartData *data = (LineChartData *)_lineView3.data;
        set5 = (LineChartDataSet *)data.dataSets[0];
        set5.values = yVals;
        set5.valueFormatter = [[SetValueFormatter alloc]initWithArr:yVals];
        return data;
    }else{
        //创建LineChartDataSet对象
        set5 = [[LineChartDataSet alloc]initWithValues:yVals label:nil];
        //设置折线的样式
        set5.lineWidth = 1.0/[UIScreen mainScreen].scale;//折线宽度
        
        set5.drawValuesEnabled = YES;//是否在拐点处显示数据
        set5.valueFormatter = [[SetValueFormatter alloc]initWithArr:yVals];
        
        set5.valueColors = @[[UIColor brownColor]];//折线拐点处显示数据的颜色
        
        [set5 setColor:[UIColor redColor]];//折线颜色
        set5.highlightColor = [UIColor redColor];
        //    set1.drawSteppedEnabled = NO;//是否开启绘制阶梯样式的折线图
        //折线拐点样式
        set5.drawCirclesEnabled = NO;//是否绘制拐点
        set5.drawFilledEnabled = YES;//是否填充颜色
        
        //将 LineChartDataSet 对象放入数组中
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set5];
        
        //添加第二个LineChartDataSet对象
        
        //        NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
        //        for (int i = 0; i <  xVals_count; i++) {
        //            //  int a = arc4random() % 80;
        //            DLData *model = self.phArry[i];
        //            int temperature = [(model.wendu) intValue];//使用intValue
        //
        //
        //            ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:temperature];
        //            [yVals2 addObject:entry];
        //        }
        //        LineChartDataSet *set4 = [set3 copy];
        //        set4.values = yVals2;
        //        set4.drawValuesEnabled = NO;
        //        [set4 setColor:[UIColor blueColor]];
        //
        //        [dataSets addObject:set4];
        //创建 LineChartData 对象, 此对象就是lineChartView需要最终数据对象
        LineChartData *data = [[LineChartData alloc]initWithDataSets:dataSets];
        
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:11.f]];//文字字体
        [data setValueTextColor:[UIColor blackColor]];//文字颜色
        
        
        return data;
    }
    
}



- (LineChartData *)setDdlData{
    
    NSInteger xVals_count = self.ddlArry.count;//X轴上要显示多少条数据
    //X轴上面需要显示的数据
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i <= xVals_count - 1; i++) {
        @autoreleasepool {
            
            
            // 1. 获取模型数据
            DLDdlData *model = self.ddlArry[i];
            // 3. 把模型数据设置给单元格
            NSString *Date = model.Date;
            //        NSString *temperature = model.wendu;
            //        NSString *humidity = model.shidu;
            
            NSString *dateString = [Date substringFromIndex:5];
            NSString *date = [dateString substringToIndex:8];
            
            [xVals addObject: [NSString stringWithFormat:@"%@",date]];
            
        }
        
    }
    _lineView4.xAxis.valueFormatter = [[DateValueFormatter alloc]initWithArr:xVals];
    //对应Y轴上面需要显示的数据
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    for (int i = 0; i < xVals_count; i++) {
        @autoreleasepool {
            
            
            DLDdlData *model = self.ddlArry[i];
            int ddl = [(model.ddl) intValue];//使用intValue
            
            // NSLog(@"%ld",temperature);
            //int a = arc4random() % 100;
            
            ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:ddl];
            [yVals addObject:entry];
        }
    }
    
    LineChartDataSet *set7 = nil;
    if (_lineView4.data.dataSetCount > 0) {
        LineChartData *data = (LineChartData *)_lineView4.data;
        set7 = (LineChartDataSet *)data.dataSets[0];
        set7.values = yVals;
        set7.valueFormatter = [[SetValueFormatter alloc]initWithArr:yVals];
        return data;
    }else{
        //创建LineChartDataSet对象
        set7 = [[LineChartDataSet alloc]initWithValues:yVals label:nil];
        //设置折线的样式
        set7.lineWidth = 1.0/[UIScreen mainScreen].scale;//折线宽度
        
        set7.drawValuesEnabled = YES;//是否在拐点处显示数据
        set7.valueFormatter = [[SetValueFormatter alloc]initWithArr:yVals];
        
        set7.valueColors = @[[UIColor brownColor]];//折线拐点处显示数据的颜色
        
        [set7 setColor:[UIColor purpleColor]];//折线颜色
        set7.highlightColor = [UIColor redColor];
        //    set1.drawSteppedEnabled = NO;//是否开启绘制阶梯样式的折线图
        //折线拐点样式
        set7.drawCirclesEnabled = NO;//是否绘制拐点
        set7.drawFilledEnabled = YES;//是否填充颜色
        
        //将 LineChartDataSet 对象放入数组中
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set7];
        
        //添加第二个LineChartDataSet对象
        
        //        NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
        //        for (int i = 0; i <  xVals_count; i++) {
        //            //  int a = arc4random() % 80;
        //            DLData *model = self.phArry[i];
        //            int temperature = [(model.wendu) intValue];//使用intValue
        //
        //
        //            ChartDataEntry *entry = [[ChartDataEntry alloc] initWithX:i y:temperature];
        //            [yVals2 addObject:entry];
        //        }
        //        LineChartDataSet *set4 = [set3 copy];
        //        set4.values = yVals2;
        //        set4.drawValuesEnabled = NO;
        //        [set4 setColor:[UIColor blueColor]];
        //
        //        [dataSets addObject:set4];
        //创建 LineChartData 对象, 此对象就是lineChartView需要最终数据对象
        LineChartData *data = [[LineChartData alloc]initWithDataSets:dataSets];
        
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:11.f]];//文字字体
        [data setValueTextColor:[UIColor blackColor]];//文字颜色
        
        
        return data;
    }
    
}







- (void)chartValueSelected:(ChartViewBase * _Nonnull)chartView entry:(ChartDataEntry * _Nonnull)entry highlight:(ChartHighlight * _Nonnull)highlight {
    
    _markY.text = [NSString stringWithFormat:@"%ld%%",(NSInteger)entry.y];
    //将点击的数据滑动到中间
    [_lineView centerViewToAnimatedWithXValue:entry.x yValue:entry.y axis:[_lineView.data getDataSetByIndex:highlight.dataSetIndex].axisDependency duration:1.0];
    
}
- (void)chartValueNothingSelected:(ChartViewBase * _Nonnull)chartView {
    
    
}


-(UIView *)roundBackViewWith:(CGFloat)left1:(CGFloat)top1:(CGFloat)width1:(CGFloat)height1
{
    //把 view2 的 左下角 和 右下角的直角切成圆角
    DLShapeView *view2 = [[DLShapeView alloc] initWithFrame:CGRectMake(left1,top1,width1,height1)];
    view2.backgroundColor = [UIColor whiteColor];
//    view2.backgroundColor = [UIColor colorWithRed:241/255.0f green:211/255.0f blue:151/255.0f alpha:0.3];
    [self.backView addSubview:view2];
    //设置切哪个直角
  
//    //得到view的遮罩路径
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view2.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(20,20)];
//    //创建 layer
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = view2.bounds;
//    //赋值
//    maskLayer.path = maskPath.CGPath;
//    view2.layer.mask = maskLayer;
    
    
     view2.layer.shadowColor = [UIColor grayColor].CGColor;
    // 阴影偏移，默认(0, -3)
     view2.layer.shadowOffset = CGSizeMake(10,10);
    // 阴影透明度，默认0
     view2.layer.shadowOpacity = 0.5;
    // 阴影半径，默认3
     view2.layer.shadowRadius = 10;
 
    
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
//                             (__bridge id)[UIColor yellowColor].CGColor
//                             ];
//
//    gradientLayer.locations = @[@0.3, @1.0];
//    gradientLayer.startPoint = CGPointMake(0, 0);
//    gradientLayer.endPoint = CGPointMake(10, 10);
//    gradientLayer.frame = CGRectMake(0, 0,  100, 100);
//    gradientLayer.mask = maskLayer;
//   // gradientLayer.cornerRadius = 50;
//    [view2.layer addSublayer:gradientLayer];




    
  

    return view2;
    
}
@end
