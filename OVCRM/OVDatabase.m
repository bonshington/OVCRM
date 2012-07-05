//
//  OVDataWrapper.m
//  OVCRM
//
//  Created by Apple on 03/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OVDatabase.h"
#import "AppDelegate.h"

@implementation OVDatabase

-(id) init{
    
    AppDelegate *app = [AppDelegate sharedInstance];
    
    if(app.db == nil){
        
        NSString *docsDir;
        NSArray *dirPaths;
        
        // Get the documents directory
        dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        docsDir = [dirPaths objectAtIndex:0];
        
        // Build the path to the database file
        NSString *databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: [NSString stringWithFormat:@"%@.db", [SFRestAPI sharedInstance].coordinator.credentials.userId]]];
        
        NSFileManager *filemgr = [NSFileManager defaultManager];
        
        app.db = [self initWithPath:databasePath];
        app.db.logsErrors = YES;
        
        [app.db open];
    }  
    else{
        self = app.db;
    }
    
    return self;
}

+ (OVDatabase *) sharedInstance{

    return [AppDelegate sharedInstance].db;
}

@end
