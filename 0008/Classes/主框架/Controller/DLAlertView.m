//
//  DLAlertView.m
//  0008
//
//  Created by 董亮 on 2018/12/29.
//  Copyright © 2018 董亮. All rights reserved.
//

#import "DLAlertView.h"

@implementation DLAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(void)showAlter:(NSString *)message;
{
    UIAlertView *alter=[[UIAlertView alloc]initWithTitle:nil message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [NSTimer scheduledTimerWithTimeInterval:ALTERTIME target:self selector:@selector(timerAction:) userInfo:alter repeats:NO];
    [alter show];
}
+(void)timerAction:(NSTimer *)timer
{
    UIAlertView *alter=(UIAlertView *)[timer userInfo];
    [alter dismissWithClickedButtonIndex:0 animated:YES];
}

@end
