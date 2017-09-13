//
//  RealmBaseModel.h
//  RealmDemo
//
//  Created by bufb on 2017/9/12.
//  Copyright © 2017年 kris. All rights reserved.
//

#import <Realm/Realm.h>

/**
 Realm 数据库模型基类
 */
@interface RealmBaseModel : RLMObject

// MARK: - 增
/**
 添加单个实体对象
 @param object realmModel
 */
+ (BOOL)addObject:(RealmBaseModel *)object;

/**
 添加多个实体对象
 @param array realmModels
 */
+ (BOOL)addObjects:(id<NSFastEnumeration>)array;

/**
 添加单个实体对象-只可添加设置了主键的实体
 @param object realmModel
 */
+ (BOOL)addOrUpdateObject:(RealmBaseModel *)object;

/**
 添加多个实体对象-只可添加设置了主键的实体

 @param array realmModels
 */
+ (BOOL)addOrUpdateObjectsFromArray:(id)array;


// MARK: - 删
/**
 删除单个实体对象
 @param object realmModel
 */
+ (BOOL)deleteObject:(RealmBaseModel *)object;

/**
 删除多个实体对象
 @param array realmModels
 */
+ (BOOL)deleteObjects:(id)array;

/**
 删除整个数据库里面的所有内容(表结构保留)
 */
+ (BOOL)deleteAllObjects;


// MARK: - 改
/**
 修改实体
 block内直接修改实体的属性即可，无需其他操作
 @param block 更新的block
 */
+ (BOOL)updateWithBlock:(void(^)(void))block;


// MARK: - 查
/**
 查询当前表所有数据
 @return realmModels
 */
+ (RLMResults *)allObjects;

/**
 使用断言字符串查询
 @param predicateFormat 查询断言
 @return realmModels
 */
+ (RLMResults *)objectsWhere:(NSString *)predicateFormat, ...;

/**
 使用谓词对象查询
 @param predicate 谓词对象
 @return realmModels
 */
+ (RLMResults *)objectsWithPredicate:(nullable NSPredicate *)predicate;

/**
 使用主键查询
 @param primaryKey 主键
 @return realmModel
 */
+ (nullable instancetype)objectForPrimaryKey:(nullable id)primaryKey;

@end
