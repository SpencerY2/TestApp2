//
//  LtAppNameConstants.h
//  Lutino
//
//  Created by Spencer Yeh on 10/31/13.
//  Copyright (c) 2013 Yeh Technology. All rights reserved.
//

#ifndef Lutino_LtAppNameConstants_h
#define Lutino_LtAppNameConstants_h

typedef enum {
    kFreeVersion,
    kStandard,
} BuildType;

#ifdef FREE_VERSION_BUILD
#define kBuildType kFreeVersion
#else
#define kBuildType kStandard
#endif

/*
 *  System Versioning Preprocessor Macros
 */

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#endif