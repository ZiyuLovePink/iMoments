//
//  STPhotoViewCellCell.m
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

#import "STPhotoViewCellCell.h"
#import "STBaseImageView.h"

@implementation STPhotoViewCellCell
{
    UIButton *imageViewLeft,*imageViewMid,*imageViewRight;
}

+(CGFloat)cellHeightForObject:(id)object
{
    Moment *moment = object;
    CGFloat height = [moment.content sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(300, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping].height;
    return height+30+20;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        imageViewLeft = [[UIButton alloc] initWithFrame:CGRectMake(5,5,100,100)];
        [self addSubview:imageViewLeft];
        imageViewMid = [[UIButton alloc] initWithFrame:CGRectMake(110,5,100,100)];
        [self addSubview:imageViewMid];
        imageViewRight = [[UIButton alloc] initWithFrame:CGRectMake(215,5,100,100)];
        [self addSubview:imageViewRight];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)showObject:(id)object index:(int)index;
{
    Moment *moment;
    if ([object count]>=1) {
        moment = [object objectAtIndex:0];
        imageViewLeft.tag = index*3;
        UIImage *image = [UIImage imageWithContentsOfFile:moment.imagePath];
        [imageViewLeft setBackgroundImage:image forState:UIControlStateNormal];
        [imageViewLeft setBackgroundImage:image forState:UIControlStateHighlighted];
        [imageViewLeft addTarget:self action:@selector(showDiary:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    if ([object count]>=2) {
        moment = [object objectAtIndex:1];
        imageViewMid.tag = index*3+1;
        UIImage *image = [UIImage imageWithContentsOfFile:moment.imagePath];
        [imageViewMid setBackgroundImage:image forState:UIControlStateNormal];
        [imageViewMid setBackgroundImage:image forState:UIControlStateHighlighted];
        [imageViewMid addTarget:self action:@selector(showDiary:) forControlEvents:UIControlEventTouchUpInside];
    }
    if ([object count]==3) {
        moment = [object objectAtIndex:2];
        imageViewRight.tag = index*3+2;
        UIImage *image = [UIImage imageWithContentsOfFile:moment.imagePath];
        [imageViewRight setBackgroundImage:image forState:UIControlStateNormal];
        [imageViewRight setBackgroundImage:image forState:UIControlStateHighlighted];
        [imageViewRight addTarget:self action:@selector(showDiary:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

-(void)showDiary:(id)sender
{
    UIButton *button = (UIButton *)sender;
    [_delegate showDiary:[_dataSource objectAtIndex:button.tag]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
