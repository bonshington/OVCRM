//
//  OVPlanViewController+UIDatePickerHandler.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/23/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "OVPlanViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation OVPlanViewController (UIDatePickerHandler)

-(void)tableView:(UITableView *)tableView showDatePickerAtIndexPath:(NSIndexPath *)indexPath{
	
	[self.view endEditing:YES];
	
	selected = indexPath;
	
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	
	switch (cell.tag) {
		case tagForCellStartDate:
			self.datePicker.minimumDate = [[NSDate date] midnight];
			break;
			
		case tagForCellEndDate:
			if(start != nil){
				self.datePicker.minimumDate = start;
				self.datePicker.maximumDate = [[start midnight] addTimeInterval:(60 * 60 * 24) - 1 ];
			}
			break;
	}
	
	tableView.scrollEnabled = NO;
	self.textArea.userInteractionEnabled = NO;
	
	// capture cell image
	UIGraphicsBeginImageContext(cell.frame.size);
	[cell.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *cellImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	mimic = [[UIImageView alloc] initWithImage:cellImage];
	
	
	CGRect positionToScreen = [self.tableView convertRect:[self.tableView rectForRowAtIndexPath:indexPath] 
												   toView:self.view];
	
	self.datePicker.frame = pickerInactiveFrame;
	
	mimic.frame = CGRectMake(0
							 , positionToScreen.origin.y
							 , cell.frame.size.width
							 , cell.frame.size.height);
	
	// display as cell itself
	[self.view addSubview:mimic];
	
	[UIView beginAnimations:nil context: NULL];
	[UIView setAnimationDuration: 0.25];
	[UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
	
	[self.tableView setAlpha:0.3];
	
	self.datePicker.frame = CGRectMake(0
									   , positionToScreen.origin.y + cell.frame.size.height
									   , self.datePicker.frame.size.width
									   , self.datePicker.frame.size.height);
	
	[UIView commitAnimations];
	
	// add tapped gesture to tableView recognition
    [self.tableView addGestureRecognizer:tapped];
}


-(void)dismissDatePicker:(id)sender{
	
	if(mimic == nil)
		return;
	
	UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:selected];
	
	switch (cell.tag) {
		case tagForCellStartDate:
			start = self.datePicker.date;
			break;
			
		case tagForCellEndDate:
			end = self.datePicker.date;
			break;
	}
	
	
	self.tableView.scrollEnabled = YES;
	self.textArea.userInteractionEnabled = YES;
	
	[self.tableView removeGestureRecognizer:tapped];	
	[self.tableView deselectRowAtIndexPath:selected animated:YES];
	
	if(self.datePicker.frame.origin.y < 704)
		cell.detailTextLabel.text = [self.datePicker.date format:@"dd MMM yyyy - HH:mm"];
	
	
	[mimic removeFromSuperview];
	
	
	[UIView beginAnimations:nil context: NULL];
	[UIView setAnimationDuration: 0.25];
	[UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
	
	[self.tableView setAlpha:1];
	
	if(self.datePicker.frame.origin.y < 704)
		self.datePicker.frame = pickerInactiveFrame;
	else
		self.pickerView.frame = pickerInactiveFrame;
	
	[UIView commitAnimations];
	
	[self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
	
	mimic = nil;
	selected = nil;
	
	[self validate];
}

@end
