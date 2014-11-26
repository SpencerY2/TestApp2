//
//  LtSupportedLocales.h
//  Lutino
//
//  Created by Spencer Yeh on 11/2/13.
//  Copyright (c) 2013 Yeh Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LtSupportedLocales : NSObject

@property (nonatomic, retain) NSMutableArray *recognitionLocaleCodes;  // NSString
@property (nonatomic, retain) NSMutableArray *translationLocales;  // LtLocale
@property (nonatomic, retain) NSMutableArray *vocalizationLocaleCodes;  // NSString

+ (LtSupportedLocales *)instance;
+ (void)refresh;
+ (void)refresh:(NSString *)translatorName;
+ (void)refresh:(NSString *)translatorName withRecognizer:(NSString *)recognizerName andVocalizer:(NSString *)vocalizerName;

@end
