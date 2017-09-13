//
//  RealmHelper.h
//  RealmDemo
//
//  Created by bufb on 2017/9/12.
//  Copyright © 2017年 kris. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

//当前数据库版本号
#define RealmCurVersion  1.0
//默认数据库
#define RealmDB          @"RealmDB"
//根据业务定义不同的数据库
#define RealmOtherDB     @"RealmOtherDB"

@interface RealmHelper : NSObject

+ (RealmHelper *)shareInstance;

/**
 默认数据库管理对象
 注意：
 1.可以初始化多个管理对象指向同一个数据库
 2.跨线程不能使用相同的管理对象，必须通过此方法获取一个新的
 */
@property (nonatomic ,strong ,readonly)RLMRealm *realmDefault;

/**
 根据数据库名称获取数据库管理对象
 */
- (RLMRealm *)realmWithName:(NSString *)name;

/**
 数据库版本兼容操作

 注意：
 数据库model结构有更新一定要更新数据库版本号，以便区分操作；model更新最好保留修改记录
 1.model新增字段-老数据保持原有数据不变，新增字段为nil；新数据正确；
 2.model删除字段-老数据会删除原有字段；新数据直接按照新的model，即新老数据都会保持最新的
 3.model改变字段-老数据原字段不变，新字段为nil；新数据老字段为nil,新字段为新值
 */
- (void)migration;

@end
