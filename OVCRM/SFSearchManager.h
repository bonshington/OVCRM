//
//  SFSearchManager.h
//  OVCRM
//
//  Created by Apple on 10/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFSearchManager : NSObject

@property(nonatomic, retain) NSDictionary *fetched;

-(void) search:(NSString *)text;

@end



@interface SFSearchManager (UITableViewHandler)<UITableViewDataSource, UITableViewDelegate>

@end
