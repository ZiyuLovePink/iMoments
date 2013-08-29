//
//  UIView+Positioning.m
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

#import "UIView+Positioning.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (Positioning)

- (void) setOrigin:(float)x :(float)y
{
    self.layer.anchorPoint = CGPointMake(x, y);
}

- (void) resetOriginToTopLeft
{
    [self setOrigin:0 :0];
    [self setCenter:CGPointMake(0, 0)];
}

- (void) resetOriginToTopRight
{
    [self setOrigin:0 :0];
    [self setCenter:CGPointMake(0, 0)];
}

@end

