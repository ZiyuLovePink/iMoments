//
//  STMainTimelineCell.m
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "STMainTimelineCell.h"
#import "STCustomLabel.h"

@implementation STMainTimelineCell
{
    STBaseImageView *imageView ;
    STCustomLabel *contentLabel, *dateLabel;
    UIView *bgView;
    UIImageView *avatarCover, *timeLine, *sep;
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 90)];
        bgView.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
        //bgView.layer.cornerRadius = 4.0f;
        [self.atcContentView addSubview:bgView];
        
        imageView = [[STBaseImageView alloc] initWithFrame:CGRectMake(245, 10, 63, 63)];
        //[self addSubview:imageView];
        
        avatarCover = [[UIImageView alloc] initWithFrame:CGRectMake(241, 6, 72, 72)];
        avatarCover.image = [UIImage imageNamed:@"photo_cover"];
        
        contentLabel = [[STCustomLabel alloc] initWithFrame:CGRectMake(88, 10, 220, 40) text:nil font:[UIFont systemFontOfSize:16] textColor:[UIColor colorWithHexString:@"#4e4d4d"]];
        [self.atcContentView addSubview:contentLabel];
        dateLabel = [[STCustomLabel alloc] initWithFrame:CGRectMake(38, 65, 113, 13) text:nil font:[UIFont systemFontOfSize:12] textColor:[UIColor colorWithHexString:@"999999"]];
        dateLabel.textAlignment = UITextAlignmentLeft;
        dateLabel.font = [UIFont fontWithName:@"Verdana" size:11];
        dateLabel.textColor = [UIColor colorWithHexString:@"2EB1F2"];
        //dateLabel.textColor = [UIColor colorWithHexString:@"44BAC8"];
        [self.atcContentView addSubview:dateLabel];
        
        //new add for tagLabel
        tagLabel = [[STCustomLabel alloc] initWithFrame:CGRectMake(163, 65, 45, 13) text:nil font:[UIFont systemFontOfSize:12] textColor:[UIColor colorWithHexString:@"999999"]];
        tagLabel.textAlignment = UITextAlignmentLeft;
        tagLabel.font = [UIFont fontWithName:@"Verdana" size:11];
        tagLabel.textColor = [UIColor colorWithHexString:@"2EB1F2"];
        
        //add end
        
        //new add for locationLabel
        locationIcon = [[UIImageView alloc] initWithFrame:CGRectMake(215, 66, 7, 10)];
        
        //add end
        
        //new add for starLable
        
        starIcon = [[UIImageView alloc] initWithFrame:CGRectMake(225, 66, 10, 10)];
        
        //new end for star
        
        
        sep = [[UIImageView alloc] initWithFrame:CGRectMake(0, 89, 320, 1)];
        sep.backgroundColor = [UIColor colorWithHexString:@"#d6d6d6"];
        
        //self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //add the time line
        timeLine = [[UIImageView alloc] initWithFrame:CGRectMake(19, 0, 2, 90)];
        timeLine.backgroundColor = [UIColor colorWithHexString:@"#d6d6d6"];
        
        
        //end for time line
        
        //add to show emotion
        emoticon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30, 20, 20)];
        //add end
    }
    return self;
}

-(void)showObject:(id)object;
{
    Moment *moment = object;
    [self.atcContentView addSubview:timeLine];
    [self.atcContentView addSubview:emoticon];
    [self.atcContentView addSubview:sep];
    
    int tagWidth, locationWidth;
    //add for dynamic show
    if(moment.imagePath && ![moment.imagePath isEqualToString:@""]){
        [self.atcContentView addSubview:avatarCover];
    }
    if([moment.hasTag isEqualToString:@"1"]){
        tagImage= [[UIImageView alloc] initWithFrame:CGRectMake(153, 68, 8, 8)];
        tagImage.image = [UIImage imageNamed:@"tagsForTimeline"];
        [self.atcContentView addSubview:tagImage];
        [self.atcContentView addSubview:tagLabel];
        tagWidth = 45+8+3+5;
        //add tagLabel
        tagLabel.text = moment.tag;
        //add end
        CGRect tagLabelFrame= tagLabel.frame;
        tagLabelFrame.origin.x = 150 + 8 + 3+1;
        tagLabel.frame = tagLabelFrame;
    }
    else{
        tagLabel.text = @"";
        tagWidth = 0;
    }
    if(moment.location && (![moment.location isEqualToString:@""]))
    {
        [self.atcContentView addSubview:locationIcon];
        locationWidth = 8+5;
    }
    else{
        locationWidth = 0;
    }
    
    CGRect locationFrame = locationIcon.frame;
    locationFrame.origin.x = 150+tagWidth;
    locationIcon.frame = locationFrame;
    
    CGRect starFrame = starIcon.frame;
    starFrame.origin.x = 150+tagWidth+locationWidth;
    starIcon.frame = starFrame;
    
    //end for dynamic show
    if ([moment.type intValue] != 0) {
        if (!imageView) {
            imageView = [[STBaseImageView alloc] initWithFrame:CGRectMake(245, 10, 63, 63)];
        }
        
        [self.atcContentView addSubview:imageView];
        imageView.image = [UIImage imageWithContentsOfFile:moment.imagePath];
        
        contentLabel.text = moment.content;
        CGRect frame = contentLabel.frame;
        //frame.size.height = [contentLabel.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(210, 40) lineBreakMode:NSLineBreakByCharWrapping].height;
        frame.origin.x = 40;
        frame.size.width = 190;
        contentLabel.frame = frame;
        contentLabel.numberOfLines = 0;
        
    }else {
        CGRect frame = contentLabel.frame;
        //frame.size.height = [contentLabel.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(290, 40) lineBreakMode:NSLineBreakByCharWrapping].height;
        frame.size.width = 270;
        frame.origin.x = 38;
        contentLabel.frame = frame;
        contentLabel.numberOfLines = 0;
        [avatarCover  removeFromSuperview];
        [imageView removeFromSuperview];
        imageView.image = nil;
        contentLabel.text = moment.content;
    }
    
    
    
    dateLabel.text = moment.showDate;
    
    if (moment.location && ![moment.location isEqualToString:@""])
    {
        locationIcon.image = [UIImage imageNamed:@"locationForTimeline"];
    }
    // add end
    
    //add for show star
    if(moment.starred && [moment.starred isEqualToString:@"1"]){
        starIcon.image = [UIImage imageNamed:@"starredForTimeline"];
        [self.atcContentView addSubview:starIcon];
    }
    
    // end for show star
    
    emoticon.image = [UIImage imageNamed:moment.emoticon];
    //[self.atcContentView addSubview:emoticon];
    //add end
    
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
