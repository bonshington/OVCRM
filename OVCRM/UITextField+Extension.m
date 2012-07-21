//
//  UITextField+Extension.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/20/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "UITextField+Extension.h"

@implementation UITextField (Extension)

+(id) newWithCGRect:(CGRect)rect tag:(NSInteger)tag text:(NSString *)text respondTo:(id)obj selector:(SEL)sel{
	
	UITextField *ui = [[UITextField alloc] initWithFrame:rect];
	
	ui.tag = tag;
	ui.borderStyle = UITextBorderStyleRoundedRect;
	ui.keyboardType = UIKeyboardTypeNumberPad;
	ui.textAlignment = UITextAlignmentRight;
	ui.placeholder = @"0";
	
	if(obj != nil)
		[ui addTarget:obj action:sel forControlEvents:UIControlEventEditingChanged];
	
	if(text != nil && text.length > 0)
		ui.text = text;
	
	return ui;
}

@end
