//
//  STImageSaver.h
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STImageSaver : NSObject

+(STImageSaver *)shareImageSaver;

-(NSString *)saveImage:(UIImage *)image;

-(void)deleteImage:(NSString *)imagePath;

-(UIImage *)getImageFromePath:(NSString *)path;
@end
