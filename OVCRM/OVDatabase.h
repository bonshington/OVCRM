//
//  OVDataWrapper.h
//  OVCRM
//
//  Created by Apple on 03/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFRestAPI.h"
#import "SFRestRequest.h"
#import "FMDatabase.h"

@interface OVDatabase : FMDatabase

+ (OVDatabase *) sharedInstance;

@end



@interface OVDatabase (FMDB)

-(BOOL) insertOrReplaceTable:(NSString *)tableName 
                              columns:(NSArray *)columns
                                 data:(NSArray *)rows;

@end




#pragma mark - SalesForce Objects

@interface OVDatabase (SFAccount)

//-(NSArray *) selectByRoute:(NSString *)route;

@end