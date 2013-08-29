//
//  STWriteViewController.h
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

#import "Moment.h"
#import <CoreLocation/CoreLocation.h>
@protocol WriteDiaryDelegate <NSObject>

@optional
-(void)reloadDiary:(Moment *)moment;
-(void)refreshToTop;

@end


#import "STBaseViewController.h"
#import "STWriteToolBar.h"

#import <UIKit/UIKit.h>
#import "LZTagView.h"
#import "SGSelectViewController.h"

#import "CFShareCircleView.h"

#import "LZTag.h"

#import <Twitter/Twitter.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface STWriteViewController : STBaseViewController<UIActionSheetDelegate,STWriteToolBarDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDelegate, UITextViewDelegate,SGSelectViewControllerDelegate, CFShareCircleViewDelegate, CLLocationManagerDelegate>
{
    UITextView *textView;
    STWriteToolBar *toolBar;
    Moment *moment;
    LZTagView *tagView;
    
    CFShareCircleView *shareCircleView;
}
@property(nonatomic,strong)UIImage *photo;
@property(nonatomic, strong) UIDatePicker *datePicker;
@property(nonatomic,strong)Moment *editMoment;
@property(nonatomic,strong)NSString *showDate;
@property(nonatomic,weak)id<WriteDiaryDelegate>delegate;
@property (nonatomic, strong) UIActionSheet *dateSheet;
//
//@property(nonatomic,strong)LZTagView *tagView;
@end
