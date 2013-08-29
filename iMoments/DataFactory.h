//
//  DataFactory.h
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SandboxFile.h"
#import "FMDatabaseQueue.h"
#import "Moment.h"

#define GetDataBasePath [SandboxFile GetPathForDocuments:@"iMoments.db" inDir:@"DataBase"]

@interface DataFactory : NSObject
@property(retain,nonatomic)id classValues;
typedef enum
{
    momentClass,
}
FSO;//这个是枚举是区别不同的实体,我这边就写一个test;
+(DataFactory *)shardDataFactory;
//是否存在数据库
-(BOOL)IsDataBase;
//创建数据库
-(void)CreateDataBase;
//创建表
-(void)CreateTable;
//添加数据
-(void)insertToDB:(id)Model Classtype:(FSO)type;
//修改数据
-(void)updateToDB:(id)Model Classtype:(FSO)type;
//删除单条数据
-(void)deleteToDB:(id)Model Classtype:(FSO)type;
//删除表的数据
-(void)clearTableData:(FSO)type callback:(void(^)(BOOL))result;
//根据条件删除数据
-(void)deleteWhereData:(NSDictionary *)Model Classtype:(FSO)type;
//查找数据
-(void)searchWhere:(NSDictionary *)where orderBy:(NSString *)columeName offset:(int)offset count:(int)count Classtype:(FSO)type callback:(void(^)(NSArray *))result;

-(void)searchCount:(NSString *)where Classtype:(FSO)type callback:(void(^)(int))result;
@end

