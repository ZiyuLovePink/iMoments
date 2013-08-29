//
//  STSettingViewController.m
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

#import "STSettingViewController.h"
#import "KKKeychain.h"

@interface STSettingViewController ()

@end

@implementation STSettingViewController

#define DELETE_ALL_TAG  1000011

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
    [self.showTableView removeFromSuperview];
    self.title = @"Setting";
    self.showTableView = nil;
    self.showTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 320, SCREEN_HEIGHT-44) style:UITableViewStyleGrouped];
    self.showTableView.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    self.showTableView.backgroundView = nil;
    self.showTableView.dataSource = self;
    self.showTableView.delegate = self;
    [self.contentView addSubview:self.showTableView];
    [self addbackButtonWithTitle:@"Home"];
    
    AppDelegate *delegate = [AppDelegate shareAppDelegate];
    [delegate showDir];
}

-(int)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 1;
            break;
        case 3:
            return 4;
            break;
        case 4:
            return 1;
            break;
        default:
            break;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"WMSettingCellIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    switch (indexPath.section) {
        case 0:{
            if (indexPath.row == 0) {
                cell.textLabel.text = @"Sync";
                UISwitch *switchBtn = [[UISwitch alloc] init];
                switchBtn.center = CGPointMake(260, 20);
                [cell addSubview:switchBtn];
            }
            break;
        }
        case 1:{
            if (indexPath.row == 0) {
                cell.textLabel.text = @"Style";
            }else {
                cell.textLabel.text = @"Themes";
            }
            break;
        }
        case 2:{
            cell.textLabel.text = @"Passcode Lock";
            //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            UISwitch *switchBtn = [[UISwitch alloc] init];
            switchBtn.center = CGPointMake(260, 20);
            if ([[KKKeychain getStringForKey:@"passcode_on"] isEqualToString:@"YES"]) {
                switchBtn.on = YES;
            }else {
                switchBtn.on = NO;
            }
            [switchBtn addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
            [cell addSubview:switchBtn];
            break;
        }
        case 3:{
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"Tell a Friend";
                    break;
                case 1:
                    cell.textLabel.text = @"Help & Support";
                    break;
                case 2:
                    cell.textLabel.text = @"Feedback";
                    break;
                case 3:
                    cell.textLabel.text = @"About";
                    break;
                default:
                    break;
            }
            break;
        }
        case 4:{
            if (indexPath.row == 0) {
                cell.textLabel.text = @"Clear All Moments";
                cell.textLabel.textColor = [UIColor whiteColor];
                
                cell.backgroundColor = [UIColor colorWithHexString:@"#df2f3c"];
                cell.textLabel.textAlignment = UITextAlignmentCenter;
            }
            break;
        }
            
        default:
            break;
    }
    
    return cell;
}

-(void)switchAction:(id)sender
{
    UISwitch *switchBtn = (UISwitch *)sender;
    if ([switchBtn isOn]) {
        //set password
        KKPasscodeViewController* vc = [[KKPasscodeViewController alloc] initWithNibName:nil bundle:nil];
		vc.delegate = self;
        vc.mode = KKPasscodeModeSet;
        STNavigationViewController *nav = [[STNavigationViewController alloc] initWithRootViewController:vc];
        [self.navigationController presentModalViewController:nav animated:YES];
    }else {
        //clear password
        if ([[KKPasscodeLock sharedLock] isPasscodeRequired]) {
            KKPasscodeViewController *vc = [[KKPasscodeViewController alloc] initWithNibName:nil bundle:nil];
            vc.mode = KKPasscodeModeEnter;
            vc.delegate = self;
            
            dispatch_async(dispatch_get_main_queue(),^ {
                STNavigationViewController *nav = [[STNavigationViewController alloc] initWithRootViewController:vc];
                nav.navigationBarHidden = NO;
                
                [self.navigationController presentModalViewController:nav animated:YES];
            });
            
        }
        [KKKeychain setString:@"NO" forKey:@"passcode_on"];
    }
}

-(void)didSettingsChanged:(KKPasscodeViewController *)viewController
{
    
}

-(void)didCancle
{
    [self.showTableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 42;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:{
            if (indexPath.row == 0) {
                
            }else {
                
            }
            break;
            
        }
        case 1:{
            if (indexPath.row == 0) {
                
            }else {
                
            }
            break;
        }
        case 2:{
            
            break;
        }
        case 3:{
            switch (indexPath.row) {
                case 0:{
                    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Share to Facebook",@"Share to Twitter", nil];
                    [sheet showInView:self.view];
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case 4:{
            if (indexPath.row == 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Are you sure to clear all? Data can not be recovered!" delegate:self cancelButtonTitle:@"Don't clear!" otherButtonTitles:@"Clear!", nil];
                alert.tag = DELETE_ALL_TAG;
                [alert show];
            }
            break;
        }
            
        default:
            break;
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == DELETE_ALL_TAG && buttonIndex == 1) {
        [self clearAllDiary];
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}

-(void)clearAllDiary
{
    [[DataFactory shardDataFactory] clearTableData:momentClass callback:^(BOOL finished) {
        if (finished) {
            NSString *imageDir = [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), @"images"];
            NSFileManager *fileManager = [NSFileManager defaultManager];
            [fileManager removeItemAtPath:imageDir error:nil];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Successfully Cleared!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
