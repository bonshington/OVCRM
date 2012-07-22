//
//  OVPlanViewController+UIPickerHandler.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/23/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "OVPlanViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation OVPlanViewController (UIPickerHandler)

-(void)tableView:(UITableView *)tableView showPickerViewAtIndexPath:(NSIndexPath *)indexPath{

	[self.view endEditing:YES];
	
	selected = indexPath;
	
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	
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
	
	self.pickerView.frame = pickerInactiveFrame;
	
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
	
	self.pickerView.frame = CGRectMake(0
									   , positionToScreen.origin.y + cell.frame.size.height
									   , self.pickerView.frame.size.width
									   , self.pickerView.frame.size.height);
	
	[UIView commitAnimations];
	
	// add tapped gesture to tableView recognition
    [self.tableView addGestureRecognizer:tapped];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	
	[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]].detailTextLabel.text = [visitTypes objectAtIndex:row];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	return visitTypes.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	return [visitTypes objectAtIndex:row];
}

@end
