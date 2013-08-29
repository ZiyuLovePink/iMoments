//
//  STBaseViewController.h
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+HexString.h"
#import "STNavigationViewController.h"

@interface STBaseViewController : UIViewController
{
    BOOL hiddenBackButton;
}
@property (nonatomic, strong) UIView  *contentView;
@property (nonatomic, strong) UIView  *headBar;
@property (nonatomic, assign) UIButton *nkRightButton;
@property (nonatomic, assign) UIButton *nkLeftButton;
//@property (nonatomic, strong) UILabel *titleLabel;

-(IBAction)goBack:(id)sender;
//-(IBAction)rightButtonClick:(id)sender;
//-(IBAction)leftButtonClick:(id)sender;

-(UIButton*)addRightButtonWithTitle:(id)title;
//-(UIButton*)addleftButtonWithTitle:(id)title;
-(UIButton*)addbackButtonWithTitle:(id)title;
-(UIButton*)addRightButtonWithTitle:(id)title AndImage:(BOOL)image;

@end
