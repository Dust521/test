//
//  DLBaseInfo.h
//  0008
//
//  Created by 董亮 on 2019/3/7.
//  Copyright © 2019 董亮. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLBaseInfo : NSObject

@property(nonatomic,copy) NSString *ID;
@property(nonatomic,copy) NSString *prodName;
@property(nonatomic,copy) NSString *farmName;
@property(nonatomic,copy) NSString *plantTime;
@property(nonatomic,copy) NSString *pickTime;

//- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)baseInfoWithDict:(NSDictionary *)dict;


@end

NS_ASSUME_NONNULL_END
