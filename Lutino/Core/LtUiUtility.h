//
//  LtUiUtility.h
//  Lutino
//
//  Created by Spencer Yeh on 11/24/14.
//  Copyright (c) 2014 Yeh Technology. All rights reserved.
//
// Class to hold static utility functions for UI

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LtUiUtility : NSObject

+(void)logViewHierarchyForView:(UIView *)view;
+(void)logViewHierarchyForView:(UIView *)view showConstraints:(BOOL)showConstraints;
+(void)logContraintsForView:(UIView *)view;
+(UIView*)getAncestorViewOf:(UIView *)view ofType:(Class)classType;
+(UIView*)getChildViewOf:(UIView *)view ofType:(Class)classType;


@end
