//
//  LZTagView.h
//  LZTagViewExample
//
//  Created by Lukas Zielinski on 12/30/12.
//
//
//  Copyright (C) 2012 Lukas Zielinski
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in
//	all copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//	THE SOFTWARE.

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "LZTag.h"

#define TOP_AND_BOTTOM_PADDING 3
#define LEFT_PADDING 5

#define LINE_HEIGHT 25

#define PADDING_BETWEEN_TAGS 5
#define BUBBLE_PADDING 5

#define MIN_WIDTH_FOR_TEXT_FIELD 25
#define MIN_WIDTH_FOR_TAPPABLE_AREA 5

#define TAG_OK 1
#define TAG_ALREADY_EXISTS -1
#define TAG_IS_EMPTY -2

@interface LZTagView : UIView <UITextFieldDelegate>
{
    CGFloat         _currentX;
    NSUInteger      _currentLine;
    UITextField    *_textField;
}

@property (strong, nonatomic) NSMutableArray *tags;
@property (strong, nonatomic) NSMutableArray *suggestedTags;

- (NSSet *) tagSetOfStrings;

@end
