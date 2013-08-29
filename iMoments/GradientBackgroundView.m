//
//  GradientBackgroundView.m
//  TapZoomRotate
//
//  Created by Matt Gallagher on 2010/09/27.
//  Copyright 2010 Matt Gallagher. All rights reserved.
//
//  Permission is given to use this source code file, free of charge, in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#import "GradientBackgroundView.h"
#import <QuartzCore/QuartzCore.h>

@implementation GradientBackgroundView

- (void)didMoveToSuperview
{
	[super didMoveToSuperview];
	
	self.layer.shadowOpacity = 0.5;
	self.layer.shadowOffset = CGSizeMake(5, 5);
}

- (void)drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
    
	UIColor *contentColorTop = [UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1.0];
	UIColor *contentColorBottom = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
    
	CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
	CGFloat backgroundColorComponents[2][4];
	memcpy(
           backgroundColorComponents[0],
           CGColorGetComponents(contentColorTop.CGColor),
           sizeof(CGFloat) * 4);
	memcpy(
           backgroundColorComponents[1],
           CGColorGetComponents(contentColorBottom.CGColor),
           sizeof(CGFloat) * 4);
	
	const CGFloat endpointLocations[2] = {0.0, 1.0};
	CGGradientRef backgroundGradient =
    CGGradientCreateWithColorComponents(
                                        colorspace,
                                        (const CGFloat *)backgroundColorComponents,
                                        endpointLocations,
                                        2);
    
	CGContextDrawLinearGradient(
                                context,
                                backgroundGradient,
                                CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect)),
                                CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect)),
                                0);
	
	CFRelease(colorspace);
	CGGradientRelease(backgroundGradient);
}

@end
