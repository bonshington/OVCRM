//
//  viewDatePicker.h
//  TestDB
//
//  Created by Warat Agatwipat on 7/17/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Delivery;

@interface viewDatePicker : UIViewController{
    Delivery * delivery;
}

@property (strong, nonatomic) NSString * selectDate;
@property (strong, nonatomic) Delivery * delivery;
@property (strong, nonatomic) IBOutlet UIButton *buttonSelect;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)selectDate:(id)sender;
- (IBAction)dateValueChange:(id)sender;
- (IBAction)touchView:(id)sender;
@end
