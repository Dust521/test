//
//  DLTextField.h
//  0008
//
//  Created by 董亮 on 2018/12/24.
//  Copyright © 2018 董亮. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLTextField : UITextField<UITextFieldDelegate>
{
    NSString    *_previousTextFieldContent;
    UITextRange *_previousSelection;
}
@end

NS_ASSUME_NONNULL_END
