//
//  LtError.h
//  LybabTrans
//
//  Created by Spencer on 8/14/13.
//  Copyright (c) 2013 Yeh Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LtError : NSError

+ (NSError *)errorWithKey: (NSString*)errorKey;
+ (NSError *)errorWithString: (NSString*)errorString;

@end
