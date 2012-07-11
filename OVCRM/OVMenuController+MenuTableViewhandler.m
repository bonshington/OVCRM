//
//  OVRootViewController+Menu.m
//  OVCRM
//
//  Created by Apple on 03/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OVMenuController.h"
#import "OVWebViewController.h"
#import "OVSyncController.h"

@implementation OVMenuController (MenuTableViewhandler)

#pragma mark - Sections

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    /*
     
     1. Current Checked-in Account, has checkout button at footer
     2. Account list for today plan
     3. Available menus
     
    */
    
    if(self.checkedinAccount == nil){
        return 3;
    }
    else {
        return 4;
    }
}

- (NSString *)tableView:(UITableView *)tableView 
titleForHeaderInSection:(NSInteger)section{

    if(self.checkedinAccount == nil){
        switch(section){
                
            case 0: return @"Visit";
                
            case 1: return @"Menu";
                
            case 2: return @"SalesForce";
        }
    }
    else{
        switch(section){
                
            case 0: return @"Checkin";
                
            case 1: return @"Visit";
                
            case 2: return @"Menu";
                
            case 3: return @"SalesForce";
        }
    }
    
    return @"???";
}

- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section{
    
    if(self.checkedinAccount == nil){
        switch(section){
            case 0: return self.todayPlan.count;
                
            case 1: return 0;
                
            case 2: return 1;
                
            default: return 0;
        }
    }
    else{
        switch(section){
            case 0: return 0;
                
            case 1: return self.todayPlan.count;
                
            case 2: return 0;
                
            case 3: return 1;
                
            default: return 0;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(self.checkedinAccount == nil){
        switch(indexPath.section){
            case 0: return [self tableView:tableView planForRowAtIndexPath:indexPath];
                
            case 1: return nil;
                
            case 2: return [self tableView:tableView sfForRowAtIndexPath:indexPath];
                
            default: return nil;
        }
    }
    else{
        switch(indexPath.section){
            case 0: return nil;
                
            case 1: return [self tableView:tableView planForRowAtIndexPath:indexPath];
                
            case 2: return nil;
                
            case 3: return [self tableView:tableView sfForRowAtIndexPath:indexPath];
                
            default: return nil;
        }
    }
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    cell.textLabel.text = @"tt";
    
    return cell;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AppDelegate *app = [AppDelegate sharedInstance];
    UITableViewCell *tappedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    //if !confirm, return
    
    
    [app.detail popToRootViewControllerAnimated:NO];
    
    switch (tappedCell.tag) {
        case tagForCellPlanVisit:{
            
            NSString *accountId = ((UILabel *)[tappedCell viewWithTag:tagForSFAccountId]).text;
            
            NSDictionary *viewData = [NSDictionary dictionaryWithObjectsAndKeys:
                                      [[app.db executeQuery:@"select * from Account where Id = ?", accountId] readToEnd], @"Account", 
                                      [[app.db executeQuery:@"select * from Event where WhatId = ?", accountId] readToEnd], @"Event", 
                                      nil];
            
            UIBarButtonItem *checkin = [[UIBarButtonItem alloc] initWithTitle:@"Check-in" 
                                                                        style:UIBarButtonItemStyleDone 
                                                                       target:nil 
                                                                       action:nil];
            
            // show account with checkin
            [app.detail pushViewController:[[OVWebViewController alloc] initForSFObject:@"Account" 
                                                                           withMustache:viewData 
                                                                     withRightBarButton:checkin]
                                  animated:YES];
            
        }break;
            
        case tagForCellCheckedIn:
            // show account with checkout
            ;
            
            break;
            
        case tagForCellMenu:
            // present modal
            ;
            break;
            
        case tagForCellSF:
            tableView.allowsSelection = NO;
            [app.detail pushViewController:[[OVSyncController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
            break;
    }
}






/*

@required

;

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

;

@optional


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;    // fixed font style. use custom view (UILabel) if you want something different
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section;

// Editing

// Individual rows can opt out of having the -editing property set for them. If not implemented, all rows are assumed to be editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;

// Moving/reordering

// Allows the reorder accessory view to optionally be shown for a particular row. By default, the reorder control will be shown only if the datasource implements -tableView:moveRowAtIndexPath:toIndexPath:
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath;

// Index

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView;                                                    // return list of section titles to display in section index view (e.g. "ABCD...Z#")
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;  // tell table which section corresponds to section title/index (e.g. "B",1))

// Data manipulation - insert and delete support

// After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

// Data manipulation - reorder / moving support

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;

*/

@end
