//
//  DLRegisterViewController.m
//  0008
//
//  Created by 董亮 on 2019/1/1.
//  Copyright © 2019 董亮. All rights reserved.
//

#import "DLRegisterViewController.h"
#import <SMS_SDK/SMSSDK.h>
#import "DLAlertView.h"


@interface DLRegisterViewController ()

@property(nonatomic,weak)  NSString *phoneNumber;
@property(nonatomic,weak)  NSString *pwdNumber;
@property(nonatomic,weak)  UITextField *veriCodeField;
@property(nonatomic,weak)  UITextField *pwdNumField;

@property(nonatomic,strong) NSString *registerStatus;

@end

@implementation DLRegisterViewController

-(void)setRegisterStatus:(NSString *)registerStatus{
    
    _registerStatus = registerStatus;
    //等着加载完数据，重新
     NSLog(@"set方法打印registerStatus%@",registerStatus);
     NSLog(@"set方法打印_registerStatus%@",_registerStatus);
    
    [DLAlertView showAlter:@"注册成功请登录"];
    //如果注册成功返回之前的界面
    if ([_registerStatus isEqual: @"1"]) {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    
    self.view.backgroundColor = [UIColor colorWithRed:248/255.0f green:209/255.0f blue:78/255.0f alpha:1];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(30, 140, 100, 21);
    label.text = @"确认密码";
    label.textColor = [UIColor colorWithRed:72/255.0f green:85/255.0f blue:124/255.0f alpha:1];
    label.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:label];

    UILabel *label2 = [[UILabel alloc] init];
    label2.frame = CGRectMake(30, 280, 100, 21);
    label2.text = @"验证码";
    label2.textColor = [UIColor colorWithRed:72/255.0f green:85/255.0f blue:124/255.0f alpha:1];
    label2.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:label2];
    
    UILabel *labe3 = [[UILabel alloc] init];
    labe3.frame = CGRectMake(30, 500, 200, 21);
    labe3.text = _phoneNumber;
    labe3.textColor = [UIColor colorWithRed:72/255.0f green:85/255.0f blue:124/255.0f alpha:1];
    labe3.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:labe3];
    
    UILabel *label4 = [[UILabel alloc] init];
    label4.frame = CGRectMake(30, 550, 200, 21);
    label4.text = _pwdNumber;
    label4.textColor = [UIColor colorWithRed:72/255.0f green:85/255.0f blue:124/255.0f alpha:1];
    label4.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:label4];
    
    UILabel *label5 = [[UILabel alloc] init];
    label5.frame = CGRectMake(30, 240, 400, 21);
    label5.text = [NSString stringWithFormat:@"(点击以给号码为%@的手机发送短信验证码)",_phoneNumber];
    label5.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2];
    
    label5.font = [UIFont systemFontOfSize:13];
  
    
    label5.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:label5];

    UITextField *pwdNumField = [[UITextField alloc]init];
    pwdNumField.frame = CGRectMake(120, 130, 200, 30);
   // pwdNumField.text = _phoneNumber;
    //pwdNumField.backgroundColor = [UIColor whiteColor];
    pwdNumField.layer.cornerRadius = 10.0;
    self.pwdNumField = pwdNumField;
    
    [self.view addSubview:pwdNumField];
    
    UITextField *veriCodeField = [[UITextField alloc]init];
    veriCodeField.frame = CGRectMake(120, 280, 200, 30);
    //veriCodeField.text = _pwdNumber;
   //veriCodeField.backgroundColor = [UIColor whiteColor];
    veriCodeField.layer.cornerRadius = 10.0;
    
    self.veriCodeField = veriCodeField;
    //发送验证码之前验证码输入框无法编辑
    self.veriCodeField.enabled = NO;
    [self.view addSubview:veriCodeField];
    
    
//    UIImageView *line1=[self createImageViewFrame:CGRectMake(0, 30, 200, 3) imageName:nil color:[UIColor colorWithRed:248/255.0f green:209/255.0f blue:78/255.0f alpha:.3]];
    
    UIImageView *line1=[self createImageViewFrame:CGRectMake(2,30,196,3) imageName:nil color:[UIColor colorWithRed:72/255.0f green:85/255.0f blue:124/255.0f alpha:1]];
    [_pwdNumField addSubview: line1];
    
    UIImageView *line2=[self createImageViewFrame:CGRectMake(2,30,196,3) imageName:nil color:[UIColor colorWithRed:72/255.0f green:85/255.0f blue:124/255.0f alpha:1]];
    [_veriCodeField addSubview: line2];
    
    UIButton *sendVeriCodeBtn = [[UIButton alloc]init];
    sendVeriCodeBtn.frame = CGRectMake(40, 200, 280, 40);
    sendVeriCodeBtn.backgroundColor = [UIColor colorWithRed:72/255.0f green:85/255.0f blue:124/255.0f alpha:1];

    [sendVeriCodeBtn addTarget:self action:@selector(sendBackGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
    [sendVeriCodeBtn addTarget:self action:@selector(sendBackGroundNormal:) forControlEvents:UIControlEventTouchUpInside];
    
    [sendVeriCodeBtn setTitle: @"发送验证码" forState: UIControlStateNormal];
    sendVeriCodeBtn.layer.cornerRadius = 10.0;
    [self.view addSubview: sendVeriCodeBtn];
    
    //按下按钮，发送验证码功能
    [sendVeriCodeBtn addTarget:self action:@selector(sendBtnClicked) forControlEvents:UIControlEventTouchUpInside];

    
    UIButton *affirmRegisterBtn = [[UIButton alloc]init];
    affirmRegisterBtn.frame = CGRectMake(120, 350, 200, 40);
    affirmRegisterBtn.backgroundColor = [UIColor colorWithRed:72/255.0f green:85/255.0f blue:124/255.0f alpha:1];
    
    [affirmRegisterBtn addTarget:self action:@selector(sendBackGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
    [affirmRegisterBtn addTarget:self action:@selector(sendBackGroundNormal:) forControlEvents:UIControlEventTouchUpInside];
    
    [affirmRegisterBtn setTitle: @"确认注册" forState: UIControlStateNormal];
    affirmRegisterBtn.layer.cornerRadius = 10.0;
    [self.view addSubview: affirmRegisterBtn];
    
    
    //按下按钮，确认验证码和密码是否和之前输入的一致
    [affirmRegisterBtn addTarget:self action:@selector(affirmBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *cancelBtn = [[UIButton alloc]init];
    cancelBtn.frame = CGRectMake(40, 350, 60, 40);
    cancelBtn.backgroundColor = [UIColor colorWithRed:72/255.0f green:85/255.0f blue:124/255.0f alpha:1];
    
    [cancelBtn addTarget:self action:@selector(sendBackGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
    [cancelBtn addTarget:self action:@selector(sendBackGroundNormal:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn addTarget:self action:@selector(cancelBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [cancelBtn setTitle: @"取消" forState: UIControlStateNormal];
    
    cancelBtn.layer.cornerRadius = 10.0;
    [self.view addSubview:cancelBtn];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//
//- (void)sendValue:(NSString *)account
//{
//    _pwdNumber = account;
//}

- (void)sendValue:(NSString *)account pwd:(NSString *)pwd
{
    _phoneNumber = account;
    _pwdNumber = pwd;
}

//
- (void)sendBtnClicked{
    
 
    
    if([self.pwdNumField.text isEqualToString:_pwdNumber])
    {
        //发送验证码之前验证码输入框无法编辑
        self.veriCodeField.enabled = YES;
        [self.veriCodeField becomeFirstResponder];
        
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_phoneNumber zone:@"86"  result:^(NSError *error) {
        
        if (!error)
        {
            // 请求成功
            NSLog(@"发送验证码成功");
        }
        else
        {
            NSLog(@"错误信息%@",error);
        }
    }];
    }else
    {
        
        NSLog(@"密码和之前不一致");
        [DLAlertView showAlter:@"密码和之前不一致"];
        
    }
}

- (void)affirmBtnClicked{
    
    [self.view endEditing:YES];
    
//    if (self.veriCodeField.text == NULL)
//    {
//        return ;
//    }
   //提交验证码
    [SMSSDK commitVerificationCode:_veriCodeField.text phoneNumber:_phoneNumber zone:@"86" result:^(NSError *error) {
        
       
        
        if (!error)
        {
            // 验证成功
            NSLog(@"------------------");
            NSLog(@" 密码一致！验证码正确！");
            NSLog(@"------------------");
            
            NSString *strUrl = @"http://39.96.8.115/register.php";
            
            NSURL *url = [NSURL URLWithString:strUrl];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
            //发送post请求
            request.HTTPMethod = @"post";
            //设置请求体
            NSString *body = [NSString stringWithFormat: @"username=%@&pwd=%@",self.phoneNumber,self.pwdNumber];
            
            //把字符串转换成NSData对象
            request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
            
            [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
                if (connectionError){
                    NSLog(@"连接错误 %@",connectionError);
                    return;
                }
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                if (httpResponse.statusCode == 200 || httpResponse.statusCode == 304){
                    //解析数据
                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                    
                    NSLog(@"服务器返回的注册状态是%@",dic[@"registerstus"]);
                    //调用了重写了的setLoginStatus方法
                    //            -(void)setLoginStatus:(NSString *)loginStatus{
                    //                _loginStatus = loginStatus;
                    //                //等着加载完数据，重新landclick
                    //                [self loginSucess];
                    //            }
                    
                    self.registerStatus = (NSString *)dic[@"registerstus"];
                    NSLog(@"registerStatus 是 %@",dic[@"registerstus"]);
                    NSLog(@"block内部的registerstatus:%@",self->_registerStatus);
                    NSLog(@"注册请求下的网络状态码：%ld",(long)httpResponse.statusCode);
                }
                else
                {
                    NSLog(@"服务器内部错误");
                }
            }];
            
            NSLog(@"本地的registerStatus%@",self->_registerStatus);
            
            
            
            
            
            
            
            
            
        //跳转回登录界面
      //  [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        }
        else
        {
            [DLAlertView showAlter:@"验证码错误!"];
            NSLog(@"%@",error);
        }
    
        
        
        
        
    }];
    
//    }else
//    {
//
//        NSLog(@"密码和之前不一致");
//        [DLAlertView showAlter:@"密码和之前不一致"];
//
//    }
    
    
}

- (void)cancelBtnClicked
{
    //跳转回登录界面
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
//    NSString *strUrl = @"http://39.96.8.115/register.php";
//
//    NSURL *url = [NSURL URLWithString:strUrl];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    //发送post请求
//    request.HTTPMethod = @"post";
//    //设置请求体
//    NSString *body = [NSString stringWithFormat: @"username=%@&pwd=%@",self.phoneNumber,self.pwdNumber];
//
//    //把字符串转换成NSData对象
//    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
//
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//        if (connectionError){
//            NSLog(@"连接错误 %@",connectionError);
//            return;
//        }
//        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
//        if (httpResponse.statusCode == 200 || httpResponse.statusCode == 304){
//            //解析数据
//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
//
//            NSLog(@"服务器返回的注册状态是%@",dic[@"registerstus"]);
//            //调用了重写了的setLoginStatus方法
//            //            -(void)setLoginStatus:(NSString *)loginStatus{
//            //                _loginStatus = loginStatus;
//            //                //等着加载完数据，重新landclick
//            //                [self loginSucess];
//            //            }
//
//            self.registerStatus = (NSString *)dic[@"registerstus"];
//            NSLog(@"registerStatus 是 %@",dic[@"registerstus"]);
//            NSLog(@"block内部的registerstatus:%@",self->_registerStatus);
//            NSLog(@"注册请求下的网络状态码：%ld",(long)httpResponse.statusCode);
//        }
//        else
//        {
//            NSLog(@"服务器内部错误");
//        }
//    }];
//
//    NSLog(@"本地的registerStatus%@",_registerStatus);
    
    
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

- (void)sendBackGroundNormal:(UIButton *)sender
{
    sender.backgroundColor = [UIColor redColor];
}
- (void)sendBackGroundHighlighted:(UIButton *)sender
{
    sender.backgroundColor = [UIColor colorWithRed:53/255.0f green:53/255.0f blue:53/255.0f alpha:1];
}


//触摸空白区域撤回键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end

