//
//  LtServiceLocaleData.h
//  Lutino
//
//  Created by Spencer Yeh on 12/10/13.
//  Copyright (c) 2013 Yeh Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface LtServiceLocaleData : NSManagedObject

@property (nonatomic, retain) NSString * locale;
@property (nonatomic, retain) NSString * service;

@end
