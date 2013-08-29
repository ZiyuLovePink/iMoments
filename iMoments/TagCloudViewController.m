//This file is part of SphereView.
//
//SphereView is free software: you can redistribute it and/or modify
//it under the terms of the GNU General Public License as published by
//the Free Software Foundation, either version 3 of the License, or
//(at your option) any later version.
//
//SphereView is distributed in the hope that it will be useful,
//but WITHOUT ANY WARRANTY; without even the implied warranty of
//MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//GNU General Public License for more details.
//
//You should have received a copy of the GNU General Public License
//along with SphereView.  If not, see <http://www.gnu.org/licenses/>.

#import "TagCloudViewController.h"
#import "PFSphereView.h"

@implementation TagCloudViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Tag Cloud";
    }
    return self;
}

- (NSString *)tabTitle
{
	return self.title;
}

- (NSString *)tabImageName
{
	return @"tags";
}


- (void)viewDidLoad {
	self.view.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    self.title = @"Tag Cloud";
    

	PFSphereView *sphereView = [[PFSphereView alloc] initWithFrame:CGRectMake(10, 60, 300, 300)];

    //add start***********************
    NSMutableArray *uniqTags = [[NSMutableArray alloc] init];
    
    [[DataFactory shardDataFactory] searchCount:@"hasTag=1" Classtype:momentClass callback:^(int number) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:@"1" forKey:@"hasTag"];
        [[DataFactory shardDataFactory]searchWhere:dic orderBy:@"date" offset:0 count:number Classtype:momentClass callback:^(NSArray *result)
         {
             //NSMutableArray *uniqTags = [[NSMutableArray alloc] init];
             if ([result count] > 0)
             {
                 for (int i = 0; i < [result count]; i++)
                 {
                     Moment *tempMoment = [[Moment alloc] init];
                     NSString *tempTag = @"";
                     tempMoment = [result objectAtIndex:i];
                     tempTag = tempMoment.tag;
                     [uniqTags addObject:tempTag];
                 }
             }
         }];
    }];
    //add end  ***********************
    
	NSMutableArray *labels = [[NSMutableArray alloc] init];

	for (int j = 0; j < [uniqTags count]; j++)
    {
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 50)];
		label.backgroundColor = [UIColor clearColor];
		label.textColor = [UIColor colorWithHexString:@"2EB1F2"];
		label.font = [UIFont systemFontOfSize:16];
		label.text = [uniqTags objectAtIndex:j];
		[labels addObject:label];
		//[label release];
	}

	[sphereView setItems:labels];

	//[labels release];

	[self.view addSubview:sphereView];
	//[sphereView release];
	
	[super viewDidLoad];
}


@end
