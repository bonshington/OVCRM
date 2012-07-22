//
//  OVGoodReturnViewController+UIPickerViewHandler.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/22/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "OVGoodReturnViewController.h"

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

@end
