//
//  DLRetrospectViewController.m
//  0008
//
//  Created by 董亮 on 2019/1/14.
//  Copyright © 2019 董亮. All rights reserved.
//

#import "DLRetrospectViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "DLPreView.h"
#import "DLShapeView.h"

#import "AFNetworking.h"

#import "DLBaseInfo.h"

#import "DLShowInfoViewController.h"

@interface DLRetrospectViewController ()<AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic,strong) AVCaptureDeviceInput *input;
@property (nonatomic,strong) AVCaptureMetadataOutput *output;
@property (nonatomic,strong) AVCaptureSession *session;
//@property (nonatomic,strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic,strong) DLPreView *preview;
@property (nonatomic,copy) NSString *textString;

@property (nonatomic,weak) UILabel *lableTest;

@property(strong,nonatomic)NSArray *stringExist;

@end

@implementation DLRetrospectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0f green:208/255.0f blue:35/255.0f alpha:1].CGColor, (__bridge id)[UIColor whiteColor].CGColor];
    gradientLayer.locations = @[@0.1, @0.6];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    gradientLayer.frame = self.view.frame;
    [self.view.layer addSublayer:gradientLayer];
    
    
    [self roundBackViewWith:10 :10 :355 :150];
    
    
    
    [self.view setFrame:CGRectMake(0, 88,375, KScreenSzieHeight-88)];
    UIButton *scanBtn = [[UIButton alloc]init];
    scanBtn.frame = CGRectMake(195, 500,130, 45);
    scanBtn.backgroundColor = [UIColor colorWithRed:72/255.0f green:85/255.0f blue:124/255.0f alpha:1];
    
//    [scanBtn addTarget:self action:@selector(sendBackGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
//    [scanBtn addTarget:self action:@selector(sendBackGroundNormal:) forControlEvents:UIControlEventTouchUpInside];
    [scanBtn addTarget:self action:@selector(scanBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [scanBtn setTitle: @"扫描二维码" forState: UIControlStateNormal];
    
   // scanBtn.layer.cornerRadius = 15.0;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:scanBtn.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(18,18)];
    //创建 layer
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = scanBtn.bounds;
    //赋值
    maskLayer.path = maskPath.CGPath;
    scanBtn.layer.mask = maskLayer;
    
    
    [self.view addSubview:scanBtn];
    
    UIButton *textBtn = [[UIButton alloc]init];
    textBtn.frame = CGRectMake(45,500,130, 45);
    textBtn.backgroundColor = [UIColor colorWithRed:72/255.0f green:85/255.0f blue:124/255.0f alpha:1];
    
    //    [textBtnBtn addTarget:self action:@selector(sendBackGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
    //    [textBtnBtn addTarget:self action:@selector(sendBackGroundNormal:) forControlEvents:UIControlEventTouchUpInside];
    [textBtn addTarget:self action:@selector(textBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [textBtn setTitle: @"输入标示码" forState: UIControlStateNormal];
    
   // textBtn.layer.cornerRadius = 15.0;
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:textBtn.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(18,18)];
    //创建 layer
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.frame = textBtn.bounds;
    //赋值
    maskLayer1.path = maskPath.CGPath;
      textBtn.layer.mask = maskLayer1;
    
    [self.view addSubview:textBtn];
    
    UILabel *label = [[UILabel alloc] init];
    self.lableTest = label;
    label.frame = CGRectMake(45, 570, 300, 21);
    //label.text = @"扫描二维码测试结果";
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:label];
    
    
    
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
   // [self getYesOrNoWith:[NSString stringWithFormat:@"201900101234567"]];
}

- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    //1.停止会话
    [self.session stopRunning];
//
//    //2.删除layer
//    [self.previewLayer removeFromSuperlayer];
    [self.preview removeFromSuperview];
    
    //3.遍历数据获取内容
    for (AVMetadataMachineReadableCodeObject *obj in metadataObjects) {
        NSLog(@"---------------------");
        NSLog(@"%@",obj.stringValue);
        NSLog(@"---------------------");
        self.lableTest.text = obj.stringValue;
        if (obj.stringValue)
        {
            DLShowInfoViewController *controller = [[DLShowInfoViewController alloc]init];
//            _postController = controller;
            
            controller.qrCodeString = obj.stringValue;
  
          //  [self presentViewController: controller animated:YES completion:nil];
            
            [self.navigationController pushViewController:controller animated:YES];
            
        }
 
    }
}
- (void)textBtnClicked
{
    NSLog(@"%d",(int)[[UIScreen mainScreen] bounds].size.width);
    
    UITextField *textInput = [[UITextField alloc]initWithFrame:CGRectMake(30, 300, 315, 40)];
    textInput.backgroundColor = [UIColor whiteColor];
    textInput.placeholder = @"              请输入产品的唯一标识码";
    
    //_textString = textInput.text;
    [self.view addSubview:textInput];
    
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:textInput.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(13,13)];
    //创建 layer
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = textInput.bounds;
    //赋值
    maskLayer.path = maskPath.CGPath;
    textInput.layer.mask = maskLayer;
    
    textInput.delegate = self;
    textInput.returnKeyType = UIReturnKeyDone;
    
 
    
}

//实现UITextField代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
     _textString = textField.text;
    
    [textField resignFirstResponder];//取消第一响应者
    DLShowInfoViewController *controller = [[DLShowInfoViewController alloc]init];
    controller.qrCodeString = _textString;
    NSLog(@"执行了么%@",_textString);
    
    [self.navigationController pushViewController:controller animated:YES];
    return YES;
}

- (void)scanBtnClicked
{
    NSLog(@"扫描二维码按钮被点击了");
    //1.输入设备（用来获取外界信息）摄像头 麦克风 键盘
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    //2.输出设备（将收集到的信息做解析来获取收到的内容）
    self.output = [AVCaptureMetadataOutput new];
    
    //3.会话session（用来连接输入和输出设备）
    self.session = [AVCaptureSession new];
    //会话扫描展示的大小
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    
    //会话跟输入和输出设备关联
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    if ([self.session canAddOutput:self.output]) {
        [self.session addOutput:self.output];
    }
    
    //指定输出设备的代理，用来接收返回的数据
    [self.output setMetadataObjectsDelegate: self queue:dispatch_get_main_queue()];
    
    //设置元数据类型 二维码QRCode
    [self.output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
//    //4.特殊的layer(展示输入设备所采集的信息)
//    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.session];
//    //layer的大小
//    self.previewLayer.frame = self.view.bounds;
//    [self.view.layer addSublayer:self.previewLayer];

    self.preview = [[DLPreView alloc]initWithFrame:self.view.bounds];
    self.preview.session = self.session;
    [self.view addSubview:self.preview];
    //5.启动会话
    [self.session startRunning];
    
}

-(UIView *)roundBackViewWith:(CGFloat)left1:(CGFloat)top1:(CGFloat)width1:(CGFloat)height1
{
    //把 view2 的 左下角 和 右下角的直角切成圆角
    DLShapeView *view2 = [[DLShapeView alloc] initWithFrame:CGRectMake(left1,top1,width1,height1)];
    view2.backgroundColor = [UIColor whiteColor];
    //    view2.backgroundColor = [UIColor colorWithRed:241/255.0f green:211/255.0f blue:151/255.0f alpha:0.3];
    [self.view addSubview:view2];
    //设置切哪个直角
    
    //    //得到view的遮罩路径
    //    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view2.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(20,20)];
    //    //创建 layer
    //    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    //    maskLayer.frame = view2.bounds;
    //    //赋值
    //    maskLayer.path = maskPath.CGPath;
    //    view2.layer.mask = maskLayer;
    
//
//    view2.layer.shadowColor = [UIColor grayColor].CGColor;
//    // 阴影偏移，默认(0, -3)
//    view2.layer.shadowOffset = CGSizeMake(10,10);
//    // 阴影透明度，默认0
//    view2.layer.shadowOpacity = 0.5;
//    // 阴影半径，默认3
//    view2.layer.shadowRadius = 10;

    return view2;
    
}
//-(void)getYesOrNoWith:(NSString *)ProdID
//{
//
//    NSString *urlString = @"http://39.96.8.115/exist.php";
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    //发送和接收都用JSON格式
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//
//    NSString *prodCode = [NSString stringWithFormat:@"%@",ProdID];
//    NSLog(@"%@",prodCode);
//    NSDictionary *parameters = @{@"prodcode":prodCode
//                                 };
//    [manager POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:10];
//
//        [responseObject enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            DLBaseInfo *baseInfo = [DLBaseInfo baseInfoWithDict:obj];
//            [mArray addObject:baseInfo];
//        }];
//        NSLog(@"服务器返回的数据：%@",responseObject);
//        NSLog(@"mArray:%@",mArray);
//
//        //判断一个数组是否为空
//        if (mArray != nil && ![mArray isKindOfClass:[NSNull class]] && mArray.count != 0)
//        {
//            //如果使用_dataArry = mArray 则不会调用dataArray的set方法
//            self.stringExist = mArray;
//        }
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//
//    }];
//}

@end
