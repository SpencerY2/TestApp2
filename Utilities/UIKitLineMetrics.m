//
//  UIKitLineMetrics.m
//  Lutino
//
//  Created by Spencer Yeh on 11/7/13.
//  Copyright (c) 2013 Yeh Technology. All rights reserved.
//

#import "UIKitLineMetrics.h"

@interface UIKitLineMetrics ()

@property (nonatomic, strong) UITextView *measuringTextView;
@property (nonatomic, strong) UITextView *measuringSingleTextView;

@end

@implementation UIKitLineMetrics
{
    UIFont *m_PriorFont;
    CGFloat m_PriorWidth;
}

@synthesize measuringTextView;
@synthesize measuringSingleTextView;
@synthesize attributedString;

- (id) init
{
    self = [super init];
    
    if( self )
    {
        attributedString = [[NSMutableAttributedString alloc] init];
        measuringTextView = [[UITextView alloc] initWithFrame:CGRectZero];
        //measuringSingleTextView = [[UITextView alloc] initWithFrame:CGRectZero];
    }
    
    return self;
}

- (CGSize) UIKitLineSizeForText:(NSString*)text
{
    //measuringTextView.text = [text stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    measuringTextView.text = text;
    
    CGSize sz = [measuringTextView sizeThatFits:CGSizeMake(measuringTextView.frame.size.width, CGFLOAT_MAX)];
    
    return CGSizeMake(sz.width - 16, sz.height - 16);
}

- (CGSize) UIKitSingleLineSizeForText:(NSString*)text
{
    measuringSingleTextView.text = [text stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    CGSize sz = [measuringSingleTextView sizeThatFits:CGSizeMake(measuringSingleTextView.frame.size.width, CGFLOAT_MAX)];
    
    return CGSizeMake(sz.width - 16, sz.height - 16);
}

- (void) updateWithFont:(UIFont*)font andWidth:(CGFloat)width
{
    if (font != m_PriorFont)
    {
        measuringTextView.font = font;
        //measuringSingleTextView.font = font;
        m_PriorFont = font;
    }
    
    if (width != m_PriorWidth)
    {
        measuringTextView.frame = CGRectMake(0, 0, width, 500);
        //measuringSingleTextView.frame = CGRectMake(0, 0, 50000, 500);
        m_PriorWidth = width;
    }
}

@end
