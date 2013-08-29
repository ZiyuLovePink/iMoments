//
//  STPhotoViewCellCell.h
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

@protocol STPhotoViewCellDelegate <NSObject>

@optional
-(void)showDiary:(Moment *)moment;
@end

#import <UIKit/UIKit.h>

@interface STPhotoViewCellCell : UITableViewCell

@property(nonatomic,unsafe_unretained)id<STPhotoViewCellDelegate>delegate;

@property(nonatomic,copy)NSMutableArray *dataSource;
+(CGFloat)cellHeightForObject:(id)object;
-(void)showObject:(id)object index:(int)index;

@end
