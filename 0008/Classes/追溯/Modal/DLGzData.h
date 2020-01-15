//
//  DLGzData.h
//  0008
//
//  Created by 董亮 on 2019/3/28.
//  Copyright © 2019 董亮. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLGzData : NSObject
@property(nonatomic,copy) NSString *Date;
@property(nonatomic,copy) NSString *gz;

//- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)GzWithDict:(NSDictionary *)dict;


@end

NS_ASSUME_NONNULL_END
