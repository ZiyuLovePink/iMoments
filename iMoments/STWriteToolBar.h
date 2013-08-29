//
//  STWriteToolBar.h
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

@protocol STWriteToolBarDelegate <NSObject>

@optional
-(void)barItemTapedAtIndex:(int)index;

@end

#import "STBaseView.h"

@interface STWriteToolBar : STBaseView

@property(nonatomic,strong)UIButton *photoButton,*calendarButton, *locationButton, *starButton;
@property(nonatomic,assign)id<STWriteToolBarDelegate>delegate;

-(void)resetPhotoButton;
@end
