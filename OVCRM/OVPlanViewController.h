//
//  OVPlanViewController.h
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/22/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface OVPlanViewController : UIViewController{
	UIImageView *mimic;
	UITapGestureRecognizer *tapped;
	NSIndexPath *selected;
	NSArray *visitTypes;
	CGRect pickerInactiveFrame;
	
	NSDate *start;
	NSDate *end;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *saveButton;
@property (nonatomic, retain) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, retain) IBOutlet UIPickerView *pickerView;
@property (nonatomic, retain) IBOutlet UITextView *textArea;

@property (nonatomic, retain) NSDictionary *account;

-(IBAction)save:(id)sender;
-(void)validate;

@end


@interface OVPlanViewController (UITableViewHandler) <UITableViewDataSource, UITableViewDelegate>

-(UITableViewCell *) tableView:(UITableView *)tableView calendarAtIndexPath:(NSIndexPath *)indexPath;
-(UITableViewCell *) tableView:(UITableView *)tableView descriptionAtIndexPath:(NSIndexPath *)indexPath;
-(UITableViewCell *) tableView:(UITableView *)tableView accountAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface OVPlanViewController (UIDatePickerHandler)

-(void)tableView:(UITableView *)tableView showDatePickerAtIndexPath:(NSIndexPath *)indexPath;
-(void)tableView:(UITableView *)tableView showPickerViewAtIndexPath:(NSIndexPath *)indexPath;
-(void)dismissDatePicker:(id)sender;

@end


@interface OVPlanViewController (UIPickerHandler)<UIPickerViewDataSource, UIPickerViewDelegate>

@end


