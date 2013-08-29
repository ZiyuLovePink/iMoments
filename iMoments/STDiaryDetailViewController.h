//
//  STDiaryDetailViewController.h
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

@protocol STDetailViewDelegate <NSObject>

@optional
-(void)reloadData;

@end


#import "STBaseTableViewController.h"
#import "STBaseImageView.h"
#import "UIScrollView+APParallaxHeader.h"
#import "STDetailCell.h"
#import "STWriteViewController.h"
#import "CFShareCircleView.h"

#import <UIKit/UIKit.h>
#import <Twitter/Twitter.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface STDiaryDetailViewController : STBaseTableViewController<WriteDiaryDelegate,UIActionSheetDelegate,CFShareCircleViewDelegate,STDetailCellDelegate>

@property(nonatomic,strong)Moment *moment;
@property(nonatomic,unsafe_unretained)id<STDetailViewDelegate>delegate;
@end
