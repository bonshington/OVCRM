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
					  text:(NSString *)text{
	
	if(text == nil || text.length == 0)
		return nil;
	
	UILabel *ui = [[UILabel alloc] initWithFrame:rect];
	
	ui.tag = tag;
	ui.text = text;
	
	return ui;
	
}

@end
