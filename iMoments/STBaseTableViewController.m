//
//  STBaseTableViewController.m
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

#import "STBaseTableViewController.h"

@interface STBaseTableViewController ()

@end

@implementation STBaseTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _showTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 43, 320, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    _showTableView.dataSource = self;
    _showTableView.delegate = self;
    [self.contentView insertSubview:_showTableView atIndex:0];
    _showTableView.backgroundColor = [UIColor whiteColor];
    //_showTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.dataSource = [[NSMutableArray alloc] init];
    
}

#pragma mark TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return nil;
}


#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void) reloadTableViewDataSource {
    
    //  should be calling your tableviews data source model to reload
    //  put here just for demo
    _reloading = YES;
    
}

- (void) doneLoadingTableViewData {
    
    //  model should call this when its done loading
    _reloading = NO;
    [self.refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.showTableView];
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView==_showTableView) {
        [self.refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    }
    
    
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView==_showTableView) {
        
        [self.refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    }
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void) egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view {
    
    [self reloadTableViewDataSource];
}

- (BOOL) egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view {
    
    return _reloading;     // should return if data source model is reloading
}

- (NSDate *) egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view {
    
    return [NSDate date];     // should return date data source was last changed
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
