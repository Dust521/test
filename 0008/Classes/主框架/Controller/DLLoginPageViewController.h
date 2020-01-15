//
//  DLLoginPageViewController.h
//  0008
//
//  Created by 董亮 on 2018/12/24.
//  Copyright © 2018 董亮. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//传值的协议
@protocol DLLoginPageViewControllerDelegate <NSObject>
- (void)sendValue:(NSString *)account pwd:(NSString *)pwd;
@end

@interface DLLoginPageViewController : UIViewController
@property (nonatomic, weak)id<DLLoginPageViewControllerDelegate> delegate; //声明协议变量
@end

NS_ASSUME_NONNULL_END
