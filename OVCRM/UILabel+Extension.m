//
//  UILabel+Extension.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/14/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

+(id) hiddenLabelForText:(NSString *)text withTag:(int)tag{
	
	UILabel *label = [UILabel new];
	
	label.hidden = YES;
	label.tag = tag;
	label.text = text;
	
	return label;
}

+(UILabel *) labelWithRect:(CGRect)rect 
					   tag:(int)tag 
					  text:(id)text{
	
	UILabel *ui = [[UILabel alloc] initWithFrame:rect];
	
	ui.tag = tag;
	ui.backgroundColor = [UIColor clearColor];
	ui.textAlignment = UITextAlignmentCenter;
	
	if(text != nil)
		ui.text = text;
	
	return ui;
	
}

+(UILabel *) labelWithRect:(CGRect)rect 
					   tag:(int)tag 
					number:(NSNumber *)num{
	
	UILabel *ui = [[UILabel alloc] initWithFrame:rect];
	
	ui.tag = tag;
	ui.backgroundColor = [UIColor clearColor];
	ui.textAlignment = UITextAlignmentRight;
	ui.baselineAdjustment = UITextAlignmentCenter;
	
	if(num != nil)
		ui.text = [NSString stringWithFormat:@"%@", num];
	
	return ui;
	
}

@end
