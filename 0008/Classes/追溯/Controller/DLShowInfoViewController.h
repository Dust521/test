//
//  DLShowInfoViewController.h
//  0008
//
//  Created by 董亮 on 2019/1/14.
//  Copyright © 2019 董亮. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLShowInfoViewController : UIViewController

//利用属性正向传值
@property (nonatomic,copy) NSString *qrCodeString;
@property (nonatomic,copy) NSArray *baseArray;

@end

NS_ASSUME_NONNULL_END
