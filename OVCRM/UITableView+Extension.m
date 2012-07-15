//
//  UITableView+Extension.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/14/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "UITableView+Extension.h"

@implementation UITableView (Extension)

-(UITableViewCell *)selectedCell{
	
	return [self cellForRowAtIndexPath:[self indexPathForSelectedRow]];
}

-(UILabel *)labelInSelectdCellWithTag:(int)tag{
	return (UILabel *)[[self selectedCell] viewWithTag:tag];
}

@end
