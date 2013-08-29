//
//  AnimatedTableCell.h
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimatedTableCell : UITableViewCell

@property (nonatomic) bool popped;
@property (nonatomic,strong) UIView *atcContentView;

- (void) resetPosition;
- (void) configureCellContentSizeWidth:(float) width height:(float)height;

- (void) pushCellWithAnimation:(bool)animated;
- (void) pushCellWithAnimation:(bool)animated direction:(NSString *)direction;
- (void) pushCellWithAnimation:(bool)animated duration:(float)duration;
- (void) pushCellWithAnimation:(bool)animated duration:(float)duration direction:(NSString *)direction;

- (void) popCellWithAnimation:(bool)animated;
- (void) popCellWithAnimation:(bool)animated duration:(float)duration;

@end
