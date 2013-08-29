//
//  Moment.m
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

#import "Moment.h"
@implementation MomentModelBase
+(Class)getBindingModelClass
{
    return [Moment class];//返回实体
}
const static NSString* tablename = @"Moment";//表名

+(const NSString *)getTableName
{
    return tablename;
}
@end

@implementation Moment

-(id)init
{
    self = [super init];
    if (self)
    {
        self.primaryKey = @"mid";//主健
    }
    return self;
}

- (id)initWithJsonDictionary:(NSDictionary*)dic
{
    NSLog(@"dic is : %@",dic);
    self = [self init];
    if (self)
    {
        self.mid = [dic objectOrNilForKey:@"mid"];
        self.content = [dic objectOrNilForKey:@"content"];
        self.title = [dic objectOrNilForKey:@"title"];
        self.date = [dic objectOrNilForKey:@"date"];
        self.showDate = [dic objectOrNilForKey:@"showDate"];
        self.imagePath = [dic objectOrNilForKey:@"imagePath"];
        self.weather = [dic objectOrNilForKey:@"weather"];
        self.isPrivate = [dic objectOrNilForKey:@"isPrivate"];
        self.type = [dic objectOrNilForKey:@"type"];
        self.tag = [dic objectOrNilForKey:@"tag"];
        
        // new added
        self.dateForCalendar = [dic objectOrNilForKey:@"dateForCalendar"];
        self.hasTag = [dic objectOrNilForKey:@"hasTag"];
        self.tag = [dic objectOrNilForKey:@"emoticon"];
        self.tag = [dic objectOrNilForKey:@"location"];
        self.starred = [dic objectOrNilForKey:@"starred"];
        
    }
    return self;
}
@end

@implementation NSDictionary (ForJsonNull)

- (id)objectOrNilForKey:(id)key {
    id object = [self objectForKey:key];
    if(object == [NSNull null]) {
        return nil;
    }
    return object;
}

@end

