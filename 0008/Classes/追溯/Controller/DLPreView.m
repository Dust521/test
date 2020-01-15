//
//  DLPreView.m
//  0008
//
//  Created by 董亮 on 2019/1/14.
//  Copyright © 2019 董亮. All rights reserved.
//

#import "DLPreView.h"

@interface DLPreView()
@property (nonatomic,strong)UIImageView *imageView;


@property (nonatomic,strong)UIImageView *lineImageView;
@property (nonatomic,strong)NSTimer *timer;

@end

@implementation DLPreView

+(Class)layerClass
{
    return [AVCaptureVideoPreviewLayer class];
}

- (void)setSession:(AVCaptureSession *)session
{
    _session = session;
    
    AVCaptureVideoPreviewLayer *layer = (AVCaptureVideoPreviewLayer *)self.layer;
    layer.session = session;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initUiConfig];
    }
    return self;
}

- (void)initUiConfig
{
    //设置背景图片
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ScanQR.png"]];
    //设置位置到界面中间
    _imageView.frame = CGRectMake(self.bounds.size.width * 0.5 - 120, self.bounds.size.height *0.5 -120, 240, 240);
    //添加到视图上
    [self addSubview:_imageView];
    
    
    //初始化二维码到扫描线位置
    _lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 220, 2)];
    _lineImageView.image = [UIImage imageNamed:@"scanLine.png"];
    [_imageView addSubview:_lineImageView];
    
    //开启定时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(animation) userInfo:nil repeats:YES];
}

- (void)animation
{
    [UIView animateWithDuration:2.8 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        _lineImageView.frame = CGRectMake(10, 235, 220, 2);
        
    } completion:^(BOOL finished) {
        _lineImageView.frame = CGRectMake(10, 0, 220, 2);
    }];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
