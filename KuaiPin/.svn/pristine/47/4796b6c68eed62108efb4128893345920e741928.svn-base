//
//  KPDatabase.m
//  KuaiPin
//
//  Created by 21_xm on 16/6/21.
//  Copyright © 2016年 21_xm. All rights reserved.
//

#import "KPDatabase.h"
#import <FMDB.h>
#import "KPProduct.h"

static FMDatabase *_db;
@implementation KPDatabase

singleton_implementation(Database)

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 1.获得数据库文件的路径
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *filename = [doc stringByAppendingPathComponent:@"KPTable.sqlite"];
        WHYNSLog(@"%@", filename);
        
        // 2.得到数据库
        _db = [FMDatabase databaseWithPath:filename];
        
        // 3.打开数据库
        if ([_db open]) {
            // 4.创表
            BOOL result = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS KP_Table (id integer PRIMARY KEY AUTOINCREMENT, productId integer NOT NULL, product blob NOT NULL);"];
            if (result) {
                NSLog(@"成功创表");
            } else {
                NSLog(@"创表失败");
            }
        }
    }
    return self;
}


- (void)saveData:(NSDictionary *)dict
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
    NSArray *products = [self selectAllProduct];
    if (products.count == 0)
    {
        [_db executeUpdate:@"INSERT INTO KP_Table (productId, product) VALUES (?, ?);",
         dict[@"id"], data];
        return;
    }
    for (KPProduct *product in products) {
        
        if (product.productId.integerValue == [dict[@"id"] integerValue])   return;
    }
    
    [_db executeUpdate:@"INSERT INTO KP_Table (productId, product) VALUES (?, ?);",
     dict[@"id"], data];
    
}

- (NSArray *)selectAllProduct
{
    FMResultSet * result = [_db executeQuery:@"SELECT * FROM KP_Table;"];
    
    NSMutableArray * products = [[NSMutableArray alloc]init];
    while ([result next])
    {
        NSData *productData = [result dataForColumn:@"product"];
        NSDictionary *productDict = [NSKeyedUnarchiver unarchiveObjectWithData:productData];
        KPProduct * product = [KPProduct mj_objectWithKeyValues:productDict];
        [products addObject:product];
    }
    return products;
}

- (KPProduct *)selectProductWithProductId:(NSNumber *)productId
{
    FMResultSet * result = [_db executeQuery:@"SELECT * FROM KP_Table productId = ?;", productId];
    KPProduct * product;
    while ([result next])
    {
        NSData *productData = [result dataForColumn:@"productId"];
        NSDictionary *productDict = [NSKeyedUnarchiver unarchiveObjectWithData:productData];
        product = [KPProduct mj_objectWithKeyValues:productDict];
    }
    return product;
}

- (void)deleteAllProduct
{
    [_db executeUpdate:@"DELETE FROM KP_Table;"];
}

- (void)deleteWithProductId:(NSNumber *)productId
{
    [_db executeUpdate:@"DELETE FROM KP_Table WHERE productId = ?;", productId];
}
@end
