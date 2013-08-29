//
//  STDetailCell.m
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

#import "STDetailCell.h"

@implementation STDetailCell
{
    STCustomLabel *contentLabel,*dateLabel, *tagContentLabel, *locationContentLabel;
    
    UIImageView *emoticonImage, *starredImage, *tagImage, *locationImage;
    UIButton *shareButton;
    
}
+(CGFloat)cellHeightForObject:(id)object
{
    Moment *moment = object;
    CGFloat height = [moment.content sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(300, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping].height;
    return height+30+20+10;
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        UIColor *mainColor = [UIColor colorWithHexString:@"2EB1F2"];
        
        contentLabel = [[STCustomLabel alloc] initWithFrame:CGRectZero text:nil font:[UIFont systemFontOfSize:16] textColor:[UIColor colorWithHexString:@"#4e4d4d"]];
        [self addSubview:contentLabel];
        contentLabel.numberOfLines = 0;
        dateLabel = [[STCustomLabel alloc] initWithFrame:CGRectZero text:nil font:[UIFont systemFontOfSize:14] textColor:[UIColor colorWithHexString:@"#999999"]];
        //[self addSubview:dateLabel];
        
        emoticonImage = [[UIImageView alloc] initWithFrame:CGRectMake(5,9, 25, 25)];
        starredImage = [[UIImageView alloc] initWithFrame:CGRectMake(41, 13, 20, 20)];
        tagImage = [[UIImageView alloc] initWithFrame:CGRectMake(73, 15, 17, 17)];
        
        
        tagContentLabel = [[STCustomLabel alloc] initWithFrame:CGRectMake(95, 10, 150,25)  text:nil font:[UIFont systemFontOfSize:14] textColor:mainColor];
        
        locationImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
        
        locationContentLabel = [[STCustomLabel alloc] initWithFrame:CGRectZero text:nil font:[UIFont systemFontOfSize:14] textColor:mainColor];
        
        shareButton = [[UIButton alloc] initWithFrame:CGRectMake(277, 13, 33, 23)];
        [shareButton addTarget:self action:@selector(clickShareButton:) forControlEvents:UIControlEventTouchUpInside];
        [shareButton setBackgroundImage:[UIImage imageNamed:@"shareAfterClick"] forState:UIControlStateNormal];
        [self addSubview:shareButton];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
    }
    return self;
}

-(void)clickShareButton:(id)sender
{
    NSLog(@"come in here!");
    [_myDelegate shareButtonClicked];
}

-(void)showObject:(id)object;
{
    Moment *moment = object;
    
    emoticonImage.image = [UIImage imageNamed:moment.emoticon];
    [self addSubview:emoticonImage];
    
    
    
    CGFloat height = [moment.content sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(300, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping].height;
    contentLabel.frame = CGRectMake(10, 40, 300, height);
    
    if(moment.starred && [moment.starred isEqualToString:@"1"])
    {
        starredImage.image = [UIImage imageNamed:@"starredForTimeline"];
        [self addSubview:starredImage];
    }
    
    if (moment.hasTag && [moment.hasTag isEqualToString:@"1"])
    {
        tagImage.image = [UIImage imageNamed:@"tagsForTimeline"];
        [self addSubview:tagImage];
        tagContentLabel.text = moment.tag;
        [self addSubview:tagContentLabel];
    }
    else
    {
        tagContentLabel.text = @"";
    }
    
    int oneLineHeight = 4;
    if(moment.location && ![moment.location isEqualToString:@""])
    {
        NSArray * coordinate = [moment.location componentsSeparatedByString: @" "];
        NSString *altitude = [coordinate objectAtIndex:0];
        NSString *longitude = [coordinate objectAtIndex:1];
        
        
        altitude = [NSString stringWithFormat:@"%1.1f",[altitude doubleValue]];
        longitude = [NSString stringWithFormat:@"%1.1f", [longitude doubleValue]];
        
        oneLineHeight = 34;
        
        locationImage.frame = CGRectMake(10, 42, 14, 19);
        locationContentLabel.frame = CGRectMake(30, 42, 280, 23);
        locationContentLabel.text =[NSString stringWithFormat: @"Altitude %@°, Longitude %@°", altitude,longitude];
        [self addSubview:locationContentLabel];
        
        locationImage.image = [UIImage imageNamed:@"locationForTimeline"];
        [self addSubview:locationImage];
        
    }
    
    
    CGRect contentFrame = contentLabel.frame;
    contentFrame.origin.y = 34+oneLineHeight+5;
    contentLabel.frame = contentFrame;
    contentLabel.text = moment.content;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
