//
//  LtUsageData.h
//  Lutino
//
//  Created by Spencer Yeh on 12/10/13.
//  Copyright (c) 2013 Yeh Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface LtUsageData : NSManagedObject

@property (nonatomic, retain) NSDate * lastRechargeDate;
@property (nonatomic, retain) NSNumber * remainingAnytimeCredits;
@property (nonatomic, retain) NSNumber * remainingDailyCredits;
@property (nonatomic, retain) NSNumber * totalCharacters;
@property (nonatomic, retain) NSNumber * totalTranslations;
@property (nonatomic, retain) NSString * racCode;
@property (nonatomic, retain) NSString * rdcCode;

@end
