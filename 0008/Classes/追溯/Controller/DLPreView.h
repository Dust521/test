//
//  DLPreView.h
//  0008
//
//  Created by 董亮 on 2019/1/14.
//  Copyright © 2019 董亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface DLPreView : UIView
@property (nonatomic,strong)AVCaptureSession *session;
@end

NS_ASSUME_NONNULL_END
