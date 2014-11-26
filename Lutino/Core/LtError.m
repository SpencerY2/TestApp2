//
//  LtError.m
//  LybabTrans
//
//  Created by Spencer on 8/14/13.
//  Copyright (c) 2013 Yeh Technology. All rights reserved.
//

#import "LtError.h"

@implementation LtError

+ (NSError *)errorWithKey: (NSString*)errorKey
{
    NSString *domain = @"com.YehTechnology.Lutino";
    NSString *desc = NSLocalizedString(errorKey, @"");
    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : desc };
    
    NSError *error = [NSError errorWithDomain:domain code:-101 userInfo:userInfo];
    
    return error;
}

+ (NSError *)errorWithString: (NSString*)errorString
{
    NSString *domain = @"com.YehTechnology.Lutino";
    NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : errorString };
    
    NSError *error = [NSError errorWithDomain:domain code:-102 userInfo:userInfo];
    
    return error;
}

@end
