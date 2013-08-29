//
//  ViewController.m
//  Statements
//
//  Created by Moncter8 on 13-5-30.
//  Copyright (c) 2013年 Moncter8. All rights reserved.
//

#import "MoodViewController.h"
#import "PieChartView.h"

#define PIE_HEIGHT 280

@interface MoodViewController ()
@property (nonatomic,strong) NSMutableArray *valueArray;
@property (nonatomic,strong) NSMutableArray *colorArray;
@property (nonatomic,strong) NSMutableArray *valueArray2;
@property (nonatomic,strong) NSMutableArray *colorArray2;
@property (nonatomic,strong) PieChartView *pieChartView;
@property (nonatomic,strong) UIView *pieContainer;
@property (nonatomic)BOOL inOut;
@property (nonatomic,strong) UILabel *selLabel;

@property (nonatomic,strong) UIImageView *showEmoticon;
@end

@implementation MoodViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Mood";
    }
    return self;
}


- (NSString *)tabTitle
{
	return self.title;
}

- (NSString *)tabImageName
{
	return @"mood";
}

- (void)dealloc
{
    self.valueArray = nil;
    self.colorArray = nil;
    self.valueArray2 = nil;
    self.colorArray2 = nil;
    self.pieContainer = nil;
    self.selLabel = nil;
    self.showEmoticon = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.inOut = YES;
    
    
    // LOOK AT HERE!!!!!!!!!!!!!
    //add code to get mood data from database later!!!!!!!!!
    //add start***********************
    __block int numForEmoticon0 = 1;
    __block int numForEmoticon1 = 1;
    __block int numForEmoticon2 = 1;
    __block int numForEmoticon3 = 1;
    __block int numForEmoticon4 = 1;
    __block int numForEmoticon5 = 1;
    __block int numForEmoticon6 = 1;
    __block int numForEmoticon7 = 1;
    __block int numForEmoticon8 = 1;

    [[DataFactory shardDataFactory] searchCount:@"type=1 or type=0" Classtype:momentClass callback:^(int number) {
        [[DataFactory shardDataFactory]searchWhere:nil orderBy:@"date" offset:0 count:number Classtype:momentClass callback:^(NSArray *result)
         {
             //NSMutableArray *uniqTags = [[NSMutableArray alloc] init];
             if ([result count] > 0)
             {
                 numForEmoticon0 = 0;
                 numForEmoticon1 = 0;
                 numForEmoticon2 = 0;
                 numForEmoticon3 = 0;
                 numForEmoticon4 = 0;
                 numForEmoticon5 = 0;
                 numForEmoticon6 = 0;
                 numForEmoticon7 = 0;
                 numForEmoticon8 = 0;
                
                 for (int i = 0; i < [result count]; i++)
                 {
                     Moment *tempMoment = [[Moment alloc] init];
                     NSString *tempEmoticon = @"";
                     tempMoment = [result objectAtIndex:i];
                     tempEmoticon = tempMoment.emoticon;

                     if ([tempEmoticon isEqualToString:@"emoticon0.png"] || [tempEmoticon isEqualToString:@"emoticonDefault.png"])
                     {
                         numForEmoticon0++;
                     }
                     else if([tempEmoticon isEqualToString:@"emoticon1.png"])
                     {
                         numForEmoticon1++;
                     }
                     else if([tempEmoticon isEqualToString:@"emoticon2.png"])
                     {
                         numForEmoticon2++;
                     }
                     else if([tempEmoticon isEqualToString:@"emoticon3.png"])
                     {
                         numForEmoticon3++;
                     }
                     else if([tempEmoticon isEqualToString:@"emoticon4.png"])
                     {
                         numForEmoticon4++;
                     }
                     else if([tempEmoticon isEqualToString:@"emoticon5.png"])
                     {
                         numForEmoticon5++;
                     }
                     else if([tempEmoticon isEqualToString:@"emoticon6.png"])
                     {
                         numForEmoticon6++;
                     }
                     else if([tempEmoticon isEqualToString:@"emoticon7.png"])
                     {
                         numForEmoticon7++;
                     }
                     else if([tempEmoticon isEqualToString:@"emoticon8.png"])
                     {
                         numForEmoticon8++;
                     }
                 }
             }
         }];
    }];
    //add end  ***********************
    
    //在这里把九个值赋给NSNumber就行了。
     
    
    self.valueArray = [[NSMutableArray alloc] initWithObjects:
                       [NSNumber numberWithInt:numForEmoticon0],
                       [NSNumber numberWithInt:numForEmoticon1],
                       [NSNumber numberWithInt:numForEmoticon2],
                       [NSNumber numberWithInt:numForEmoticon3],
                       [NSNumber numberWithInt:numForEmoticon4],
                       [NSNumber numberWithInt:numForEmoticon5],
                       [NSNumber numberWithInt:numForEmoticon6],
                       [NSNumber numberWithInt:numForEmoticon7],
                       [NSNumber numberWithInt:numForEmoticon8],
                       nil];
    self.valueArray2 = [[NSMutableArray alloc] initWithObjects:
                        [NSNumber numberWithInt:numForEmoticon0],
                        [NSNumber numberWithInt:numForEmoticon1],
                        [NSNumber numberWithInt:numForEmoticon2],
                        [NSNumber numberWithInt:numForEmoticon3],
                        [NSNumber numberWithInt:numForEmoticon4],
                        [NSNumber numberWithInt:numForEmoticon5],
                        [NSNumber numberWithInt:numForEmoticon6],
                        [NSNumber numberWithInt:numForEmoticon7],
                        [NSNumber numberWithInt:numForEmoticon8],
                        nil];
    /*
    self.colorArray = [NSMutableArray arrayWithObjects:
                       [UIColor colorWithHue:((0/8)%20)/20.0+0.02 saturation:(0%8+3)/10.0 brightness:91/100.0 alpha:1],
                       [UIColor colorWithHue:((1/8)%20)/20.0+0.02 saturation:(1%8+3)/10.0 brightness:91/100.0 alpha:1],
                       [UIColor colorWithHue:((2/8)%20)/20.0+0.02 saturation:(2%8+3)/10.0 brightness:91/100.0 alpha:1],
                       [UIColor colorWithHue:((3/8)%20)/20.0+0.02 saturation:(3%8+3)/10.0 brightness:91/100.0 alpha:1],
                       [UIColor colorWithHue:((4/8)%20)/20.0+0.02 saturation:(4%8+3)/10.0 brightness:91/100.0 alpha:1],
                       [UIColor colorWithHue:((5/8)%20)/20.0+0.02 saturation:(5%8+3)/10.0 brightness:91/100.0 alpha:1],
                       [UIColor colorWithHue:((4/8)%20)/20.0+0.02 saturation:(4%8+3)/10.0 brightness:91/100.0 alpha:1],
                       [UIColor colorWithHue:((5/8)%20)/20.0+0.02 saturation:(5%8+3)/10.0 brightness:91/100.0 alpha:1],
                       [UIColor colorWithHue:((0/8)%20)/20.0+0.02 saturation:(0%8+3)/10.0 brightness:91/100.0 alpha:1],
                       nil];
    self.colorArray2 = [[NSMutableArray alloc] initWithObjects:
                        [UIColor colorWithHue:((0/8)%20)/20.0+0.02 saturation:(0%8+3)/10.0 brightness:91/100.0 alpha:1],
                        [UIColor colorWithHue:((1/8)%20)/20.0+0.02 saturation:(1%8+3)/10.0 brightness:91/100.0 alpha:1],
                        [UIColor colorWithHue:((2/8)%20)/20.0+0.02 saturation:(2%8+3)/10.0 brightness:91/100.0 alpha:1],
                        [UIColor colorWithHue:((3/8)%20)/20.0+0.02 saturation:(3%8+3)/10.0 brightness:91/100.0 alpha:1],
                        [UIColor colorWithHue:((4/8)%20)/20.0+0.02 saturation:(4%8+3)/10.0 brightness:91/100.0 alpha:1],
                        [UIColor colorWithHue:((5/8)%20)/20.0+0.02 saturation:(5%8+3)/10.0 brightness:91/100.0 alpha:1],
                        [UIColor colorWithHue:((4/8)%20)/20.0+0.02 saturation:(4%8+3)/10.0 brightness:91/100.0 alpha:1],
                        [UIColor colorWithHue:((5/8)%20)/20.0+0.02 saturation:(5%8+3)/10.0 brightness:91/100.0 alpha:1],
                        [UIColor colorWithHue:((0/8)%20)/20.0+0.02 saturation:(0%8+3)/10.0 brightness:91/100.0 alpha:1],
                        nil];
     */
    self.colorArray = [NSMutableArray arrayWithObjects:
                       [UIColor colorWithHexString:@"ED95EA"],
                       [UIColor colorWithHexString:@"DE629C"],
                       [UIColor colorWithHexString:@"E60E72"],
                       [UIColor colorWithHexString:@"B8ADB2"],
                       [UIColor colorWithHexString:@"C484A2"],
                       [UIColor colorWithHexString:@"E82020"],
                       [UIColor colorWithHexString:@"E820E1"],
                       [UIColor colorWithHexString:@"9D5EDB"],
                       [UIColor colorWithHexString:@"5380E0"],
                       nil];
    self.colorArray2 = [NSMutableArray arrayWithObjects:
                        [UIColor colorWithHexString:@"ED95EA"],
                        [UIColor colorWithHexString:@"DE629C"],
                        [UIColor colorWithHexString:@"E60E72"],
                        [UIColor colorWithHexString:@"B8ADB2"],
                        [UIColor colorWithHexString:@"C484A2"],
                        [UIColor colorWithHexString:@"E82020"],
                        [UIColor colorWithHexString:@"E820E1"],
                        [UIColor colorWithHexString:@"9D5EDB"],
                        [UIColor colorWithHexString:@"5380E0"],
                        nil];

    self.title = @"Mood";
    //add shadow img
    CGRect pieFrame = CGRectMake((self.view.frame.size.width - PIE_HEIGHT) / 2, 50-0, PIE_HEIGHT, PIE_HEIGHT);
    
    UIImage *shadowImg = [UIImage imageNamed:@"shadow.png"];
    UIImageView *shadowImgView = [[UIImageView alloc]initWithImage:shadowImg];
    shadowImgView.frame = CGRectMake(0, pieFrame.origin.y + PIE_HEIGHT*0.92, shadowImg.size.width/2, shadowImg.size.height/2);
    [self.view addSubview:shadowImgView];
    
    self.pieContainer = [[UIView alloc]initWithFrame:pieFrame];
    self.pieChartView = [[PieChartView alloc]initWithFrame:self.pieContainer.bounds withValue:self.valueArray withColor:self.colorArray];
    self.pieChartView.delegate = self;
    [self.pieContainer addSubview:self.pieChartView];
    [self.pieChartView setAmountText:@"Mood"];
    [self.view addSubview:self.pieContainer];
    
    //add selected view
    UIImageView *selView = [[UIImageView alloc]init];
    selView.image = [UIImage imageNamed:@"select.png"];
    selView.frame = CGRectMake((self.view.frame.size.width - selView.image.size.width/2)/2, self.pieContainer.frame.origin.y + self.pieContainer.frame.size.height, selView.image.size.width/2, selView.image.size.height/2);
    [self.view addSubview:selView];
    
    self.selLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 24, selView.image.size.width/2, 21)];
    self.selLabel.backgroundColor = [UIColor clearColor];
    self.selLabel.textAlignment = NSTextAlignmentCenter;
    self.selLabel.font = [UIFont systemFontOfSize:17];
    self.selLabel.textColor = [UIColor whiteColor];
    [selView addSubview:self.selLabel];
    
    // add for showEmoticon
    self.showEmoticon = [[UIImageView alloc] initWithFrame:CGRectMake(40, 20, 30, 30)];
    [selView addSubview:self.showEmoticon];
    // add end
    
    [self.pieChartView setTitleText:@""];
    self.title = @"Mood";
    self.view.backgroundColor = [self colorFromHexRGB:@"f3f3f3"];
}

- (UIColor *) colorFromHexRGB:(NSString *) inColorString
{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:1.0];
    return result;
}

- (void)selectedFinish:(PieChartView *)pieChartView index:(NSInteger)index percent:(float)per
{
    self.selLabel.text = [NSString stringWithFormat:@"%2.2f%@",per*100,@"%"];
    if(index == 0){
        self.showEmoticon.image = [UIImage imageNamed:@"emoticon0"];
    }
    else if(index == 1)
    {
        self.showEmoticon.image = [UIImage imageNamed:@"emoticon1"];
    }
    else if(index == 2)
    {
        self.showEmoticon.image = [UIImage imageNamed:@"emoticon2"];
    }
    else if(index == 3)
    {
        self.showEmoticon.image = [UIImage imageNamed:@"emoticon3"];
    }
    else if(index == 4)
    {
        self.showEmoticon.image = [UIImage imageNamed:@"emoticon4"];
    }
    else if(index == 5)
    {
        self.showEmoticon.image = [UIImage imageNamed:@"emoticon5"];
    }
    else if(index == 6)
    {
        self.showEmoticon.image = [UIImage imageNamed:@"emoticon6"];
    }
    else if(index == 7)
    {
        self.showEmoticon.image = [UIImage imageNamed:@"emoticon7"];
    }
    else if(index == 8)
    {
        self.showEmoticon.image = [UIImage imageNamed:@"emoticon8"];
    }
}

- (void)onCenterClick:(PieChartView *)pieChartView
{
    self.inOut = !self.inOut;
    self.pieChartView.delegate = nil;
    [self.pieChartView removeFromSuperview];
    self.pieChartView = [[PieChartView alloc]initWithFrame:self.pieContainer.bounds withValue:self.inOut?self.valueArray:self.valueArray withColor:self.inOut?self.colorArray:self.colorArray];
    self.pieChartView.delegate = self;
    [self.pieContainer addSubview:self.pieChartView];
    [self.pieChartView reloadChart];
    
    if (self.inOut) {
        [self.pieChartView setTitleText:@""];
        [self.pieChartView setAmountText:@"Mood"];
        
    }else{
        [self.pieChartView setTitleText:@""];
        [self.pieChartView setAmountText:@"Mood"];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.pieChartView reloadChart];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
