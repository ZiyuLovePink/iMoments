//
//  UIView+Positioning.h
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Positioning)

- (void) setOrigin:(float)x :(float)y;

- (void) resetOriginToTopLeft;
- (void) resetOriginToTopRight;

@end
