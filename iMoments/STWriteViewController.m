//
//  STWriteViewController.m
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

#import "STWriteViewController.h"
#import "STSettingViewController.h"


@interface STWriteViewController ()
{
    UIImage *savePhoto;
    BOOL hasDate;
    NSDateFormatter *dateFormatter;
    NSDateFormatter *dateFormatterForDateForCalendar;
    UIButton *selectBtn;
    SGSelectViewController *sg;
    NSString *tempForEmoticon;
    CLLocationManager *locationManager;
    BOOL locationAdded;
    
    SLComposeViewController *slComposerSheet;
}
@end

@implementation STWriteViewController

#define SHOW_PHOTO 11000
#define DELETE_PHOTO 12000
#define SHOW_SAVE 22000

#define TOOL_HEIGHT 34

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        dateFormatter = [[NSDateFormatter alloc] init];
        
        dateFormatterForDateForCalendar = [[NSDateFormatter alloc] init];
        
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    moment = [[Moment alloc] init];
    
    //COMMENT THE FOLLOWING TWO SENTENCE************
    //dateFormatter = [[NSDateFormatter alloc] init];
    
    //dateFormatterForDateForCalendar = [[NSDateFormatter alloc] init];
    //**************
    
    if (_showDate) {
        self.title = _showDate;
        moment.showDate = _showDate;
        //[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSDate *date = [dateFormatter dateFromString:_showDate];
        moment.dateForCalendar = [dateFormatterForDateForCalendar stringFromDate:date];
        moment.date = [NSString stringWithFormat:@"%f",[date timeIntervalSince1970]];
    }else {
        self.title = [dateFormatter stringFromDate:[NSDate date]];
    }
    
    
    if (!_editMoment) {
        moment.tag = @"";
        moment.starred = @"0";
        
        if (!_showDate) {
            moment.date = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
            moment.showDate = [dateFormatter stringFromDate:[NSDate date]];
            moment.dateForCalendar = [dateFormatterForDateForCalendar stringFromDate:[NSDate date]];
            //add end
            
        }
        moment.mid = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
        
    }else {
        
        //start
        moment.tag = _editMoment.tag;
        //end
        moment.date = _editMoment.date;
        moment.showDate = _editMoment.showDate;
        
        moment.dateForCalendar = _editMoment.dateForCalendar;
        
        moment.mid = _editMoment.mid;
        moment.emoticon = _editMoment.emoticon;
        moment.location = _editMoment.location;
        moment.starred = _editMoment.starred;
    }
    
    
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    //textView = [[UITextView alloc] initWithFrame:CGRectMake(5, 34, 310, SCREEN_HEIGHT-76-216-TOOL_HEIGHT)];
    
    textView = [[UITextView alloc] initWithFrame:CGRectMake(5, 38, 310, 100)];
    //new start for enable the right button
    textView.delegate = self;
    //new end for enable the right button
    
    textView.font = [UIFont systemFontOfSize:16];
    [textView becomeFirstResponder];
    [self.contentView addSubview:textView];
    [self addbackButtonWithTitle:@"Cancel"];
    [self addRightButtonWithTitle:@"Done"];
    
    
    //add for emoticon
    
    tempForEmoticon = moment.emoticon;
    
    sg = [[SGSelectViewController alloc]init];
    [self.contentView addSubview:sg.view];
    sg.delegate = self;
    
    selectBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    [selectBtn setFrame:CGRectMake(285, 2, 30, 30)];
    
    NSLog(@"reach mark 4");
    
    // 设置表情选择按钮的初始图片
    NSString *initiaEmoticonName = @"emoticonDefault.png";
    if (![tempForEmoticon isEqualToString:@""])
    {
        initiaEmoticonName = tempForEmoticon;
    }
    
    
    [selectBtn setBackgroundImage:[UIImage imageNamed:initiaEmoticonName] forState:UIControlStateNormal];
    [selectBtn addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:selectBtn];
    
    //还原emoticon的值
    moment.emoticon = tempForEmoticon;
    //end for emoticon
    
    toolBar = [[STWriteToolBar alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-216-TOOL_HEIGHT-64, 320, TOOL_HEIGHT)];
    toolBar.delegate = self;
    [self.contentView addSubview:toolBar];
    
    
    //add start for tag
    UIImageView *tagImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 20, 20)];
    tagImage.image = [UIImage imageNamed:@"tagForWriteView"];
    [self.contentView addSubview:tagImage];
    
    UIImageView *tagLine = [[UIImageView alloc] initWithFrame:CGRectMake(5, 35, 310, 1)];
    tagLine.backgroundColor = [UIColor colorWithHexString:@"b6c8d1"];
    [self.contentView addSubview:tagLine];
    NSLog(@"reach mark 5");
    
    NSMutableArray *tags = [[NSMutableArray alloc] init];
    if(!moment.tag || [moment.tag isEqualToString:@""]){
        NSLog(@"equal to nil");
        //tags = @[];
    }
    else{
        NSLog(@"have value");
        NSString *tempMomentTag = moment.tag;
        //tags = @[tempDiaryTag];
        [tags addObject:tempMomentTag];
    }
    
    NSLog(@"reach mark 5.5");
    
    tagView = [[LZTagView alloc] initWithFrame:CGRectMake(33, 4, 250, TOOL_HEIGHT)];
    for( NSString *tag in tags )
    {
        LZTag *lzt = [[LZTag alloc] initWithTag:tag];
        [tagView.tags addObject:lzt];
    }
    
    NSArray *suggestedTags = @[@"Study", @"Workout", @"Shopping", @"Food", @"Travel", @"Interview", @"Party", @"Homework", @"Date",@"Game"];
    for( NSString *tag in suggestedTags )
    {
        LZTag *lzt = [[LZTag alloc] initWithTag:tag];
        [tagView.suggestedTags addObject:lzt];
    }
    [self.contentView addSubview:tagView];
    //add end
    
    NSLog(@"reach mark 6");
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    if (_editMoment) {
        moment = _editMoment;
        if ([_editMoment.type intValue] !=0 && _editMoment.imagePath) {
            savePhoto = [UIImage imageWithContentsOfFile:_editMoment.imagePath];
            [toolBar.photoButton setImage:nil forState:UIControlStateNormal];
            [toolBar.photoButton setImage:nil forState:UIControlStateHighlighted];
            [toolBar.photoButton setImageEdgeInsets:UIEdgeInsetsMake(1, 14, 0, 14)];
            [toolBar.photoButton setImage:savePhoto forState:UIControlStateNormal];
        }
        //add for toolbar initial color for location and star
        if(_editMoment.location && ![_editMoment.location isEqualToString:@""]){
            [toolBar.locationButton setImage:[UIImage imageNamed:@"add_location_highlighted"] forState:UIControlStateNormal];
            locationAdded = TRUE;
        }
        if(_editMoment.starred && [_editMoment.starred isEqualToString:@"1"]){
            [toolBar.starButton setImage:[UIImage imageNamed:@"starred"] forState:UIControlStateNormal];
        }
        
        //add end for toolbar initial color for location and star
        
        textView.text = _editMoment.content;
        self.title = _editMoment.showDate;
    }
    
    NSLog(@"reach mark 7");
    
    //new add for control the right button to enable or not
    if([textView.text isEqualToString:@""] && !savePhoto){
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    else{
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
    //new end
    shareCircleView = [[CFShareCircleView alloc] initWithFrame:self.contentView.frame];
    shareCircleView.delegate = self;
    [self.contentView addSubview:shareCircleView];
    locationAdded = FALSE;
    
    NSLog(@"reach the end of viewDidload");
    
}

// add to implement the delegate required by shareButton
- (void)shareCircleView:(CFShareCircleView *)aShareCircleView didSelectSharer:(CFSharer *)sharer {
    //[textView becomeFirstResponder];
    NSLog(@"Selected sharer: %@", sharer.name);
    
    //********************************************
    if([sharer.name isEqualToString:@"Facebook"])
    {
        //分享到facebook
        
        if ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=6) {
            //  if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
            //{
            slComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            [slComposerSheet setInitialText:textView.text];
            [slComposerSheet addImage:savePhoto];
            
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
            [tweetViewController setInitialText:textView.text];
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
            [slComposerSheet setInitialText:textView.text];
            [slComposerSheet addImage:savePhoto];
            
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
    //[textView becomeFirstResponder];
    if([sharer.name isEqualToString:@"Weibo"]){
        
        if ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=6) {
            slComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
            [slComposerSheet setInitialText:textView.text];
            [slComposerSheet addImage:savePhoto];
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
    
    //**********************************************
}

- (void)shareCircleDisappear:(id)sender{
    //[textView becomeFirstResponder];
}
//add end

//new add for emoticon
-(void)tap:(id)sender{
    
    [sg sgViewAppear];
    //[textView endEditing:YES];
}

-(void)oneEmoticonPressed:(NSDictionary *)tmpDic{
    NSString *imageName = [tmpDic objectForKey:@"icon"];
    if([imageName isEqualToString:@"emoticonDefault.png"])
    {
        if(tempForEmoticon)
        {
            if (![tempForEmoticon isEqualToString:@"emoticonDefault.png"])
            {
                imageName = tempForEmoticon;
            }
        }
    }
    [selectBtn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [textView becomeFirstResponder];
    moment.emoticon = imageName;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [sg sgViewDissAppear];
    [toolBar setHidden:NO];
    //[self.contentView addSubview:toolBar];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    [toolBar setHidden:YES];
    //[toolBar removeFromSuperview];
}

//new end for emoticon

//new start for enable the right button
-(void)textViewDidChange:(UITextView *)textView1
{
    NSString *textTrimmed = [textView1.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if([textTrimmed isEqual:@""] && !savePhoto){
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    else{
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
}
//new end


//  set the textView
//  设置textview中的文字，既返回的识别结果
- (void)onUpdateTextView:(NSString *)sentence
{
	textView.text = [textView.text stringByAppendingString:sentence];
}

- (void)onRecognizeResult:(NSArray *)array
{
    //  execute the onUpdateTextView function in main thread
    //  在主线程中执行onUpdateTextView方法
	[self performSelectorOnMainThread:@selector(onUpdateTextView:) withObject:
	 [[array objectAtIndex:0] objectForKey:@"NAME"] waitUntilDone:YES];
}


- (void)keyboardWillShow:(NSNotification *)notification
{
    static CGFloat normalKeyboardHeight = 216.0f;
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    CGFloat distanceToMove = kbSize.height - normalKeyboardHeight;
    NSLog(@"%f", distanceToMove);
    [self animateView:distanceToMove];
    
}

- (void)animateView:(CGFloat)tag
{
    CGRect rect = toolBar.frame;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    rect.origin.y = SCREEN_HEIGHT - 216 -tag-TOOL_HEIGHT-64;
    toolBar.frame = rect;
    rect = textView.frame;
    //rect.size.height = SCREEN_HEIGHT-64-216-2*TOOL_HEIGHT-tag-4
    rect.size.height = SCREEN_HEIGHT-64-216-2*TOOL_HEIGHT-4;
    textView.frame = rect;
    [UIView commitAnimations];
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    // checkinLocation = newLocation;
    //do something else
    moment.location = [NSString stringWithFormat: @"%@ %@",
                      [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude],
                      [NSString stringWithFormat:@"%f", newLocation.coordinate.longitude]];
    [locationManager stopUpdatingLocation];
}

//寻址失败时调用
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
    [locationManager stopUpdatingLocation];
}

-(void)barItemTapedAtIndex:(int)index
{
    switch (index) {
        case 0:{
            
            if (locationAdded)
            {
                locationManager = nil;
                locationManager.delegate = nil;
                moment.location = nil;
                [toolBar.locationButton setImage:[UIImage imageNamed:@"add_location"]forState:UIControlStateNormal];
                locationAdded = FALSE;
            }
            else
            {
                locationManager = [[CLLocationManager alloc]init];
                locationManager.delegate = self;
                locationManager.desiredAccuracy = kCLLocationAccuracyBest;
                locationManager.distanceFilter = 5.0;
                [locationManager startUpdatingLocation];
                
                [toolBar.locationButton setImage:[UIImage imageNamed:@"add_location_highlighted"]forState:UIControlStateNormal];
                
                //[locationManager stopUpdatingLocation];
                NSLog(@"ahahaha");
                locationAdded = TRUE;
            }
            
            break;
        }
        case 1:{
            if (savePhoto) {
                UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Delete Photo" otherButtonTitles:nil, nil];
                actionSheet.tag = DELETE_PHOTO;
                [actionSheet showInView:self.view];
            }else {
                UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera",@"Photo Library", nil];
                actionSheet.tag = SHOW_PHOTO;
                [actionSheet showInView:self.view];
            }
            break;
        }
        case 2:{
            [self pickDate:nil];
            
            break;
        }
        case 3:{
            if ([moment.starred isEqualToString:@"0"])
            {
                NSLog(@"become starred");
                moment.starred = @"1";
                [toolBar.starButton setImage:[UIImage imageNamed:@"starred"]forState:UIControlStateNormal];
            }
            else if ([moment.starred isEqualToString:@"1"])
            {
                NSLog(@"become unstarred");
                moment.starred = @"0";
                [toolBar.starButton setImage:[UIImage imageNamed:@"star"]forState:UIControlStateNormal];
            }
            break;
        }
        case 4:{
            [textView endEditing:YES];
            [shareCircleView animateIn];
            break;
        }
        default:
            break;
    }
}

-(UIButton*)addLeftCancelButton{
    return [self addleftButtonWithTitle:[NSArray arrayWithObjects:[UIImage imageNamed:@"xbutton.png"], [UIImage imageNamed:@"xbutton.png"], nil]];
    
}

-(UIButton*)styleButton{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *normal = [[UIImage imageNamed:@"right_button_bg_normal"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
    UIImage *highlight = [[UIImage imageNamed:@"right_button_bg_highlight"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
    button.frame = CGRectMake(0, 0, normal.size.width, normal.size.height);
    [button setBackgroundImage:normal forState:UIControlStateNormal];
    [button setBackgroundImage:highlight forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    //[button setTitleColor:[UIColor colorWithHexString:@"#595959"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:@"#848484"] forState:UIControlStateNormal];
    [self.headBar addSubview:button];
    [button setImageEdgeInsets:UIEdgeInsetsMake(1, 0, 0, 0)];
    return button;
    
}

-(UIButton*)addleftButtonWithTitle:(id)title{
    
    UIButton *button = [self styleButton];
    [button addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    if ([title isKindOfClass:[NSString class]]) {
        [button setTitle:title forState:UIControlStateNormal];
        button.frame = CGRectMake(10, 7, 50, 30);
    }
    else if ([title isKindOfClass:[NSArray class]]){
        [button setImage:[title objectAtIndex:0] forState:UIControlStateNormal];
        [button setImage:[title objectAtIndex:1] forState:UIControlStateHighlighted];
        button.frame = CGRectMake(10, 7, 50, 30);
    }
    
    return button;
}

-(UIButton*)addrightButtonWithTitle:(id)title{
    
    UIButton *button = [self styleButton];
    [button addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    if ([title isKindOfClass:[NSString class]]) {
        [button setTitle:title forState:UIControlStateNormal];
        button.frame = CGRectMake(320-60, 7, 50, 30);
    }
    else if ([title isKindOfClass:[NSArray class]]){
        [button setImage:[title objectAtIndex:0] forState:UIControlStateNormal];
        [button setImage:[title objectAtIndex:1] forState:UIControlStateHighlighted];
        button.frame = CGRectMake(0, 0, 55, 43);
    }
    
    return button;
}

-(void)dateCancel:(id)sender{
    hasDate = NO;
    [_dateSheet dismissWithClickedButtonIndex:0 animated:YES];
}

-(void)dateOK:(id)sender{
    //[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    moment.showDate = [dateFormatter stringFromDate:_datePicker.date];
    
    // add for dateForCalendar
    //[dateFormatterForDateForCalendar setDateFormat:@"yyyy-M-d"];
    moment.dateForCalendar = [dateFormatterForDateForCalendar stringFromDate:_datePicker.date];
    // add end
    
    self.title = moment.showDate;
    moment.date = [NSString stringWithFormat:@"%f",[_datePicker.date timeIntervalSince1970]];
    [_dateSheet dismissWithClickedButtonIndex:0 animated:YES];
}

-(void)dateChange:(id)sender{
    
}

-(void)pickDate:(id)sender{
    hasDate = YES;
    self.dateSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"hello" destructiveButtonTitle:@"hello" otherButtonTitles:@"hello", @"hello", nil];
    
    UIImageView *white = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    white.image = [UIImage imageNamed:@"nav_bar"];
    white.contentMode = UIViewContentModeTop;
    white.clipsToBounds = YES;
    white.userInteractionEnabled = YES;
    [_dateSheet addSubview:white];
    
    UIButton *dateCancelButton = [self addleftButtonWithTitle:@"Cancel"];
    [white addSubview:dateCancelButton];
    [dateCancelButton removeTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [dateCancelButton addTarget:self action:@selector(dateCancel:) forControlEvents:UIControlEventTouchUpInside];
    dateCancelButton.center = CGPointMake(dateCancelButton.center.x, dateCancelButton.center.y+3);
    
    UIButton *sendButton = [self addrightButtonWithTitle:@"Done"];
    UIButton *dateOKButton = sendButton;
    [white addSubview:dateOKButton];
    [dateOKButton removeTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [dateOKButton addTarget:self action:@selector(dateOK:) forControlEvents:UIControlEventTouchUpInside];
    dateOKButton.center = CGPointMake(dateOKButton.center.x, dateOKButton.center.y+3);
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    
    lable.font = [UIFont boldSystemFontOfSize:20];
    
    lable.backgroundColor = [UIColor clearColor];
    lable.center = CGPointMake(160, 25);
    //lable.shadowColor = [UIColor grayColor];
    lable.textColor = [UIColor colorWithHexString:@"#848484"];
    //lable.shadowOffset = CGSizeMake(0, 1);
    [white addSubview:lable];
    lable.text = @"Pick Time";
    
    self.datePicker = [[UIDatePicker alloc] initWithFrame:_dateSheet.bounds];
    CGRect datePickerFrame = _datePicker.frame;
    datePickerFrame.origin.y = 44;
    _datePicker.frame = datePickerFrame;
    _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    [_datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    [_dateSheet addSubview:_datePicker];
    
    [_dateSheet showInView:self.view];
    
    
    
}

-(void)goBack:(id)sender
{
    if (savePhoto || [textView.text length]>0) {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Don't save" otherButtonTitles:@"Save", nil];
        sheet.tag = SHOW_SAVE;
        [sheet showInView:self.view];
    }else {
        [self dismissModalViewControllerAnimated:YES];
    }
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == SHOW_PHOTO) {
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
        
    }else if (actionSheet.tag == SHOW_SAVE) {
        if (buttonIndex == 0) {
            [self dismissModalViewControllerAnimated:YES];
        }else if (buttonIndex == 1){
            [self rightButtonClick:nil];
        }
    }else if (actionSheet.tag == DELETE_PHOTO) {
        if (buttonIndex == 0) {
            _photo = nil;
            savePhoto = nil;
            //add to disable the right button
            if([textView.text isEqualToString:@""]){
                self.navigationItem.rightBarButtonItem.enabled = NO;
            }
            //add end
            moment.imagePath = nil;
            moment.type = @"0";
            
            if (_editMoment) {
                [[STImageSaver shareImageSaver] deleteImage:_editMoment.imagePath];
                _editMoment.imagePath = nil;
                _editMoment.type = @"0";
            }
            
            [toolBar resetPhotoButton];
        }
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[picker dismissModalViewControllerAnimated:YES];
	savePhoto = [info objectForKey:UIImagePickerControllerEditedImage];
    //add for enable the right button
    self.navigationItem.rightBarButtonItem.enabled = YES;
    //add end
    [toolBar.photoButton setImage:nil forState:UIControlStateNormal];
    [toolBar.photoButton setImage:nil forState:UIControlStateHighlighted];
    [toolBar.photoButton setImageEdgeInsets:UIEdgeInsetsMake(1, 14, 0, 14)];
    [toolBar.photoButton setImage:savePhoto forState:UIControlStateNormal];
    
    NSData *imageData = UIImageJPEGRepresentation(savePhoto, 0.8f);
    UIImage *photo = [UIImage imageWithData:imageData];
    moment.imagePath = [[STImageSaver shareImageSaver] saveImage:photo];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self dismissModalViewControllerAnimated:YES];
}

-(void)rightButtonClick:(id)sender
{
    if ([textView.text length] > 0 || savePhoto) {
        moment.content = textView.text;
        
        if (savePhoto) {
        }else {
            moment.imagePath = nil;
        }
        
        moment.weather = @"";
        
        //cast to LZTag, get the property Title as the NSString!
        NSString *lastTag = ((LZTag*)[tagView.tags lastObject]).title;
        
        moment.tag = lastTag;
        
        //new add for hasTag
        if(moment.tag)
        {
            NSLog(@"hastag = 1");
            moment.hasTag = @"1";
        }
        else
        {
            NSLog(@"hastag = 0");
            moment.hasTag = @"0";
        }
        
        //new end
        
        if ([moment.content length] && moment.imagePath) {
            moment.type = @"1";
        }else if ([moment.content length]) {
            moment.type = @"0";
        }else if (moment.imagePath) {
            moment.type = @"1";
        }else {
            return;
        }

        if (_editMoment) {
            [[DataFactory shardDataFactory]updateToDB:moment Classtype:momentClass];
        }else {
            [[DataFactory shardDataFactory]insertToDB:moment Classtype:momentClass];
        }
    }
    
    // add to refresh to timeline top
    [_delegate reloadDiary:moment];
    if(!_editMoment)
    {
        [_delegate refreshToTop];
    }
    
    [self dismissModalViewControllerAnimated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillShowNotification];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
