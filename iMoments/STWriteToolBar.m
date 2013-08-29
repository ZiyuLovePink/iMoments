//
//  STWriteToolBar.m
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

#import "STWriteToolBar.h"

@implementation STWriteToolBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *topLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
        topLine.backgroundColor = [UIColor colorWithHexString:@"#999999"];
        [self addSubview:topLine];
        for (int i=0; i<5; i++) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i*64, 0, 64, 30)];
            btn.tag = 10000+i;
            [btn addTarget:self action:@selector(showItem:) forControlEvents:UIControlEventTouchUpInside];
            
            switch (i) {
                case 0: {
                    /*
                     [btn setImage:[UIImage imageNamed:@"add_Location"] forState:UIControlStateNormal];
                     [btn setImage:[UIImage imageNamed:@"add_Location_highlighted"] forState:UIControlStateHighlighted];
                     [btn setImageEdgeInsets:UIEdgeInsetsMake(5, 13, 0, 12)];
                     [self addSubview:btn];
                     break;
                     */
                    
                    _locationButton = [[UIButton alloc] initWithFrame:CGRectMake(i*64, 0, 64, 34)];
                    _locationButton.tag = 10000+i;
                    [_locationButton addTarget:self action:@selector(showItem:) forControlEvents:UIControlEventTouchUpInside];
                    [_locationButton setImage:[UIImage imageNamed:@"add_location"] forState:UIControlStateNormal];
                    [_locationButton setImage:[UIImage imageNamed:@"add_location_highlighted"] forState:UIControlStateHighlighted];
                    [_locationButton setImageEdgeInsets:UIEdgeInsetsMake(3, 13, 0, 12)];
                    [self addSubview:_locationButton];
                    break;
                }
                case 1: {
                    _photoButton = [[UIButton alloc] initWithFrame:CGRectMake(i*64, 0, 64, 34)];
                    _photoButton.tag = 10000+i;
                    [_photoButton addTarget:self action:@selector(showItem:) forControlEvents:UIControlEventTouchUpInside];
                    [_photoButton setImage:[UIImage imageNamed:@"icon_camera"] forState:UIControlStateNormal];
                    [_photoButton setImage:[UIImage imageNamed:@"icon_camera"] forState:UIControlStateHighlighted];
                    [_photoButton setImageEdgeInsets:UIEdgeInsetsMake(3, 13, 0, 12)];
                    [self addSubview:_photoButton];
                    break;
                }
                case 2: {
                    _calendarButton = [[UIButton alloc] initWithFrame:CGRectMake(i*64, 0, 64, 34)];
                    _calendarButton.tag = 10000+i;
                    [_calendarButton addTarget:self action:@selector(showItem:) forControlEvents:UIControlEventTouchUpInside];
                    
                    [_calendarButton setImage:[UIImage imageNamed:@"icon_calendar"] forState:UIControlStateNormal];
                    [_calendarButton setImage:[UIImage imageNamed:@"icon_calendar_highlighted"] forState:UIControlStateHighlighted];
                    [_calendarButton setImageEdgeInsets:UIEdgeInsetsMake(3, 13, 0, 12)];
                    [self addSubview:_calendarButton];
                    break;
                }
                case 3: {
                    _starButton = [[UIButton alloc] initWithFrame:CGRectMake(i*64, 0, 64, 34)];
                    _starButton.tag = 10000+i;
                    [_starButton addTarget:self action:@selector(showItem:) forControlEvents:UIControlEventTouchUpInside];
                    
                    [_starButton setImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
                    [_starButton setImage:[UIImage imageNamed:@"starred"] forState:UIControlStateHighlighted];
                    [_starButton setImageEdgeInsets:UIEdgeInsetsMake(5, 13, 0, 12)];
                    [self addSubview:_starButton];
                    break;
                }
                case 4: {
                    [btn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
                    [btn setImage:[UIImage imageNamed:@"shareAfterClick"] forState:UIControlStateHighlighted];
                    [btn setImageEdgeInsets:UIEdgeInsetsMake(5, 13, 0, 12)];
                    [self addSubview:btn];
                    break;
                }
                default:
                    break;
            }
            
            //UIImageView *sepLine = [[UIImageView alloc] initWithFrame:CGRectMake(80+i*80, 0, 0.5, 34)];
            //sepLine.backgroundColor = [UIColor colorWithHexString:@"#999999"];
            //[self addSubview:sepLine];
            
        }
        
    }
    return self;
}

-(void)resetPhotoButton
{
    [_photoButton setImage:[UIImage imageNamed:@"icon_camera"] forState:UIControlStateNormal];
    [_photoButton setImage:[UIImage imageNamed:@"icon_camera"] forState:UIControlStateHighlighted];
    [_photoButton setImageEdgeInsets:UIEdgeInsetsMake(3, 13, 0, 12)];
}

-(void)showItem:(id)sender
{
    UIButton *button = (UIButton *)sender;
    [_delegate barItemTapedAtIndex:button.tag-10000];
}
@end
