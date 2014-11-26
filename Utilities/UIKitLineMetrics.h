//
//  UIKitLineMetrics.h
//  Lutino
//
//  Created by Spencer Yeh on 11/7/13.
//  Copyright (c) 2013 Yeh Technology. All rights reserved.
//
// http://stackoverflow.com/questions/3612491/discrepancy-between-sizewithfontconstrainedtosizelinebreakmode-and-textview-c

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIKitLineMetrics : NSObject

@property (nonatomic, strong) NSMutableAttributedString *attributedString;

- (CGSize) UIKitLineSizeForText:(NSString*)text;
- (CGSize) UIKitSingleLineSizeForText:(NSString*)text;

- (void) updateWithFont:(UIFont*)font andWidth:(CGFloat)width;

@end
