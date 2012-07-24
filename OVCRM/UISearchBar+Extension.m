//
//  UISearchBar+Extension.m
//  OVCRM
//
//  Created by Apple on 24/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UISearchBar+Extension.h"

@implementation UISearchBar (Extension)

-(void) removeBackground{
	[self setTranslucent:YES];
	
	if ([[[self subviews] objectAtIndex:0] isKindOfClass:[UIImageView class]]){
		[[[self subviews] objectAtIndex:0] removeFromSuperview];
	}
}

@end
