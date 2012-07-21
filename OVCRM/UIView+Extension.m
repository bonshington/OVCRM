//
//  UIView+Extension.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/20/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

-(id)lookupFor:(Class)cls{
	
	UIView *result = [self superview];
	
	while(result != nil && ![result isKindOfClass:cls]){
		result = [result superview];
	}
	
	return result;
}

@end
