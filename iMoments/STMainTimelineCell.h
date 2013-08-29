//
//  STMainTimelineCell.h
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "STBaseImageView.h"
#import "AnimatedTableCell.h"

@interface STMainTimelineCell : AnimatedTableCell
{
    STCustomLabel *tagLabel;
    UIImageView *emoticon, *locationIcon, *starIcon;
    UIImageView *tagImage;
}

-(void)showObject:(id)object;
@end
