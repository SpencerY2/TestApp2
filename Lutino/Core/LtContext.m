//
//  LtContext.m
//  LybabTrans
//
//  Created by Spencer Yeh on 10/9/13.
//  Copyright (c) 2013 Yeh Technology. All rights reserved.
//

#import "LtContext.h"
#import "LtPropertyData.h"
#import "LtLocaleData.h"
#import "LtServiceLocaleData.h"
#import "LtUsageData.h"
#import "LtServiceData.h"

@implementation LtContext


@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
//@synthesize defaultDataManagedObjectContext = _defaultDataManagedObjectContext;


static LtContext *s_Instance = nil;

+(LtContext *)instance
{
    @synchronized(self)
    {
        if (s_Instance == nil)
        {
            s_Instance = [LtContext new];
        }
    }
    return s_Instance;
}


- (void)save
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"LtData" withExtension:@"momd"];
    
    NSLog(@"model URL: %@", modelURL);
    
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"LtData.sqlite"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:[storeURL path]]) {
        NSString *defaultDataPath = [[NSBundle mainBundle] pathForResource:@"LtDataDefault" ofType:@"sqlite"];
        
        if (defaultDataPath == nil)
        {
            // Generate default data file
            @throw ([NSException exceptionWithName:@"NullReferenceException" reason:@"Missing default data file" userInfo:nil]);
        }
        else
        {
            NSURL *preloadURL = [NSURL fileURLWithPath:defaultDataPath];
            NSError* err = nil;
            
            if (![[NSFileManager defaultManager] copyItemAtURL:preloadURL toURL:storeURL error:&err]) {
                @throw ([NSException exceptionWithName:@"Exception" reason:@"Failed to copy default data file" userInfo:nil]);
            }
        }
    }
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)defaultDataManagedObjectContext
{
    NSManagedObjectContext *context = nil;
    
    @autoreleasepool {
        context = [[NSManagedObjectContext alloc] init];
        
        NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
        [context setPersistentStoreCoordinator:coordinator];
        
        NSString *STORE_TYPE = NSSQLiteStoreType;
        
        NSURL *url = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"LtDataDefault.sqlite"];
        
        NSLog (@"Store path: %@", url);
        
        NSError *error;
        
        [[NSFileManager defaultManager] removeItemAtURL:url error:&error];
        
        NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption:@YES,
                    NSInferMappingModelAutomaticallyOption:@YES,
                    NSSQLitePragmasOption: @{@"journal_mode": @"DELETE"}  // old style SQLite single file.
                    };
        
        NSPersistentStore *newStore = [coordinator addPersistentStoreWithType:STORE_TYPE configuration:nil URL:url options:options error:&error];
        
        if (newStore == nil) {
            NSLog(@"Store Configuration Failure %@", ([error localizedDescription] != nil) ? [error localizedDescription] : @"Unknown Error");
        }
        
    }
    return context;
}

- (void) generateDefaultData {
    // Create the managed object context
    NSManagedObjectContext *context = LtContext.instance.defaultDataManagedObjectContext;
    
    // Load Property data
    NSError* error = nil;
    NSString* dataPath = [[NSBundle mainBundle] pathForResource:@"Property" ofType:@"json"];
    NSArray* Property = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:dataPath]
                                                        options:kNilOptions
                                                          error:&error];
    NSLog(@"Imported Property: %@", Property);
    
    [Property enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        LtPropertyData *entity = [NSEntityDescription
                                  insertNewObjectForEntityForName:@"LtPropertyData"
                                  inManagedObjectContext:context];
        entity.key = [obj objectForKey:@"key"];
        entity.value = [obj objectForKey:@"value"];
        
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Couldn't save Property: %@", [error localizedDescription]);
        }
    }];
    
    // Test listing all Property from the store
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"LtPropertyData"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (LtPropertyData *info in fetchedObjects) {
        NSLog(@"key: %@", info.key);
        NSLog(@"value: %@", info.value);
    }
    
    // Load Locale data
    dataPath = [[NSBundle mainBundle] pathForResource:@"Locale" ofType:@"json"];
    NSArray* Locale = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:dataPath]
                                                      options:kNilOptions
                                                        error:&error];
    NSLog(@"Imported Locale: %@", Locale);
    
    
    [Locale enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        LtLocaleData *entity = [NSEntityDescription
                                insertNewObjectForEntityForName:@"LtLocaleData"
                                inManagedObjectContext:context];
        entity.locale = [obj objectForKey:@"locale"];
        entity.name = [obj objectForKey:@"name"];
        
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Couldn't save Locale: %@", [error localizedDescription]);
        }
    }];
    
    // Test listing all Locale from the store
    fetchRequest = [[NSFetchRequest alloc] init];
    entity = [NSEntityDescription entityForName:@"LtLocaleData"
                         inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (LtLocaleData *info in fetchedObjects) {
        NSLog(@"locale: %@", info.locale);
        NSLog(@"name: %@", info.name);
    }
    
    // Load ServiceLocale data
    dataPath = [[NSBundle mainBundle] pathForResource:@"ServiceLocale" ofType:@"json"];
    NSArray* ServiceLocale = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:dataPath]
                                                      options:kNilOptions
                                                        error:&error];
    NSLog(@"Imported ServiceLocale: %@", ServiceLocale);
    
    NSMutableArray *serviceLocaleArray = [[NSMutableArray alloc] initWithCapacity:100];
    
    [ServiceLocale enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        LtServiceLocaleData *entity = [NSEntityDescription
                                insertNewObjectForEntityForName:@"LtServiceLocaleData"
                                inManagedObjectContext:context];
        entity.service = [obj objectForKey:@"service"];
        entity.locale = [obj objectForKey:@"locale"];
        
        [serviceLocaleArray addObject:entity];
        
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Couldn't save ServiceLocale: %@", [error localizedDescription]);
        }
    }];
    
    // Test listing all ServiceLocale from the store
    fetchRequest = [[NSFetchRequest alloc] init];
    entity = [NSEntityDescription entityForName:@"LtServiceLocaleData"
                         inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (LtServiceLocaleData *info in fetchedObjects) {
        NSLog(@"service: %@", info.service);
        NSLog(@"locale: %@", info.locale);
    }

    // Load Service data
    dataPath = [[NSBundle mainBundle] pathForResource:@"Service" ofType:@"json"];
    NSArray* Service = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:dataPath]
                                                      options:kNilOptions
                                                        error:&error];
    NSLog(@"Imported Service: %@", Service);
    
    
    [Service enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        LtServiceData *entity = [NSEntityDescription
                                insertNewObjectForEntityForName:@"LtServiceData"
                                inManagedObjectContext:context];
        entity.name = [obj objectForKey:@"name"];
        
        NSError *error;
        
        // Get the locales associated with the service
        NSFetchRequest *fetchRequest3 = [NSFetchRequest new];
        NSEntityDescription *entity3 = [NSEntityDescription entityForName:@"LtServiceLocaleData" inManagedObjectContext:context];
        [fetchRequest3 setEntity:entity3];
        NSPredicate *predicate3 = [NSPredicate predicateWithFormat:@"service == %@", entity.name];
        [fetchRequest3 setPredicate:predicate3];
        [fetchRequest3 setReturnsDistinctResults:YES];
        [fetchRequest3 setResultType:NSDictionaryResultType];
        [fetchRequest3 setPropertiesToFetch:@[@"locale"]];
        NSArray *fetchedObjects3 = [context executeFetchRequest:fetchRequest3 error:&error];
        
        // Transfer to an array of strings.
        NSMutableArray *localeArray = [NSMutableArray arrayWithCapacity:100];
        for (NSDictionary *dict in fetchedObjects3)
        {
            [localeArray addObject:[dict objectForKey:@"locale"]];
        }
        
        // Pull up managed objects for those locales
        NSFetchRequest *fetchRequest2 = [NSFetchRequest new];
        NSEntityDescription *entity2 = [NSEntityDescription entityForName:@"LtLocaleData" inManagedObjectContext:context];
        [fetchRequest2 setEntity:entity2];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"locale IN %@", localeArray];
        [fetchRequest2 setPredicate:predicate];
        NSArray *fetchedObjects2 = [context executeFetchRequest:fetchRequest2 error:&error];
        
        // Make an NSSet of the LtLocaleData's
        NSSet *localesSet = [NSSet setWithArray:fetchedObjects2];
        
        // Set as the associated locales
        entity.locales = localesSet;

        if (![context save:&error]) {
            NSLog(@"Couldn't save Service: %@", [error localizedDescription]);
        }
    }];
    
    // Test listing all Service from the store
    fetchRequest = [[NSFetchRequest alloc] init];
    entity = [NSEntityDescription entityForName:@"LtServiceData"
                         inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (LtServiceData *info in fetchedObjects) {
        NSLog(@"name: %@", info.name);
        NSLog(@"locales: %@", info.locales);
    }
    
    // Load Usage data
    error = nil;
    dataPath = [[NSBundle mainBundle] pathForResource:@"Usage" ofType:@"json"];
    NSArray *Usage = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:dataPath]
                                                        options:kNilOptions
                                                          error:&error];
    NSLog(@"Imported Usage: %@", Usage);
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];

    [Usage enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        LtUsageData *entity = [NSEntityDescription
                                  insertNewObjectForEntityForName:@"LtUsageData"
                                  inManagedObjectContext:context];
        
//        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];

        entity.totalTranslations = [numberFormatter numberFromString:[obj objectForKey:@"totalTranslations"]];
        entity.remainingDailyCredits = [numberFormatter numberFromString:[obj objectForKey:@"remainingDailyCredits"]];
        entity.remainingAnytimeCredits = [numberFormatter numberFromString:[obj objectForKey:@"remainingAnytimeCredits"]];
        entity.totalCharacters = [numberFormatter numberFromString:[obj objectForKey:@"totalCharacters"]];
        entity.lastRechargeDate = [dateFormatter dateFromString:[obj objectForKey:@"lastRechargeDate"]];
        
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Couldn't save Usage: %@", [error localizedDescription]);
        }
    }];
    
    // Test listing all Usage from the store
    fetchRequest = [[NSFetchRequest alloc] init];
    entity = [NSEntityDescription entityForName:@"LtUsageData"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (LtUsageData *info in fetchedObjects) {
        NSLog(@"totalTranslations: %@", info.totalTranslations);
        NSLog(@"totalCharacters: %@", info.totalCharacters);
        NSLog(@"remainingDailyCredits: %@", info.remainingDailyCredits);
        NSLog(@"remainingAnytimeCredits: %@", info.remainingAnytimeCredits);
        NSLog(@"lastRechargeDate: %@", info.lastRechargeDate);
    }
    
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end
