//
//  RealmHelper.m
//  RealmDemo
//
//  Created by bufb on 2017/9/12.
//  Copyright © 2017年 kris. All rights reserved.
//

#import "RealmHelper.h"

#import "PersonModel.h"

@interface RealmHelper ()

@property (nonatomic ,strong)RLMRealmConfiguration *configDefault;

@end

@implementation RealmHelper

+ (RealmHelper *)shareInstance
{
    static RealmHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[RealmHelper alloc]init];
    });
    return helper;
}

// MARK: - 默认数据库-RealmDB
- (RLMRealm *)realmDefault
{
    return [RLMRealm realmWithConfiguration:self.configDefault error:nil];
}

- (RLMRealmConfiguration *)configDefault
{
    if (!_configDefault) {
        _configDefault = [self configForName:RealmDB];
    }
    return _configDefault;
}

// MARK: - 创建的其他数据库
- (RLMRealm *)realmWithName:(NSString *)name
{
    RLMRealmConfiguration *config = [self configForName:name];
    return [RLMRealm realmWithConfiguration:config error:nil];
}

// MARK: - 数据库版本迁移
- (void)migration
{
    self.configDefault.migrationBlock = ^(RLMMigration * _Nonnull migration, uint64_t oldSchemaVersion) {
        //如果历史版本小于当前版本
        if (oldSchemaVersion < RealmCurVersion) {
            [migration enumerateObjects:PersonModel.className block:^(RLMObject *oldObject, RLMObject *newObject) {
                newObject[@"fullName"] = [NSString stringWithFormat:@"%@ %@", oldObject[@"firstName"], oldObject[@"secondName"]];
            }];
        }
        NSLog(@"Migration complete.");
    };
    [RLMRealm performMigrationForConfiguration:self.configDefault error:nil];
}

// MARK: - 类内公共方法
/**
 按照名称生成数据库配置

 @param name 数据库名称
 @return 数据库配置
 */
- (RLMRealmConfiguration *)configForName:(NSString *)name
{
    //数据库路径
    NSString *strDBPath = [self realmDBPathForName:name];
    //数据库设置
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    //数据库路径
    config.fileURL = [NSURL URLWithString:strDBPath];
    //当前版本号
    config.schemaVersion = RealmCurVersion;
    //指定数据库可存储的类,项目协同做约束用
    //config.objectClasses = @[Model.class,OtherModel.class];
    //内存数据库标识
    //config.inMemoryIdentifier = @"RealmDBMemoryID";
    //加密秘钥
    //config.encryptionKey = NSData;
    //是否只读
    //config.readOnly = YES;
    [RLMRealmConfiguration setDefaultConfiguration:config];
    return config;
}

/**
 按照名称生成数据库路径

 @param name 数据库名称
 @return 数据库完整路径
 */
- (NSString *)realmDBPathForName:(NSString *)name
{
    NSString *docDir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSFileManager *fileManage = [NSFileManager defaultManager];
    NSString *realmDir = [docDir stringByAppendingPathComponent:RealmDB];
    BOOL isDir;
    BOOL exit = [fileManage fileExistsAtPath:realmDir isDirectory:&isDir];
    if (!exit || !isDir) {
        [fileManage createDirectoryAtPath:realmDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if (name.length == 0 || name == nil) {
        name = RealmDB;
    }
    NSString *dbName = [NSString stringWithFormat:@"%@.realm",name];
    NSString *dbPath = [realmDir stringByAppendingPathComponent:dbName];
    return dbPath;
}

@end
