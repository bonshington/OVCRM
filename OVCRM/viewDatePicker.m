//
//  viewDatePicker.m
//  TestDB
//
//  Created by Warat Agatwipat on 7/17/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "viewDatePicker.h"
#import "Delivery.h"

@interface viewDatePicker ()

@end

@implementation viewDatePicker

@synthesize selectDate;
@synthesize buttonSelect;
@synthesize datePicker;
@synthesize delivery;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [buttonSelect setTitle:@"OK" forState:UIControlStateNormal];//[self dateToString:datePicker.date]
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setButtonSelect:nil];
    [self setDatePicker:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (IBAction)selectDate:(id)sender {
    [delivery.navigationItem.rightBarButtonItem setEnabled:YES];
    [self.view removeFromSuperview];
}

- (IBAction)dateValueChange:(id)sender 
{
    selectDate = [self dateToString:datePicker.date];
    [delivery.buttonDate setTitle:selectDate forState:UIControlStateNormal];
//    [buttonSelect setTitle:[self dateToString:datePicker.date] forState:UIControlStateNormal];
}

- (IBAction)touchView:(id)sender {
    [self.view removeFromSuperview];
    [delivery.navigationItem.rightBarButtonItem setEnabled:YES];
}

-(NSString *)dateToString:(NSDate*)sDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];//@"th_TH"];
    [dateFormatter setLocale:usLocale];
    return [dateFormatter stringFromDate:sDate];
}

@end
