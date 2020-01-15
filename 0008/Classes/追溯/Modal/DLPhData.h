//
//  DLPhData.h
//  0008
//
//  Created by 董亮 on 2019/3/28.
//  Copyright © 2019 董亮. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLPhData : NSObject
@property(nonatomic,copy) NSString *Date;
@property(nonatomic,copy) NSString *ph;

//- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)PhWithDict:(NSDictionary *)dict;


@end


NS_ASSUME_NONNULL_END
