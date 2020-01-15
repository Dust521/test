//
//  DLShapeView.m
//  0008
//
//  Created by 董亮 on 2019/3/10.
//  Copyright © 2019 董亮. All rights reserved.
//

#import "DLShapeView.h"

@implementation DLShapeView
+ (Class)layerClass {
    return [CAShapeLayer class];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        ((CAShapeLayer *)self.layer).fillColor = [UIColor colorWithRed:0 green:1 blue:1 alpha:1.0].CGColor;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(20,20)];
    ((CAShapeLayer *)self.layer).path = maskPath.CGPath;
    
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    ((CAShapeLayer *)self.layer).fillColor = backgroundColor.CGColor;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
