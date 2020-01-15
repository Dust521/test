//
//  DLVegetable.m
//  0008
//
//  Created by 董亮 on 2018/12/17.
//  Copyright © 2018 董亮. All rights reserved.
//

#import "DLVegetable.h"

@implementation DLVegetable

+ (instancetype)vegetablesWithDict:(NSDictionary *)dict
{
    //return [[self alloc] initWithDict:dict];
    DLVegetable *vegetables = [self new];
    
    [vegetables setValuesForKeysWithDictionary:dict];
    return vegetables;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

//用来能够输出对象里面的信息
-(NSString *)description{
    return [NSString stringWithFormat:@"{num:%@,name:%@,imageUrl:%@,intro:%@}",self.num,self.name,self.imageUrl,self.intro];
}
@end
