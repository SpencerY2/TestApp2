//
//  LtTranslationData.h
//  Lutino
//
//  Created by Spencer Yeh on 12/10/13.
//  Copyright (c) 2013 Yeh Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LtLocaleData;

@interface LtTranslationData : NSManagedObject

@property (nonatomic, retain) NSDate * createdDate;
@property (nonatomic, retain) NSString * text1Locale;
@property (nonatomic, retain) NSString * text1Text;
@property (nonatomic, retain) NSString * text2Locale;
@property (nonatomic, retain) NSString * text2Text;
@property (nonatomic, retain) LtLocaleData *locale1;
@property (nonatomic, retain) LtLocaleData *locale2;

@end
