//
//  STPictureViewer.m
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

#import "STPictureViewer.h"

@implementation STPictureViewer
@synthesize imageView,myScrollView,startFrame;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        
        self.backgroundColor = [UIColor blackColor];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        [self addGestureRecognizer:tap];
        //[tap requireGestureRecognizerToFail:longPress];
        
        self.myScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.myScrollView.maximumZoomScale = 3.0;
        self.myScrollView.minimumZoomScale = 0.5;
        self.myScrollView.contentSize = self.bounds.size;
        self.myScrollView.delegate = self;
        [self addSubview:myScrollView];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)];
        [myScrollView addGestureRecognizer:longPress];
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent animated:YES];
    }
    return self;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    return self.imageView;
    
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    
    imageView.center = CGPointMake(MAX(imageView.frame.size.width/2, self.frame.size.width/2) , MAX(imageView.frame.size.height/2, self.frame.size.height/2));
    
}


#pragma mark Gesture


-(void)tapped:(UITapGestureRecognizer*)gesture{
    
    gesture.enabled = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:YES];
    
    [self addSubview:imageView];
    imageView.frame = [self convertRect:imageView.frame fromView:myScrollView];
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.3 animations:^{
            
            imageView.frame = startFrame;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                self.alpha = 0.0;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        }];
    }
    
}

#pragma mark Init

+(id)pictureViewerForView:(UIView*)view{
    
    
    UIImageView *imageView = (UIImageView*)view;
    
    if (!imageView.image) {
        return nil;
    }
    
    UIWindow *topWindow = [[[UIApplication sharedApplication] windows] lastObject];
    CGRect frameInWindow = [view convertRect:view.bounds toView:topWindow];
    
    CGSize imageSize = [[imageView image] size];
    
    if (imageSize.width/imageSize.height >= imageView.bounds.size.width/imageView.bounds.size.height) {
        
        frameInWindow.size.height = imageView.bounds.size.height;
        frameInWindow.size.width = imageSize.width/imageSize.height*imageView.bounds.size.height;
        frameInWindow.origin.x -= (frameInWindow.size.width-view.bounds.size.width)/2;
        
    }
    else {
        frameInWindow.size.width = imageView.bounds.size.width;
        frameInWindow.size.height = imageSize.height/imageSize.width*imageView.bounds.size.width;
        frameInWindow.origin.y -= (frameInWindow.size.height-view.bounds.size.height)/2;
    }
    
    STPictureViewer *viewer = [STPictureViewer pictureViewerWithFrame:frameInWindow];
    viewer.imageView.image = imageView.image;
    [topWindow addSubview:viewer];
    
    return viewer;
    
    
}

+(id)pictureViewerWithFrame:(CGRect)frame{
    
    CGRect boundFrame = [[UIScreen mainScreen] bounds];
    STPictureViewer *newViewer = [[STPictureViewer alloc] initWithFrame: boundFrame];
    
    newViewer.alpha = 0.0;
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    [newViewer addSubview:imageView];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    newViewer.imageView = imageView;
    newViewer.startFrame = frame;
    [newViewer.myScrollView addSubview:imageView];
    return newViewer;
    
}

-(void)showPictureForImage:(UIImage *)image{
    imageView.image = image;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            
            CGRect imageViewFrame = imageView.frame;
            CGSize imageSize = [[imageView image] size];
            if (imageSize.width/imageSize.height >= self.bounds.size.width/self.bounds.size.height) {
                imageViewFrame.size.width = self.bounds.size.width;
                imageViewFrame.size.height = imageSize.height/imageSize.width*self.bounds.size.width;
            }
            else {
                imageViewFrame.size.height = self.bounds.size.height;
                imageViewFrame.size.width = imageSize.width/imageSize.height*self.bounds.size.height;
            }
            
            imageView.bounds = imageViewFrame;
            imageView.center = self.center;
            
        } completion:^(BOOL finished) {
            
        }];
        
    }];
}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

-(void)longPressed:(UILongPressGestureRecognizer*)gesture{
    
    if (gesture.state == UIGestureRecognizerStateBegan && self.imageView.image !=nil) {
        
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存到相册", nil];
        [sheet showInView:self];
        
        
    }
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    if (buttonIndex!=actionSheet.cancelButtonIndex) {
        
        switch (buttonIndex) {
            case 0:
                
                UIImageWriteToSavedPhotosAlbum(self.imageView.image, nil, nil, nil);
                
                break;
                
            default:
                break;
        }
    }
    
    
    
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

