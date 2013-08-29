//
//  DataFactory.m
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

#import "DataFactory.h"

static FMDatabaseQueue* queue;
@implementation DataFactory
@synthesize classValues;
+(DataFactory *)shardDataFactory
{
    static id ShardInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ShardInstance=[[self alloc]init];
    });
    return ShardInstance;
}
-(BOOL)IsDataBase
{
    BOOL Value=NO;
    if (![SandboxFile IsFileExists:GetDataBasePath])
    {
        Value=YES;
    }
    return Value;
}
-(void)CreateDataBase
{
    queue=[[FMDatabaseQueue alloc]initWithPath:GetDataBasePath];
}
-(void)CreateTable
{
    [[MomentModelBase alloc]initWithDBQueue:queue];
}
-(id)Factory:(FSO)type
{
    id result;
    queue=[[FMDatabaseQueue alloc]initWithPath:GetDataBasePath];
    switch (type)
    {
        case momentClass:
            result=[[MomentModelBase alloc]initWithDBQueue:queue];
            break;
        default:
            break;
    }
    return result;
}
-(void)insertToDB:(id)Model Classtype:(FSO)type
{
    self.classValues=[self Factory:type];
    [classValues insertToDB:Model callback:^(BOOL Values)
     {
         NSLog(@"添加%d",Values);
     }];
}
-(void)updateToDB:(id)Model Classtype:(FSO)type
{
    self.classValues=[self Factory:type];
    [classValues updateToDB:Model callback:^(BOOL Values)
     {
         NSLog(@"修改%d",Values);
     }];
}
-(void)deleteToDB:(id)Model Classtype:(FSO)type
{
    self.classValues=[self Factory:type];
    [classValues deleteToDB:Model callback:^(BOOL Values)
     {
         NSLog(@"删除%d",Values);
     }];
}
-(void)clearTableData:(FSO)type callback:(void(^)(BOOL))result
{
    self.classValues=[self Factory:type];
    [classValues clearTableData:^(BOOL finished) {
        result(finished);
    }];
    NSLog(@"删除全部数据");
}
-(void)deleteWhereData:(NSDictionary *)Model Classtype:(FSO)type
{
    self.classValues=[self Factory:type];
    [classValues deleteToDBWithWhereDic:Model callback:^(BOOL finished)
     {
         NSLog(@"删除成功");
     }];
}
-(void)searchWhere:(NSDictionary *)where orderBy:(NSString *)columeName offset:(int)offset count:(int)count Classtype:(FSO)type callback:(void(^)(NSArray *))result
{
    self.classValues=[self Factory:type];
    [classValues searchWhereDic:where orderBy:columeName offset:offset count:count callback:^(NSArray *array)
     {
         result(array);
     }];
}

-(void)searchCount:(NSString *)where Classtype:(FSO)type callback:(void(^)(int))result
{
    self.classValues=[self Factory:type];
    [classValues searchCount:where callback:^(int number) {
        result(number);
    }];
}

-(void)dealloc
{
}
@end
