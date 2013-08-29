//
//  STRootViewController.m
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

#import "STRootViewController.h"
#import "STNavigationViewController.h"

@interface STRootViewController ()
{
    NSArray *nameArray,*colorArray, *imageArray;
    NSMutableArray *dataList,*imageList;
    UIView *profileBgView;
    UIImageView *profileImageView;
    STCustomLabel *totalLabel,*photoLabel,*tagLabel;
}
@end

@implementation STRootViewController

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
    //APParallaxView *parallaxView =
    //[self.showTableView addParallaxWithImage:[UIImage imageNamed:@"ParallaxImage.jpg"] andHeight:180];
    //    parallaxView.appDelegate = self;
    nameArray = [NSArray arrayWithObjects:@"Timeline",@"Photo Gallery",@"Calendar",@"Tags Filter",@"Starred",@"Statistics",@"Setting" ,nil];
    imageArray = [NSArray arrayWithObjects:@"root0", @"root1", @"root2", @"root3", @"root4", @"root5", @"root6",nil];
    colorArray = [NSArray arrayWithObjects:[UIColor colorWithHexString:@"#01d0f8"],[UIColor colorWithHexString:@"#f5559f"],[UIColor colorWithHexString:@"#3f62b6"],[UIColor colorWithHexString:@"#ef5440"],[UIColor colorWithHexString:@"#1ed3b4"],nil];
    self.title = @"iMoments";
    
    
    [self addRightButtonWithTitle:@"Add" AndImage:YES];
    
    dataList = [[NSMutableArray alloc] init];
    imageList = [[NSMutableArray alloc] init];
    
    
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#35373f"];
    self.showTableView.backgroundView = nil;
    self.showTableView.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    self.showTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    
}

-(void)getData
{
    [[DataFactory shardDataFactory] searchCount:@"type=1 or type=0" Classtype:momentClass callback:^(int number) {
        if (number>10000) {
            totalLabel.text = [NSString stringWithFormat:@"%dk",number/1000];
        }else {
            totalLabel.text = [NSString stringWithFormat:@"%d",number];
        }
        
    }];
    
    [[DataFactory shardDataFactory] searchCount:@"type=1" Classtype:momentClass callback:^(int number) {
        if (number>10000) {
            photoLabel.text = [NSString stringWithFormat:@"%dk",number/1000];
        }else {
            photoLabel.text = [NSString stringWithFormat:@"%d",number];
        }
    }];
    
    //add to update total tag number
    [[DataFactory shardDataFactory] searchCount:@"hasTag=1" Classtype:momentClass callback:^(int number) {
        
        //add start***********************
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:@"1" forKey:@"hasTag"];
        [[DataFactory shardDataFactory]searchWhere:dic orderBy:@"date" offset:0 count:number Classtype:momentClass callback:^(NSArray *result)
         {
             if ([result count] < 1)
             {
                 tagLabel.text = @"0";
             }
             else
             {
                 NSMutableArray *uniqTags = [[NSMutableArray alloc] initWithCapacity:1];
                 for (int i = 0; i < [result count]; i++)
                 {
                     Moment *tempMoment = [[Moment alloc] init];
                     NSString *tempTag = @"";
                     tempMoment = [result objectAtIndex:i];
                     tempTag = tempMoment.tag;
                     if (![uniqTags containsObject:tempTag])
                     {
                         [uniqTags addObject:tempTag];
                     }
                 }
                 if ([uniqTags count] > 10000) {
                     tagLabel.text = [NSString stringWithFormat:@"%dk",[uniqTags count]/1000];
                 }else {
                     tagLabel.text = [NSString stringWithFormat:@"%d",[uniqTags count]];
                 }
             }
         }];
        //add end  ***********************
    }];
    //add end
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self addHeaderView];
    [self viewAnimate:profileBgView animated:YES];
    [self getData];
}

-(void)addHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 250)];
    headerView.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    
    //UIColor* mainColor = [UIColor colorWithRed:28.0/255 green:158.0/255 blue:121.0/255 alpha:1.0f];
    UIColor *mainColor = [UIColor colorWithHexString:@"2EB1F2"];
    //UIColor* imageBorderColor = [UIColor colorWithRed:28.0/255 green:158.0/255 blue:121.0/255 alpha:0.4f];
    UIColor *imageBorderColor = [UIColor colorWithHexString:@"2EB1F2"];
    //UIColor *imageBorderColor = [UIColor colorWithHue:nil saturation:nil brightness:nil alpha:0.4];
    //NSString* fontName = @"Avenir-Book";
    NSString* boldItalicFontName = @"Avenir-BlackOblique";
    NSString* boldFontName = @"Avenir-Black";
    
    profileBgView = [[UIView alloc] initWithFrame:CGRectMake(100, -80, 120, 120)];
    [headerView addSubview:profileBgView];
    profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
    profileImageView.userInteractionEnabled = YES;
    profileImageView.contentMode = UIViewContentModeScaleAspectFill;
    profileImageView.clipsToBounds = YES;
    profileImageView.layer.borderWidth = 4.0f;
    profileImageView.layer.cornerRadius = 60.0f;
    profileImageView.layer.borderColor = imageBorderColor.CGColor;
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"avatar"]) {
        profileImageView.image = [UIImage imageWithContentsOfFile:[[NSUserDefaults standardUserDefaults] valueForKey:@"avatar"]];
    }else {
        profileImageView.image = [UIImage imageNamed:@"ParallaxImage.jpg"];
    }
    
    [profileBgView addSubview:profileImageView];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeAvatar)];
    [profileImageView addGestureRecognizer:singleTap];
    
    totalLabel = [[STCustomLabel alloc] initWithFrame:CGRectMake(-60, 175, 66, 20) text:@"2013" font:[UIFont fontWithName:boldItalicFontName size:20] textColor:mainColor];
    totalLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:totalLabel];
    STCustomLabel *totalTitleLabel = [[STCustomLabel alloc] initWithFrame:CGRectMake(0, 250, 66, 17) text:@"All" font:[UIFont fontWithName:boldFontName size:17] textColor:mainColor];
    totalTitleLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:totalTitleLabel];
    
    [self viewAnimate:totalLabel animated:YES x:28 y:175 duration:0.8];
    [self viewAnimate:totalTitleLabel animated:YES x:28 y:200 duration:1.0];
    
    photoLabel = [[STCustomLabel alloc] initWithFrame:CGRectMake(122, 225, 66, 20) text:@"1987" font:[UIFont fontWithName:boldItalicFontName size:20] textColor:mainColor];
    photoLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:photoLabel];
    STCustomLabel *photoTitleLabel = [[STCustomLabel alloc] initWithFrame:CGRectMake(122, 250, 66, 17) text:@"Photos" font:[UIFont fontWithName:boldFontName size:17] textColor:mainColor];
    photoTitleLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:photoTitleLabel];
    
    [self viewAnimate:photoLabel animated:YES x:122 y:175 duration:0.8];
    [self viewAnimate:photoTitleLabel animated:YES x:122 y:200 duration:1.0];
    
    tagLabel = [[STCustomLabel alloc] initWithFrame:CGRectMake(360, 175, 66, 20) text:@"56" font:[UIFont fontWithName:boldItalicFontName size:20] textColor:mainColor];
    tagLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:tagLabel];
    STCustomLabel *tagTitleLabel = [[STCustomLabel alloc] initWithFrame:CGRectMake(360, 250, 66, 17) text:@"Tags" font:[UIFont fontWithName:boldFontName size:17] textColor:mainColor];
    tagTitleLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:tagTitleLabel];
    
    [self viewAnimate:tagLabel animated:YES x:226 y:175 duration:0.8];
    [self viewAnimate:tagTitleLabel animated:YES x:226 y:200 duration:1.0];
    
    self.showTableView.tableHeaderView = headerView;
}

-(void)viewAnimate:(UIView *)view animated:(BOOL)animated x:(CGFloat)x y:(CGFloat)y duration:(CGFloat)duration
{
    [UIView animateWithDuration:animated?duration:0 animations:^{
        CGRect frame = view.frame;
        frame.origin.x = x;
        frame.origin.y = y;
        view.frame = frame;
    }];
}

-(void)viewAnimate:(UIView*)view animated:(BOOL)animated{
    
    [UIView animateWithDuration:animated?1.6:0 animations:^{
        CGRect frame = profileBgView.frame;
        frame.origin.y = 30;
        view.frame = frame;
    }];
    
}

-(void)changeAvatar
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera",@"Photo Library", nil];
    [sheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSUInteger sourceType = 0;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        switch (buttonIndex) {
            case 0:
                sourceType = UIImagePickerControllerSourceTypeCamera;
                break;
            case 1:
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
            default:
                return;
        }
    } else {
        if (buttonIndex == 2) {
            return;
        } else {
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
    }
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
    [self presentModalViewController:imagePickerController animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"avatar"]) {
        [[STImageSaver shareImageSaver] deleteImage:[[NSUserDefaults standardUserDefaults] valueForKey:@"avatar"]];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"avatar"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
	[picker dismissModalViewControllerAnimated:YES];
	UIImage *saveImage = [info objectForKey:UIImagePickerControllerEditedImage];
    profileImageView.image = saveImage;
    NSString *avatarUrl = [[STImageSaver shareImageSaver] saveImage:saveImage];
    [[NSUserDefaults standardUserDefaults] setValue:avatarUrl forKey:@"avatar"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self dismissModalViewControllerAnimated:YES];
}

-(void)rightButtonClick:(id)sender
{
    [self addDiary:sender];
}


-(void)addDiary:(id)sender
{
    STWriteViewController *writeViewController = [[STWriteViewController alloc] init];
    STNavigationViewController *nav = [[STNavigationViewController alloc] initWithRootViewController:writeViewController];
    [self.navigationController presentModalViewController:nav animated:YES];
    
}


-(void)showTimeline
{
    STMainTimeLineViewController *timelineViewController = [[STMainTimeLineViewController alloc] init];
    [self.navigationController pushViewController:timelineViewController animated:YES];
}

-(void)showPhotoView
{
    STPhotoViewController *photoViewController = [[STPhotoViewController alloc] init];
    photoViewController.dataSource = dataList;
    photoViewController.imageList = imageList;
    [self.navigationController pushViewController:photoViewController animated:YES];
}

-(void)showCalendar
{
    STCalendarViewController *calendarViewController = [[STCalendarViewController alloc] init];
    [self.navigationController pushViewController:calendarViewController animated:YES];
}

-(void)showYearLine
{
    STDateShowViewController *dateShowViewController = [[STDateShowViewController alloc] init];
    [self.navigationController pushViewController:dateShowViewController animated:YES];
}

// add to show tags select
-(void)showTagSelectPage
{
    STTagSelectViewController *tagSelectViewController = [[STTagSelectViewController alloc] init];
    [self.navigationController pushViewController:tagSelectViewController animated:YES];
}
//end add

// add to show starred page
-(void)showStarredPage
{
    STMainTimeLineViewController *timelineViewController = [[STMainTimeLineViewController alloc] init];
    NSMutableDictionary *dicForStarred = [[NSMutableDictionary alloc] init];
    [dicForStarred setValue:@"1" forKey:@"starred"];
    timelineViewController.searchWhere = dicForStarred;
    [self.navigationController pushViewController:timelineViewController animated:YES];
}
//end add

//add to show statistics
-(void)showStatistics
{
    
    // If the device is an iPad, we make it taller.
    AKTabBarController *tabBarController = [[AKTabBarController alloc] initWithTabBarHeight:(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 70 : 50];
    [tabBarController setMinimumHeightToDisplayTitle:40.0];

    // initialize moodViewController
    MoodViewController *moodViewController = [[MoodViewController alloc] init];
    
    
    // initialize mapViewController
    MapViewController *mapViewController = [[MapViewController alloc] init];
    
    TagCloudViewController *tagCloudViewController = [[TagCloudViewController alloc] init];
    tagCloudViewController.title = @"Tag Cloud";
    
    NSLog(@"aaaa");
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:mapViewController];
    navigationController.navigationBar.tintColor = [UIColor grayColor];
    
    
    [tabBarController setViewControllers:[NSMutableArray arrayWithObjects:
                                          navigationController,
                                          moodViewController,
                                          tagCloudViewController,
                                          nil]];
    [self.navigationController pushViewController:tabBarController animated:YES];
    
    NSLog(@"bbb");
    
    
}
//end add

-(UIButton*)addbackButtonWithTitle:(id)title{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *normal = [UIImage imageNamed:@"nav_back_bg_normal"] ;
    UIImage *highlight = [UIImage imageNamed:@"nav_back_bg_highlight"];
    button.frame = CGRectMake(10, 0, 52, 30);
    //    [button setBackgroundImage:[UIImage imageNamed:@"btnback"] forState:UIControlStateNormal];
    //    [button setBackgroundImage:[UIImage imageNamed:@"btnback"] forState:UIControlStateHighlighted];
    [button setBackgroundImage:normal forState:UIControlStateNormal];
    [button setBackgroundImage:highlight forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    //[button setTitleColor:[UIColor colorWithHexString:@"#595959"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:@"#848484"] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleEdgeInsets = UIEdgeInsetsMake(6, 7, 5, 0);
    [self.headBar addSubview:button];
    [button setImageEdgeInsets:UIEdgeInsetsMake(1, 0, 0, 0)];
    [button addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return button;
}

-(void)showSetting:(id)sender
{
    STSettingViewController *settingViewController = [[STSettingViewController alloc] init];
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:settingViewController animated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * CellIdentifier = @"STRootCellIdentifier";
    STRootCell *cell = (STRootCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[STRootCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell setTitle:[nameArray objectAtIndex:indexPath.row] AndImage:[UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]]];
    //cell.imageView.image = [UIImage imageNamed:@"add"];
    UIView *myView = [[UIView alloc] init];
    myView.backgroundColor = [UIColor colorWithHexString:@"#fefefe"];
    cell.backgroundView = myView;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0: {
            [self showTimeline];
            break;
        }
        case 1: {
            [self showPhotoView];
            break;
        }
        case 2: {
            [self showYearLine];
            break;
        }
        case 3: {
            [self showTagSelectPage];
            break;
        }
        case 4: {   // to change
            [self showStarredPage];
            break;
        }
        case 5: {
            [self showStatistics];
            break;
        }
        case 6: {
            [self showSetting:nil];
            break;
        }
        default:
            break;
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
