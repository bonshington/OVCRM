//
//  OVHistoryManager.h
//  OVCRM
//
//  Created by Apple on 24/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

#define OVHistoryTable_Width 

@interface OVHistoryManager : NSObject {
	UIView		*_column;
	UITableView *_container;
	UITableView *_tableView;
	NSDictionary *_data;
}

@property (nonatomic, retain) id delegate;

-(id) initWithTableView:(UITableView *)tableView 
				 column:(UIView *)column 
			  container:(UITableView *)container;

-(void) show:(id)sender;
-(void) hide:(id)sender;

-(UITableViewCell *) cellForId:(NSString *)prodId;

@end
