//
//  DLBaseInfo.m
//  0008
//
//  Created by 董亮 on 2019/3/7.
//  Copyright © 2019 董亮. All rights reserved.
//

#import "DLBaseInfo.h"

@implementation DLBaseInfo

+ (instancetype)baseInfoWithDict:(NSDictionary *)dict
{
    //return [[self alloc] initWithDict:dict];
    DLBaseInfo *baseInfo = [self new];
    
    [baseInfo setValuesForKeysWithDictionary:dict];
    return baseInfo;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

//用来能够输出对象里面的信息
-(NSString *)description{
    return [NSString stringWithFormat:@"{ID:%@,name:%@,farmName:%@,plantTime:%@,pickTime:%@}",self.ID,self.prodName,self.farmName,self.plantTime,self.pickTime];
}
@end
