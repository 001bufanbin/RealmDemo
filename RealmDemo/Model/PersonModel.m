//
//  PersonModel.m
//  RealmDemo
//
//  Created by bufb on 2017/9/12.
//  Copyright © 2017年 kris. All rights reserved.
//

#import "PersonModel.h"

@implementation Language

@end

@implementation Dog

@end

@implementation PersonModel
// MARK: - 忽略属性
+ (NSArray *)ignoredProperties
{
    return @[@"languages"];
}

// MARK: - 重写languages的set&get方法
- (void)setLanguages:(NSArray *)languages
{
    [self.storedLanguages removeAllObjects];
    for (NSString *value in languages) {
        Language *model = [[Language alloc]initWithValue:@[value]];
        [self.storedLanguages addObject:model];
    }
}

- (NSArray *)languages
{
    return [self.storedLanguages valueForKey:@"value"];
}

@end
