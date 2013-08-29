//
//  STBaseImageView.m
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

#import "STBaseImageView.h"
#import "STPictureViewer.h"

@implementation STBaseImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
        //        zoomingViewController = [[ZoomingViewController alloc] init];
        //        zoomingViewController.view = self;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pictureTapped:)];
        [self addGestureRecognizer:singleTap];
        
    }
    return self;
}


-(void)pictureTapped:(UITapGestureRecognizer*)gesture{
    
    STPictureViewer *viewer = [STPictureViewer pictureViewerForView:[gesture view]];
    [viewer showPictureForImage:self.image];
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end

