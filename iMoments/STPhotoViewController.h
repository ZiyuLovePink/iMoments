//
//  STPhotoViewController.h
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

#import "STBaseTableViewController.h"
#import "STPhotoViewCellCell.h"
#import "STDiaryDetailViewController.h"

@interface STPhotoViewController : STBaseTableViewController<WriteDiaryDelegate,STPhotoViewCellDelegate,STDetailViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;
@property(nonatomic,strong)NSArray *imageList;

@end
