//
//  STBaseTableViewController.h
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STBaseViewController.h"
#import "EGORefreshTableHeaderView.h"

@interface STBaseTableViewController : STBaseViewController<UITableViewDataSource, UITableViewDelegate, EGORefreshTableHeaderDelegate>
{
    //    UITableView *showTableView;
    //    NSMutableArray *dataSource;
    //
    //    EGORefreshTableHeaderView *refreshHeaderView;
    //
    //    BOOL gettingMoreData;
    //
    //    BOOL shouldAutoGetMoreData;
    //
    //    BOOL shouldAutoRefreshData;
    BOOL _reloading;
}

@property (nonatomic, strong) UITableView *showTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

//@property (nonatomic, retain) NKLoadingMoreView *loadingMoreView;
@property (nonatomic, strong) EGORefreshTableHeaderView *refreshHeaderView;

@property (nonatomic) BOOL shouldAutoGetMoreData;
@property (nonatomic) BOOL upsideDown;

@property (nonatomic) BOOL shouldAutoRefreshData;
@end
