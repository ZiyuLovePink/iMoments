//
//  STDiaryDetailViewController.m
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

#import "STDiaryDetailViewController.h"

@interface STDiaryDetailViewController ()
{
    STBaseImageView *imageView;
    STCustomLabel *contentLabel;
    
    CFShareCircleView *shareCircleView;
    UIButton *shareButton;
    
    SLComposeViewController *slComposerSheet;
}
@end

@implementation STDiaryDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}
-(void)clickShareButton:(id)sender
{
    [shareCircleView animateIn];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = _moment.showDate;
    [self addbackButtonWithTitle:@"Back"];
    [self addRightButtonWithTitle:@"Edit"];
    
    self.showTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.dataSource addObject:_moment];
    Moment *moment = [self.dataSource objectAtIndex:0];
    if ([moment.type intValue] != 0) {
        [self.showTableView addParallaxWithImage:[UIImage imageWithContentsOfFile:moment.imagePath] andHeight:230];
    }else {
        [self.showTableView addParallaxWithImage:nil andHeight:200];
    }
    [self.showTableView reloadData];

}

-(void)viewWillAppear:(BOOL)animated
{
    
}

-(void)getData
{
    [self.showTableView removeFromSuperview];
    self.showTableView = nil;
    self.showTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 320, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    self.showTableView.dataSource = self;
    self.showTableView.delegate = self;
    self.showTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.contentView insertSubview:self.showTableView atIndex:0];
    self.showTableView.backgroundColor = [UIColor whiteColor];
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    [dic setObject:_moment.mid forKey:@"mid"];
    [[DataFactory shardDataFactory]searchWhere:dic orderBy:@"date" offset:0 count:DEFAULT_COUNT Classtype:momentClass callback:^(NSArray *result)
     {
         for (int i=0; i<[result count]; i++) {
             [self.dataSource addObject:[result objectAtIndex:i]];
         }
         Moment *moment = [self.dataSource objectAtIndex:0];
         if ([moment.type intValue] != 0) {
             [self.showTableView addParallaxWithImage:[UIImage imageWithContentsOfFile:moment.imagePath] andHeight:230];
         }else {
             [self.showTableView addParallaxWithImage:nil andHeight:230];
         }
         [self.showTableView reloadData];
     }];
}

-(void)reloadSelf:(Moment *)moment
{
    for (UIView *view in self.showTableView.subviews) {
        [view removeFromSuperview];
    }
    if ([_moment.type intValue] != 0) {
        [self.showTableView addParallaxWithImage:[UIImage imageWithContentsOfFile:_moment.imagePath] andHeight:230];
    }else {
        //[self.showTableView addParallaxWithImage:nil andHeight:260];
    }
    [self.dataSource removeAllObjects];
    [self.dataSource addObject:moment];
    
    [self.showTableView reloadData];
 
    AppDelegate *delegate = [AppDelegate shareAppDelegate];
    [delegate showDir];
}

-(void)reloadDiary:(id)moment
{
    _moment = moment;
    self.title = _moment.showDate;
    [self.dataSource removeAllObjects];
    [self getData];
    [_delegate reloadData];
}

-(int)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return [STDetailCell cellHeightForObject:[self.dataSource objectAtIndex:indexPath.row]];
    }
    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"STDairyDetailCellIdentifier";
    STDetailCell *cell = (STDetailCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[STDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.myDelegate = self;
    }
    [cell showObject:[self.dataSource objectAtIndex:indexPath.row]];
    return cell;
}


-(void)rightButtonClick:(id)sender
{
    UIActionSheet *ac = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete" otherButtonTitles:@"Edit", nil];
    [ac showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self deleteDiary];
            break;
        case 1:
            [self edit];
            break;
        default:
            break;
    }
}

-(void)deleteDiary
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:_moment.mid forKey:@"mid"];
    if ([_moment.imagePath length]) {
        [[STImageSaver shareImageSaver] deleteImage:_moment.imagePath];
    }
    
    [[DataFactory shardDataFactory] deleteWhereData:dic Classtype:momentClass];
    [_delegate reloadData];
    [self goBack:nil];
}

-(void)edit
{
    STWriteViewController *writeViewController = [[STWriteViewController alloc] init];
    writeViewController.editMoment = _moment;
    writeViewController.delegate = self;
    STNavigationViewController *nav = [[STNavigationViewController alloc] initWithRootViewController:writeViewController];
    [self.navigationController presentModalViewController:nav animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)shareButtonClicked
{
    NSLog(@"really come in");
    shareCircleView = [[CFShareCircleView alloc] initWithFrame:self.contentView.frame];
    shareCircleView.delegate = self;
    [self.contentView addSubview:shareCircleView];
    [shareCircleView animateIn];
}


// add to implement the delegate required by shareButton
- (void)shareCircleView:(CFShareCircleView *)aShareCircleView didSelectSharer:(CFSharer *)sharer
{
    if([sharer.name isEqualToString:@"Facebook"])
    {
        //分享到facebook
        
        if ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=6) {
            slComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            [slComposerSheet setInitialText:_moment.content];
            [slComposerSheet addImage:[UIImage imageWithContentsOfFile:_moment.imagePath]];
            
            //[slComposerSheet addURL:[NSURL URLWithString:@"http://www.facebook.com/"]];
            [self presentViewController:slComposerSheet animated:YES completion:nil];
            // }
            
            [slComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
                NSLog(@"start completion block");
                NSString *output;
                switch (result) {
                    case SLComposeViewControllerResultCancelled:
                        output = @"Action Cancelled";
                        break;
                    case SLComposeViewControllerResultDone:
                        output = @"Post Successfully";
                        break;
                    default:
                        break;
                }
                if (result != SLComposeViewControllerResultCancelled)
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook Message" message:output delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    [alert show];
                }
            }];
            
        }else{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.facebook.com"]];
        }
    }
    if([sharer.name isEqualToString:@"Twitter"]){
        
        int currentver = [[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue];
        //ios5
        if (currentver==5 ) {
            // Set up the built-in twitter composition view controller.
            TWTweetComposeViewController *tweetViewController = [[TWTweetComposeViewController alloc] init];
            // Set the initial tweet text. See the framework for additional properties that can be set.
            [tweetViewController setInitialText:@"IOS5 twitter"];
            // Create the completion handler block.
            [tweetViewController setCompletionHandler:^(TWTweetComposeViewControllerResult result) {
                // Dismiss the tweet composition view controller.
                [self dismissModalViewControllerAnimated:YES];
            }];
            
            // Present the tweet composition view controller modally.
            [self presentModalViewController:tweetViewController animated:YES];
            //ios6
        }else if (currentver==6) {
            //        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
            //        {
            slComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            [slComposerSheet setInitialText:_moment.content];
            [slComposerSheet addImage:[UIImage imageWithContentsOfFile:_moment.imagePath]];
            
            //[slComposerSheet addURL:[NSURL URLWithString:@"http://www.twitter.com/"]];
            [self presentViewController:slComposerSheet animated:YES completion:nil];
            //        }
            
            [slComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
                NSLog(@"start completion block");
                NSString *output;
                switch (result) {
                    case SLComposeViewControllerResultCancelled:
                        output = @"Action Cancelled";
                        [self dismissModalViewControllerAnimated:YES];
                        break;
                    case SLComposeViewControllerResultDone:
                        output = @"Post Successfully";
                        [self dismissModalViewControllerAnimated:YES];
                        break;
                    default:
                        [self dismissModalViewControllerAnimated:YES];
                        break;
                }
                if (result != SLComposeViewControllerResultCancelled)
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitter Message" message:output delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    [alert show];
                }
            }];
            
        }else{//ios5 以下
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://twitter.com"]];
        }
        
    }
    
    if([sharer.name isEqualToString:@"Weibo"]){
        
        if ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=6) {
            slComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
            [slComposerSheet setInitialText:_moment.content];
            [slComposerSheet addImage:[UIImage imageWithContentsOfFile:_moment.imagePath]];
            [slComposerSheet addURL:[NSURL URLWithString:@"http://www.weibo.com/"]];
            [self presentViewController:slComposerSheet animated:YES completion:nil];
            //}
            [slComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
                NSLog(@"start completion block");
                NSString *output;
                switch (result) {
                    case SLComposeViewControllerResultCancelled:
                        output = @"Action Cancelled";
                        [self dismissModalViewControllerAnimated:YES];
                        break;
                    case SLComposeViewControllerResultDone:
                        output = @"Post Successfully";
                        [self dismissModalViewControllerAnimated:YES];
                        break;
                    default:
                        [self dismissModalViewControllerAnimated:YES];
                        break;
                }
                if (result != SLComposeViewControllerResultCancelled)
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Weibo Message" message:output delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    [alert show];
                }
            }];
            
        }else{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://weibo.com"]];
            
        }
    }
}

- (void)shareCircleDisappear:(id)sender
{
    NSLog(@"disapear");
}
//add end

@end
