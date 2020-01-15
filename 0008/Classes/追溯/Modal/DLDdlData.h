//
//  DLDdlData.h
//  0008
//
//  Created by 董亮 on 2019/3/28.
//  Copyright © 2019 董亮. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface DLDdlData : NSObject
@property(nonatomic,copy) NSString *Date;
@property(nonatomic,copy) NSString *ddl;

//- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)DdlWithDict:(NSDictionary *)dict;


@end
NS_ASSUME_NONNULL_END
