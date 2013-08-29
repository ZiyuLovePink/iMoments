//
//  STTagSelectViewController.m
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

#import "STTagSelectViewController.h"

@interface STTagSelectViewController ()

{
    NSMutableArray *unselectedTags;
    NSMutableArray *selectedTags;
}

@end

@implementation STTagSelectViewController

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
    
    // add new
    [self.showTableView removeFromSuperview];
    self.title = @"Select Tags";
    self.showTableView = nil;
    self.showTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 320, SCREEN_HEIGHT-44) style:UITableViewStyleGrouped];
    self.showTableView.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    self.showTableView.backgroundView = nil;
    self.showTableView.dataSource = self; // 调用方法获得tag！
    self.showTableView.delegate = self;
    [self.contentView addSubview:self.showTableView];
    [self addbackButtonWithTitle:@"Home"];
    
    [self addRightButtonWithTitle:@"GO"];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    selectedTags = [[NSMutableArray alloc] init];
    unselectedTags = [[NSMutableArray alloc] init];
    [self initialSelectedAndUnselectedTags];
    //add end
    
}

-(int)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(void)initialSelectedAndUnselectedTags
{
    //add to update total tag number
    [[DataFactory shardDataFactory] searchCount:@"hasTag=1" Classtype:momentClass callback:^(int number) {
        //add start***********************
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:@"1" forKey:@"hasTag"];
        [[DataFactory shardDataFactory]searchWhere:dic orderBy:@"date" offset:0 count:number Classtype:momentClass callback:^(NSArray *result)
         {
             if ([result count] > 0)
             {
                 //NSMutableArray *uniqTags = [[NSMutableArray alloc] initWithCapacity:1];
                 for (int i = 0; i < [result count]; i++)
                 {
                     Moment *tempMoment = [[Moment alloc] init];
                     NSString *tempTag = @"";
                     tempMoment = [result objectAtIndex:i];
                     tempTag = tempMoment.tag;
                     
                     if (![unselectedTags containsObject:tempTag])
                     {
                         [unselectedTags addObject:tempTag];
                     }
                 }
             }
             // this is sort in alphabetical order case-insensitive
             [unselectedTags sortUsingSelector:@selector(caseInsensitiveCompare:)];
         }];
        //add end  ***********************
    }];
    //add end
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return [selectedTags count];
            break;
        case 1:
            return [unselectedTags count];
            break;
        default:
            break;
    }
    return 1;
}

//from stack overflow
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return @"Selected tags:";
    }
    if (section == 1)
    {
        return @"Unselected tags:";
    }
    return @"";
}
// end

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"STTagsCellIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    switch (indexPath.section) {
        case 0:{
            cell.textLabel.text = [selectedTags objectAtIndex:indexPath.row];
            break;
        }
        case 1:{
            cell.textLabel.text = [unselectedTags objectAtIndex:indexPath.row];
            break;
        }
        default:
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:{
            NSString *temp=[selectedTags objectAtIndex:indexPath.row];
            [selectedTags removeObject:temp];
            [unselectedTags addObject:temp];
            // sort!
            [unselectedTags sortUsingSelector:@selector(caseInsensitiveCompare:)];
            
            [self.showTableView reloadData];
            if ([selectedTags count] > 0)
            {
                self.navigationItem.rightBarButtonItem.enabled = YES;
            }
            else{
                self.navigationItem.rightBarButtonItem.enabled = NO;
            }
            break;
        }
        case 1:{
            
            NSString *temp=[unselectedTags objectAtIndex:indexPath.row];
            [unselectedTags removeObject:temp];
            [selectedTags addObject:temp];
            // sort!
            [selectedTags sortUsingSelector:@selector(caseInsensitiveCompare:)];
            
            [self.showTableView reloadData];
            if ([selectedTags count] > 0)
            {
                self.navigationItem.rightBarButtonItem.enabled = YES;
            }
            else{
                self.navigationItem.rightBarButtonItem.enabled = NO;
            }
            break;
        }
            
        default:
            break;
    }
    
}

// right button click!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-(void)rightButtonClick:(id)sender
{
    
    STMainTimeLineViewController *timelineViewController = [[STMainTimeLineViewController alloc] init];
    timelineViewController.backButtonName = @"Tags";
    NSMutableDictionary *dicForSelectedTags = [[NSMutableDictionary alloc] init];
    /*
     for(int i = 0; i < [selectedTags count]; i++)
     {
     NSLog(@"come in 1");
     [dicForSelectedTags setValue:(NSString*)[selectedTags objectAtIndex:i] forKey:@"tag"];
     NSLog(@"come in");
     }
     */
    
    [dicForSelectedTags setValue:selectedTags forKey:@"tag"];
    timelineViewController.searchWhere = dicForSelectedTags;
    
    //[timelineViewController addbackButtonWithTitle:@"tags"];
    
    [self.navigationController pushViewController:timelineViewController animated:YES];
    
}

// click end!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
