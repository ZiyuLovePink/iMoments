//
//  STRootCell.h
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STRootCell : UITableViewCell

@property(nonatomic,strong)UILabel *tLabel;
@property(nonatomic,strong)UIImageView *myImageView;
-(void)setTitle:(NSString *)title;
-(void)setTitle:(NSString *)title AndImage: (UIImage *)image;
@end
