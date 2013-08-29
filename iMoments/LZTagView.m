//
//  LZTagView.m
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

#import "LZTagView.h"


@implementation LZTagView

@synthesize tags, suggestedTags;

- (void) defaultInit
{
    if(!self.tags)          self.tags           = [[NSMutableArray alloc] init];
    if(!self.suggestedTags) self.suggestedTags  = [[NSMutableArray alloc] init];
    _currentLine = 0;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self defaultInit];
    }
    return self;
}

// this constructor is called when using this view in a storyboard
- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self defaultInit];
    }
    return self;
}

// called each time view is displayed, f.ex. when changing rotation of device
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect ownFrame = self.frame;
    
    // set height to what is neccessary for first row
    
    if( ownFrame.size.height != LINE_HEIGHT )
    {
        ownFrame.size.height = LINE_HEIGHT + TOP_AND_BOTTOM_PADDING;
        self.frame = ownFrame;
    }
    /*
    self.layer.borderColor = [[UIColor colorWithRed:190.0f/255.0f
                                              green:190.0f/255.0f
                                               blue:190.0f/255.0f
                                              alpha:1.0]
                                CGColor];

    self.layer.borderWidth = 1.0;
     */
    [self layoutCustomViews];
}

- (void) layoutCustomViews
{
    [self layoutTagBubbles];
    [self layoutTextField];
}

- (void) addNewLine
{
    CGRect ownFrame = self.frame;
    ownFrame.size.height += LINE_HEIGHT;
    self.frame = ownFrame;
    _currentX       = LEFT_PADDING;
    _currentLine    += 1;
}

- (CGFloat) remainingWidthInCurrentLine
{
    // the line of the label is identified by its frame's origin.y value
    CGFloat originY     = _currentLine * LINE_HEIGHT + TOP_AND_BOTTOM_PADDING;
    CGFloat availableX  = self.frame.size.width - 5;

    for(UIView *subview in self.subviews)
    {
        if([subview class] == [UILabel class])
        {
            UILabel *label = (UILabel *)subview;
            
            // only look at labels in the right line:
            if(label.frame.origin.y == originY)
            {
                availableX -= label.frame.size.width;
                availableX -= (PADDING_BETWEEN_TAGS + BUBBLE_PADDING);
            }
        }
    }

    return availableX - MIN_WIDTH_FOR_TAPPABLE_AREA;
}

- (UILabel *) labelWithTapRecognizerForTag:(LZTag *) tag WithSelector:(SEL)selector
{
    UILabel *label = [[UILabel alloc] init];
    
    //label.backgroundColor = [UIColor clearColor];
    label.backgroundColor = [UIColor colorWithHexString:@"DAE9F0"];
    label.text = tag.title;
    label.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapRecognizer =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:selector];
    
    tapRecognizer.numberOfTapsRequired = 1;
    [label addGestureRecognizer:tapRecognizer];
    
    [label sizeToFit];
    
    return label;
}

- (CGRect) bubbleFrameForLabel: (UILabel *) label
{
    CGRect bubbleFrame = label.frame;
    bubbleFrame.size.width  += BUBBLE_PADDING;
    bubbleFrame.origin.x    -= BUBBLE_PADDING / 2;
    return bubbleFrame;
}

- (void) layoutTagBubbles
{
    _currentLine = 0;
    _currentX = LEFT_PADDING;
    
    // each time start from scratch, but leave the text field
    
    for(UIView *subview in self.subviews)
    {
        if([subview class] != [UITextField class])
            [subview removeFromSuperview];
    }
    
    for( LZTag *tag in self.tags )
    {
        UILabel *label = [self labelWithTapRecognizerForTag:tag
                                               WithSelector:@selector(removeTag:)];
        CGRect labelFrame = label.frame;
        
        if(labelFrame.size.width > [self remainingWidthInCurrentLine])
            [self addNewLine];
        
        labelFrame.origin.x = _currentX + BUBBLE_PADDING / 2;
        labelFrame.origin.y = LINE_HEIGHT * _currentLine + TOP_AND_BOTTOM_PADDING;
        
        _currentX += labelFrame.size.width + PADDING_BETWEEN_TAGS + BUBBLE_PADDING;
        [label setFrame:labelFrame];
        
        // bubble background view
        UIView *bubbleView = [self bubbleViewForTag:tag
                                          WithFrame:[self bubbleFrameForLabel:label]];
        
        [self addSubview:bubbleView];
        [self addSubview:label];
    }
}

- (UIView *) bubbleViewForTag:(LZTag *)tag WithFrame:(CGRect)frame
{
    UIView *bubbleView      = [[UIView alloc] initWithFrame:frame];
    CALayer *bubbleLayer    = [CALayer layer];
    
    bubbleLayer.backgroundColor = tag.color.CGColor;
    bubbleLayer.shadowOffset    = CGSizeMake(0, 1);
    bubbleLayer.shadowRadius    = 1.0;
    bubbleLayer.shadowColor     = [UIColor blackColor].CGColor;
    bubbleLayer.shadowOpacity   = 0.9;
    bubbleLayer.cornerRadius    = 2.0;
    bubbleLayer.frame           = CGRectMake(0, 0, frame.size.width, frame.size.height);
    
    [bubbleView.layer insertSublayer:bubbleLayer atIndex:0];
    
    return bubbleView;
}

// called when user taps on suggested tag in the scrollview that is glued
// to the keyboard.
- (void) addTagFromSuggestions:(UITapGestureRecognizer *) sender
{
    UILabel *label = (UILabel *)sender.view;
    LZTag *tag = nil;
    
    for( LZTag *suggestedTag in self.suggestedTags )
    {
        if([suggestedTag.title isEqualToString:label.text])
        {
            tag = suggestedTag;
        }
    }
    
    if(tag)
    {
        [self.tags addObject:tag];
        //[self.suggestedTags removeObject:tag];
        [self layoutCustomViews];
    }

}

- (UIView *) suggestedTagsView
{
    UIView *suggestedTagsView = [[UIView alloc]
                                 initWithFrame:CGRectMake(0,0,self.window.frame.size.width, 40)];
    
    [suggestedTagsView setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:suggestedTagsView.frame];
    CGFloat startX = 5;
    
    NSMutableArray * labels = [[NSMutableArray alloc] init];
    
    for( LZTag *tag in self.suggestedTags )
    {
        UILabel *label = [self labelWithTapRecognizerForTag:tag
                                               WithSelector:@selector(addTagFromSuggestions:)];
        
        CGRect labelFrame = label.frame;
        labelFrame.origin.x = startX;
        labelFrame.origin.y = suggestedTagsView.frame.size.height / 2 - labelFrame.size.height / 2;
        startX += PADDING_BETWEEN_TAGS + labelFrame.size.width + BUBBLE_PADDING;
        
        label.frame = labelFrame;
        
        UIView *bubbleView = [self bubbleViewForTag:tag
                                          WithFrame:[self bubbleFrameForLabel:label]];
        [labels addObject:@{@"label":label,@"bubble":bubbleView}];
    }
    
    // have to interate through the tags to find out how big the content-area for
    // the scroll view has to be, so that scrolling actually works.
    
    CGFloat requiredContentSize = 0;
    
    for( NSDictionary *dict in labels )
    {
        UILabel *label = [dict objectForKey:@"label"];
        requiredContentSize += label.frame.size.width + 5 + BUBBLE_PADDING;
    }
    
    [scrollView setContentSize:CGSizeMake(requiredContentSize, scrollView.frame.size.height)];
    
    // Now actually adding the suggestedTags-bubbles.
    
    for( NSDictionary *dict in labels )
    {
        [scrollView addSubview:[dict objectForKey:@"bubble"]];
        [scrollView addSubview:[dict objectForKey:@"label"]];
    }
    
    [suggestedTagsView addSubview:scrollView];
    
    return suggestedTagsView;
}

- (void) layoutTextField
{
    if(!_textField) _textField = [[UITextField alloc] init];
    
    [_textField setReturnKeyType:UIReturnKeyDone];
    [_textField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [_textField setAutocorrectionType:UITextAutocorrectionTypeNo];
    
    if([self remainingWidthInCurrentLine] < MIN_WIDTH_FOR_TEXT_FIELD)
    {
        [self addNewLine];
    }
    
    CGFloat textOriginY = LINE_HEIGHT / 2
        - _textField.font.ascender - _textField.font.descender
        + LINE_HEIGHT * _currentLine
        + TOP_AND_BOTTOM_PADDING;

    [_textField setFrame:CGRectMake(_currentX,
                                   textOriginY,
                                   self.frame.size.width - _currentX,
                                   self.frame.size.height)];
    
    [_textField setDelegate:self]; // so we can detect end of input
    
    // Add the scrollview that is glued to the keyboard.
    // It contains tag bubbles with tags that are stored in the suggestedTags property.
    
    // The code below is very similar to the one that creates the tag bubbles above.
    // So it's not very DRY and can probably be optimized.
    
    UIView *suggestedTagsView = [self suggestedTagsView];
    
    if([self.suggestedTags count] > 0)
    {
        [_textField setInputAccessoryView:suggestedTagsView];
    }
    else
    {
        [_textField setInputAccessoryView:nil];
    }
    
    [self addSubview:_textField];
}



- (int) checkTag:(NSString *)tag
{
    BOOL alreadyExists = NO;
    
    for(LZTag *tagsTag in self.tags)
    {
        if([tagsTag.title isEqualToString:tag]) alreadyExists = YES;
    }
    
    if(alreadyExists) return TAG_ALREADY_EXISTS;
    if(tag.length == 0) return TAG_IS_EMPTY;
    return TAG_OK;
}

- (NSSet *) tagSetOfStrings
{
    NSMutableSet *tagsSet = [[NSMutableSet alloc] init];
    for( LZTag *tag in self.tags )
    {
        [tagsSet addObject:tag.title];
    }
    
    return [NSSet setWithSet:tagsSet];
}

- (void) alertWithTitle:(NSString *)title AndMessage:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil]; 
    [alertView show];
}

#pragma mark UITextViewDelegate

- (void) removeTag:(UITapGestureRecognizer *) sender
{
    UILabel *label = (UILabel*)sender.view;
    LZTag *toBeDeleted = nil;
    
    for(LZTag *tag in self.tags)
    {
        if([tag.title isEqualToString:label.text])
            toBeDeleted = tag;
    }
    
    if(toBeDeleted) [self.tags removeObject:toBeDeleted];
    
    [self layoutCustomViews];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField;               // called when clear button pressed. return NO to ignore (no notifications)
{
    NSLog(@"a");
    [self.tags removeLastObject];
    [self layoutCustomViews];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)sender
{
    NSString *tag = sender.text;
    [sender setText:@""];
    
    LZTag *newTag = [[LZTag alloc] initWithTag:tag];
    
    int tagStatus = [self checkTag:tag];
    
    switch(tagStatus){
        case TAG_ALREADY_EXISTS:
            [self alertWithTitle:[NSString stringWithFormat:@"Tag \"%@\" already exists.", tag]
                      AndMessage:@"Please add different tags."];
            return;
        case TAG_IS_EMPTY:
            //[self alertWithTitle:@"Tag is empty"
            //          AndMessage:@"Tags cannot be empty."];
            return;
        default:
            [self.tags addObject:newTag];
            [self layoutCustomViews];
            [_textField becomeFirstResponder];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)sender {
    [sender resignFirstResponder];
    return NO;
}

@end
