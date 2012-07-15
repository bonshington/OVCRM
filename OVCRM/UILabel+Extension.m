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

@end
