//
//  STRootViewController.h
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

#import "STBaseTableViewController.h"
#import "STMainTimeLineViewController.h"
#import "STPhotoViewController.h"
#import "STCalendarViewController.h"
#import "STDateShowViewController.h"
#import "STSettingViewController.h"
#import "STRootCell.h"
#import "UIScrollView+APParallaxHeader.h"

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"

#import "STTagSelectViewController.h"

#import "AKTabBarController.h"
#import "TagCloudViewController.h"
#import "MoodViewController.h"
#import "MapViewController.h"

@interface STRootViewController : STBaseTableViewController<APParallaxViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>

@end
