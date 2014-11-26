//
//  LtLanguage.h
//  LybabTrans
//
//  Created by Spencer on 8/5/13.
//  Copyright (c) 2013 Yeh Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LtLocale : NSObject

@property (nonatomic, retain) NSString *localeCode;
@property (nonatomic, retain) NSString *languageCode;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) UIImage *smallFlag;
@property (nonatomic, retain) UIImage *mediumFlag;
@property (nonatomic, retain) UIImage *largeFlag;

- (id)initWithLocaleCode:(NSString *)locale;
- (id)initWithValues:(NSString *)locale name:(NSString *)name;

@end
