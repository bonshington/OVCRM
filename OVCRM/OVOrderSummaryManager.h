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
	NSDictionary *_data;
	NSMutableDictionary *_complementary;
	NSDictionary *criteria;
	NSDictionary *sellable;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;

-(id) initWithTableView:(UITableView *)_tableView;

-(void) filterData;
-(void) loadPromotionLine;

-(void)showWithData:(NSDictionary *)data;
-(void)hide:(id)sender;

@end
