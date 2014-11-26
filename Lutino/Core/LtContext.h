//
//  LtContext.h
//  LybabTrans
//
//  Created by Spencer Yeh on 10/9/13.
//  Copyright (c) 2013 Yeh Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LtContext : NSObject

//@property (nonatomic, retain) NSManagedObjectContext* instance;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectContext *defaultDataManagedObjectContext;

- (void)save;
- (NSURL *)applicationDocumentsDirectory;

+(LtContext *)instance;

//-(NSManagedObjectContext *)defaultDataManagedObjectContext;
-(void)generateDefaultData;

@end
