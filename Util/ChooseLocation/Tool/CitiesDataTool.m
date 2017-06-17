//
//  CitiesDataTool.m
//  ChooseLocation
//
//  Created by Sekorm on 16/10/25.
//  Copyright © 2016年 HY. All rights reserved.
//

#import "CitiesDataTool.h"
#import "FMDB.h"
#import "AddressItem.h"

static NSString * const dbName = @"location.db";
static NSString * const locationTabbleName = @"tp_region";

@interface CitiesDataTool ()
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic, strong) FMDatabase *fmdb;
@end

@implementation CitiesDataTool

static CitiesDataTool *shareInstance = nil;

#pragma mark - Singleton
+ (CitiesDataTool *)sharedManager
{
    @synchronized (self) {
        if (shareInstance == nil) {
            shareInstance = [[self alloc] init];
        }
    }
    return shareInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    @synchronized (self) {
        if (shareInstance == nil) {
            shareInstance = [super allocWithZone:zone];
        }
    }
    return shareInstance;
}

- (id)copy
{
    return shareInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self creatDB];
    }
    return self;
}

- (void)creatDB
{
    
    NSString *dbPath = [self pathForName:dbName];
    self.fmdb = [FMDatabase databaseWithPath:dbPath];
}
- (void)deleteDB
{
    NSString *dbPath = [self pathForName:dbName];
    [[NSFileManager defaultManager] removeItemAtPath:dbPath error:nil];
}

//获得指定名字的文件的全路径
- (NSString *)pathForName:(NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths lastObject];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:name];
    NSLog(@"%@",dbPath);
    return dbPath;
}

// 判断是否存在表
- (BOOL) isTableOK
{
    BOOL openSuccess = [self.fmdb open];
    if (!openSuccess) {
        NSLog(@"地址数据库打开失败");
    } else {
        NSLog(@"地址数据库打开成功");
        FMResultSet *rs = [self.fmdb executeQuery:@"SELECT count(*) as 'count' FROM sqlite_master WHERE type ='table' and name = ?", locationTabbleName];
        while ([rs next])
        {
            // just print out what we've got in a number of formats.
            NSInteger count = [rs intForColumn:@"count"];
            if (0 == count)
            {
                [self.fmdb close];
                return NO;
            }
            else
            {
                [self.fmdb close];
                return YES;
            }
        }
    }
    [self.fmdb close];
    return NO;
}


//发送网络请求，获取省市区数据，这里用的是本地json数据
- (void)requestGetData{
    
    if ([self isTableOK]) {
        return;
    }
    if ([self createTable]) {
        [self insertRecords];
    }
}

//往表插入数据
- (void)insertRecords{
    
    NSDate *startTime = [NSDate date];
    // 开启事务
    if ([self.fmdb open] && [self.fmdb beginTransaction]) {
        
        BOOL isRollBack = NO;
        @try
        {
            NSString *filePath = [[NSBundle mainBundle] pathForResource:@"tp_region" ofType:@"sql"];
            NSError *error;
            NSString *sql = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
            
            BOOL isSuccess = [self.fmdb executeUpdate:sql];
            if (!isSuccess)
            {
                NSLog(@"插入地址信息数据失败");
            }
            else
            {
                NSLog(@"批量插入地址信息数据成功！");
                
            }
            NSDate *endTime = [NSDate date];
            NSTimeInterval a = [endTime timeIntervalSince1970] - [startTime timeIntervalSince1970];
            NSLog(@"使用事务地址信息用时%.3f秒",a);
            
        }
        @catch (NSException *exception)
        {
            isRollBack = YES;
            [self.fmdb rollback];
        }
        @finally
        {
            if (!isRollBack)
            {
                [self.fmdb commit];
            }
        }
        [self.fmdb close];
        
    } else {
        [self insertRecords];
    }
}


// 删除表
- (BOOL)deleteTable

{
//    if (![self isTableOK]) {
//        return YES;
//    }
    
    BOOL openSuccess = [self.fmdb open];
    if (!openSuccess) {
        NSLog(@"地址数据库打开失败");
    } else {
        NSLog(@"地址数据库打开成功");
        NSString *sqlstr = [NSString stringWithFormat:@"DROP TABLE %@", locationTabbleName];
        
        if (![self.fmdb executeUpdate:sqlstr])
        {
            [self.fmdb close];
            return NO;
        }
    }
    [self.fmdb close];
    return YES;
}

//创建表
- (BOOL)createTable{
    
    BOOL result = NO;
    BOOL openSuccess = [self.fmdb open];
    if (!openSuccess) {
        NSLog(@"地址数据库打开失败");
    } else {
        NSLog(@"地址数据库打开成功");
        //'code','sheng','di','xian','name', 'level'
        NSString *sql = [NSString stringWithFormat:@"create table if not exists %@ (id int primary key,name text,level int,parent_id int);",locationTabbleName];
//        NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (`id` int(11) unsigned NOT NULL AUTO_INCREMENT,`name` longtext,`level` tinyint(4) DEFAULT '0',`parent_id` int(10) DEFAULT NULL,PRIMARY KEY (`id`));",locationTabbleName];
        result = [self.fmdb executeUpdate:sql];
        if (!result) {
            NSLog(@"创建地址表失败");
            
        } else {
            NSLog(@"创建地址表成功");
        }
    }
    [self.fmdb close];
    return result;
}

//根据areaLevel 查询
- (NSMutableArray *)queryAllProvince
{
    if ([self.fmdb  open]) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE `level` = 1", locationTabbleName];
        FMResultSet *result = [self.fmdb  executeQuery:sql];
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
        while ([result next]) {
            AddressItem *model = [[AddressItem alloc] init];
            model.id = [NSString stringWithFormat:@"%d",[result intForColumn:@"id"]];
            model.parent_id = [NSString stringWithFormat:@"%d",[result intForColumn:@"parent_id"]];
            model.name = [result stringForColumn:@"name"];
            model.level = [NSString stringWithFormat:@"%d",[result intForColumn:@"level"]];
            [array addObject:model];
        }
        [self.fmdb close];
        return array;
    }
    return nil;
}
//查询下一级数据
- (NSMutableArray *)queryDataWith:(NSString *)level parent_id:(NSString *)parent_id
{
    if ([self.fmdb  open]) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE `level` = %@ and `parent_id` =  %@", locationTabbleName,level,parent_id];
        FMResultSet *result = [self.fmdb  executeQuery:sql];
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
        //'code','sheng','di','xian','name', 'level'
        while ([result next]) {
            AddressItem *model = [[AddressItem alloc] init];
            model.id = [NSString stringWithFormat:@"%d",[result intForColumn:@"id"]];
            model.parent_id = [NSString stringWithFormat:@"%d",[result intForColumn:@"parent_id"]];
            model.name = [result stringForColumn:@"name"];
            model.level = [NSString stringWithFormat:@"%d",[result intForColumn:@"level"]];
            [array addObject:model];
        }
        [self.fmdb close];
        return array;
    }
    return nil;
}
- (NSMutableArray *)queryDataWith:(NSInteger)id
{
    if ([self.fmdb  open]) {
        NSString *sql = [NSString stringWithFormat:@"SELECT name FROM %@ WHERE `id` = %ld ", locationTabbleName,(long)id];
        FMResultSet *result = [self.fmdb  executeQuery:sql];
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
        //'code','sheng','di','xian','name', 'level'
        while ([result next]) {
            NSString *name = [result stringForColumn:@"name"];
            [array addObject:name];
        }
        [self.fmdb close];
        return array;
    }
    return nil;
}
- (NSMutableArray *)dataArray{
    
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

@end
