//
//  InvoiceList+UITableViewHandler.m
//  OVCRM
//
//  Created by Apple on 23/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InvoiceList.h"
#import "tblInvoice.h"
#import "AppDelegate.h"

@implementation InvoiceList (UITableViewHandler)


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	switch (section) {
		case 0: return @"Amount";
			
		case 1: return [NSString stringWithFormat:
						@"                        %@                                            %@                                        %@"
						, @"Bill No."
						, @"Bill Date"
						, @"Amount"];
			
		case 2: return @"Payment";
			
		default:return nil;
	}
}


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	switch (indexPath.section) {
			
		case 2: return self.paymentView.frame.size.height;
			
		default: return 44;
	}
}

/*
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	switch (section) {
		case 1: return self.headerView.frame.size.height;
			
		default:return 22;
	}
}


-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

	switch (section) {
		case 0: return self.headerView;
			
		default:return nil;
	}
}
*/

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	switch (section) {
		case 0: return 2;
			
		case 1: return self.muTableData.count;
			
		case 2: return 1;
			
		default:return 0;
	}
	
    
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	switch (indexPath.section) {
			
		case 0:{
			UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 
														   reuseIdentifier:[indexPath toString]];
			
			cell.accessoryType = UITableViewCellAccessoryNone;
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			
			switch (indexPath.row) {
				case 0:
					cell.textLabel.text = @"Standing Amount";
//                    AAA = [NSString stringWithFormat:@"%.2f ฿",[lbTotalAmount.text doubleValue]];
					cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f ฿",[lbTotalAmount.text doubleValue]];//@"0.00 ฿";
					
					lbTotalAmount = cell.detailTextLabel;
					break;
					
				case 1:
					cell.textLabel.text = @"Payable";
					cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f ฿",[lbPayTotal.text doubleValue]];//@"0.00 ฿";
					
					lbPayTotal = cell.detailTextLabel;
					break;
			}
			
			return cell;
		}
			
		case 1: return [self tableView:tableView invoiceForRowAtIndexPath:indexPath];
			
		case 2:{
		
			UITableViewCell *cell = [[UITableViewCell alloc] initWithFrame:self.paymentView.frame];
			
			[cell.contentView addSubview:self.paymentView];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			
			return cell;
		}
			
		default: return nil;
	}
}

-(UITableViewCell *) tableView:(UITableView *)tableView invoiceForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tblInvoice * invoice = [self.muTableData objectAtIndex:indexPath.row];
    NSInteger tableWidth = tableView.frame.size.width;
    static NSString * iden = @"AAA";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:iden];
		
		cell.backgroundColor = [UIColor whiteColor];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
        cell.accessoryType = UITableViewCellAccessoryNone;
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(tableWidth*3/8, 3, 50, 39)];
        textField.placeholder = @"0";
        textField.text = @"";
        textField.delegate = nil;
        textField.borderStyle = UITextBorderStyleBezel;
        [textField setKeyboardType:UIKeyboardTypeNumberPad];
        
        
        UITextField *textField2 = [[UITextField alloc] initWithFrame:CGRectMake(tableWidth*4/8, 3, 50, 39)];
        textField2.placeholder = @"0";
        textField2.text = @"";
        textField2.delegate = nil;
        textField2.borderStyle = UITextBorderStyleBezel;
        [textField2 setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
        
        UITextField *textField3 = [[UITextField alloc] initWithFrame:CGRectMake(tableWidth*6/8, 3, 50, 39)];
        textField3.placeholder = @"0";
        textField3.text = @"";
        textField3.delegate = nil;
        textField3.borderStyle = UITextBorderStyleRoundedRect;
        [textField setKeyboardType:UIKeyboardTypeNumberPad];
        
        UISwitch * switchTable = [[UISwitch alloc]initWithFrame:CGRectMake(15,9,50,10)];
		switchTable.on = NO;
		switchTable.tag = tagForSwitch;
        [switchTable addTarget:self action:@selector(touchSwitch:) forControlEvents:UIControlEventValueChanged];
        
        UILabel * productNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(105,0,150,44)];
        productNameLabel.text = invoice.invoice_No;
		productNameLabel.baselineAdjustment = UITextAlignmentCenter;
		productNameLabel.backgroundColor = [UIColor clearColor];
        [productNameLabel setTextAlignment:UITextAlignmentLeft];
        
        UILabel * tableLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(tableWidth*3/7, 0, 100, 44)];
        tableLabel1.text = invoice.inv_DueDate;
		tableLabel1.baselineAdjustment = UITextAlignmentCenter;
		tableLabel1.backgroundColor = [UIColor clearColor];
        [tableLabel1 setTextAlignment:UITextAlignmentRight];
        
        UILabel * tableLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(tableWidth*5/7-30, 0, 100, 44)];
        tableLabel2.text = [NSString stringWithFormat:@"%.2f", [invoice.inv_Total doubleValue]];
		tableLabel2.baselineAdjustment = UITextAlignmentCenter;
		tableLabel2.backgroundColor = [UIColor clearColor];
        [tableLabel2 setTextAlignment:UITextAlignmentRight];
        
		[cell.contentView addSubview:productNameLabel];
		[cell.contentView addSubview:tableLabel1];
		[cell.contentView addSubview:tableLabel2];
		[cell.contentView addSubview:switchTable];
		
    }
    
    cell.textLabel.text = @"";//invoice.invoice_No;
    cell.detailTextLabel.numberOfLines = 2;
    cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
    [cell.detailTextLabel sizeThatFits:CGSizeMake(200, 18)];
    
    return  cell;
}

@end
