//
//  DLData.h
//  testchart
//
//  Created by 董亮 on 2019/3/6.
//  Copyright © 2019 董亮. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLData : NSObject
@property(nonatomic,copy) NSString *Date;
@property(nonatomic,copy) NSString *wendu;
@property(nonatomic,copy) NSString *shidu;


//- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)DataWithDict:(NSDictionary *)dict;


@end

NS_ASSUME_NONNULL_END
