//
//  DLLoginPageViewController.m
//  0008
//
//  Created by 董亮 on 2018/12/24.
//  Copyright © 2018 董亮. All rights reserved.
//

#import "DLLoginPageViewController.h"
#import "AppDelegate.h"
#import "DLTextField.h"
#import "DLTabbarController.h"
#import "DLAlertView.h"
#import "DLRegisterViewController.h"

@interface DLLoginPageViewController ()<UITextFieldDelegate,UIActionSheetDelegate>
{
    UIImageView *View;
    UIView *bgView;
    UITextField *pwd;
    DLTextField *accontuser;
    UIButton *QQBtn;
    UIButton *weixinBtn;
    UIButton *xinlangBtn;
}

//
@property (nonatomic,strong)NSString *loginStatus;

@property (nonatomic,strong)NSString *account;
@property (nonatomic,strong)NSString *password;


@end

@implementation DLLoginPageViewController

-(void)setLoginStatus:(NSString *)loginStatus{
    
    _loginStatus = loginStatus;
    //等着加载完数据，重新
    NSLog(@"login： set方法里面的值是%@",loginStatus);
    [self judgeLogin];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:72/255.0f green:85/255.0f blue:124/255.0f alpha:1]];
    // Do any additional setup after loading the view, typically from a nib.
    //self.view.backgroundColor=[UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
    //设置NavigationBar背景颜色
    View=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    //View.backgroundColor=[UIColor redColor];
    //View.image=[UIImage imageNamed:@"bg4"];
    [self.view addSubview:View];
    
    
    UIButton *zhuce =[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-60, 30, 30, 30)];
    [zhuce setTitle:@"注册" forState:UIControlStateNormal];
    [zhuce setTitleColor:[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1] forState:UIControlStateNormal];
    zhuce.titleLabel.font=[UIFont systemFontOfSize:17];
    [zhuce addTarget:self action:@selector(zhuce) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zhuce];
    
    
    [self createButtons];
    [self createImageViews];
    [self createTextFields];
    [self createLabel];
}

-(void)clickaddBtn:(UIButton *)button
{
    //      [kAPPDelegate appDelegateInitTabbar];
    self.view.backgroundColor=[UIColor whiteColor];
    exit(0);
}


-(void)createLabel
{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width-140)/2, 390, 140, 21)];
    label.text=@"第三方账号快速登录";
    label.textColor=[UIColor grayColor];
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:label];
}

-(void)createTextFields
{
    CGRect frame=[UIScreen mainScreen].bounds;
    bgView=[[UIView alloc]initWithFrame:CGRectMake(20, 125, frame.size.width-40, 100)];
   //bgView.layer.cornerRadius=23.0;
    
    
        //得到view的遮罩路径
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bgView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(20,20)];
        //创建 layer
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = bgView.bounds;
        //赋值
        maskLayer.path = maskPath.CGPath;
        bgView.layer.mask = maskLayer;
    
    
    bgView.alpha=0.7;
    bgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bgView];
    
    accontuser = [[DLTextField alloc]initWithFrame:CGRectMake(60, 10, 271, 30)];
    accontuser.font = [UIFont systemFontOfSize:14] ;
    accontuser.placeholder = @"请输入您的手机号码";
    accontuser.textColor=[UIColor blackColor];
    accontuser.borderStyle=UITextBorderStyleNone;
    accontuser.backgroundColor =[UIColor clearColor];
    accontuser.delegate = self;
    
    accontuser.text=@"13821009679";
    accontuser.keyboardType=UIKeyboardTypeNumberPad;
    accontuser.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    pwd=[self createTextFielfFrame:CGRectMake(60, 60, 271, 30) font:[UIFont systemFontOfSize:14] placeholder:@"密码" ];
    pwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    pwd.text=@"dl123456";
    //密文样式
    pwd.secureTextEntry=YES;
    //pwd.keyboardType=UIKeyboardTypeNumberPad;
    
    
    UIImageView *userImageView=[self createImageViewFrame:CGRectMake(20, 10, 25, 25) imageName:@"ic_landing_nickname" color:nil];
    UIImageView *pwdImageView=[self createImageViewFrame:CGRectMake(20, 60, 25, 25) imageName:@"mm_normal" color:nil];
    UIImageView *line1=[self createImageViewFrame:CGRectMake(20, 50, bgView.frame.size.width-40, 1) imageName:nil color:[UIColor colorWithRed:180/255.0f green:180/255.0f blue:180/255.0f alpha:.3]];
    
    [bgView addSubview:accontuser];
    [bgView addSubview:pwd];
    
    [bgView addSubview:userImageView];
    [bgView addSubview:pwdImageView];
    [bgView addSubview:line1];
}


-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    [accontuser resignFirstResponder];
    [pwd resignFirstResponder];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [accontuser resignFirstResponder];
    [pwd resignFirstResponder];
}

-(void)createImageViews
{
    //    UIImageView *userImageView=[self createImageViewFrame:CGRectMake(25, 10, 25, 25) imageName:@"ic_landing_nickname" color:nil];
    //    UIImageView *pwdImageView=[self createImageViewFrame:CGRectMake(25, 60, 25, 25) imageName:@"ic_landing_password" color:nil];
    //    UIImageView *line1=[self createImageViewFrame:CGRectMake(25, 50, 260, 1.5) imageName:nil color:[UIColor lightGrayColor]];
    //
    //    //UIImageView *line2=[self createImageViewFrame:CGRectMake(88, 210, 280, 1) imageName:nil color:[UIColor grayColor]];
    
    UIImageView *line3=[self createImageViewFrame:CGRectMake(2, 400, 100, 1) imageName:nil color:[UIColor lightGrayColor]];
    UIImageView *line4=[self createImageViewFrame:CGRectMake(self.view.frame.size.width-100-4, 400, 100, 1) imageName:nil color:[UIColor lightGrayColor]];
    
    //    [bgView addSubview:userImageView];
    //    [bgView addSubview:pwdImageView];
    //    [bgView addSubview:line1];
    //[self.view addSubview:line2];
    [self.view addSubview:line3];
    [self.view addSubview:line4];
    
}


-(void)createButtons
{
    UIButton *landBtn=[self createButtonFrame:CGRectMake(20, 290, self.view.frame.size.width-40, 47) backImageName:nil title:@"登录/注册" titleColor:[UIColor whiteColor]  font:[UIFont systemFontOfSize:19] target:self action:@selector(judgeLogin)];
    landBtn.backgroundColor=[UIColor colorWithRed:248/255.0f green:209/255.0f blue:78/255.0f alpha:1];
   // landBtn.layer.cornerRadius=20.0f;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:landBtn.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(18,18)];
    //创建 layer
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = landBtn.bounds;
    //赋值
    maskLayer.path = maskPath.CGPath;
    landBtn.layer.mask = maskLayer;
    
    
    UIButton *newUserBtn=[self createButtonFrame:CGRectMake(5, 235, 70, 30) backImageName:nil title:@"快速注册" titleColor:[UIColor grayColor] font:[UIFont systemFontOfSize:13] target:self action:@selector(registration:)];
    //newUserBtn.backgroundColor=[UIColor lightGrayColor];
    
    UIButton *forgotPwdBtn=[self createButtonFrame:CGRectMake(self.view.frame.size.width-75, 235, 60, 30) backImageName:nil title:@"找回密码" titleColor:[UIColor grayColor] font:[UIFont systemFontOfSize:13] target:self action:@selector(fogetPwd:)];
    //fogotPwdBtn.backgroundColor=[UIColor lightGrayColor];
    
    
#define Start_X 60.0f           // 第一个按钮的X坐标
#define Start_Y 440.0f           // 第一个按钮的Y坐标
#define Width_Space 50.0f        // 2个按钮之间的横间距
#define Height_Space 20.0f      // 竖间距
#define Button_Height 50.0f    // 高
#define Button_Width 50.0f      // 宽
    
    
    
    //微信
    weixinBtn=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-50)/2, 440, 50, 50)];
    //weixinBtn.tag = UMSocialSnsTypeWechatSession;
    weixinBtn.layer.cornerRadius=25;
    weixinBtn=[self createButtonFrame:weixinBtn.frame backImageName:@"ic_landing_wechat" title:nil titleColor:nil font:nil target:self action:@selector(onClickWX:)];
    //qq
    QQBtn=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-50)/2-100, 440, 50, 50)];
    //QQBtn.tag = UMSocialSnsTypeMobileQQ;
    QQBtn.layer.cornerRadius=25;
    QQBtn=[self createButtonFrame:QQBtn.frame backImageName:@"ic_landing_qq" title:nil titleColor:nil font:nil target:self action:@selector(onClickQQ:)];
    
    //新浪微博
    xinlangBtn=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-50)/2+100, 440, 50, 50)];
    //xinlangBtn.tag = UMSocialSnsTypeSina;
    xinlangBtn.layer.cornerRadius=25;
    xinlangBtn=[self createButtonFrame:xinlangBtn.frame backImageName:@"ic_landing_microblog" title:nil titleColor:nil font:nil target:self action:@selector(onClickSina:)];
    
    [self.view addSubview:weixinBtn];
    [self.view addSubview:QQBtn];
    [self.view addSubview:xinlangBtn];
    [self.view addSubview:landBtn];
    [self.view addSubview:newUserBtn];
    [self.view addSubview:forgotPwdBtn];
}


- (void)onClickQQ:(UIButton *)button
{
}

- (void)onClickWX:(UIButton *)button
{
}


- (void)onClickSina:(UIButton *)button
{
    
}
-(UITextField *)createTextFielfFrame:(CGRect)frame font:(UIFont *)font placeholder:(NSString *)placeholder
{
    UITextField *textField=[[UITextField alloc]initWithFrame:frame];
    
    textField.font=font;
    
    textField.textColor=[UIColor grayColor];
    
    textField.borderStyle=UITextBorderStyleNone;
    
    textField.placeholder=placeholder;
    
    return textField;
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

-(UIButton *)createButtonFrame:(CGRect)frame backImageName:(NSString *)imageName title:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font target:(id)target action:(SEL)action
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=frame;
    if (imageName)
    {
        [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    
    if (font)
    {
        btn.titleLabel.font=font;
    }
    
    if (title)
    {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    if (color)
    {
        [btn setTitleColor:color forState:UIControlStateNormal];
    }
    if (target&&action)
    {
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}




-(void)judgeLogin{
    //用户名和密码
    _account = accontuser.text;
    _password = pwd.text;
    
    NSLog(@"------------------------------");
    NSLog(@"account is %@, pwd is %@ ",_account,_password);
    NSLog(@"------------------------------");
    
    //去掉手机号textfields中的空格，否则存不到数据库中
    _account = [_account stringByReplacingOccurrencesOfString:@" " withString:@""];
    _password = [_password stringByReplacingOccurrencesOfString:@" " withString:@""];
  
    if (_loginStatus == NULL)
    {
          [self login];
    }else
    {
        //int logstus;
        //= [[self login]intValue];
        
        NSLog(@"_loginStatus是%@",_loginStatus);
        
        if ([_loginStatus isEqualToString:@"0"]){
            NSLog(@"用户名或者密码为空");
            [DLAlertView showAlter:@"用户名或密码为空"];
            _loginStatus = NULL;
        
            
        }else if([_loginStatus isEqualToString:@"1"])
        {
            NSLog(@"登录成功");
            [self loginSucess];
            [DLAlertView showAlter:@"登陆成功"];
            
        }else if([_loginStatus isEqualToString:@"2"])
        {
            NSLog(@"密码错误");
            [DLAlertView showAlter:@"密码错误"];
//            [self login];
//            [self judgeLogin];
            
            
              _loginStatus = NULL; //这行代码很重要*************
            
        }
        else if([_loginStatus isEqualToString:@"3"])
        {
            NSLog(@"账户不存在");
          //  [DLAlertView showAlter:@"账号不存在"];
             _loginStatus = NULL;
            //跳转到注册界面
            [self rigsterOrNot];
            
            
            
            
        }
        else if([_loginStatus isEqualToString:@"4"])
        {
            NSLog(@"logonstatus这个返回值没起作用呀！");
        }
        else
        {
            NSLog(@"emmmmmmmmmm");
        }
   
    }
}

//提示框






//登录
-(void)loginSucess
{
    //登录后切换根视图控制器为tabarcontroller控制器
     //切换根视图控制器的动画：
    CATransition *transtion =[CATransition animation];
    transtion.duration = 0.2;
    transtion.startProgress = 0;
    transtion.endProgress = 1;
    transtion.type = @"rippleEffect";
    transtion.type = kCATransitionPush;
    transtion.subtype = kCATransitionFromRight;
    [self.navigationController popToRootViewControllerAnimated:YES];
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:transtion forKey:@"anmotion"];
    
    DLTabbarController *tabbarController = [[DLTabbarController alloc]init];
    [self.view.window setRootViewController:tabbarController];
}


//限制最大输入字数限制
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if (textField == accontuser) {
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if ([toBeString length] > 13) {
            
            return NO;
        }
    }
    if([string hasSuffix:@" "])     // 忽视空格
        return NO;
    else
        return YES;
    return YES;
}


//post请求登录:   login  login   login
-(void)login{
    
    NSString *strUrl = @"http://39.96.8.115/index.php";
    
    NSURL *url = [NSURL URLWithString:strUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //发送post请求
    request.HTTPMethod = @"post";
    //设置请求体
    NSString *body = [NSString stringWithFormat: @"username=%@&pwd=%@",_account,_password];
   
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
            
            NSLog(@"服务器返回的登录状态是%@",dic[@"logstus"]);
            //调用了重写了的setLoginStatus方法
//            -(void)setLoginStatus:(NSString *)loginStatus{
//                _loginStatus = loginStatus;
//                //等着加载完数据，重新landclick
//                [self loginSucess];
//            }
            
            self.loginStatus = (NSString *)dic[@"logstus"];
            
            NSLog(@"block内部的loginstatus:%@",(NSString *)dic[@"logstus"]);
            NSLog(@"网络状态码：%ld",(long)httpResponse.statusCode);
        }
            else
            {
                NSLog(@"服务器内部错误");
            }
   }];
    
    NSLog(@"本地的%@",_loginStatus);
    
    }


//账号不存在是否要注册
-(void)rigsterOrNot
{
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"账号不存在，是否立即注册？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"立即注册" otherButtonTitles: nil];
    [sheet showInView:self.view];
}



- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0) {
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"register" bundle:nil];
//        DLRegisterViewController  * controller  = [storyboard instantiateViewControllerWithIdentifier:@"registerViewControllerID"];
        
        
        DLRegisterViewController  * controller  =[[DLRegisterViewController alloc]init];
        
      
        self.delegate = controller;
        
        
        if ([self.delegate respondsToSelector:@selector(sendValue: pwd:)]) {
            //传值
      
            [self.delegate sendValue:_account pwd:_password];
            
        }else{
            NSLog(@"拉闸");
        }

        [self presentViewController:controller animated:YES completion:nil];
       
       
    }
}




//注册
-(void)zhuce
{
 
}

-(void)registration:(UIButton *)button
{
    
}

-(void)fogetPwd:(UIButton *)button
{
    
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
