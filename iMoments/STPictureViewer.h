//
//  STPictureViewer.h
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STPictureViewer : UIView<UIScrollViewDelegate,UIActionSheetDelegate> {
    UIImageView *imageView;
    
    CGRect startFrame;
    
    UIScrollView *myScrollView;
}


@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic)CGRect startFrame;
@property(nonatomic,strong)UIScrollView *myScrollView;

+(id)pictureViewerWithFrame:(CGRect)frame;
+(id)pictureViewerForView:(UIView*)view;

-(void)showPictureForImage:(UIImage *)image;
@end
