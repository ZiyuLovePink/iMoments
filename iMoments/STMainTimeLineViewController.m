//
//  STMainTimeLineViewController.m
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

#import "STMainTimeLineViewController.h"

@interface STMainTimeLineViewController ()
{
    BOOL tableAnimated;
}
@end

@implementation STMainTimeLineViewController

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
	// Do any additional setup after loading the view.
    self.title = @"Timeline";
    [self addbackButtonWithTitle:@"Home"];
    if([_backButtonName isEqualToString:@"Calendar"]){
        
        [self addbackButtonWithTitle:@"Back"];
    }
    if([_backButtonName isEqualToString:@"Tags"]){
        [self addbackButtonWithTitle:@"Tags"];
    }
    [self addRightButtonWithTitle:@"Add" AndImage:YES];
    
    self.showTableView.delegate = self;
    self.showTableView.dataSource = self;
    self.showTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    self.showTableView.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    self.showTableView.backgroundView = nil;
    
    //new add
    //_searchWhere = [[NSMutableDictionary alloc] init];
    //add end
    [self getData];
}



-(void)rightButtonClick:(id)sender
{
    [self addDiary:sender];
}

-(void)reloadDiary:(Moment *)moment
{
    [self.dataSource removeAllObjects];
    [self getData];
}

// add to refresh to time line top
-(void)refreshToTop
{
    [self.showTableView setContentOffset:CGPointZero animated:YES];
}

-(void)addDiary:(id)sender
{
    STWriteViewController *writeViewController = [[STWriteViewController alloc] init];
    //self.navigationController.navigationBarHidden = NO;
    writeViewController.delegate = self;
    STNavigationViewController *nav = [[STNavigationViewController alloc] initWithRootViewController:writeViewController];
    [self.navigationController presentModalViewController:nav animated:YES];
}


-(void)getData
{
    [[DataFactory shardDataFactory]searchWhere:_searchWhere orderBy:@"date" offset:0 count:DEFAULT_COUNT Classtype:momentClass callback:^(NSArray *result)
     {
         for (int i=0; i<[result count]; i++) {
             [self.dataSource addObject:[result objectAtIndex:i]];
         }
         [self.showTableView reloadData];
         [self replayAnimation];
     }];
}

-(void)getMore
{
    [[DataFactory shardDataFactory]searchWhere:_searchWhere orderBy:nil offset:[self.dataSource count] count:DEFAULT_COUNT Classtype:momentClass callback:^(NSArray *result)
     {
         for (int i=0; i<[result count]; i++) {
             [self.dataSource addObject:[result objectAtIndex:i]];
         }
         [self.showTableView reloadData];
     }];
    
}

-(int)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    STDiaryDetailViewController *detailViewController = [[STDiaryDetailViewController alloc] init];
    detailViewController.moment = [self.dataSource objectAtIndex:indexPath.row];
    detailViewController.delegate = self;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

-(void)reloadData
{
    [self.dataSource removeAllObjects];
    [self getData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Moment *moment = [self.dataSource objectAtIndex:indexPath.row];
    
    NSString *cellIdentifierBase = @"STMainTimelineCellIdentifier";
    NSString *midForThisDiary = moment.mid;
    NSString *CellIdentifier = [cellIdentifierBase stringByAppendingString:midForThisDiary];
    
    //static NSString * CellIdentifier = @"STMainTimelineCellIdentifier";
    STMainTimelineCell *cell = (STMainTimelineCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //STMainTimelineCell *cell = [[STMainTimelineCell alloc] init];
    
    if (cell == nil) {
        cell = [[STMainTimelineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        //STMainTimelineCell *cell = [[STMainTimelineCell alloc] init];
        [cell configureCellContentSizeWidth:tableView.frame.size.width height:95];
    }
    
    [cell resetPosition];
    // remove all the subviews
    
    NSArray *allSubviews = cell.atcContentView.subviews;
    NSMutableArray *subviewsWhichNeedToRemove = [[NSMutableArray alloc] init];
    for (int i = 0; i < [allSubviews count]; i++) {
        if ([[allSubviews objectAtIndex:i] isKindOfClass:[UIImageView class]]) {
            [subviewsWhichNeedToRemove addObject:[allSubviews objectAtIndex:i]];
        }
    }
    [subviewsWhichNeedToRemove makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    // Trigger tableView didLoad and then start animation
    
    if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row){
        // Show once only
        if (!tableAnimated)
            [self startTableViewAnimation:tableView];
    }
    
    [cell showObject:moment];
    return cell;
}

- (void) startTableViewAnimation:(UITableView *)table
{
    tableAnimated = YES;
    for (AnimatedTableCell *atCell in table.visibleCells) {
        if ([table.visibleCells indexOfObject:atCell] % 2 == 0)
            [atCell pushCellWithAnimation:YES direction:@"up"];
        else
            [atCell pushCellWithAnimation:YES direction:@"down"];
    }
}

- (void) replayAnimation
{
    [self startTableViewAnimation:self.showTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
