//
//  LtUiUtility.m
//  Lutino
//
//  Created by Spencer Yeh on 11/24/14.
//  Copyright (c) 2014 Yeh Technology. All rights reserved.
//

#import "LtUiUtility.h"

@implementation LtUiUtility

+(void)logViewHierarchyForView:(UIView *)view
{
    [self logViewHierarchyForView:view showConstraints:NO];
}

+(void)logViewHierarchyForView:(UIView *)view showConstraints:(BOOL)showConstraints
{
    NSLog(@"Logging view hierarchy for %@", view.class);
    [self logViewHierarchyRecursive:view depth:0 showConstraints:showConstraints];
}

+ (void)logViewHierarchyRecursive:(UIView *)view depth:(NSInteger)depth showConstraints:(BOOL)showConstraints

{
    if (!view)
    {
        return;
    }
    
    NSMutableString *tabString = [NSMutableString stringWithCapacity:depth];
    
    // Output string of hyphens to represent View depth
    for (int i = 0; i < depth; i++)
    {
        [tabString appendString:@"-- "];
    }
    NSLog(@"%@%@", tabString, view);
    
    if (showConstraints)
    {
        [self logContraintsForView:view];
    }
    
    NSArray *subviews = [view subviews];
    
    if (subviews)
    {
        // Recursively log subviews
        for (UIView *view in subviews)
        {
            [self logViewHierarchyRecursive:view depth:depth+1 showConstraints:showConstraints];

        }
    }
}

+(void)logContraintsForView:(UIView *)view
{
    NSArray *constraintsArray = view.constraints;
    
    NSLog(@"Logging view constraints for %@ with %d constraints", view.class, view.constraints.count);
    
    for (int i=0; i < [constraintsArray count]; i++) {
        NSLog(@"%@", [constraintsArray objectAtIndex:i]);
    }
}

+ (UIView *)getAncestorViewOf:(UIView *)view ofType:(Class)classType
{
    while ([view isKindOfClass:[UIView class]])
    {
        view = [view superview];
        if ([view isKindOfClass:classType])
        {
            return view;
        }
    }
    return nil;
}

// Looks for child of specific type
+(UIView *)getChildViewOf:(UIView *)view ofType:(Class)classType
{
    if (!view)
    {
        return nil;
    }
    
    if ([view isKindOfClass:classType])
    {
        return view;
    }
    else
    {
        NSArray *subviews = [view subviews];
        
        if (subviews)
        {
            for (UIView *subview in subviews)
            {
                UIView *childView = [self getChildViewOf:subview ofType:classType];
                if (childView != nil)
                {
                    return childView;
                }
                // otherwise keep looking...
            }
        }
        else
        {
            return nil;
        }
    }
    return nil;
}

@end
