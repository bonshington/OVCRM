//
//  NSDictionary+NullHandling.m
//  OVCRM
//
//  Created by Apple on 05/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSDictionary+NullHandling.h"

@implementation NSDictionary (NullHandling)

- (id)emptyIfNull:(id)key{
    
    id test = [self objectForKey:key];
    
    if(test == nil || test == [NSNull null] || test == NULL)
        return @"";
    else {
        return test;
    }
}

@end
