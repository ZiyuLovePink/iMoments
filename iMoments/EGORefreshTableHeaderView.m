//
//  EGORefreshTableHeaderView.m
//  Demo
//
//  Created by Devin Doty on 10/14/09October14.
//  Copyright 2009 enormego. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "EGORefreshTableHeaderView.h"
#import "UIColor+HexString.h"

//#define TEXT_COLOR              [UIColor colorWithRed:87.0 / 255.0 green:108.0 / 255.0 blue:137.0 / 255.0 alpha:1.0]

#define TEXT_COLOR              [UIColor whiteColor]

#define FLIP_ANIMATION_DURATION 0.18f


@interface EGORefreshTableHeaderView (Private)
- (void) setState:(EGOPullRefreshState)aState;
@end

@implementation EGORefreshTableHeaderView

@synthesize delegate = __delegate;

@synthesize headerStyle;


-(void)changeStyle:(EGORefreshTableHeaderStyle)style{
    
    
    
    self.headerStyle = style;
    
    switch (style) {
        case EGORefreshTableHeaderStyleTexturedBackgroud:{
            UIColor *textColor = TEXT_COLOR;
            
            
            UIImageView *background = [[UIImageView alloc] initWithFrame:self.bounds];
            background.contentMode = UIViewContentModeScaleAspectFill;
            [self insertSubview:background atIndex:0];
            background.image = [UIImage imageNamed:@"ego_back.png"];
            
            _lastUpdatedLabel.textColor = textColor;
            _statusLabel.textColor = textColor;
            _activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
            self.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
            _arrowImage.contents = (id)[UIImage imageNamed : @"whiteArrow.png"].CGImage;
        }
            break;
            
        case EGORefreshTableHeaderStyleCard:{
            UIColor *textColor = TEXT_COLOR;
            
            
            //UIImageView *background = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"tvCard.png"] resizeImageWithCapInsets:UIEdgeInsetsMake(40, 50, 41, 50)]];
            UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tvCard.png"]];
            UIEdgeInsets edgeInset = UIEdgeInsetsMake(40, 50, 41, 50);
            background.contentStretch = CGRectMake(edgeInset.left / background.image.size.width, edgeInset.top / background.image.size.height, (background.image.size.width - edgeInset.left-edgeInset.right)/background.image.size.width, (background.image.size.height - edgeInset.top-edgeInset.bottom)/background.image.size.height);
            //background.contentStretch = CGRectMake(0.5, 0.32, 0.1, 0.05);
            background.frame = CGRectMake(0, -100, self.bounds.size.width, self.bounds.size.height+100);
            //background.contentMode = UIViewContentModeScaleAspectFill;
            [self insertSubview:background atIndex:0];
            //background.image = [UIImage imageNamed:@"tvCard.png"];
            
            _lastUpdatedLabel.textColor = textColor;
            _statusLabel.textColor = [UIColor blackColor];
            _activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
            _arrowImage.contents = (id)[UIImage imageNamed : @"whiteArrow.png"].CGImage;
        }
            break;

        case EGORefreshTableHeaderStyleDefaultStyle:{
            UIColor *textColor = [UIColor colorWithRed:87.0 / 255.0 green:108.0 / 255.0 blue:137.0 / 255.0 alpha:1.0];
            
            _lastUpdatedLabel.textColor = textColor;
            _statusLabel.textColor = textColor;
            _activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
            self.backgroundColor = [UIColor clearColor];
            _arrowImage.contents = (id)[UIImage imageNamed : @"blueArrow.png"].CGImage;
        }
            break;
            
        case EGORefreshTableHeaderStyleZUO:{
            UIColor *textColor = [UIColor colorWithHexString:@"#889097"];
            
            _lastUpdatedLabel.hidden = YES;
            _statusLabel.textColor = textColor;
            _statusLabel.frame = CGRectMake(137, self.frame.size.height-34, 115, 16);
            _statusLabel.font = [UIFont boldSystemFontOfSize:14];
            _statusLabel.textAlignment = UITextAlignmentLeft;
            _activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
            _activityView.center = CGPointMake(120, self.frame.size.height-26);
            self.backgroundColor = [UIColor clearColor];
            _arrowImage.frame = CGRectMake(109.0f, self.frame.size.height - 34.0f, 18.0f, 15.0f);
            _arrowImage.contents = (id)[UIImage imageNamed : @"ego_arrow.png"].CGImage;
        }
            break;
        case EGORefreshTableHeaderStyleZUOLineDetail:{
            UIColor *textColor = [UIColor whiteColor];
            
            _lastUpdatedLabel.hidden = YES;
            _statusLabel.textColor = textColor;
            _statusLabel.frame = CGRectMake(137, self.frame.size.height-34, 115, 16);
            _statusLabel.font = [UIFont boldSystemFontOfSize:14];
            _statusLabel.textAlignment = UITextAlignmentLeft;
            _activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
            _activityView.center = CGPointMake(120, self.frame.size.height-26);
            self.backgroundColor = [UIColor clearColor];
            _arrowImage.frame = CGRectMake(109.0f, self.frame.size.height - 34.0f, 18.0f, 15.0f);
            _arrowImage.contents = (id)[UIImage imageNamed : @"ego_arrow_white.png"].CGImage;
        }
            break;
        case EGORefreshTableHeaderStyleZUOLineDetailWithShadow:{
            UIColor *textColor = [UIColor whiteColor];
            
            _lastUpdatedLabel.hidden = YES;
            _statusLabel.textColor = textColor;
            _statusLabel.shadowColor = [UIColor darkGrayColor];
            _statusLabel.shadowOffset = CGSizeMake(0, 1);
            _statusLabel.frame = CGRectMake(137, self.frame.size.height-34, 115, 16);
            _statusLabel.font = [UIFont boldSystemFontOfSize:14];
            _statusLabel.textAlignment = UITextAlignmentLeft;
            _activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
            _activityView.center = CGPointMake(120, self.frame.size.height-26);
            self.backgroundColor = [UIColor clearColor];
            _arrowImage.frame = CGRectMake(109.0f, self.frame.size.height - 34.0f, 18.0f, 15.0f);
            _arrowImage.contents = (id)[UIImage imageNamed : @"ego_arrow_white.png"].CGImage;
        }
            break;
            
        case EGORefreshTableHeaderStyleZUOLeft:{
            UIColor *textColor = [UIColor colorWithHexString:@"#889097"];
            
            CGFloat moveX = 15;
            
            _lastUpdatedLabel.hidden = YES;
            _statusLabel.textColor = textColor;
            _statusLabel.frame = CGRectMake(137 - moveX, self.frame.size.height-34, 115, 16);
            _statusLabel.font = [UIFont boldSystemFontOfSize:14];
            _statusLabel.textAlignment = UITextAlignmentLeft;
            _activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
            _activityView.center = CGPointMake(120 - moveX, self.frame.size.height-26);
            self.backgroundColor = [UIColor clearColor];
            _arrowImage.frame = CGRectMake(109.0f - moveX, self.frame.size.height - 34.0f, 18.0f, 15.0f);
            _arrowImage.contents = (id)[UIImage imageNamed : @"ego_arrow.png"].CGImage;
        }
            break;
        default:{
            UIColor *textColor = [UIColor colorWithRed:87.0 / 255.0 green:108.0 / 255.0 blue:137.0 / 255.0 alpha:1.0];
            
            _lastUpdatedLabel.textColor = textColor;
            _statusLabel.textColor = textColor;
            _activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
            self.backgroundColor = [UIColor clearColor];
            _arrowImage.contents = (id)[UIImage imageNamed : @"blueArrow.png"].CGImage;
        }
            
            
            break;
    }
    
    
    
    
    
}


- (id) initWithFrame:(CGRect)frame andHeaderStyle:(EGORefreshTableHeaderStyle)style {

    if (self = [super initWithFrame:frame]) {

        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        // self.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:1.0];

        //self.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];

        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 30.0f, self.frame.size.width, 20.0f)];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        label.font = [UIFont systemFontOfSize:12.0f];
        label.textColor = TEXT_COLOR;
        //label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
        //label.shadowOffset = CGSizeMake(0.0f, 1.0f);
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;
        [self addSubview:label];
        _lastUpdatedLabel = label;

        label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, frame.size.height - 48.0f, self.frame.size.width, 20.0f)];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        label.font = [UIFont boldSystemFontOfSize:13.0f];
        label.textColor = TEXT_COLOR;
        //label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
        //label.shadowOffset = CGSizeMake(0.0f, 1.0f);
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;
        [self addSubview:label];
        _statusLabel = label;

        CALayer * layer = [CALayer layer];
        layer.frame = CGRectMake(25.0f, frame.size.height - 65.0f, 30.0f, 55.0f);
        layer.contentsGravity = kCAGravityResizeAspect;
        layer.contents = (id)[UIImage imageNamed : @"whiteArrow.png"].CGImage;

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
            layer.contentsScale = [[UIScreen mainScreen] scale];
        }
#endif

        [[self layer] addSublayer:layer];
        _arrowImage = layer;

        UIActivityIndicatorView * view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        view.frame = CGRectMake(25.0f, frame.size.height - 38.0f, 20.0f, 20.0f);
        [self addSubview:view];
        _activityView = view;


        [self setState:EGOOPullRefreshNormal];

        [self changeStyle:style];
    }

    return self;
} /* initWithFrame */

- (id) initWithFrame:(CGRect)frame {

    return [self initWithFrame:frame andHeaderStyle:EGORefreshTableHeaderStyleRoom];
}


#pragma mark -
#pragma mark Setters

- (void) refreshLastUpdatedDate {

    if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceLastUpdated:)]) {

        NSDate * date = [_delegate egoRefreshTableHeaderDataSourceLastUpdated:self];

        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        // [formatter setAMSymbol:@"AM"];
        // [formatter setPMSymbol:@"PM"];
        [formatter setDateFormat:@"MM/dd/yyyy hh:mm:ss"];
        _lastUpdatedLabel.text = [NSString stringWithFormat:@"%@: %@", NSLocalizedString(@"Last Updated...", @"Last Update time"), [formatter stringFromDate:date]];
    } else {

        _lastUpdatedLabel.text = nil;
    }
}

- (void) setState:(EGOPullRefreshState)aState {

    switch (aState) {
        case EGOOPullRefreshPulling:

            _statusLabel.text = NSLocalizedString(@"Release to refresh...", @"Release to refresh status");
            [CATransaction begin];
            [CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
            _arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
            [CATransaction commit];

            break;
        case EGOOPullRefreshNormal:

            if (_state == EGOOPullRefreshPulling) {
                [CATransaction begin];
                [CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
                _arrowImage.transform = CATransform3DIdentity;
                [CATransaction commit];
            }

            _statusLabel.text = NSLocalizedString(@"Pull down to refresh...", @"Pull down to refresh status");
            [_activityView stopAnimating];
            [CATransaction begin];
            [CATransaction setValue:(id) kCFBooleanTrue forKey:kCATransactionDisableActions];
            _arrowImage.hidden = NO;
            _arrowImage.transform = CATransform3DIdentity;
            [CATransaction commit];

            [self refreshLastUpdatedDate];

            break;
        case EGOOPullRefreshLoading:


            switch (self.headerStyle) {
                case EGORefreshTableHeaderStyleRoom: {
                    _statusLabel.text = NSLocalizedString(@"Loading...", @"Loading Status");
                }

                break;
                case EGORefreshTableHeaderStyleContact: {
                    _statusLabel.text = NSLocalizedString(@"Updating...", @"Updating Status");
                }

                break;
                default:
                    break;
            }


            [_activityView startAnimating];
            [CATransaction begin];
            [CATransaction setValue:(id) kCFBooleanTrue forKey:kCATransactionDisableActions];
            _arrowImage.hidden = YES;
            [CATransaction commit];

            break;
        default:
            break;
    } /* switch */

    _state = aState;
} /* setState */


#pragma mark -
#pragma mark ScrollView Methods

- (void) egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView {

    if (_state == EGOOPullRefreshLoading) {

        CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
        offset = MIN(offset, 60);
        scrollView.contentInset = UIEdgeInsetsMake(offset, 0.0f, 0.0f, 0.0f);
    } else if (scrollView.isDragging) {

        BOOL _loading = NO;
        if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceIsLoading:)]) {
            _loading = [_delegate egoRefreshTableHeaderDataSourceIsLoading:self];
        }

        if (( _state == EGOOPullRefreshPulling) && ( scrollView.contentOffset.y > -65.0f) && ( scrollView.contentOffset.y < 0.0f) && !_loading) {
            [self setState:EGOOPullRefreshNormal];
        } else if (( _state == EGOOPullRefreshNormal) && ( scrollView.contentOffset.y < -65.0f) && !_loading) {
            [self setState:EGOOPullRefreshPulling];
        }

        if (scrollView.contentInset.top != 0) {
            scrollView.contentInset = UIEdgeInsetsZero;
        }
    }
} /* egoRefreshScrollViewDidScroll */

- (void) egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView {

    BOOL _loading = NO;

    if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDataSourceIsLoading:)]) {
        _loading = [_delegate egoRefreshTableHeaderDataSourceIsLoading:self];
    }

    if (( scrollView.contentOffset.y <= -65.0f) && !_loading) {

        if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDidTriggerRefresh:)]) {
            [_delegate egoRefreshTableHeaderDidTriggerRefresh:self];
        }

        [self setState:EGOOPullRefreshLoading];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
        scrollView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
        [UIView commitAnimations];
    }
} /* egoRefreshScrollViewDidEndDragging */

- (void) egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.3];
    [scrollView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
    [UIView commitAnimations];

    [self setState:EGOOPullRefreshNormal];
}


#pragma mark -
#pragma mark Dealloc

- (void) dealloc {

    _delegate = nil;
    _activityView = nil;
    _statusLabel = nil;
    _arrowImage = nil;
    _lastUpdatedLabel = nil;
}


@end
