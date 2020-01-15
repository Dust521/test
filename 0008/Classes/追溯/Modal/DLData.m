//
//  DLData.m
//  testchart
//
//  Created by 董亮 on 2019/3/6.
//  Copyright © 2019 董亮. All rights reserved.
//

#import "DLData.h"

@implementation DLData
+ (instancetype)DataWithDict:(NSDictionary *)dict
{
    //return [[self alloc] initWithDict:dict];
    DLData *data = [self new];
    
    [data setValuesForKeysWithDictionary:dict];
    return data;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

//用来能够输出对象里面的信息
-(NSString *)description{
    return [NSString stringWithFormat:@"{Date:%@,wendu:%@,shidu:%@}",self.Date,self.wendu,self.shidu];
}
@end
