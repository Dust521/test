//
//  DLPhData.m
//  0008
//
//  Created by 董亮 on 2019/3/28.
//  Copyright © 2019 董亮. All rights reserved.
//

#import "DLPhData.h"

@implementation DLPhData
+ (instancetype)PhWithDict:(NSDictionary *)dict
{
    //return [[self alloc] initWithDict:dict];
    DLPhData *data = [self new];
    
    [data setValuesForKeysWithDictionary:dict];
    return data;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

//用来能够输出对象里面的信息
-(NSString *)description{
    return [NSString stringWithFormat:@"{Date:%@,ph:%@}",self.Date,self.ph];
}
@end
