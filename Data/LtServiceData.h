//
//  LtServiceData.h
//  Lutino
//
//  Created by Spencer Yeh on 12/10/13.
//  Copyright (c) 2013 Yeh Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LtLocaleData;

@interface LtServiceData : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *locales;
@end

@interface LtServiceData (CoreDataGeneratedAccessors)

- (void)addLocalesObject:(LtLocaleData *)value;
- (void)removeLocalesObject:(LtLocaleData *)value;
- (void)addLocales:(NSSet *)values;
- (void)removeLocales:(NSSet *)values;

@end
