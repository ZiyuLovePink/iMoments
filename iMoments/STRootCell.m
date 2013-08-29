//
//  STRootCell.m
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

#import "STRootCell.h"

@implementation STRootCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.myImageView =[[UIImageView alloc] initWithFrame:CGRectMake(9, 16, 23, 23)];
        [self addSubview:self.myImageView];
        self.tLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 18, 280, 20)];
        self.tLabel.backgroundColor = [UIColor clearColor];
        self.tLabel.font = [UIFont boldSystemFontOfSize:20];
        //self.tLabel.textColor = [UIColor colorWithHexString:@"#1c9e79"];
        [self addSubview:self.tLabel];
        //self.backgroundColor = [UIColor colorWithHexString:@"#fefefe"];
        //self.selectionStyle = UITableViewCellSelectionStyleNone;
        //UIImageView *sepLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 65, 320, 1)];
        //sepLine.backgroundColor = [UIColor colorWithHexString:@"#e9e9e9"];
        //[self addSubview:sepLine];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

-(void)setTitle:(NSString *)title
{
    self.tLabel.text = title;
    self.tLabel.textColor = [UIColor colorWithHexString:@"#1c9e79"];
}

-(void)setTitle:(NSString *)title AndImage: (UIImage *)image
{
    self.tLabel.text = title;
    self.myImageView.image = image;
    self.tLabel.textColor = [UIColor colorWithHexString:@"#1c9e79"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (selected) {
        self.tLabel.textColor = [UIColor whiteColor];
        UIView *myView = [[UIView alloc] init];
        myView.backgroundColor = [UIColor colorWithHexString:@"#68d39f"];
        self.backgroundView = myView;
    }else {
        self.tLabel.textColor = [UIColor colorWithHexString:@"#6d7174"];
        UIView *myView = [[UIView alloc] init];
        myView.backgroundColor = [UIColor colorWithHexString:@"#fefefe"];
        self.backgroundView = myView;
    }
    [super setSelected:selected animated:animated];
    
    
    // Configure the view for the selected state
}

@end
