//
//  OVGoodReturnViewController.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/22/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "OVGoodReturnViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation OVGoodReturnViewController

@synthesize data, pickerView;

- (void)viewDidLoad
{
	reasonsOfReturn = [NSArray arrayWithObjects:
					   @"",
					   @"Customer Reject", 
					   @"Damaged",
					   @"Expired",
					   @"Others",
					   @"Wrong Order",
					   nil];
	
	self.delegate = self;
	
	[self load];
	
    [super viewDidLoad];
    
	self.title = @"Market Hygiene";
	
	self.pickerView.frame = CGRectMake(self.tableView.frame.size.width
									   , 0
									   , self.pickerView.frame.size.width
									   , self.pickerView.frame.size.height);
	
	[self.view addSubview:self.pickerView];

	tapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePicker:)];
    tapped.numberOfTapsRequired = 1;
}


-(void) load{
	
	OVDatabase *db = [OVDatabase sharedInstance];
	
	if(!db.open)
		[db open];
	
	self.data = [NSMutableDictionary new];
	
	NSArray *unsync = [[db executeQuery:@"select * from Upload where planId = ? and sObject = 'Goods_Return__c' and syncTime is null", self.planId] readToEnd];
	
	// resume
	if(unsync != nil && unsync.count > 0){
		
		[unsync enumerateObjectsUsingBlock:^(NSDictionary *upload, NSUInteger index, BOOL *stop){
		
			NSDictionary *json = [SFJsonUtils objectFromJSONString:[upload objectForKey:@"json"]];
			
			[self.data setObject:json forKey:[json objectForKey:@"prod_db_id__c"]];
		}];
	}
	else{
		// load synced
		self.data = [NSMutableDictionary dictionaryWithDictionary:
					 [[db executeQuery:
					   @"select * from Goods_Return__c where Account__c = ? and Return_Date__c in (select ActivityDate from Plan where Id = ?)", self.accountId, self.planId] readToEndBy:@"prod_db_id__c"]];
		
		
	}
	
	// incase load not found
	if(self.data == nil)
		self.data = [NSMutableDictionary new];
	
}

- (void)openPicker:(id)sender{
	
	[self.view endEditing:YES];
	
	UIButton *button = (UIButton *)sender;
	selected = [button lookupFor:[UITableViewCell class]];
	
	// capture cell image
	UIGraphicsBeginImageContext(selected.frame.size);
	[selected.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *cellImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	mimic = [[UIImageView alloc] initWithImage:cellImage];
	
	
	CGRect positionToScreen = [self.tableView convertRect:[self.tableView rectForRowAtIndexPath:[self.tableView indexPathForCell:selected]] 
												   toView:self.view];
	
	self.pickerView.frame = CGRectMake(self.tableView.frame.size.width
									   , positionToScreen.origin.y+ selected.frame.size.height
									   , self.pickerView.frame.size.width
									   , self.pickerView.frame.size.height);
	
	mimic.frame = CGRectMake(0
							 , positionToScreen.origin.y
							 , selected.frame.size.width
							 , selected.frame.size.height);
	
	// display as cell itself
	[self.view addSubview:mimic];
	
	self.tableView.scrollEnabled = NO;
	self.searchBar.userInteractionEnabled = NO;
	
	
	[UIView beginAnimations:nil context: NULL];
	[UIView setAnimationDuration: 0.25];
	[UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
	
	[self.tableView setAlpha:0.3];
	
	self.pickerView.frame = CGRectMake(self.pickerView.frame.origin.x - self.pickerView.frame.size.width
									   , self.pickerView.frame.origin.y
									   , self.pickerView.frame.size.width
									   , self.pickerView.frame.size.height);
	
	[UIView commitAnimations];
	
	// add tapped gesture to tableView recognition
    [self.tableView addGestureRecognizer:tapped];
}

- (void)hidePicker:(id)sender{
	
	if(mimic == nil)
		return;
	
	
	[mimic removeFromSuperview];

	[UIView beginAnimations:nil context: NULL];
	[UIView setAnimationDuration: 0.25];
	[UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
	
	[self.tableView setAlpha:1];
	
	pickerView.frame = CGRectMake(self.tableView.frame.size.width
								  , pickerView.frame.origin.y
								  , self.pickerView.frame.size.width
								  , self.pickerView.frame.size.height);
	
	[UIView commitAnimations];
	
	[self.tableView removeGestureRecognizer:tapped];
	self.tableView.scrollEnabled = YES;
	self.searchBar.userInteractionEnabled = YES;
	
	mimic = nil;
	selected = nil;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
	
	[self hidePicker:textField];
	
	return YES;
}

@end
