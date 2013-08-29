//
//  STBaseViewController.m
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

#import "STBaseViewController.h"

@interface STBaseViewController ()

@end

@implementation STBaseViewController

//@synthesize titleLabel;

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
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    self.view.backgroundColor = [UIColor whiteColor];
    //UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    //[self.view addGestureRecognizer:swipe];
    
    //    _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    //    _navView.backgroundColor = [UIColor clearColor];
    //    [self.view addSubview:_navView];
    
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, SCREEN_HEIGHT)];
    _contentView.userInteractionEnabled = YES;
    [self.view addSubview:_contentView];
    
    self.headBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [self.view insertSubview:_headBar atIndex:0];
    
    //    if (!self.titleLabel) {
    //        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    //        titleLabel.textAlignment = NSTextAlignmentCenter;
    //        titleLabel.textColor = [UIColor colorWithHexString:@"848484"];
    //
    //        titleLabel.font = [UIFont boldSystemFontOfSize:20];
    //
    //        titleLabel.backgroundColor = [UIColor clearColor];
    //        titleLabel.center = CGPointMake(160, 22);
    //        titleLabel.shadowColor = [UIColor whiteColor];
    //        titleLabel.shadowOffset = CGSizeMake(0, 1);
    //        for (id view in self.navigationController.navigationBar.subviews) {
    //            if ([view isKindOfClass:[UILabel class]]) {
    //                [view removeFromSuperview];
    //            }
    //
    //        }
    //        [self.navigationController.navigationBar addSubview:titleLabel];
    //    }
    
}



-(void)swipe:(id)sender
{
    if ([self.navigationController performSelector:@selector(popViewControllerAnimated:)]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
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

-(UIButton*)addRightButtonWithTitle:(id)title{
    
    UIButton *button = [self styleButton];
    [button addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    if ([title isKindOfClass:[NSString class]]) {
        [button setTitle:title forState:UIControlStateNormal];
        button.frame = CGRectMake(320-60, 7, 50, 30);
        
    }
    else if ([title isKindOfClass:[NSArray class]]){
        [button setImage:[title objectAtIndex:0] forState:UIControlStateNormal];
        [button setImage:[title objectAtIndex:0] forState:UIControlStateHighlighted];
        [button setImageEdgeInsets:UIEdgeInsetsMake(2, 12, 3, 10)];
        button.frame = CGRectMake(320-55, 7, 50, 30);
    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return button;
    
}

-(UIButton*)addRightButtonWithTitle:(id)title AndImage:(BOOL) image{
    
    UIButton *button = [self styleButton];
    [button addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    if ([title isKindOfClass:[NSString class]]) {
        [button setTitle:title forState:UIControlStateNormal];
        button.frame = CGRectMake(320-60, 7, 50, 30);
        
    }
    else if ([title isKindOfClass:[NSArray class]]){
        [button setImage:[title objectAtIndex:0] forState:UIControlStateNormal];
        [button setImage:[title objectAtIndex:0] forState:UIControlStateHighlighted];
        [button setImageEdgeInsets:UIEdgeInsetsMake(2, 12, 3, 10)];
        button.frame = CGRectMake(320-55, 7, 50, 30);
    }
    if(image){
        UIImage * add = [UIImage imageNamed:@"add"];
        [button setImageEdgeInsets:UIEdgeInsetsMake(5, 16, 5, 14)];
        [button setImage:add forState:UIControlStateNormal];
    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    return button;
    
}



-(IBAction)goBack:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
