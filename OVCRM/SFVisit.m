//
//  SFVisit.m
//  OVCRM
//
//  Created by Apple on 05/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SFVisit.h"

#define SFVisit_columns @""

@implementation SFVisit

- (void)request:(SFRestRequest *)request 
didLoadResponse:(id)jsonResponse{
    
}

+(void) loadAfterDate:(NSString *)date{
    
    [super loadWithQuery:[NSString stringWithFormat:@"select %@ from Event where ActivityDate >= %@", SFVisit_columns, date] delegate:[SFVisit new]];
}

@end
