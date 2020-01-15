//
//  DLVegetable.h
//  0008
//
//  Created by 董亮 on 2018/12/17.
//  Copyright © 2018 董亮. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLVegetable : NSObject

@property(nonatomic,copy) NSString *num;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *intro;
@property(nonatomic,copy) NSString *imageUrl;

//- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)vegetablesWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
