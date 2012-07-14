//
//  SFSearchManager+UITableViewHandler.m
//  OVCRM
//
//  Created by Apple on 10/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SFSearchManager.h"
#import "SFAccount.h"
#import "AppDelegate.h"

@implementation SFSearchManager (UITableViewHandler)

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AppDelegate *app = [AppDelegate sharedInstance];
    UITableViewCell *tappedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    //if !confirm, return
    
    
    [app.detail popToRootViewControllerAnimated:NO];
    
    switch (tappedCell.tag) {
			
        case tagForCellAccount:{
            
            NSString *accountId = ((UILabel *)[tappedCell viewWithTag:tagForSFAccountId]).text;
            
            // show account
			[self.delegate invokeSFObject:((UILabel *)[tappedCell viewWithTag:tagForTableName]).text
							 withMustache:[SFAccount selectAccountContextOf:accountId] 
					   withRightBarButton:nil];        
		}break;
            
    }
	
	[self.searchBox resignFirstResponder];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if(self.fetched == nil) 
        return 0;
    
    else 
        return [self.fetched allKeys].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [(NSArray *)[self.fetched objectAtIndex:section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return  [[self.fetched allKeys] objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *entry = [(NSArray *)[self.fetched objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    NSString *sObjectId = [entry objectForKey:@"Id"];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sObjectId];
    
    if(cell == nil){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:sObjectId];
        
        cell.textLabel.text = [entry objectForKey:@"label"];
        cell.detailTextLabel.text = [entry objectForKey:@"detail"];
		
		if([@"Account"isEqualToString:[entry objectForKey:@"obj"]]){
			cell.tag = tagForCellAccount;
			
			UILabel *accountId = [UILabel new];
			accountId.hidden = YES;
			accountId.text = sObjectId;
			accountId.tag = tagForSFAccountId;
			
			[cell addSubview:accountId];
		}
        
        UILabel *tableName = [UILabel new];
        tableName.hidden = YES;
        tableName.text = [entry objectForKey:@"obj"];
        tableName.tag = tagForTableName;
        
        [cell addSubview:tableName];
    }
    
    return cell;
}



@end
