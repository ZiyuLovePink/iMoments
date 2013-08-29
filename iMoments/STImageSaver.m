//
//  STImageSaver.m
//  iMoments
//
//  Created by Kai Lu on 13-8-25.
//  Copyright (c) 2013年 Kai Lu and Ziyu Ou. All rights reserved.
//

#import "STImageSaver.h"

#define IMAGE_REPRESENTATION    0.8f

@implementation STImageSaver

+(STImageSaver *)shareImageSaver
{
    STImageSaver *imageSaver;
    if (!imageSaver) {
        imageSaver = [[STImageSaver alloc] init];
    }
    return imageSaver;
}

-(NSString *)saveImage:(UIImage *)image
{
    NSString *path = [self findUniqueSavePath];
    [UIImageJPEGRepresentation(image, IMAGE_REPRESENTATION) writeToFile:path atomically:YES];
    return path;
}

-(void)deleteImage:(NSString *)imagePath;
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    [fileManager removeItemAtPath:imagePath error:nil];
}

-(NSString *)findUniqueSavePath
{
    int i = 1;
    NSString *path;
    do {
        [[NSFileManager defaultManager] createDirectoryAtPath: [NSString stringWithFormat:@"%@/Documents/images", NSHomeDirectory()] withIntermediateDirectories:YES attributes:nil error:nil];
        path = [NSString stringWithFormat:@"%@/Documents/images/IMAGE_%0.8d.PNG",NSHomeDirectory(),i++];
    } while ([[NSFileManager defaultManager] fileExistsAtPath:path]);
    
    return  path;
}

-(UIImage *)getImageFromePath:(NSString *)path
{
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    return  image;
}

@end

