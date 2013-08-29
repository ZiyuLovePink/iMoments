//
//  STMainTimeLineViewController.h
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

#import "STBaseTableViewController.h"
#import "STMainTimelineCell.h"
#import "STMainTableCell.h"
#import "STDiaryDetailViewController.h"

@interface STMainTimeLineViewController : STBaseTableViewController<WriteDiaryDelegate,STDetailViewDelegate>

// add new

@property(nonatomic,strong)NSMutableDictionary *searchWhere;
@property(nonatomic,strong)NSString *backButtonName;
// add end

@end
