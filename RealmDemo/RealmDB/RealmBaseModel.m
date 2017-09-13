//
//  RealmBaseModel.m
//  RealmDemo
//
//  Created by bufb on 2017/9/12.
//  Copyright © 2017年 kris. All rights reserved.
//

#import "RealmBaseModel.h"
#import "RealmHelper.h"

/**
 1.对象可以使用数组创建，需要注意的是在数组中值的顺序必须跟Model中相应属性顺序保持一致。
 2.RLMArray仅仅只能包含RLMObject对象，而不包括基本数据类型例如NSString。
 3.对于2这种情况需要将string包装成RLMObject对象。
 */
@implementation RealmBaseModel

/*********************属性设置*********************/
/**
 主键
 以某个属性作为主键
 @return 属性字符串
 */
+ (NSString *)primaryKey {
    return nil;
}

/**
 索引属性
 支持字符串、整数、布尔值以及 NSDate 属性作为索引
 @return 添加索引的属性数组
 */
+ (NSArray *)indexedProperties {
    return @[];
}

/**
 忽略属性
 @return 存储要忽略的属性数组
 */
+ (NSArray *)ignoredProperties {
    return nil;
}

/**
 必须属性
 被设置为必须的属性在被添加数据库之前一定要被设置值
 @return 必须有值的属性数组
 */
+ (NSArray *)requiredProperties {
    return @[];
}

/**
 属性默认值
 在对象创建之后为其提供默认值
 @return 对象-属性：默认值的字典
 */
+ (NSDictionary *)defaultPropertyValues {
    return nil;
}

/**
 反向关系
 链接是单向性的。如Person.dogs 链接了一个 Dog 实例，而这个实例的 Dog.owner 又链接到了对应的这个 Person 实例，那么实际上这些链接仍然是互相独立的。
 为 Person 实例的 dogs 属性添加一个新的 Dog 实例，并不会将这个 Dog 实例的 owner 属性自动设置为该 Person。
 由于手动同步双向关系会很容易出错，并且这个操作还非常得复杂、冗余，因此 Realm 提供了“链接对象 (linking objects)” 属性来表示这些反向关系。
 @return 关联属性字典
 */
+ (NSDictionary *)linkingObjectsProperties {
    return @{};
}


/*********************公共方法-增删改查(所有的增删改操作必须在事物中)*********************/

+ (BOOL)addObject:(RealmBaseModel *)object
{
    RLMRealm *realm = [RealmHelper shareInstance].realmDefault;
    NSError *error;
    [realm transactionWithBlock:^{
        [realm addObject:object];
    } error:&error];

    if (error) {
        NSLog(@"Realm addOject error == %@",error);
        return NO;
    }
    return YES;
}

+ (BOOL)addObjects:(id<NSFastEnumeration>)array
{
    RLMRealm *realm = [RealmHelper shareInstance].realmDefault;
    NSError *error;
    [realm transactionWithBlock:^{
        [realm addObjects:array];
    } error:&error];

    if (error) {
        NSLog(@"Realm addOjects error == %@",error);
        return NO;
    }
    return YES;
}

+ (BOOL)addOrUpdateObject:(RealmBaseModel *)object
{
    RLMRealm *realm = [RealmHelper shareInstance].realmDefault;
    NSError *error;
    [realm transactionWithBlock:^{
        [realm addOrUpdateObject:object];
    } error:&error];

    if (error) {
        NSLog(@"Realm addOrUpdateObject error == %@",error);
        return NO;
    }
    return YES;
}

+ (BOOL)addOrUpdateObjectsFromArray:(id)array
{
    RLMRealm *realm = [RealmHelper shareInstance].realmDefault;
    NSError *error;
    [realm transactionWithBlock:^{
        [realm addOrUpdateObjectsFromArray:array];
    } error:&error];

    if (error) {
        NSLog(@"Realm addOrUpdateObjectsFromArray error == %@",error);
        return NO;
    }
    return YES;
}

+ (BOOL)deleteObject:(RealmBaseModel *)object
{
    RLMRealm *realm = [RealmHelper shareInstance].realmDefault;
    NSError *error;
    [realm transactionWithBlock:^{
        [realm deleteObject:object];
    } error:&error];

    if (error) {
        NSLog(@"Realm deleteObject error == %@",error);
        return NO;
    }
    return YES;
}

+ (BOOL)deleteObjects:(id)array
{
    RLMRealm *realm = [RealmHelper shareInstance].realmDefault;
    NSError *error;
    [realm transactionWithBlock:^{
        [realm deleteObjects:array];
    } error:&error];

    if (error) {
        NSLog(@"Realm deleteObjects error == %@",error);
        return NO;
    }
    return YES;
}

+ (BOOL)deleteAllObjects
{
    RLMRealm *realm = [RealmHelper shareInstance].realmDefault;
    NSError *error;
    [realm transactionWithBlock:^{
        [realm deleteAllObjects];
    } error:&error];

    if (error) {
        NSLog(@"Realm deleteAllObjects error == %@",error);
        return NO;
    }
    return YES;
}

+ (BOOL)updateWithBlock:(void(^)(void))block
{
    RLMRealm *realm = [RealmHelper shareInstance].realmDefault;
    NSError *error;
    [realm transactionWithBlock:^{
        block();
    } error:&error];

    if (error) {
        NSLog(@"Realm updateWithBlock error == %@",error);
        return NO;
    }
    return YES;
}

+ (RLMResults *)allObjects
{
    RLMRealm *realm = [RealmHelper shareInstance].realmDefault;
    return [self allObjectsInRealm:realm];
}

+ (RLMResults *)objectsWhere:(NSString *)predicateFormat, ...
{
    RLMRealm *realm = [RealmHelper shareInstance].realmDefault;
    return [self objectsInRealm:realm where:predicateFormat];
}

+ (RLMResults *)objectsWithPredicate:(nullable NSPredicate *)predicate
{
    RLMRealm *realm = [RealmHelper shareInstance].realmDefault;
    return [self objectsInRealm:realm withPredicate:predicate];
}

+ (instancetype)objectForPrimaryKey:(id)primaryKey
{
    RLMRealm *realm = [RealmHelper shareInstance].realmDefault;
    return [self objectInRealm:realm forPrimaryKey:primaryKey];
}

@end
