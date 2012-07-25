//
//  OVOrderSummaryManager.h
//  OVCRM
//
//  Created by Apple on 25/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OVOrderSummaryManager : NSObject <UITableViewDataSource, UITableViewDelegate>{
	UITableView *_container;
	UITableView *_tableView;
	NSDictionary *_data;
}

@property (nonatomic, retain) IBOutlet UITableView *view;


-(id) initWithTableView:(UITableView *)tableView;

-(void) filterData;

-(void)showWithData:(NSDictionary *)data;
-(void)hide:(id)sender;

@end
