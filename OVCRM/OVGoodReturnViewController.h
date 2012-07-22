//
//  OVGoodReturnViewController.h
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/22/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OVProductConsumerController.h"


@interface OVGoodReturnViewController : OVProductConsumerController<UITextFieldDelegate>{
	
	NSArray *reasonsOfReturn;
	UIImageView *mimic;
	UITapGestureRecognizer *tapped;
	UITableViewCell *selected;
}

@property(nonatomic, retain) NSMutableDictionary *data;
@property(nonatomic, retain) IBOutlet UIPickerView *pickerView;

- (void)openPicker:(id)sender;
- (void)hidePicker:(id)sender;

@end



@interface OVGoodReturnViewController (Action)<SFStepActionProtocal>


@end



@interface OVGoodReturnViewController (UITableViewHandler)<UITableViewDelegate, UITableViewDataSource>

-(void)tableViewCell:(UITableViewCell *)cell renderInputWith:(NSDictionary *)_data;
-(void)tableViewCell:(UITableViewCell *)cell renderLabelWith:(NSDictionary *)_data;



@end



@interface OVGoodReturnViewController (UIPickerViewHandler)<UIPickerViewDataSource, UIPickerViewDelegate>

@end