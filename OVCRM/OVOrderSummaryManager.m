//
//  OVOrderSummaryManager.m
//  OVCRM
//
//  Created by Apple on 25/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OVOrderSummaryManager.h"
#import "AppDelegate.h"
#import "SFProduct.h"
#import "SFPromotionCriteria.h"

@implementation OVOrderSummaryManager

@synthesize tableView;


-(id) initWithTableView:(UITableView *)_tableView{
	
	self = [super init];
	
	if(self != nil){
		
		_complementary = [NSMutableDictionary new];
		
		_container = _tableView;
		
		self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) 
												  style:UITableViewStyleGrouped];
		self.tableView.hidden = YES;
		//self.tableView.allowsSelection = NO;
		
		self.tableView.dataSource = self;
		self.tableView.delegate = self;
		
		[_container.superview addSubview:self.tableView];
		
		sellable = [AppDelegate sharedInstance].sellable;
		criteria = [SFPromotionCriteria current];
	}
	
	return self;
}

-(void) loadPromotionLine{
	
	[_data enumerateKeysAndObjectsUsingBlock:^(NSString *prodId, NSDictionary *detail, BOOL *stop){
	
		if([criteria objectForKey:prodId] != nil){
			
			NSDictionary *condition = [criteria objectForKey:prodId];
			NSString *promoId = nil;
			NSInteger multiplier = 0;
			
			// check for qty
			if([condition objectForKey:@"Quantity__c"] != nil){
				
				NSInteger qtyCriteria = [condition integerForKey:@"Quantity__c"];
				NSInteger qtyTaking = [detail integerForKey:@"Quantity__c"];
				
				// pass criteria
				if(qtyTaking > qtyCriteria){ // got promotion
					
					promoId = [condition objectForKey:@"Promotion__c"];
					multiplier = qtyTaking / qtyCriteria;
				}
			}
			
			// cehck for amount
			else if([condition objectForKey:@"Amount__c"] != nil){
			
				NSInteger amountCriteria = [condition integerForKey:@"Amount__c"];
				float amountTaking = [detail integerForKey:@"Quantity__c"] * [sellable floatForKey:prodId];
				
				// pass criteria
				if(amountTaking > [condition floatForKey:@"Amount__c"]){
					
					prodId = [condition objectForKey:@"Promotion__c"];
					multiplier = amountTaking / amountCriteria;
				}
			}
			
			
			// calculate line item
			if(promoId != nil){
				NSArray *lines = [[[OVDatabase sharedInstance] executeQuery:@"select *, ? as qty from Promotion_Line_Item__c where Products_Database__c = ?", prodId] readToEnd];
				
				for(NSDictionary *line in lines){
					
					// in case duplicate complimentary items
					
					// already gave
					NSString *subProdId = [line objectForKey:@"Products_Database__c"];
					
					if([_complementary objectForKey:subProdId] != nil){
						
						NSMutableDictionary *adding = [NSMutableDictionary dictionaryWithDictionary:line];
						
						NSInteger existingQty = [[_complementary objectForKey:subProdId] integerForKey:@"qty"] ;
						NSInteger currentQty = [line integerForKey:@"qty"];
						
						[adding setObject:[NSString stringWithFormat:@"%d", existingQty + currentQty]
								   forKey:subProdId];
						
						[_complementary setObject:adding forKey:subProdId];
					}
					// new
					else{
						[_complementary setObject:line forKey:subProdId];
					}
				}
			}
		}
		
	}];
}


#pragma mark - UI

-(void)showWithData:(NSDictionary *)data{
	
	if(!self.tableView.hidden)
		return;
	
	// order detail
	_data = data;
	[self loadPromotionLine];
	
	[self.tableView reloadData];
	
	self.tableView.hidden = NO;
	_container.userInteractionEnabled = NO;

	self.tableView.frame = CGRectMake(-1 * UITableView_SummaryView_Width
							, 0
							, UITableView_SummaryView_Width
							, _container.contentSize.height);
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration: 0.25];
	[UIView setAnimationCurve: UIViewAnimationCurveEaseIn];
	
	self.tableView.frame = CGRectMake(0
							, 0
							, UITableView_SummaryView_Width
							, _container.contentSize.height);
	
	[_container setAlpha:0.2];
	
	[UIView commitAnimations];
}

-(void)hide:(id)sender{
	
	_container.userInteractionEnabled = YES;
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration: 0.25];
	[UIView setAnimationCurve: UIViewAnimationCurveEaseOut];
	[UIView setAnimationDidStopSelector:@selector(didHide:)];
	
	self.tableView.frame = CGRectMake(-1 * UITableView_SummaryView_Width
							, 0
							, UITableView_SummaryView_Width
							, _container.contentSize.height);
	
	[_container setAlpha:1];
	
	[UIView commitAnimations];
}

-(void) didHide:(id)sender{
	self.tableView.hidden = YES;
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 4;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	switch (section) {
		case 0: return 2;
		case 1: return _data.count;
		case 2: return _complementary.count;
		case 3: return 1;
		default: return 0;
	}
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	switch (section) {
		case 0: return @"Total";
		case 1: return @"Taking";
		case 2: return @"Complementary";
			
		default:return nil;
	}
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	UITableViewCell *cell = nil;
	
	switch (indexPath.section) {
		case 0:{
			NSString *cellId = [indexPath toString];
			
			cell = [tableView dequeueReusableCellWithIdentifier:cellId];
			
			if(cell == nil){ // render total
				
				cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
				cell.selectionStyle = UITableViewCellSelectionStyleNone;
				//cell.userInteractionEnabled = NO;
				
				switch (indexPath.row) {
					case 0:
						cell.textLabel.text = @"Total";
						cell.detailTextLabel.text = @"฿ 100.00";
						break;
						
					case 1:
						cell.textLabel.text = @"???";
						cell.detailTextLabel.text = @"฿ 100.00";
						break;
				}
				
			}
		
		}break;
			
		case 1:{
			NSString *prodId = [_data keyAtIndex:indexPath.row];
			
			cell = [tableView dequeueReusableCellWithIdentifier:prodId];
			
			if(cell == nil){ // render products
				
				NSDictionary *indexing = [[AppDelegate sharedInstance].indexing objectForKey: prodId];
				
				cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:prodId];
				
				cell.selectionStyle = UITableViewCellSelectionStyleNone;
				//cell.userInteractionEnabled = NO;
				
				cell.textLabel.text = [indexing objectForKey:@"shortName"];
				cell.detailTextLabel.text = [indexing objectForKey:@"product_Code"];
				
				[cell addSubview:[UILabel labelWithRect:CGRectMake(325, 0, 100, 44) 
													tag:0 
												 text:[[_data objectForKey:prodId] objectForKey:@"Quantity__c"]
								  ]
				 ];
			}
			
		}break;
			
		case 2:{
			// sub product
			NSString *prodId = [_complementary keyAtIndex:indexPath.row];
			
			cell = [tableView dequeueReusableCellWithIdentifier:prodId];
			
			if(cell == nil){ // render products
				
				cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:prodId];
				
				cell.selectionStyle = UITableViewCellSelectionStyleNone;
				//cell.userInteractionEnabled = NO;
				
				cell.textLabel.text = [[_complementary objectForKey:prodId] objectForKey:@"shortName"];
				cell.detailTextLabel.text = [[_complementary objectForKey:prodId] objectForKey:@"product_Code"];
			} 
		}break;
			
		case 3:{ // next button
			
			cell = [tableView dequeueReusableCellWithIdentifier:[indexPath toString]];
			
			if(cell == nil){
				
				cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[indexPath toString]];
				
				
				cell.selectionStyle = UITableViewCellSelectionStyleBlue;
				
				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
				cell.textLabel.text = @"           Next";
			}
			
		}break;
	}
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	if (indexPath.section == 3) {
		
		// save
		
		[self hide:tableView];
	}
}



@end
