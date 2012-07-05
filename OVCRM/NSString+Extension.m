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

@end
