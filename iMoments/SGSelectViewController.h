//
//  SGSelectViewController.h
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol SGSelectViewControllerDelegate<NSObject>
@optional
-(void)oneEmoticonPressed:(NSDictionary *)tmpDic;
@end
@interface SGSelectViewController : UIViewController
@property(nonatomic ,strong)UIButton *selectBtn;
@property(nonatomic,weak) id<SGSelectViewControllerDelegate> delegate;
-(void)sgViewAppear;
-(void)sgViewDissAppear;

@end
