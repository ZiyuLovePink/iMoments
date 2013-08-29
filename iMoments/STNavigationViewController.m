//
//  STNavigationViewController.m
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

#import "STNavigationViewController.h"

@interface STNavigationViewController ()

@end

@implementation STNavigationViewController

@synthesize titleLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(BOOL)shouldAutorotate{
    
    return NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    
    UIImageView *back = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 320, SCREEN_HEIGHT-20)];
    //back.image = [[UIImage imageNamed:@"background.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(100, 50, 100, 50)];
    back.backgroundColor = [UIColor colorWithHexString:@"#628dc2"];
    [self.view insertSubview:back atIndex:0];
    [self setNavigationBarHidden:NO];
    
    if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bar"] forBarMetrics:UIBarMetricsDefault];
        self.navigationBar.layer.cornerRadius = 4.0f;
    }
    NSDictionary *textTitleOptions = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"#848484"], UITextAttributeTextColor, [UIColor whiteColor], UITextAttributeTextShadowColor, nil];
    [[UINavigationBar appearance] setTitleTextAttributes:textTitleOptions];
    
    //[self.navigationBar setBackgroundColor:[UIColor colorWithHexString:@"#628dc2"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
