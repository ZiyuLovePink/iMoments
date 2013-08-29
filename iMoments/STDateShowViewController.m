//
//  STDateShowViewController.m
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

#import "STDateShowViewController.h"

@interface STDateShowViewController ()
{
    NSString *selectDate;
}
@end

@implementation STDateShowViewController

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
    self.title = @"Calendar";
    [self addbackButtonWithTitle:@"Home"];
    
    CKCalendarView *calView = [[CKCalendarView alloc] initWithStartDay:startSunday frame:CGRectMake(0, 44, 320, 290)];
    calView.delegate = self;
    [self.contentView addSubview:calView];
    
    CGRect frame = self.showTableView.frame;
    frame.origin.y = 90;
    self.showTableView.frame = frame;
}

-(void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-M-d"];
    
    NSDateFormatter *dateFormatterForNewMoment = [[NSDateFormatter alloc] init];
    [dateFormatterForNewMoment setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatterForNewMoment setTimeStyle:NSDateFormatterShortStyle];
    NSString *dateForNewMoment = [dateFormatterForNewMoment stringFromDate:date];
    selectDate = dateForNewMoment;
    //NSLog(@"did select date : %@",[dateFormatter stringFromDate:date]);
    NSString *queryDate = [dateFormatter stringFromDate:date];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:queryDate forKey:@"dateForCalendar"];
    
    [[DataFactory shardDataFactory]searchWhere:dic orderBy:@"date" offset:0 count:DEFAULT_COUNT Classtype:momentClass callback:^(NSArray *result)
     {
         if ([result count]>0)
         {
             STMainTimeLineViewController *timelineViewController = [[STMainTimeLineViewController alloc] init];
             timelineViewController.backButtonName = @"Calendar";
             timelineViewController.searchWhere = dic;
             [self.navigationController pushViewController:timelineViewController animated:YES];
         }
         else
         {
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"No moment found. Want to add one？" delegate:self cancelButtonTitle:@"Not now." otherButtonTitles:@"Sure!Go!", nil];
             [alert show];
         }
         
     }];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        STWriteViewController *writeViewController = [[STWriteViewController alloc] init];
        writeViewController.showDate = selectDate;
        STNavigationViewController *nav = [[STNavigationViewController alloc] initWithRootViewController:writeViewController];
        [self.navigationController presentModalViewController:nav animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end