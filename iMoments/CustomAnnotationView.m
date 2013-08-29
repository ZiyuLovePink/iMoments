//
//  CustomAnnotationView.m
//  CustomAnnotation
//
//  Created by akshay on 8/17/12.
//  Copyright (c) 2012 raw engineering, inc. All rights reserved.
//

#import "CustomAnnotationView.h"
#import "Annotation.h"

@implementation CustomAnnotationView

@synthesize calloutView;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];

    Annotation *ann = self.annotation;
    if(selected)
    {
        //Add your custom view to self...
        if ([ann.locationType isEqualToString:@"emoticonDefault.png"]) {
            calloutView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"emoticon0"]];
        }
        if ([ann.locationType isEqualToString:@"emoticon0.png"]) {
            calloutView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"emoticon0"]];
        }
        if ([ann.locationType isEqualToString:@"emoticon1.png"]) {
            calloutView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"emoticon1"]];
        }
        if ([ann.locationType isEqualToString:@"emoticon2.png"]) {
            calloutView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"emoticon2"]];
        }
        if ([ann.locationType isEqualToString:@"emoticon3.png"]) {
            calloutView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"emoticon3"]];
        }
        if ([ann.locationType isEqualToString:@"emoticon4.png"]) {
            calloutView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"emoticon4"]];
        }
        if ([ann.locationType isEqualToString:@"emoticon5.png"]) {
            calloutView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"emoticon5"]];
        }
        if ([ann.locationType isEqualToString:@"emoticon6.png"]) {
            calloutView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"emoticon6"]];
        }
        if ([ann.locationType isEqualToString:@"emoticon7.png"]) {
            calloutView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"emoticon7"]];
        }
        if ([ann.locationType isEqualToString:@"emoticon8.png"]) {
            calloutView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"emoticon8"]];
        }
        
        
        //calloutView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:ann.locationType]];

        [calloutView setFrame:CGRectMake(-6, -8, 25, 25)];
        //[calloutView sizeToFit];
        
        [self animateCalloutAppearance];
        [self addSubview:calloutView];
    }
    else
    {
        //Remove your custom view...
        [calloutView removeFromSuperview];
    }
}

- (void)didAddSubview:(UIView *)subview{
    Annotation *ann = self.annotation;
    if (![ann.locationType isEqualToString:@"dropped"]) {
        if ([[[subview class] description] isEqualToString:@"UICalloutView"]) {
            for (UIView *subsubView in subview.subviews) {
                if ([subsubView class] == [UIImageView class]) {
                    UIImageView *imageView = ((UIImageView *)subsubView);
                    [imageView removeFromSuperview];
                }else if ([subsubView class] == [UILabel class]) {
                    UILabel *labelView = ((UILabel *)subsubView);
                    [labelView removeFromSuperview];
                }
            }
        }
    }
}

- (void)animateCalloutAppearance {
    CGFloat scale = 0.001f;
    calloutView.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, -50);
    
    [UIView animateWithDuration:0.15 delay:0 options:(UIViewAnimationOptions)UIViewAnimationCurveEaseOut animations:^{
        CGFloat scale = 1.1f;
        calloutView.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 delay:0 options:(UIViewAnimationOptions)UIViewAnimationCurveEaseInOut animations:^{
            CGFloat scale = 0.95;
            calloutView.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, -2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.075 delay:0 options:(UIViewAnimationOptions)UIViewAnimationCurveEaseInOut animations:^{
                CGFloat scale = 1.0;
                calloutView.transform = CGAffineTransformMake(scale, 0.0f, 0.0f, scale, 0, 0);
            } completion:nil];
        }];
    }];
}

@end
