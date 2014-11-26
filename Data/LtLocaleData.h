//
//  LtLocaleData.h
//  Lutino
//
//  Created by Spencer Yeh on 12/10/13.
//  Copyright (c) 2013 Yeh Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LtServiceData, LtTranslationData;

@interface LtLocaleData : NSManagedObject

@property (nonatomic, retain) NSData * largeFlag;
@property (nonatomic, retain) NSString * locale;
@property (nonatomic, retain) NSData * mediumFlag;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSData * smallFlag;
@property (nonatomic, retain) NSSet *services;
@property (nonatomic, retain) NSSet *translation1;
@property (nonatomic, retain) NSSet *translation2;
@end

@interface LtLocaleData (CoreDataGeneratedAccessors)

- (void)addServicesObject:(LtServiceData *)value;
- (void)removeServicesObject:(LtServiceData *)value;
- (void)addServices:(NSSet *)values;
- (void)removeServices:(NSSet *)values;

- (void)addTranslation1Object:(LtTranslationData *)value;
- (void)removeTranslation1Object:(LtTranslationData *)value;
- (void)addTranslation1:(NSSet *)values;
- (void)removeTranslation1:(NSSet *)values;

- (void)addTranslation2Object:(LtTranslationData *)value;
- (void)removeTranslation2Object:(LtTranslationData *)value;
- (void)addTranslation2:(NSSet *)values;
- (void)removeTranslation2:(NSSet *)values;

@end
