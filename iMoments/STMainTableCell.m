//
//  STMainTableCell.m
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

#import "STMainTableCell.h"

@implementation STMainTableCell

{
    STBaseImageView *imageView ;
    STCustomLabel *contentLabel, *dateLabel;
    UIImageView *bgView;
    UIImageView *avatarCover;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 95)];
        bgView.contentMode = UIViewContentModeScaleToFill;
        //bgView.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
        //bgView.layer.cornerRadius = 4.0f;
        [self.atcContentView addSubview:bgView];
        
        //        imageView = [[STBaseImageView alloc] initWithFrame:CGRectMake(10, 10, 63, 63)];
        //        //[self addSubview:imageView];
        //
        //        avatarCover = [[UIImageView alloc] initWithFrame:CGRectMake(6, 6, 72, 72)];
        //        avatarCover.image = [UIImage imageNamed:@"photo_cover"];
        //        [self.atcContentView addSubview:avatarCover];
        contentLabel = [[STCustomLabel alloc] initWithFrame:CGRectMake(10, 10, 300, 40) text:nil font:[UIFont systemFontOfSize:14] textColor:[UIColor colorWithHexString:@"#f4f4f4"]];
        [self.atcContentView addSubview:contentLabel];
        dateLabel = [[STCustomLabel alloc] initWithFrame:CGRectMake(200, 56, 110, 13) text:nil font:[UIFont systemFontOfSize:12] textColor:[UIColor colorWithHexString:@"999999"]];
        dateLabel.textAlignment = UITextAlignmentRight;
        [self.atcContentView addSubview:dateLabel];
        
        
        UIImageView *sep = [[UIImageView alloc] initWithFrame:CGRectMake(0, 94, 320, 1)];
        sep.backgroundColor = [UIColor colorWithHexString:@"#d6d6d6"];
        [self.atcContentView addSubview:sep];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)showObject:(id)object;
{
    Moment *moment = object;
    
    if ([moment.type intValue] != 0) {
        //        if (!imageView) {
        //            imageView = [[STBaseImageView alloc] initWithFrame:CGRectMake(10, 10, 63, 63)];
        //        }
        //
        //        [self.atcContentView addSubview:imageView];
        //        imageView.image = [UIImage imageWithContentsOfFile:diary.imagePath];
        bgView.image = [UIImage imageWithContentsOfFile:moment.imagePath];
        CGRect frameTmp = bgView.frame;
        frameTmp.size.width = 320;
        bgView.frame = frameTmp;
        contentLabel.text = moment.content;
        CGRect frame = contentLabel.frame;
        //frame.size.height = [contentLabel.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(210, 40) lineBreakMode:NSLineBreakByCharWrapping].height;
        frame.origin.x = 10;
        frame.size.width = 300;
        contentLabel.frame = frame;
        contentLabel.numberOfLines = 0;
        
    }else {
        CGRect frame = contentLabel.frame;
        //frame.size.height = [contentLabel.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(290, 40) lineBreakMode:NSLineBreakByCharWrapping].height;
        frame.size.width = 300;
        frame.origin.x = 10;
        contentLabel.frame = frame;
        contentLabel.numberOfLines = 0;
        [avatarCover  removeFromSuperview];
        [imageView removeFromSuperview];
        imageView.image = nil;
        contentLabel.text = moment.content;
        
    }
    
    dateLabel.text = moment.showDate;
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
