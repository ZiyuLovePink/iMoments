//
//  UIScrollView+APParallaxHeader.h
//
//  Created by Mathias Amnell on 2013-04-12.
//  Copyright (c) 2013 Apping AB. All rights reserved.
//

@protocol APParallaxViewDelegate <NSObject>

@optional

-(void)scrollViewScroll;

@end

#import <UIKit/UIKit.h>

@class APParallaxView;
@class ShadowView;

@interface UIScrollView (APParallaxHeader)

- (APParallaxView *)addParallaxWithImage:(UIImage *)image andHeight:(CGFloat)height;


@property (nonatomic, strong, readonly) APParallaxView *parallaxView;
@property (nonatomic, assign) BOOL showsParallax;


@end

enum {
    APParallaxTrackingActive = 0,
    APParallaxTrackingInactive
};

typedef NSUInteger APParallaxTrackingState;

@interface APParallaxView : UIView

@property (nonatomic, readonly) APParallaxTrackingState state;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) ShadowView *shadowView;
@property (nonatomic,assign)id<APParallaxViewDelegate>appDelegate;

@end
