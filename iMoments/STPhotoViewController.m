//
//  STPhotoViewController.m
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

#import "STPhotoViewController.h"

@interface STPhotoViewController ()

@end

@implementation STPhotoViewController

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
    self.title = @"Photo Gallery";
    [self addbackButtonWithTitle:@"Home"];
    self.showTableView.delegate = self;
    self.showTableView.dataSource = self;
    self.showTableView.backgroundColor = [UIColor colorWithHexString:@"#ebe7e9"];
    [self getData];
    self.showTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //[self addRightButtonWithTitle:@"Add" AndImage:YES];
}

-(void)rightButtonClick:(id)sender
{
    [self addDiary:sender];
}

-(void)addDiary:(id)sender
{
    STWriteViewController *writeViewController = [[STWriteViewController alloc] init];
    //self.navigationController.navigationBarHidden = NO;
    writeViewController.delegate = self;
    STNavigationViewController *nav = [[STNavigationViewController alloc] initWithRootViewController:writeViewController];
    [self.navigationController presentModalViewController:nav animated:YES];
}

-(void)reloadDiary:(Moment *)moment
{
    [self.dataSource removeAllObjects];
    [self getData];
}

-(void)getData
{
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    [dic setObject:@"1" forKey:@"type"];
    [[DataFactory shardDataFactory]searchWhere:dic orderBy:@"date" offset:0 count:DEFAULT_COUNT Classtype:momentClass callback:^(NSArray *result)
     {
         for (int i=0; i<[result count]; i++) {
             Moment *moment = [result objectAtIndex:i];
             if ([moment.type intValue] != 0) {
                 [self.dataSource addObject:moment];
             }
             
         }
         [self.showTableView reloadData];
     }];
}

-(int)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105;
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.dataSource count] % 3>0) {
        return (int)([self.dataSource count]/3.0 +1);
    }
    return [self.dataSource count]/3.0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"STPhotoCellIdentifier";
    STPhotoViewCellCell *cell = (STPhotoViewCellCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[STPhotoViewCellCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.delegate = self;
    }
    cell.dataSource = self.dataSource;
    NSMutableArray *tmp = [[NSMutableArray alloc] init];
    
    if (indexPath.row*3<[self.dataSource count]) {
        [tmp addObject:[self.dataSource objectAtIndex:indexPath.row*3]];
    }
    
    if (indexPath.row *3+1 <[self.dataSource count]) {
        [tmp addObject:[self.dataSource objectAtIndex:indexPath.row*3+1]];
    }
    
    if (indexPath.row*3+2 < [self.dataSource count]) {
        [tmp addObject:[self.dataSource objectAtIndex:indexPath.row*3+2]];
    }
    
    [cell showObject:tmp index:indexPath.row];
    tmp = nil;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)showDiary:(Moment *)moment
{
    STDiaryDetailViewController *detailViewController = [[STDiaryDetailViewController alloc] init];
    detailViewController.moment = moment;
    detailViewController.delegate = self;
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

-(void)reloadData
{
    [self.dataSource removeAllObjects];
    [self getData];
}


-(void)viewWillAppear:(BOOL)animated
{
    [[AppDelegate shareAppDelegate] showDir];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
