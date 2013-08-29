//
//  Moment.h
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LKDaoBase.h"

@interface MomentModelBase:LKDAOBase

@end

@interface Moment : LKModelBase

@property(nonatomic,strong)NSString *mid;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *date;
@property(nonatomic,strong)NSString *showDate;
@property(nonatomic,strong)NSString *imagePath;
@property(nonatomic,strong)NSString *weather;
@property(nonatomic,strong)NSString *isPrivate;
@property(nonatomic,strong)NSString *type;//type=0:纯文字  type=1:纯图片  type=2:图片+文字
@property(nonatomic,strong)NSString *tag;

// new added
@property(nonatomic,strong)NSString *dateForCalendar;
@property(nonatomic,strong)NSString *hasTag; //1 = has tag
@property(nonatomic,strong)NSString *emoticon;
@property(nonatomic,strong)NSString *location;
@property(nonatomic,strong)NSString *starred; // =1 starred


- (id)initWithJsonDictionary:(NSDictionary*)dic;
@end

@interface NSDictionary (ForJsonNull)

- (id)objectOrNilForKey:(id)key;

@end
