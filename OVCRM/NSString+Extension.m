//
//  NSString_Extension.m
//  OVCRM
//
//  Created by Apple on 05/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString(Extension)

-(NSString *) stringByReplace:(NSArray *)array 
                   withString:(NSString *)withString{
    
    NSString *result = [NSString stringWithString:self];
    
    for(NSString *each in array){
        result = [result stringByReplacingOccurrencesOfString:each withString:withString];
    }
    
    return result;
}

-(NSString *)htmlEncode{
    
    if(self == nil || self.length == 0)
        return @"";
    
    NSString *encoded = [self stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
    
    encoded = [encoded stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"];
    encoded = [encoded stringByReplacingOccurrencesOfString:@"'" withString:@"&apos;"];
    
    encoded = [encoded stringByReplacingOccurrencesOfString:@"<" withString:@"&lt;"];
    encoded = [encoded stringByReplacingOccurrencesOfString:@">" withString:@"&gt;"];
    
    return encoded;
}

@end
