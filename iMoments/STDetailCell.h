//
//  STDetailCell.h
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

@protocol STDetailCellDelegate <NSObject>

@optional

-(void)shareButtonClicked;

@end

#import <UIKit/UIKit.h>

@interface STDetailCell : UITableViewCell

@property(nonatomic,assign)id<STDetailCellDelegate>myDelegate;

+(CGFloat)cellHeightForObject:(id)object;
-(void)showObject:(id)object;

@end
