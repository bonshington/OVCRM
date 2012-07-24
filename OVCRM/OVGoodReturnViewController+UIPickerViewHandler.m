//
//  OVGoodReturnViewController+UIPickerViewHandler.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/22/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "OVGoodReturnViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation OVGoodReturnViewController (UIPickerViewHandler)


#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	return reasonsOfReturn.count;
}


#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	
	UILabel *label = (UILabel *)[selected viewWithTag:tagForReturnReason];
	
	label.text = [reasonsOfReturn objectAtIndex:row];
	
	label.hidden = NO;
	
	[self change:selected];
	
	//[self hidePicker:pickerView];
	
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	return [reasonsOfReturn objectAtIndex:row];
}


#pragma mark - Animation

- (void)didHidePicker:(id)sender{
	self.pickerView.hidden = YES;
}

- (void)openPicker:(id)sender{
	
	[self.view endEditing:YES];
	
	self.pickerView.hidden = NO;
	
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
	
	BOOL tooLow = (positionToScreen.origin.y + self.pickerView.frame.size.height + selected.frame.size.height) > self.tableView.frame.size.height;
	
	if(tooLow){
		self.pickerView.frame = CGRectMake(self.tableView.frame.size.width
										   , positionToScreen.origin.y - self.pickerView.frame.size.height
										   , self.pickerView.frame.size.width
										   , self.pickerView.frame.size.height);
		
		mimic.frame = CGRectMake(0
								 , positionToScreen.origin.y
								 , selected.frame.size.width
								 , selected.frame.size.height);
	}
	else{
		self.pickerView.frame = CGRectMake(self.tableView.frame.size.width
										   , positionToScreen.origin.y+ selected.frame.size.height
										   , self.pickerView.frame.size.width
										   , self.pickerView.frame.size.height);
		
		mimic.frame = CGRectMake(0
								 , positionToScreen.origin.y
								 , selected.frame.size.width
								 , selected.frame.size.height);
	}
	
	
	// display as cell itself
	[self.view addSubview:mimic];
	
	self.tableView.scrollEnabled = NO;
	self.searchBar.userInteractionEnabled = NO;
	
	[self.pickerView selectRow:0 inComponent:0 animated:NO];
	
	
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
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(didHidePicker:)];
	
	[self.tableView setAlpha:1];
	
	self.pickerView.frame = CGRectMake(self.tableView.frame.size.width
									   , self.pickerView.frame.origin.y
									   , self.pickerView.frame.size.width
									   , self.pickerView.frame.size.height);
	
	[UIView commitAnimations];
	
	[self.tableView removeGestureRecognizer:tapped];
	
	self.tableView.scrollEnabled = YES;
	self.searchBar.userInteractionEnabled = YES;
	
	mimic = nil;
	selected = nil;
}

@end
